import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'page/home.dart';
import 'config/style.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale('zh', 'CN'),
      title: 'Aime',
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
          selectedLabelStyle: const TextStyle(fontSize: 10,fontWeight: FontWeight.w300),
          selectedIconTheme: const IconThemeData(size: 30),
          unselectedIconTheme: const IconThemeData(size: 30),
          unselectedLabelStyle: const TextStyle(fontSize: 10,fontWeight: FontWeight.w300),
          unselectedItemColor: AppColors.primary.withValues(alpha: 0.9),
        ),
      ),
      home: MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
