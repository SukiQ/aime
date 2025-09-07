import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalTheme extends ChangeNotifier {
  static const String _localeKey = "locale_theme";
  ThemeMode _locale = ThemeMode.system;

  ThemeMode get locale => _locale;

  LocalTheme() {
    _loadLocalTheme();
  }

  // 切换主题并保存
  Future<void> setLocalTheme(ThemeMode mode) async {
    _locale = mode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_localeKey, mode.index);
  }

  // 从 SharedPreferences 加载主题
  Future<void> _loadLocalTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt(_localeKey) ?? ThemeMode.system.index;
    _locale = ThemeMode.values[index];
    notifyListeners();
  }
}
