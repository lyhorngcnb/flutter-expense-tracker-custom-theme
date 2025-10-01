import 'package:flutter/material.dart';

class AppTheme {
  // Light theme color scheme
  static const ColorScheme _lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF1976D2), // Blue
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFBBDEFB),
    onPrimaryContainer: Color(0xFF001D36),
    secondary: Color(0xFF0288D1),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFB3E5FC),
    onSecondaryContainer: Color(0xFF001F2A),
    tertiary: Color(0xFF7B1FA2),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFE1BEE7),
    onTertiaryContainer: Color(0xFF2A0033),
    error: Color(0xFFD32F2F),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFFFCDD2),
    onErrorContainer: Color(0xFF410002),
    background: Color(0xFFFAFAFA),
    onBackground: Color(0xFF1A1C1E),
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0xFF1A1C1E),
    surfaceVariant: Color(0xFFE0E0E0),
    onSurfaceVariant: Color(0xFF424242),
    outline: Color(0xFF757575),
    outlineVariant: Color(0xFFBDBDBD),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    inverseSurface: Color(0xFF2E3133),
    onInverseSurface: Color(0xFFEFF1F3),
    inversePrimary: Color(0xFF90CAF9),
    surfaceTint: Color(0xFF1976D2),
  );

  // Dark theme color scheme
  static const ColorScheme _darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF26A69A), // Teal
    onPrimary: Color(0xFF003731),
    primaryContainer: Color(0xFF005048),
    onPrimaryContainer: Color(0xFF80CBC4),
    secondary: Color(0xFF4DB6AC),
    onSecondary: Color(0xFF00332E),
    secondaryContainer: Color(0xFF004D45),
    onSecondaryContainer: Color(0xFFB2DFDB),
    tertiary: Color(0xFFBA68C8),
    onTertiary: Color(0xFF3E1046),
    tertiaryContainer: Color(0xFF5A275D),
    onTertiaryContainer: Color(0xFFE1BEE7),
    error: Color(0xFFEF5350),
    onError: Color(0xFF601410),
    errorContainer: Color(0xFF8C1D18),
    onErrorContainer: Color(0xFFFFDAD6),
    background: Color(0xFF121212),
    onBackground: Color(0xFFE3E2E6),
    surface: Color(0xFF1E1E1E),
    onSurface: Color(0xFFE3E2E6),
    surfaceVariant: Color(0xFF424242),
    onSurfaceVariant: Color(0xFFBDBDBD),
    outline: Color(0xFF8E8E93),
    outlineVariant: Color(0xFF484848),
    shadow: Color(0xFF000000),
    scrim: Color(0xFF000000),
    inverseSurface: Color(0xFFE3E2E6),
    onInverseSurface: Color(0xFF1E1E1E),
    inversePrimary: Color(0xFF00695C),
    surfaceTint: Color(0xFF26A69A),
  );

  static ThemeData lightTheme(Locale locale) => ThemeData(
    useMaterial3: true,
    colorScheme: _lightColorScheme,
    fontFamily: locale.languageCode == 'km' ? "KantumruyPro" : "Inter",

    // AppBar theme
    appBarTheme: AppBarTheme(
      centerTitle: false,
      elevation: 0,
      backgroundColor: _lightColorScheme.surface,
      foregroundColor: _lightColorScheme.onSurface,
      surfaceTintColor: _lightColorScheme.surfaceTint,
    ),

    // Card theme
    cardTheme: CardThemeData(
      elevation: 1,
      color: _lightColorScheme.surface,
      surfaceTintColor: _lightColorScheme.surfaceTint,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),

    // Input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _lightColorScheme.surfaceVariant.withOpacity(0.4),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: _lightColorScheme.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: _lightColorScheme.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: _lightColorScheme.error),
      ),
    ),

    // Elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 1,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),

    // Filled button theme
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),

    // Text button theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),

    // Floating action button theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),

    // Navigation bar theme
    navigationBarTheme: NavigationBarThemeData(
      elevation: 3,
      height: 80,
      backgroundColor: _lightColorScheme.surface,
      indicatorColor: _lightColorScheme.secondaryContainer,
      labelTextStyle: MaterialStateProperty.all(
        const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      ),
    ),

    // Dialog theme
    dialogTheme: DialogThemeData(
      elevation: 3,
      backgroundColor: _lightColorScheme.surface,
      surfaceTintColor: _lightColorScheme.surfaceTint,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),
    ),

    // Bottom sheet theme
    bottomSheetTheme: BottomSheetThemeData(
      elevation: 3,
      backgroundColor: _lightColorScheme.surface,
      surfaceTintColor: _lightColorScheme.surfaceTint,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
    ),

    // Divider theme
    dividerTheme: DividerThemeData(
      color: _lightColorScheme.outlineVariant,
      thickness: 1,
      space: 1,
    ),
  );

  static ThemeData darkTheme(Locale locale) => ThemeData(
    useMaterial3: true,
    colorScheme: _darkColorScheme,
    fontFamily: locale.languageCode == 'km' ? "KantumruyPro" : "Inter",

    // AppBar theme
    appBarTheme: AppBarTheme(
      centerTitle: false,
      elevation: 0,
      backgroundColor: _darkColorScheme.surface,
      foregroundColor: _darkColorScheme.onSurface,
      surfaceTintColor: _darkColorScheme.surfaceTint,
    ),

    // Card theme
    cardTheme: CardThemeData(
      elevation: 1,
      color: _darkColorScheme.surface,
      surfaceTintColor: _darkColorScheme.surfaceTint,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),

    // Input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _darkColorScheme.surfaceVariant.withOpacity(0.4),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: _darkColorScheme.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: _darkColorScheme.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: _darkColorScheme.error),
      ),
    ),

    // Elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 1,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),

    // Filled button theme
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),

    // Text button theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),

    // Floating action button theme
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),

    // Navigation bar theme
    navigationBarTheme: NavigationBarThemeData(
      elevation: 3,
      height: 80,
      backgroundColor: _darkColorScheme.surface,
      indicatorColor: _darkColorScheme.secondaryContainer,
      labelTextStyle: MaterialStateProperty.all(
        const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      ),
    ),

    // Dialog theme
    dialogTheme: DialogThemeData(
      elevation: 3,
      backgroundColor: _darkColorScheme.surface,
      surfaceTintColor: _darkColorScheme.surfaceTint,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),
    ),

    // Bottom sheet theme
    bottomSheetTheme: BottomSheetThemeData(
      elevation: 3,
      backgroundColor: _darkColorScheme.surface,
      surfaceTintColor: _darkColorScheme.surfaceTint,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
    ),

    // Divider theme
    dividerTheme: DividerThemeData(
      color: _darkColorScheme.outlineVariant,
      thickness: 1,
      space: 1,
    ),
  );
}