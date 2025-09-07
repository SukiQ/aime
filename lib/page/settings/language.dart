import 'package:aime/page/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../../config/language_config.dart';
import '../../config/style_config.dart';
import '../../helper/screen_helper.dart';
import '../../l10n/app_localizations.dart';
import '../../widget/local/local_provider.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isWide = ScreenHelper.isWide(context);
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);

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
  LocaleProvider localeProvider,
  bool isWide,
) {
  final List<Widget> list = [];
  if (isWide) list.insert(0, buildWideAppBar(l10n.selectLanguage));
  list.addAll(
    languages.map((lang) {
      final isSelected =
          lang.locale.languageCode ==
          Localizations.localeOf(context).languageCode;
      return Padding(
        padding: isWide ? EdgeInsets.only(left: 10) : EdgeInsets.zero,
        child: ListTile(
          title: Text(lang.label),
          trailing: isSelected
              ? const Icon(LucideIcons.check300, color: AppColors.select)
              : null,
          onTap: () {
            localeProvider.setLocale(lang.locale);
            if (isWide) {
              return;
            }
            Navigator.pop(context, lang.locale);
          },
        ),
      );
    }).toList(),
  );
  return list;
}
