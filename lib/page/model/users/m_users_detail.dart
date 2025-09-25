import 'package:aime/cache/db/users.dart';
import 'package:aime/helper/screen.dart';
import 'package:aime/l10n/app_localizations.dart';
import 'package:aime/setting/app_routes.dart';
import 'package:aime/setting/format.dart';
import 'package:aime/system/widget/loading.dart';
import 'package:aime/system/widget/sheet.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class UsersDetailPage extends StatefulWidget {
  const UsersDetailPage({super.key, required this.id});

  final String id;

  @override
  State<StatefulWidget> createState() {
    return _UsersDetailPageState();
  }
}

class _UsersDetailPageState extends State<UsersDetailPage> {
  bool _loading = true;
  late Users _user;
  late final UsersDao _dao;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isWide = ScreenHelper.isWide(context);

    ///  扩展项
    final List<Widget> extendTiles = [
      ListTile(
        leading: const Icon(LucideIcons.pencil300),
        title: Text(l10n.edit),
        onTap: () async {
          final result = await Navigator.popAndPushNamed(
            context,
            AppRoutes.mUsersEdit,
            arguments: {"id": widget.id},
          );
          if (result != null) {
            setState(() {
              _user = result as Users;
            });
          }
        },
      ),
      ListTile(
        leading: Icon(LucideIcons.trash2300),
        title: Text(l10n.remove),
        onTap: () {
          _dao.delete(widget.id);

          /// 关闭 bottom sheet
          Navigator.pop(context);
          // 返回上一级页面
          Navigator.pop(context, true);
        },
        iconColor: Theme.of(context).colorScheme.error,
        textColor: Theme.of(context).colorScheme.error,
      ),
    ];

    return _loading
        ? LoadingWidget()
        : Scaffold(
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    actions: [
                      IconButton(
                        icon: const Icon(LucideIcons.ellipsisVertical300),
                        tooltip: l10n.modelAddLabel,
                        onPressed: () {
                          buildModalBottomSheet(
                            context: context,
                            widgets: extendTiles,
                          );
                        },
                      ),
                    ],
                    expandedHeight: 100,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.pin,
                      centerTitle: true,
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
                    _user.birthday == null
                        ? null
                        : FormatConfig.dateFormat.format(_user.birthday!),
                  ),
                  _buildUserDetailTile(
                    LucideIcons.phone300,
                    l10n.phone,
                    _user.phone,
                  ),
                ],
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
