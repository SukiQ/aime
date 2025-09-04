import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/language_config.dart';

class LocaleProvider extends ChangeNotifier {
  static const String _localeKey = "locale_language";
  Locale _locale = languageLocaleMajor;

  Locale get locale => _locale;

  LocaleProvider() {
    _loadLocale();
  }

  Future<void> _loadLocale() async {
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
