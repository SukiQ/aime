import 'package:aime/page/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../../config/language_config.dart';
import '../../helper/screen_helper.dart';
import '../../l10n/app_localizations.dart';
import '../../widget/local/local_language.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isWide = ScreenHelper.isWide(context);
    final localeProvider = Provider.of<LocaleLanguage>(context, listen: false);

    return Scaffold(
      appBar: isWide ? null : AppBar(title: Text(l10n.selectLanguage)),
      body: ListView(
        children: _buildListTiles(context, l10n, localeProvider, isWide),
      ),
    );
  }
}

List<Widget> _buildListTiles(
  BuildContext context,
  AppLocalizations l10n,
  LocaleLanguage localeProvider,
  bool isWide,
) {
  final ColorScheme colorScheme = Theme.of(context).colorScheme;
  final List<Widget> list = [];
  if (isWide) list.insert(0, buildWideAppBar(l10n.selectLanguage));
  list.addAll(
    Languages.values.map((lang) {
      final isSelected =
          lang.locale.toLanguageTag() == Localizations.localeOf(context).toLanguageTag();

      return Padding(
        padding: isWide ? EdgeInsets.only(left: 10) : EdgeInsets.zero,
        child: ListTile(
          title: Text(lang.label),
          subtitle: Text(lang.getDisplayName(context)),
          trailing: isSelected
              ? Icon(LucideIcons.check300, color: colorScheme.primary)
              : null,
          onTap: () {
            localeProvider.setLocale(lang.locale);
            if (isWide) {
              return;
            }
            Navigator.pop(context);
          },
        ),
      );
    }).toList(),
  );
  return list;
}
