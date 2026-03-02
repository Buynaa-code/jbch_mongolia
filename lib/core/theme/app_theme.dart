import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

/// Application theme configuration with Material 3 support
/// Provides both light and dark themes with warm earth tones
abstract final class AppTheme {
  // Border radius constants
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusXLarge = 24.0;

  // Spacing constants
  static const double spacingXSmall = 4.0;
  static const double spacingSmall = 8.0;
  static const double spacingMedium = 16.0;
  static const double spacingLarge = 24.0;
  static const double spacingXLarge = 32.0;

  // Elevation constants
  static const double elevationLow = 1.0;
  static const double elevationMedium = 2.0;
  static const double elevationHigh = 4.0;

  /// Light theme configuration
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: _lightColorScheme,
      textTheme: _textTheme,
      appBarTheme: _lightAppBarTheme,
      cardTheme: _lightCardTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
      outlinedButtonTheme: _outlinedButtonTheme,
      textButtonTheme: _textButtonTheme,
      inputDecorationTheme: _lightInputDecorationTheme,
      bottomNavigationBarTheme: _lightBottomNavTheme,
      navigationBarTheme: _lightNavigationBarTheme,
      floatingActionButtonTheme: _fabTheme,
      dividerTheme: _lightDividerTheme,
      listTileTheme: _lightListTileTheme,
      scaffoldBackgroundColor: AppColors.backgroundLight,
    );
  }

  /// Dark theme configuration
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: _darkColorScheme,
      textTheme: _textTheme,
      appBarTheme: _darkAppBarTheme,
      cardTheme: _darkCardTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
      outlinedButtonTheme: _outlinedButtonTheme,
      textButtonTheme: _textButtonTheme,
      inputDecorationTheme: _darkInputDecorationTheme,
      bottomNavigationBarTheme: _darkBottomNavTheme,
      navigationBarTheme: _darkNavigationBarTheme,
      floatingActionButtonTheme: _fabTheme,
      dividerTheme: _darkDividerTheme,
      listTileTheme: _darkListTileTheme,
      scaffoldBackgroundColor: AppColors.backgroundDark,
    );
  }

  // Color Schemes
  static const ColorScheme _lightColorScheme = ColorScheme.light(
    primary: AppColors.primary,
    onPrimary: AppColors.onPrimary,
    primaryContainer: AppColors.primaryLight,
    onPrimaryContainer: AppColors.primaryDark,
    secondary: AppColors.secondary,
    onSecondary: AppColors.onSecondary,
    secondaryContainer: AppColors.secondaryLight,
    onSecondaryContainer: AppColors.secondaryDark,
    tertiary: AppColors.accent,
    onTertiary: AppColors.onPrimary,
    tertiaryContainer: AppColors.accentLight,
    surface: AppColors.surfaceLight,
    onSurface: AppColors.onSurfaceLight,
    surfaceContainerLowest: AppColors.backgroundLight,
    surfaceContainerLow: AppColors.surfaceLight,
    surfaceContainer: AppColors.surfaceContainerLight,
    surfaceContainerHigh: AppColors.surfaceContainerHighLight,
    onSurfaceVariant: AppColors.onSurfaceVariantLight,
    error: AppColors.error,
    onError: AppColors.onError,
    errorContainer: AppColors.errorLight,
    outline: AppColors.outlineLight,
    shadow: AppColors.shadowLight,
  );

  static const ColorScheme _darkColorScheme = ColorScheme.dark(
    primary: AppColors.primaryLight,
    onPrimary: AppColors.primaryDark,
    primaryContainer: AppColors.primary,
    onPrimaryContainer: AppColors.tertiary,
    secondary: AppColors.secondaryLight,
    onSecondary: AppColors.secondaryDark,
    secondaryContainer: AppColors.secondary,
    onSecondaryContainer: AppColors.secondaryLight,
    tertiary: AppColors.accentLight,
    onTertiary: AppColors.primaryDark,
    tertiaryContainer: AppColors.accent,
    surface: AppColors.surfaceDark,
    onSurface: AppColors.onSurfaceDark,
    surfaceContainerLowest: AppColors.backgroundDark,
    surfaceContainerLow: AppColors.surfaceDark,
    surfaceContainer: AppColors.surfaceContainerDark,
    surfaceContainerHigh: AppColors.surfaceContainerHighDark,
    onSurfaceVariant: AppColors.onSurfaceVariantDark,
    error: AppColors.errorLight,
    onError: AppColors.error,
    errorContainer: AppColors.error,
    outline: AppColors.outlineDark,
    shadow: AppColors.shadowDark,
  );

  // Text Theme
  static TextTheme get _textTheme {
    return TextTheme(
      displayLarge: AppTextStyles.displayLarge,
      displayMedium: AppTextStyles.displayMedium,
      displaySmall: AppTextStyles.displaySmall,
      headlineLarge: AppTextStyles.headlineLarge,
      headlineMedium: AppTextStyles.headlineMedium,
      headlineSmall: AppTextStyles.headlineSmall,
      titleLarge: AppTextStyles.titleLarge,
      titleMedium: AppTextStyles.titleMedium,
      titleSmall: AppTextStyles.titleSmall,
      bodyLarge: AppTextStyles.bodyLarge,
      bodyMedium: AppTextStyles.bodyMedium,
      bodySmall: AppTextStyles.bodySmall,
      labelLarge: AppTextStyles.labelLarge,
      labelMedium: AppTextStyles.labelMedium,
      labelSmall: AppTextStyles.labelSmall,
    );
  }

  // AppBar Themes
  static const AppBarTheme _lightAppBarTheme = AppBarTheme(
    elevation: 0,
    scrolledUnderElevation: 1,
    centerTitle: true,
    backgroundColor: AppColors.surfaceLight,
    foregroundColor: AppColors.onSurfaceLight,
    surfaceTintColor: Colors.transparent,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  static const AppBarTheme _darkAppBarTheme = AppBarTheme(
    elevation: 0,
    scrolledUnderElevation: 1,
    centerTitle: true,
    backgroundColor: AppColors.surfaceDark,
    foregroundColor: AppColors.onSurfaceDark,
    surfaceTintColor: Colors.transparent,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  );

  // Card Themes
  static CardThemeData get _lightCardTheme {
    return CardThemeData(
      elevation: elevationMedium,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusLarge),
      ),
      color: AppColors.surfaceLight,
      surfaceTintColor: Colors.transparent,
      shadowColor: AppColors.shadowLight,
      margin: EdgeInsets.zero,
    );
  }

  static CardThemeData get _darkCardTheme {
    return CardThemeData(
      elevation: elevationMedium,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusLarge),
      ),
      color: AppColors.surfaceContainerDark,
      surfaceTintColor: Colors.transparent,
      shadowColor: AppColors.shadowDark,
      margin: EdgeInsets.zero,
    );
  }

  // Button Themes
  static ElevatedButtonThemeData get _elevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: elevationLow,
        padding: const EdgeInsets.symmetric(
          horizontal: spacingLarge,
          vertical: spacingMedium,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
        ),
        textStyle: AppTextStyles.labelLarge,
      ),
    );
  }

  static OutlinedButtonThemeData get _outlinedButtonTheme {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: spacingLarge,
          vertical: spacingMedium,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
        ),
        textStyle: AppTextStyles.labelLarge,
      ),
    );
  }

  static TextButtonThemeData get _textButtonTheme {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: spacingMedium,
          vertical: spacingSmall,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusSmall),
        ),
        textStyle: AppTextStyles.labelLarge,
      ),
    );
  }

  // Input Decoration Themes
  static InputDecorationTheme get _lightInputDecorationTheme {
    return InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surfaceContainerLight,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMedium),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMedium),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMedium),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMedium),
        borderSide: const BorderSide(color: AppColors.error, width: 1),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: spacingMedium,
        vertical: spacingMedium,
      ),
    );
  }

  static InputDecorationTheme get _darkInputDecorationTheme {
    return InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surfaceContainerDark,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMedium),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMedium),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMedium),
        borderSide: const BorderSide(color: AppColors.primaryLight, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radiusMedium),
        borderSide: const BorderSide(color: AppColors.errorLight, width: 1),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: spacingMedium,
        vertical: spacingMedium,
      ),
    );
  }

  // Bottom Navigation Bar Themes
  static const BottomNavigationBarThemeData _lightBottomNavTheme =
      BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: AppColors.surfaceLight,
    selectedItemColor: AppColors.primary,
    unselectedItemColor: AppColors.onSurfaceVariantLight,
    elevation: 8,
    showUnselectedLabels: true,
  );

  static const BottomNavigationBarThemeData _darkBottomNavTheme =
      BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: AppColors.surfaceDark,
    selectedItemColor: AppColors.primaryLight,
    unselectedItemColor: AppColors.onSurfaceVariantDark,
    elevation: 8,
    showUnselectedLabels: true,
  );

  // Navigation Bar Themes (Material 3)
  static NavigationBarThemeData get _lightNavigationBarTheme {
    return NavigationBarThemeData(
      height: 80,
      elevation: 0,
      backgroundColor: AppColors.surfaceContainerLight,
      surfaceTintColor: Colors.transparent,
      indicatorColor: AppColors.primaryLight.withValues(alpha: 0.2),
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: AppColors.primary, size: 24);
        }
        return const IconThemeData(
            color: AppColors.onSurfaceVariantLight, size: 24);
      }),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppTextStyles.labelMedium.copyWith(color: AppColors.primary);
        }
        return AppTextStyles.labelMedium
            .copyWith(color: AppColors.onSurfaceVariantLight);
      }),
    );
  }

  static NavigationBarThemeData get _darkNavigationBarTheme {
    return NavigationBarThemeData(
      height: 80,
      elevation: 0,
      backgroundColor: AppColors.surfaceContainerDark,
      surfaceTintColor: Colors.transparent,
      indicatorColor: AppColors.primaryLight.withValues(alpha: 0.2),
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: AppColors.primaryLight, size: 24);
        }
        return const IconThemeData(
            color: AppColors.onSurfaceVariantDark, size: 24);
      }),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppTextStyles.labelMedium
              .copyWith(color: AppColors.primaryLight);
        }
        return AppTextStyles.labelMedium
            .copyWith(color: AppColors.onSurfaceVariantDark);
      }),
    );
  }

  // FAB Theme
  static FloatingActionButtonThemeData get _fabTheme {
    return FloatingActionButtonThemeData(
      elevation: elevationMedium,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusLarge),
      ),
    );
  }

  // Divider Themes
  static const DividerThemeData _lightDividerTheme = DividerThemeData(
    color: AppColors.dividerLight,
    thickness: 1,
    space: 1,
  );

  static const DividerThemeData _darkDividerTheme = DividerThemeData(
    color: AppColors.dividerDark,
    thickness: 1,
    space: 1,
  );

  // ListTile Themes
  static ListTileThemeData get _lightListTileTheme {
    return ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(horizontal: spacingMedium),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusMedium),
      ),
      tileColor: Colors.transparent,
      selectedTileColor: AppColors.primaryLight.withValues(alpha: 0.1),
    );
  }

  static ListTileThemeData get _darkListTileTheme {
    return ListTileThemeData(
      contentPadding: const EdgeInsets.symmetric(horizontal: spacingMedium),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radiusMedium),
      ),
      tileColor: Colors.transparent,
      selectedTileColor: AppColors.primaryLight.withValues(alpha: 0.1),
    );
  }
}
