import 'package:aime/cache/local/database.dart';
import 'package:aime/cache/local/local_language.dart';
import 'package:aime/cache/local/local_theme.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';


class LocaleInitializer {

  static List<SingleChildWidget> get providers => [
    ChangeNotifierProvider(create: (_) => LocaleLanguage()),
    ChangeNotifierProvider(create: (_) => LocalTheme()),
    ChangeNotifierProvider(create: (_) => LocalDatabase()),
  ];
}


