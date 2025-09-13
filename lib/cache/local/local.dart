import 'package:flutter/foundation.dart';

import 'database.dart';
import 'local_language.dart';
import 'local_theme.dart';

final List<ChangeNotifier> locals = [
  LocaleLanguage(),
  LocalTheme(),
  LocalDatabase(),
];
