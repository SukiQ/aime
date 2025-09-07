import 'package:aime/system/style/system_animation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/style_config.dart';

ThemeData buildDarkThemeData(BuildContext context) {
  return ThemeData(
    splashFactory: NoSplash.splashFactory,
    textTheme: _buildTextTheme(context),
    primaryColor: AppColors.primaryDark,
    appBarTheme: _buildAppBarTheme(),
    listTileTheme: _buildListTileTheme(),
    pageTransitionsTheme: buildPageTransitionsTheme(),
    scaffoldBackgroundColor: AppColors.backgroundDark,
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.backgroundDark,
    ),
    navigationDrawerTheme: NavigationDrawerThemeData(
      backgroundColor: AppColors.backgroundDark,
    ),
    bottomNavigationBarTheme: _buildBottomNavigationBarThemeData(),
    navigationRailTheme: _buildNavigationRailThemeData(),
  );
}

ListTileThemeData _buildListTileTheme() {
  return ListTileThemeData(
    iconColor: AppColors.primaryDark,
    textColor: AppColors.primaryDark,
    tileColor: AppColors.backgroundDark,
    selectedTileColor: AppColors.selectDark,
    selectedColor: AppColors.selectDark,
    subtitleTextStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w200),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  );
}

AppBarTheme _buildAppBarTheme() {
  return AppBarTheme(
    toolbarHeight: 60.0,
    titleSpacing: 40.0,
    backgroundColor: AppColors.backgroundDark,
    titleTextStyle: TextStyle(color: AppColors.primaryDark),
    iconTheme: IconThemeData(color: AppColors.primaryDark),
  );
}

TextTheme _buildTextTheme(BuildContext context) {
  return GoogleFonts.notoSansScTextTheme(Theme.of(context).textTheme).copyWith(
    bodyLarge: GoogleFonts.notoSansSc(
      fontWeight: FontWeight.w400,
      fontSize: 17,
    ),
    bodyMedium: GoogleFonts.notoSansSc(
      fontWeight: FontWeight.w400,
      fontSize: 15,
    ),
    bodySmall: GoogleFonts.notoSansSc(
      fontWeight: FontWeight.w400,
      fontSize: 13,
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
  );
}

NavigationRailThemeData _buildNavigationRailThemeData() {
  return NavigationRailThemeData(
    minWidth: 60,
    labelType: NavigationRailLabelType.all,
    backgroundColor: AppColors.backgroundDark,
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
      color: AppColors.backgroundDark,
      size: 28,
    ),
    indicatorColor: AppColors.selectDark,
    elevation: 0,
  );
}

BottomNavigationBarThemeData _buildBottomNavigationBarThemeData() {
  return BottomNavigationBarThemeData(
    enableFeedback: false,
    elevation: 0,
    type: BottomNavigationBarType.fixed,
    backgroundColor: AppColors.backgroundDark,
    selectedItemColor: AppColors.selectDark,
    selectedLabelStyle: const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w300,
    ),
    showSelectedLabels: true,
    showUnselectedLabels: true,
    selectedIconTheme: const IconThemeData(size: 32),
    unselectedIconTheme: const IconThemeData(size: 32),
    unselectedLabelStyle: const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w300,
    ),
    unselectedItemColor: AppColors.primaryDark.withValues(alpha: 0.9),
  );
}
