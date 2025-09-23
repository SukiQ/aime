import 'package:aime/cache/db/users.dart';
import 'package:aime/helper/screen.dart';
import 'package:aime/l10n/app_localizations.dart';
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
    print('===');

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
                      onPressed: () async {
                        await showModalBottomSheet<String>(
                          context: context,
                          builder: (BuildContext context) {
                            return ListView(
                              children: [
                                ListTile(
                                  leading: Icon(LucideIcons.userRoundPlus400),
                                  title: Text(l10n.modelAddLabel),
                                  onTap: () {
                                    Navigator.pop(context, "add");
                                  },
                                ),
                                ListTile(
                                  leading: Icon(LucideIcons.userRoundMinus400),
                                  title: Text(l10n.users),
                                  onTap: () {},
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                  expandedHeight: 100,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(_user.username!)
                  ),
                ),
                SliverToBoxAdapter(
                  child: Text(_user.nickname ?? "",textAlign: TextAlign.center),
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
                _buildUserDetailTile(LucideIcons.phone300, l10n.phone, _user.phone),
              ]
            ),
          ),
        ),
    ));
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
