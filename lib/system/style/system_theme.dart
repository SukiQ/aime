import 'dart:io';

import 'package:aime/helper/screen.dart';
import 'package:aime/system/style/system_animation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:aime/config/style_config.dart';

ThemeData buildThemeData(BuildContext context, ThemeMode themeMode) {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      surface: themeMode == ThemeMode.light
          ? AppColors.surface
          : AppColors.surfaceDark,
      seedColor: AppColors.seedColor,
      onSurfaceVariant: AppColors.onSurfaceVariant,
      surfaceContainerHigh: themeMode == ThemeMode.light
          ? AppColors.surfaceContainerHigh
          : AppColors.surfaceContainerHighDark,
      brightness: themeMode == ThemeMode.light
          ? Brightness.light
          : Brightness.dark,
    ),
    splashFactory: NoSplash.splashFactory,
    textTheme: _buildTextTheme(context),
    appBarTheme: _buildAppBarTheme(),
    listTileTheme: _buildListTileTheme(),
    searchBarTheme: _buildSearchBarTheme(context),
    pageTransitionsTheme: buildPageTransitionsTheme(),
    bottomNavigationBarTheme: _buildBottomNavigationBarThemeData(),
    navigationRailTheme: _buildNavigationRailThemeData(),
    inputDecorationTheme: _buildInputDecorationTheme(),
  );
}

ListTileThemeData _buildListTileTheme() {
  return ListTileThemeData(
    style: ListTileStyle.list,
    shape: ScreenHelper.isPhone() ? null : RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
  );
}

AppBarTheme _buildAppBarTheme() {
  return AppBarTheme(toolbarHeight: 60.0, titleSpacing: 40.0);
}

TextTheme _buildTextTheme(BuildContext context) {
  return GoogleFonts.notoSansScTextTheme(Theme.of(context).textTheme).copyWith(
    bodyLarge: GoogleFonts.notoSansSc(
      fontWeight: FontWeight.w400,
      fontSize: ScreenHelper.isPhone() ? 17 : 15,
    ),
    bodyMedium: GoogleFonts.notoSansSc(
      fontWeight: FontWeight.w400,
      fontSize: ScreenHelper.isPhone() ? 14 : 12,
    ),
    bodySmall: GoogleFonts.notoSansSc(
      fontWeight: FontWeight.w400,
      fontSize: ScreenHelper.isPhone() ? 11 : 9,
    ),
    headlineLarge: GoogleFonts.notoSansSc(fontWeight: FontWeight.w200),
    headlineMedium: GoogleFonts.notoSansSc(fontWeight: FontWeight.w200),
    headlineSmall: GoogleFonts.notoSansSc(fontWeight: FontWeight.w200),
    titleLarge: GoogleFonts.notoSansSc(
      fontWeight: FontWeight.bold,
      fontSize: ScreenHelper.isPhone()? 20 :18,
    ),
    titleMedium: GoogleFonts.notoSansSc(
      fontWeight: FontWeight.bold,
      fontSize: ScreenHelper.isPhone() ? 18 :16,
    ),
    titleSmall: GoogleFonts.notoSansSc(
      fontWeight: FontWeight.bold,
      fontSize: ScreenHelper.isPhone() ? 16 :14,
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
    labelType: NavigationRailLabelType.none,
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

BottomNavigationBarThemeData _buildBottomNavigationBarThemeData() {
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

SearchBarThemeData? _buildSearchBarTheme(BuildContext context) {
  return SearchBarThemeData(
    padding: const WidgetStatePropertyAll(
      EdgeInsets.symmetric(horizontal: 15, vertical: 0),
    ),
    side: const WidgetStatePropertyAll(BorderSide.none),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    elevation: const WidgetStatePropertyAll(0),
    constraints: const BoxConstraints(minHeight: 40, maxHeight: 40),
  );
}

InputDecorationThemeData? _buildInputDecorationTheme() {
  return InputDecorationThemeData(
    filled: true,
    constraints: const BoxConstraints(minHeight: 40),
    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
  );
}
