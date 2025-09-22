import 'dart:io';

import 'package:cbl_flutter/cbl_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import 'cache/local/local.dart';
import 'l10n/app_localizations.dart';
import 'page/home.dart';
import 'system/style/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await windowManager.ensureInitialized();

    WindowOptions windowOptions = const WindowOptions(
      size: Size(1000, 800),
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
  await CouchbaseLiteFlutter.init();
  runApp(
    MultiProvider(providers: LocaleInitializer.providers, child: const MyApp()),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      locale: LocaleInitializer.language(context).locale,
      title: 'Aime',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: buildThemeData(context, Brightness.light),
      home: MainPage(),
      debugShowCheckedModeBanner: false,
      darkTheme: buildThemeData(context, Brightness.dark),
      themeMode: LocaleInitializer.theme(context).locale,
    );
  }


}
