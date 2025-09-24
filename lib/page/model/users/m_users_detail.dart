import 'package:aime/cache/db/users.dart';
import 'package:aime/helper/screen.dart';
import 'package:aime/l10n/app_localizations.dart';
import 'package:aime/page/model/users/m_users.dart';
import 'package:aime/page/model/users/m_users_add.dart';
import 'package:aime/system/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class UsersDetailPage extends StatefulWidget {
  const UsersDetailPage(this.id, {super.key});

  final String id;

  @override
  State<StatefulWidget> createState() {
    return _UsersDetailPageState();
  }
}

class _UsersDetailPageState extends State<UsersDetailPage> {
  late Users _user;
  late UsersDao _dao;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isWide = ScreenHelper.isWide(context);

    return Scaffold(
      body: _loading
          ? LoadingWidget()
          :
            //
            DefaultTabController(
              length: 3, // Tab 数量
              child: Scaffold(
                body: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        actions: [
                          IconButton(
                            icon: const Icon(LucideIcons.ellipsisVertical300),
                            tooltip: l10n.modelAddLabel,
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16),
                                  ),
                                ),
                                showDragHandle:
                                    true, // 显示顶部拖拽手柄 (Flutter 3.10+)
                                builder: (context) {
                                  return SafeArea(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min, // 高度自适应内容
                                      children: [
                                        ListTile(
                                          leading: const Icon(
                                            LucideIcons.pencil300,
                                          ),
                                          title: Text(l10n.edit),
                                          onTap: () {
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text("点击了编辑"),
                                              ),
                                            );
                                          },
                                        ),
                                        ListTile(
                                          leading: Icon(LucideIcons.trash2300),
                                          title: Text(l10n.remove),
                                          onTap: () {
                                            _dao.delete(widget.id);
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(builder: (context) => UsersPage()),
                                            );

                                          },
                                          iconColor: Theme.of(
                                            context,
                                          ).colorScheme.error,
                                          textColor: Theme.of(
                                            context,
                                          ).colorScheme.error,
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                        expandedHeight: 100,
                        pinned: true,
                        flexibleSpace: FlexibleSpaceBar(
                          title: Text(_user.username!),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Text(
                          _user.nickname ?? "",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ];
                  },
                  body: ListView(
                    padding: const EdgeInsets.all(8),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      _buildUserDetailTile(
                        LucideIcons.cake300,
                        l10n.birthday,
                        _user.birthday?.timeZoneName,
                      ),
                      _buildUserDetailTile(
                        LucideIcons.phone300,
                        l10n.phone,
                        _user.phone,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildUserDetailTile(IconData icon, String title, String? subtitle) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: subtitle == null ? null : Text(subtitle),
    );
  }

  Future<void> _load() async {
    UsersDao.build(context)
        .then((dao) {
          _dao = dao;
          return _dao.details(widget.id);
        })
        .then((user) {
          setState(() {
            _user = user;
            _loading = false;
          });
        });
  }
}
