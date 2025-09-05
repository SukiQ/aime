import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../l10n/app_localizations.dart';


class ThemeSwitcherPage extends StatelessWidget {
  const ThemeSwitcherPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // final localeProvider = Provider.of<LocaleProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.selectLanguage)),
      body: ListView(
        children: [ListTile(title: Text('123'))]
      ),
    );
  }
}
