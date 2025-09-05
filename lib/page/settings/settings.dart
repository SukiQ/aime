import 'package:aime/page/settings/theme_switcher_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../helper/screen_helper.dart';
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
    final isWide = ScreenHelper.isWide(context);

    return Scaffold(
      appBar: isWide ? null : AppBar(title: Text(l10n.settings)),
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: ListView(
              children: [
                if (isWide)
                  AppBar(
                    titleSpacing: 25,
                    toolbarHeight: 100,
                    title: Padding(
                      padding: EdgeInsets.only(top: 50, bottom: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(l10n.settings),
                      ),
                    ),
                  ),
                _SettingTile(
                  LucideIcons.languages300,
                  l10n.selectLanguage,
                  LanguagePage(),
                ),
                _SettingTile(
                  LucideIcons.palette300,
                  l10n.theme,
                  ThemeSwitcherPage(),
                ),
              ],
            ),
          ),
          if (isWide)
            VerticalDivider(
              color: Colors.black.withValues(alpha: 0.15),
              thickness: 1,
              width: 10,
              indent: 35,
              endIndent: 35,
            ),
          if (isWide) Expanded(flex: 7, child: Center(child: LanguagePage())),
        ],
      ),
    );
  }
}

class _SettingTile extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final Widget page;

  const _SettingTile(this.leadingIcon, this.title, this.page);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(leadingIcon),
      title: Text(title),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
    );
  }
}
