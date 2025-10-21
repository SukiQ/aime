import 'package:aime/helper/screen.dart';
import 'package:aime/system/style/animation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:aime/setting/colors.dart';

ThemeData buildThemeData(BuildContext context, Brightness brightness) {
  return ThemeData(
    fontFamily: 'MiSans',
    useMaterial3: true,
    elevatedButtonTheme: _buildElevatedButtonTheme(),
    floatingActionButtonTheme: _buildFloatingActionButtonTheme(brightness),
    outlinedButtonTheme: _buildOutlinedButtonTheme(brightness),
    buttonTheme: _buildButtonThemeData(),
    cardTheme: _buildCardTheme(brightness),
    colorScheme: ColorScheme(
      brightness: brightness,
      primary: ColorsConfig.primary.color(brightness),
      onPrimary: ColorsConfig.onPrimary.color(brightness),
      secondary: ColorsConfig.secondary.color(brightness),
      onSecondary: ColorsConfig.onSecondary.color(brightness),
      error: ColorsConfig.error.color(brightness),
      onError: ColorsConfig.onError.color(brightness),
      surface: ColorsConfig.surface.color(brightness),
      onSurface: ColorsConfig.onSurface.color(brightness),
      scrim: ColorsConfig.scrim.color(brightness),
      surfaceTint: ColorsConfig.onPrimary.color(brightness),
    ),
    splashFactory: NoSplash.splashFactory,
    textTheme: _buildTextTheme(context),
    appBarTheme: _buildAppBarTheme(),
    listTileTheme: _buildListTileTheme(),
    searchBarTheme: _buildSearchBarTheme(context),
    pageTransitionsTheme: buildPageTransitionsTheme(),
    bottomNavigationBarTheme: _buildBottomNavigationBarThemeData(),
    navigationRailTheme: _buildNavigationRailThemeData(),
    inputDecorationTheme: _buildInputDecorationTheme(brightness),
    bottomSheetTheme: _buildBottomSheetTheme(),
    sliderTheme: _buildSliderTheme(),
    scrollbarTheme: _buildScrollbarTheme(),
  );
}

CardThemeData? _buildCardTheme(Brightness brightness) {
  return CardThemeData(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(color: ColorsConfig.scrim.color(brightness), width: 1),
    ),
    clipBehavior: Clip.antiAlias,
    margin: EdgeInsets.zero,
  );
}

FloatingActionButtonThemeData? _buildFloatingActionButtonTheme(
  Brightness brightness,
) {
  return FloatingActionButtonThemeData(
    backgroundColor: ColorsConfig.onPrimary.color(brightness),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  );
}

ElevatedButtonThemeData? _buildElevatedButtonTheme() {
  return ElevatedButtonThemeData(
    style: ButtonStyle(
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      // overlayColor: WidgetStatePropertyAll(AppColors.surfaceContainerHigh),
    ),
  );
}

OutlinedButtonThemeData? _buildOutlinedButtonTheme(Brightness brightness) {
  return OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      side: BorderSide(color: ColorsConfig.scrim.color(brightness), width: 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
    ),
  );
}

ButtonThemeData? _buildButtonThemeData() {
  return ButtonThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
  );
}

ListTileThemeData _buildListTileTheme() {
  return ListTileThemeData(
    titleAlignment: ListTileTitleAlignment.center,
    style: ListTileStyle.list,
    shape: ScreenHelper.isPhone()
        ? null
        : RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
  );
}

AppBarTheme _buildAppBarTheme() {
  return AppBarTheme(
    toolbarHeight: 70.0,
    titleSpacing: 40.0,
    actionsPadding: const EdgeInsets.symmetric(horizontal: 10.0),
  );
}

TextTheme _buildTextTheme(BuildContext context) {
  return TextTheme(
    bodyLarge: TextStyle(
      fontWeight: FontWeight.w400,
      fontFamily: 'MiSans',
      fontSize: ScreenHelper.isPhone() ? 17 : 13,
    ),
    bodyMedium: TextStyle(
      fontWeight: FontWeight.w400,
      fontFamily: 'MiSans',
      fontSize: ScreenHelper.isPhone() ? 12 : 8,
    ),
    bodySmall: TextStyle(
      fontWeight: FontWeight.w400,
      fontFamily: 'MiSans',
      fontSize: ScreenHelper.isPhone() ? 9 : 5,
    ),
    headlineLarge: TextStyle(
      fontWeight: FontWeight.w400,
      fontFamily: 'MiSans',
    ),
    headlineMedium: TextStyle(
      fontWeight: FontWeight.w400,
      fontFamily: 'MiSans',
    ),
    headlineSmall: TextStyle(
      fontWeight: FontWeight.w400,
      fontFamily: 'MiSans',
    ),
    titleLarge: TextStyle(
      fontWeight: FontWeight.w400,
      fontFamily: 'MiSans',
      fontSize: ScreenHelper.isPhone() ? 20 : 16,
    ),
    titleMedium: TextStyle(
      fontWeight: FontWeight.w400,
      fontFamily: 'MiSans',
      fontSize: ScreenHelper.isPhone() ? 18 : 14,
    ),
    titleSmall: TextStyle(
      fontWeight: FontWeight.w400,
      fontFamily: 'MiSans',
      fontSize: ScreenHelper.isPhone() ? 16 : 12,
    ),
    displayLarge: TextStyle(
      fontWeight: FontWeight.w400,
      fontFamily: 'MiSans',
      fontSize: ScreenHelper.isPhone() ? 20 : 16,
    ),
    displayMedium: TextStyle(
      fontWeight: FontWeight.w400,
      fontFamily: 'MiSans',
      fontSize: ScreenHelper.isPhone() ? 18 : 14,
    ),
    displaySmall: TextStyle(
      fontWeight: FontWeight.w400,
      fontFamily: 'MiSans',
      fontSize: ScreenHelper.isPhone() ? 16 : 12,
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
    indicatorColor: Colors.transparent,
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
    showSelectedLabels: false,
    showUnselectedLabels: false,
    selectedIconTheme: const IconThemeData(size: 34),
    unselectedIconTheme: const IconThemeData(size: 34),
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

InputDecorationThemeData? _buildInputDecorationTheme(Brightness brightness) {
  return InputDecorationThemeData(
    isCollapsed: false,
    filled: false,
    floatingLabelStyle: WidgetStateTextStyle.resolveWith((states) {
      if (states.contains(WidgetState.error)) {
        return TextStyle(color: ColorsConfig.error.color(brightness));
      }
      return TextStyle(color: ColorsConfig.secondary.color(brightness));
    }),
    constraints: const BoxConstraints(minHeight: 40),
    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(
        width: 1,
        color: ColorsConfig.error.color(brightness),
      ),
    ),
    errorStyle: TextStyle(color: ColorsConfig.error.color(brightness)),
    focusColor: ColorsConfig.secondary.color(brightness),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(
        width: 1,
        color: ColorsConfig.secondary.color(brightness),
      ),
    ),
      enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(
        width: 1,
        color: ColorsConfig.scrim.color(brightness),
      ),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(
        width: 1,
        color: ColorsConfig.secondary.color(brightness),
      ),
    ),
  );
}

BottomSheetThemeData? _buildBottomSheetTheme() {
  return BottomSheetThemeData(
    showDragHandle: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
    ),
  );
}

SliderThemeData? _buildSliderTheme() {
  return SliderThemeData();
}

ScrollbarThemeData? _buildScrollbarTheme() {
  return ScrollbarThemeData(
    radius: const Radius.circular(12),
    interactive: true,
  );
}
