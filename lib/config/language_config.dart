import 'dart:ui';

class LanguagesConfig {
  final String label;
  final Locale locale;

  const LanguagesConfig(this.label, this.locale);
}

/// 语言列表
const List<LanguagesConfig> languages = [
  LanguagesConfig('简体中文', Locale('zh', 'CN')),
  LanguagesConfig('English', Locale('en', 'US')),
];

final languageLocales = languages.map((lang) => lang.locale).toList();

final languageMajor = languages[0];

final languageLocaleMajor = languageMajor.locale;