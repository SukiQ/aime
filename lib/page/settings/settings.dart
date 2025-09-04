import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../l10n/app_localizations.dart';
import 'language.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPage createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(LucideIcons.languages300),
            title: Text(l10n.selectLanguage),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LanguagePage(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('账号'),
            subtitle: Text('查看和编辑账号信息'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              // TODO: 跳转账号页面
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('关于'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: '设置页面示例',
                applicationVersion: 'v1.0.0',
                applicationIcon: Icon(Icons.settings),
                children: [
                  Text('这是一个 Flutter 设置页面示例。'),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

