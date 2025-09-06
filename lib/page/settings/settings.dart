import 'package:aime/page/settings/theme_switcher_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../helper/screen_helper.dart';
import '../../l10n/app_localizations.dart';
import '../../system/widget/vertical_widget.dart';
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
    final isWide = ScreenHelper.isWide(context);

    return Scaffold(
      appBar: isWide ? null : AppBar(title: Text(l10n.settings)),
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: ListView(
              children: [
                if (isWide) _buildAppBar(l10n),
                _buildListTile(
                  context,
                  LucideIcons.languages400,
                  l10n.selectLanguage,
                  LanguagePage(),
                ),
                _buildListTile(
                  context,
                  LucideIcons.palette400,
                  l10n.theme,
                  ThemeSwitcherPage(),
                ),
              ],
            ),
          ),
          if (isWide) buildVerticalDivider(),
          if (isWide) Expanded(flex: 7, child: Center(child: LanguagePage())),
        ],
      ),
    );
  }

  AppBar _buildAppBar(AppLocalizations l10n) {
    return AppBar(
      titleSpacing: 25,
      toolbarHeight: 100,
      title: Padding(
        padding: EdgeInsets.only(top: 50, bottom: 20),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(l10n.settings),
        ),
      ),
    );
  }
}

ListTile _buildListTile(
  BuildContext context,
  IconData icon,
  String title,
  Widget page,
) {
  final isWide = ScreenHelper.isWide(context);
  return ListTile(
    leading: Icon(icon),
    title: Text(title),
    trailing: isWide ? null : Icon(LucideIcons.chevronRight300),
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => page));
    },
  );
}
