import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

part 'theme_colors.dart';

class CustomTheme {
  static final themeData = ThemeData(
    colorScheme: const ColorScheme.light(
      primary: ThemeColors.primary,
      secondary: ThemeColors.secondary,
      surface: ThemeColors.surface,
      onPrimary: ThemeColors.onPrimary,
      onSecondary: ThemeColors.onSecondary,
      onSurface: ThemeColors.onSurface,
      error: ThemeColors.error,
    ),
    textTheme: GoogleFonts.livvicTextTheme().copyWith(
      displayLarge: const TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: ThemeColors.primary,
        fontStyle: FontStyle.italic,
      ),
      bodyLarge: const TextStyle(
        fontSize: 16.0,
        color: ThemeColors.onSurface,
      ),
      bodyMedium: const TextStyle(
        fontSize: 14.0,
        color: ThemeColors.onSurface,
      ),
    ),
    scaffoldBackgroundColor: ThemeColors.surface,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ThemeColors.button,
        foregroundColor: ThemeColors.onPrimary,
        disabledBackgroundColor: ThemeColors.disabled,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ThemeColors.backgroundInput,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          color: ThemeColors.secondary,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          color: ThemeColors.secondary,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          color: ThemeColors.primary,
        ),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: ThemeColors.surface,
      foregroundColor: ThemeColors.secondary,
      centerTitle: true,
      titleSpacing: 50,
      titleTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: ThemeColors.primary,
      ),
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    dividerTheme: const DividerThemeData(
      color: Colors.black12,
      space: 20,
    ),
  );
}
