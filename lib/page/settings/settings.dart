import 'package:aime/page/settings/about.dart';
import 'package:aime/page/settings/theme_setting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../helper/screen_helper.dart';
import '../../l10n/app_localizations.dart';
import '../../system/widget/vertical_widget.dart';
import 'language_setting.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPage createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  Widget currentPage = LanguageSetting();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isWide = ScreenHelper.isWide(context);

    return Scaffold(
      appBar: isWide ? null : AppBar(title: Text(l10n.settings)),
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: ListView(
              children: [
                if (isWide) buildWideAppBar(l10n.settings),
                _buildListTile(
                  context,
                  LucideIcons.languages400,
                  l10n.selectLanguage,
                  LanguageSetting(),
                ),
                _buildListTile(
                  context,
                  LucideIcons.palette400,
                  l10n.theme,
                  ThemeSetting(),
                ),
                _buildListTile(
                  context,
                  LucideIcons.badgeInfo400,
                  l10n.about,
                  About(),
                ),
              ],
            ),
          ),
          if (isWide) buildVerticalDivider(),
          if (isWide) Expanded(flex: 7, child: Center(child: currentPage)),
        ],
      ),
    );
  }

  Widget _buildListTile(
      BuildContext context,
      IconData icon,
      String title,
      Widget page,
      ) {
    final isWide = ScreenHelper.isWide(context);
    return Padding(padding: isWide ? EdgeInsets.only(left: 10) : EdgeInsets.zero,child: ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: isWide ? null : Icon(LucideIcons.chevronRight300),
      onTap: () {
        if(isWide) {
          setState(() {
            currentPage = page;
          });
        } else {
          Navigator.push(context, MaterialPageRoute(builder: (context) => page));
        }
      },
    ),);
  }
}

Widget buildWideAppBar(String text) {
  return AppBar(
    titleSpacing: 25,
    toolbarHeight: 130,
    title: Padding(
      padding: EdgeInsets.only(top: 80, bottom: 20),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(text),
      ),
    ),
  );
}


