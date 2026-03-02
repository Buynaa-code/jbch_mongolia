import 'package:flutter/material.dart';

/// Application color palette based on app icon
/// Deep blue globe with white dove - peace and global mission theme
abstract final class AppColors {
  // Primary - Deep Navy Blue (from globe)
  static const Color primary = Color(0xFF0D47A1);
  static const Color primaryLight = Color(0xFF5472D3);
  static const Color primaryDark = Color(0xFF002171);

  // Secondary - Sky Blue (lighter globe gradient)
  static const Color secondary = Color(0xFF42A5F5);
  static const Color secondaryLight = Color(0xFF80D6FF);
  static const Color secondaryDark = Color(0xFF0077C2);

  // Tertiary - Mint/Cyan (background gradient)
  static const Color tertiary = Color(0xFFE0F7FA);
  static const Color tertiaryDark = Color(0xFFB2EBF2);

  // Accent - Teal (highlight)
  static const Color accent = Color(0xFF26A69A);
  static const Color accentLight = Color(0xFF80CBC4);

  // Surfaces - Light Mode
  static const Color surfaceLight = Color(0xFFF5FCFF);
  static const Color surfaceContainerLight = Color(0xFFE8F4F8);
  static const Color surfaceContainerHighLight = Color(0xFFDCEEF5);
  static const Color backgroundLight = Color(0xFFFAFDFF);

  // Surfaces - Dark Mode
  static const Color surfaceDark = Color(0xFF0A1929);
  static const Color surfaceContainerDark = Color(0xFF132F4C);
  static const Color surfaceContainerHighDark = Color(0xFF1E4976);
  static const Color backgroundDark = Color(0xFF001E3C);

  // Text Colors - Light Mode
  static const Color onSurfaceLight = Color(0xFF1A237E);
  static const Color onSurfaceVariantLight = Color(0xFF455A64);

  // Text Colors - Dark Mode
  static const Color onSurfaceDark = Color(0xFFE3F2FD);
  static const Color onSurfaceVariantDark = Color(0xFFB0BEC5);

  // On Primary/Secondary
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onSecondary = Color(0xFFFFFFFF);

  // Error Colors
  static const Color error = Color(0xFFBA1A1A);
  static const Color errorLight = Color(0xFFFFDAD6);
  static const Color onError = Color(0xFFFFFFFF);

  // Success Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color successLight = Color(0xFFE8F5E9);

  // Outline Colors
  static const Color outlineLight = Color(0xFF78909C);
  static const Color outlineDark = Color(0xFF90A4AE);

  // Divider Colors
  static const Color dividerLight = Color(0xFFB0BEC5);
  static const Color dividerDark = Color(0xFF37474F);

  // Shadow Colors
  static const Color shadowLight = Color(0x1A000000);
  static const Color shadowDark = Color(0x3D000000);
}
