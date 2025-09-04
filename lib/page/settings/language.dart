import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../../config/language_config.dart';
import '../../config/style.dart';
import '../../l10n/app_localizations.dart';
import '../../widget/local/provider.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.selectLanguage)),
      body: ListView(
        children: languages.map((lang) {
          final isSelected =
              lang.locale.languageCode ==
              Localizations.localeOf(context).languageCode;
          return ListTile(
            title: Text(lang.label),
            trailing: isSelected
                ? const Icon(LucideIcons.check300, color: AppColors.select)
                : null,
            onTap: () {
              localeProvider.setLocale(lang.locale);
              Navigator.pop(context, lang.locale);
            },
          );
        }).toList(),
      ),
    );
  }
}
