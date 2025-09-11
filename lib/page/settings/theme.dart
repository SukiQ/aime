import 'package:aime/page/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';

import 'package:aime/helper/screen.dart';
import 'package:aime/l10n/app_localizations.dart';
import 'package:aime/cache/local/local_theme.dart';
import 'package:aime/system/widget/page.dart';

class ThemeSetting extends StatelessWidget {
  const ThemeSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isWide = ScreenHelper.isWide(context);

    return Scaffold(
      appBar: isWide ? null : AppBar(title: Text(l10n.theme)),
      body: ViewPage(
        child: ListView(
          children: [
            if (isWide) buildWideAppBar(l10n.theme),
            _buildListTile(context, l10n.themeLight, null, ThemeMode.light),
            _buildListTile(context, l10n.themeDark, null, ThemeMode.dark),
            _buildListTile(
              context,
              l10n.themeSystem,
              l10n.themeSystemLabel,
              ThemeMode.system,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(
    BuildContext context,
    String title,
    String? label,
    ThemeMode themeMode,
  ) {
    final isWide = ScreenHelper.isWide(context);
    final localeProvider = Provider.of<LocalTheme>(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: isWide ? EdgeInsets.only(left: 10) : EdgeInsets.zero,
      child: ListTile(
        title: Text(title),
        trailing: localeProvider.locale == themeMode
            ? Icon(LucideIcons.circleCheck400, color: colorScheme.primary)
            : Icon(LucideIcons.circle300),
        subtitle: label == null ? null : Text(label),
        onTap: () {
          localeProvider.setLocalTheme(themeMode);
          if (isWide) {
            return;
          }
          Navigator.pop(context);
        },
      ),
    );
  }
}
