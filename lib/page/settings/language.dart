import 'package:aime/page/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:aime/config/language_config.dart';
import 'package:aime/helper/screen.dart';
import 'package:aime/l10n/app_localizations.dart';
import 'package:aime/cache/local/local_language.dart';
import 'package:aime/system/widget/page.dart';

class LanguageSetting extends StatefulWidget {
  const LanguageSetting({super.key});

  @override
  _LearningPageState createState() => _LearningPageState();
}

class _LearningPageState extends State<LanguageSetting> {
  String _query = "";

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isWide = ScreenHelper.isWide(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final localeProvider = Provider.of<LocaleLanguage>(context, listen: false);

    return Scaffold(
      appBar: isWide ? null : AppBar(title: Text(l10n.selectLanguage)),
      body: ViewPage( child:Column(
        children: [
          if (isWide) buildWideAppBar(l10n.selectLanguage),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              decoration: InputDecoration(
                hintText: l10n.search,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _query.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() => _query = "");
                        },
                      )
                    : null,
              ),
              onChanged: (value) => setState(() => _query = value),
            ),
          ),
          Expanded(
            child: ListView(
              children: Languages.values
                  .where(
                    (lang) =>
                        lang.label.toLowerCase().contains(
                          _query.toLowerCase(),
                        ) ||
                        lang
                            .getDisplayName(context)
                            .toLowerCase()
                            .contains(_query.toLowerCase()),
                  )
                  .map((lang) {
                    return _buildLanguageTile(
                      lang,
                      context,
                      isWide,
                      colorScheme,
                      localeProvider,
                    );
                  })
                  .toList(),
            ),
          ),
        ],
      ))
    );
  }
}

Padding _buildLanguageTile(
  Languages lang,
  BuildContext context,
  bool isWide,
  ColorScheme colorScheme,
  LocaleLanguage localeProvider,
) {
  final isSelected =
      lang.locale.toLanguageTag() ==
      Localizations.localeOf(context).toLanguageTag();

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
}
