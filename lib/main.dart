import 'package:aime/widget/local/local_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import 'l10n/app_localizations.dart';
import 'page/home.dart';
import 'config/style_config.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(800, 600),
    center: true,
    // 窗口背景
    backgroundColor: Colors.transparent,
    // 窗口标题
    titleBarStyle: TitleBarStyle.hidden,
    skipTaskbar: true
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => LocaleProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    return MaterialApp(
      locale: localeProvider.locale,
      title: 'Aime',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: buildThemeData(context),
      home: MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }

  ThemeData buildThemeData(BuildContext context) {
    return ThemeData(
      splashFactory: NoSplash.splashFactory,
      textTheme: GoogleFonts.notoSansScTextTheme(Theme.of(context).textTheme)
          .copyWith(
            bodyLarge: GoogleFonts.notoSansSc(
              fontWeight: FontWeight.w200,
              fontSize: 16,
            ),
            bodyMedium: GoogleFonts.notoSansSc(
              fontWeight: FontWeight.w200,
              fontSize: 14,
            ),
            bodySmall: GoogleFonts.notoSansSc(
              fontWeight: FontWeight.w200,
              fontSize: 12,
            ),
            headlineLarge: GoogleFonts.notoSansSc(fontWeight: FontWeight.w200),
            headlineMedium: GoogleFonts.notoSansSc(fontWeight: FontWeight.w200),
            headlineSmall: GoogleFonts.notoSansSc(fontWeight: FontWeight.w200),
            titleLarge: GoogleFonts.notoSansSc(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            titleMedium: GoogleFonts.notoSansSc(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            titleSmall: GoogleFonts.notoSansSc(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
      primaryColor: AppColors.primary,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        titleSpacing: 0.8,
      ),
      scaffoldBackgroundColor: AppColors.background,
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.background,
      ),
      navigationDrawerTheme: NavigationDrawerThemeData(
        backgroundColor: AppColors.background,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        enableFeedback: false,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.background,
        selectedItemColor: AppColors.select,
        selectedLabelStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w300,
        ),
        selectedIconTheme: const IconThemeData(size: 35),
        unselectedIconTheme: const IconThemeData(size: 35),
        unselectedLabelStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w300,
        ),
        unselectedItemColor: AppColors.primary.withValues(alpha: 0.9),
      ),
      navigationRailTheme: NavigationRailThemeData(
        minWidth: 60,
        labelType: NavigationRailLabelType.none,
        backgroundColor: AppColors.background,
        unselectedLabelTextStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w300,
        ),
        selectedLabelTextStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w300,
        ),
        unselectedIconTheme: const IconThemeData(size: 28),
        selectedIconTheme: const IconThemeData(
          color: AppColors.background,
          size: 28,
        ),
        indicatorColor: AppColors.select,
        elevation: 0,
      ),
    );
  }
}
