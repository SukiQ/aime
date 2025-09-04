import 'package:aime/widget/local/local_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'l10n/app_localizations.dart';
import 'page/home.dart';
import 'config/style_config.dart';

void main() {
  runApp(  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => LocaleProvider()),
    ],
    child: const MyApp(),
  ),);
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
      theme: ThemeData(
        splashFactory: NoSplash.splashFactory,
        textTheme: GoogleFonts.notoSansScTextTheme(Theme.of(context).textTheme)
            .copyWith(
              bodyLarge: GoogleFonts.notoSansSc(
                fontWeight: FontWeight.w200,
                fontSize: 18,
              ),
              bodyMedium: GoogleFonts.notoSansSc(
                fontWeight: FontWeight.w200,
                fontSize: 16,
              ),
              bodySmall: GoogleFonts.notoSansSc(
                fontWeight: FontWeight.w200,
                fontSize: 14,
              ),
              headlineLarge: GoogleFonts.notoSansSc(
                fontWeight: FontWeight.w200,
              ),
              headlineMedium: GoogleFonts.notoSansSc(
                fontWeight: FontWeight.w200,
              ),
              headlineSmall: GoogleFonts.notoSansSc(
                fontWeight: FontWeight.w200,
              ),
            ),
        primaryColor: AppColors.primary,
        appBarTheme: AppBarTheme(backgroundColor: AppColors.background),
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
          selectedLabelStyle: const TextStyle(fontSize: 15,fontWeight: FontWeight.w300),
          selectedIconTheme: const IconThemeData(size: 35),
          unselectedIconTheme: const IconThemeData(size: 35),
          unselectedLabelStyle: const TextStyle(fontSize: 15,fontWeight: FontWeight.w300),
          unselectedItemColor: AppColors.primary.withValues(alpha: 0.9),
        ),
      ),
      home: MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
