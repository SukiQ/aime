import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/language_config.dart';

class LocaleLanguage extends ChangeNotifier {
  static const String _localeKey = "locale_language";
  Locale _locale = Languages.chineseSimple.locale;

  Locale get locale => _locale;

  LocaleLanguage() {
    _loadLocaleLanguage();
  }

  Future<void> _loadLocaleLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_localeKey);

    if (code != null) {
      final parts = code.split('_');
      _locale = Locale(parts[0], parts.length > 1 ? parts[1] : null);
      notifyListeners();
    }
  }

  Future<void> setLocale(Locale locale) async {
    _locale = locale;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _localeKey,
      "${locale.languageCode}_${locale.countryCode ?? ''}",
    );
  }
}
