import 'package:aime/cache/db/users.dart';
import 'package:aime/helper/screen.dart';
import 'package:aime/helper/string.dart';
import 'package:aime/l10n/app_localizations.dart';
import 'package:aime/page/model/m_users_detail.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class UsersAddPage extends StatefulWidget {
  const UsersAddPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _UsersAddPageState();
  }
}

class _UsersAddPageState extends State<UsersAddPage> {
  late UsersDao _dao;
  final Users _user = Users();

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
      appBar: isWide
          ? null
          : AppBar(
              title: Text(l10n.addUser),
              actions: [
                IconButton(
                  icon: const Icon(LucideIcons.save300),
                  tooltip: l10n.modelAddLabel,
                  onPressed: () {
                    if (StringHelper.isNotBlank(_user.username)) {
                      _dao.add(_user);
                    }
                    ;
                  },
                ),
              ],
            ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(LucideIcons.user300),
                  title: TextField(
                    decoration: InputDecoration(
                      labelText: l10n.users,
                      hintText: l10n.users,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _user.username = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _load() async {
    _dao = await UsersDao.build(context);
  }
}
