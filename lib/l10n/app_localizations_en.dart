// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get helloWorld => 'Hello World';

  @override
  String get model => 'model';

  @override
  String get think => 'think';

  @override
  String get search => 'search';

  @override
  String get learning => 'learning';

  @override
  String get settings => 'settings';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get selectLanguageLabel =>
      'Select the preferred operating system language for Aime';

  @override
  String get theme => 'theme';

  @override
  String get themeDark => 'Dark mode';

  @override
  String get themeLight => 'Light mode';

  @override
  String get themeSystem => 'System mode';

  @override
  String get themeSystemLabel => 'I\'ll adjust the mode to match your system';
}
