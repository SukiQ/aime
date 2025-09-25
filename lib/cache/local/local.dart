import 'package:aime/cache/local/database.dart';
import 'package:aime/cache/local/language.dart';
import 'package:aime/cache/local/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class LocaleInitializer {
  static List<SingleChildWidget> get providers => [
    ChangeNotifierProvider(create: (_) => LocaleLanguage()),
    ChangeNotifierProvider(create: (_) => LocalTheme()),
    ChangeNotifierProvider(create: (_) => LocalDatabase()),
  ];

  /// 获取语言
  static LocaleLanguage language(BuildContext context) =>
      Provider.of<LocaleLanguage>(context);

  /// 获取主题
  static LocalTheme theme(BuildContext context) =>
      Provider.of<LocalTheme>(context);

  /// 获取数据库
  static LocalDatabase database(BuildContext context) =>
      Provider.of<LocalDatabase>(context);
}
