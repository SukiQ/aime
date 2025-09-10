import 'dart:io';

import 'package:aime/cache/local/local_language.dart';
import 'package:aime/cache/local/local_theme.dart';
import 'package:cbl_flutter/cbl_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import 'l10n/app_localizations.dart';
import 'page/home.dart';
import 'system/style/system_theme.dart';

void main() async {
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    WidgetsFlutterBinding.ensureInitialized();
    await windowManager.ensureInitialized();

    WindowOptions windowOptions = const WindowOptions(
      size: Size(1100, 800),
      center: true,
      backgroundColor: Colors.transparent,
      titleBarStyle: TitleBarStyle.hidden,
      windowButtonVisibility: true,
    );

    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }
  // await CouchbaseLiteFlutter.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocaleLanguage()),
        ChangeNotifierProvider(create: (_) => LocalTheme()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localeLanguage = Provider.of<LocaleLanguage>(context);
    final localeTheme = Provider.of<LocalTheme>(context);

    return MaterialApp(
      locale: localeLanguage.locale,
      title: 'Aime',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: buildThemeData(context, ThemeMode.light),
      home: MainPage(),
      debugShowCheckedModeBanner: false,
      darkTheme: buildThemeData(context, ThemeMode.dark),
      themeMode: localeTheme.locale,
    );
  }
}
