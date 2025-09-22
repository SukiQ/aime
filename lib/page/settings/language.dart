import 'package:aime/page/settings/settings.dart';
import 'package:aime/system/widget/field/search.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:aime/config/language.dart';
import 'package:aime/helper/screen.dart';
import 'package:aime/l10n/app_localizations.dart';
import 'package:aime/cache/local/language.dart';
import 'package:aime/system/widget/page.dart';

class LanguageSetting extends StatefulWidget {
  const LanguageSetting({super.key});

  @override
  _LearningPageState createState() => _LearningPageState();
}

class _LearningPageState extends State<LanguageSetting> {
  final TextEditingController _queryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _queryController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isWide = ScreenHelper.isWide(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final localeProvider = Provider.of<LocaleLanguage>(context, listen: false);

    return Scaffold(
      appBar: isWide ? null : AppBar(title: Text(l10n.selectLanguage)),
      body: ViewPage(
        child: Column(
          children: [
            if (isWide) buildWideAppBar(l10n.selectLanguage),
            SearchTextField(controller: _queryController),
            Expanded(
              child: ListView(
                children: Languages.values
                    .where(
                      (lang) =>
                          lang.label.toLowerCase().contains(
                            _queryController.text.toLowerCase(),
                          ) ||
                          lang
                              .getDisplayName(context)
                              .toLowerCase()
                              .contains(_queryController.text.toLowerCase()),
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
        ),
      ),
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
