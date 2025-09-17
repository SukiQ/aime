
import 'package:aime/cache/db/users.dart';
import 'package:aime/helper/screen.dart';
import 'package:aime/l10n/app_localizations.dart';
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
      appBar: AppBar(
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
                          onTap: () {}
                        )
                      ]
                    );
                  });
            },
          ),
        ],
      ),
      body: _loading ? LoadingWidget() : ListView(
        children: [
          ListTile(
            title: Text(_user.username,textAlign: TextAlign.center,style: TextStyle(fontSize: 30)),
            subtitle: Text(_user.nickname ?? "",textAlign: TextAlign.center),
          ),
          _buildUserDetailTile(
            LucideIcons.cake300,
            l10n.birthday,
            _user.birthday?.timeZoneName,
          ),
          _buildUserDetailTile(LucideIcons.phone300, l10n.phone, _user.phone),
        ],
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


