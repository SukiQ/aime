import 'dart:ui';

import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

enum Languages {
  chineseSimple,
  chineseTraditionalTW,
  chineseTraditionalHK,
  english,
}

extension LanguagesExtension on Languages {
  /// 获取对应的 Locale
  Locale get locale {
    switch (this) {
      case Languages.chineseSimple:
        return const Locale('zh');
      case Languages.chineseTraditionalTW:
        return const Locale('zh', 'TW');
      case Languages.chineseTraditionalHK:
        return const Locale('zh', 'HK');
      case Languages.english:
        return const Locale('en');
    }
  }

  String get label {
    switch (this) {
      case Languages.chineseSimple:
        return '简体中文';
      case Languages.chineseTraditionalTW:
        return '繁體中文 (台灣)';
      case Languages.chineseTraditionalHK:
        return '繁體中文 (香港)';
      case Languages.english:
        return 'English';
    }
  }

  String getDisplayName(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (this) {
      case Languages.chineseSimple:
        return l10n.chineseSimple;
      case Languages.chineseTraditionalTW:
        return l10n.chineseTraditionalTW;
      case Languages.chineseTraditionalHK:
        return l10n.chineseTraditionalHK;
      case Languages.english:
        return l10n.english;
    }
  }
}

//
// final languageLocales = languages.map((lang) => lang.locale).toList();
//
// final languageMajor = languages[0];
//
// final
// languageLocaleMajor
// =
// languageMajor
// .
// locale;
