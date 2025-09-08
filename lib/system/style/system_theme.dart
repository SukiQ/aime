import 'package:aime/system/style/system_animation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/style_config.dart';

ThemeData buildThemeData(BuildContext context, ThemeMode themeMode) {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      onSurfaceVariant: AppColors.label,
      brightness: themeMode == ThemeMode.light
          ? Brightness.light
          : Brightness.dark,
    ),
    splashFactory: NoSplash.splashFactory,
    textTheme: _buildTextTheme(context),
    appBarTheme: _buildAppBarTheme(),
    listTileTheme: _buildListTileTheme(),
    pageTransitionsTheme: buildPageTransitionsTheme(),
    navigationBarTheme: NavigationBarThemeData(),
    navigationDrawerTheme: NavigationDrawerThemeData(),
    bottomNavigationBarTheme: _buildBottomNavigationBarThemeData(themeMode),
    navigationRailTheme: _buildNavigationRailThemeData(),
  );
}

ListTileThemeData _buildListTileTheme() {
  return ListTileThemeData(
    style: ListTileStyle.list,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  );
}

AppBarTheme _buildAppBarTheme() {
  return AppBarTheme(
    toolbarHeight: 60.0,
    titleSpacing: 40.0,
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
      fontSize: 14,
    ),
    bodySmall: GoogleFonts.notoSansSc(
      fontWeight: FontWeight.w400,
      fontSize: 11,
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
    displayLarge: GoogleFonts.notoSansSc(
      fontWeight: FontWeight.w200,
      fontSize: 20,
    ),
    displayMedium: GoogleFonts.notoSansSc(
      fontWeight: FontWeight.w200,
      fontSize: 18,
    ),
    displaySmall: GoogleFonts.notoSansSc(
      fontWeight: FontWeight.w200,
      fontSize: 16,
    ),
  );
}

NavigationRailThemeData _buildNavigationRailThemeData() {
  return NavigationRailThemeData(
    minWidth: 60,
    labelType: NavigationRailLabelType.all,
    unselectedLabelTextStyle: const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
    ),
    selectedLabelTextStyle: const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
    ),
    unselectedIconTheme: const IconThemeData(size: 28),
    selectedIconTheme: IconThemeData(size: 28),
    elevation: 0,
  );
}

BottomNavigationBarThemeData _buildBottomNavigationBarThemeData(
  ThemeMode themeMode,
) {
  return BottomNavigationBarThemeData(
    enableFeedback: false,
    elevation: 0,
    type: BottomNavigationBarType.fixed,
    selectedLabelStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    showSelectedLabels: true,
    showUnselectedLabels: true,
    selectedIconTheme: const IconThemeData(size: 32),
    unselectedIconTheme: const IconThemeData(size: 32),
    unselectedLabelStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
  );
}
