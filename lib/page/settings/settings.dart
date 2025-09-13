import 'package:aime/page/settings/about.dart';
import 'package:aime/page/settings/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:aime/helper/screen.dart';
import 'package:aime/l10n/app_localizations.dart';
import 'package:aime/system/widget/list.dart';
import 'package:aime/system/widget/page.dart';
import 'package:aime/system/widget/vertical_widget.dart';
import 'language.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPage createState() => _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  Widget _currentPage = About();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isWide = ScreenHelper.isWide(context);

    return Scaffold(
      appBar: isWide ? null : AppBar(title: Text(l10n.settings)),
      body: ViewPage(
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: ListView(
                children: [
                  if (isWide) buildWideAppBar(l10n.settings),
                  buildLevel1ListTile(
                    context,
                    LucideIcons.languages400,
                    l10n.selectLanguage,
                    () {
                      if (isWide) {
                        setState(() {
                          _currentPage = LanguageSetting();
                        });
                        return;
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LanguageSetting(),
                        ),
                      );
                    },
                  ),
                  buildLevel1ListTile(
                    context,
                    LucideIcons.palette400,
                    l10n.theme,
                    () {
                      if (isWide) {
                        setState(() {
                          _currentPage = ThemeSetting();
                        });
                        return;
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ThemeSetting()),
                      );
                    },
                  ),
                  buildLevel1ListTile(
                    context,
                    LucideIcons.badgeInfo400,
                    l10n.about,
                    () {
                      if (isWide) {
                        setState(() {
                          _currentPage = About();
                        });
                        return;
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => About()),
                      );
                    },
                  ),
                ],
              ),
            ),
            if (isWide) buildVerticalDivider(),
            if (isWide) Expanded(flex: 7, child: _currentPage),
          ],
        ),
      ),
    );
  }
}

Widget buildWideAppBar(String text) {
  return AppBar(
    titleSpacing: 25,
    toolbarHeight: 130,
    title: Padding(
      padding: EdgeInsets.only(top: 80, bottom: 20),
      child: Align(alignment: Alignment.centerLeft, child: Text(text)),
    ),
  );
}
