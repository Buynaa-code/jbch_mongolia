import 'package:flutter/material.dart';

/// Application color palette with warm earth tones
/// Designed for a spiritual, welcoming church app aesthetic
abstract final class AppColors {
  // Primary - Deep Brown (warm, grounded)
  static const Color primary = Color(0xFF5D4037);
  static const Color primaryLight = Color(0xFF8B6B61);
  static const Color primaryDark = Color(0xFF321911);

  // Secondary - Sage Green (nature, growth)
  static const Color secondary = Color(0xFF7CB342);
  static const Color secondaryLight = Color(0xFFAEE571);
  static const Color secondaryDark = Color(0xFF4B830D);

  // Tertiary - Warm Cream (soft, welcoming)
  static const Color tertiary = Color(0xFFF5E6D3);
  static const Color tertiaryDark = Color(0xFFE8D5BE);

  // Accent - Soft Gold (highlights)
  static const Color accent = Color(0xFFD4A574);
  static const Color accentLight = Color(0xFFE8C9A8);

  // Surfaces - Light Mode
  static const Color surfaceLight = Color(0xFFFFFBF5);
  static const Color surfaceContainerLight = Color(0xFFF5EFE7);
  static const Color surfaceContainerHighLight = Color(0xFFEDE5DA);
  static const Color backgroundLight = Color(0xFFFFFDF9);

  // Surfaces - Dark Mode
  static const Color surfaceDark = Color(0xFF2D2520);
  static const Color surfaceContainerDark = Color(0xFF3D332C);
  static const Color surfaceContainerHighDark = Color(0xFF4D4138);
  static const Color backgroundDark = Color(0xFF1A1512);

  // Text Colors - Light Mode
  static const Color onSurfaceLight = Color(0xFF1D1B16);
  static const Color onSurfaceVariantLight = Color(0xFF4F4539);

  // Text Colors - Dark Mode
  static const Color onSurfaceDark = Color(0xFFF0E6DC);
  static const Color onSurfaceVariantDark = Color(0xFFD5C8BA);

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
  static const Color outlineLight = Color(0xFF847468);
  static const Color outlineDark = Color(0xFF9E8E82);

  // Divider Colors
  static const Color dividerLight = Color(0xFFE0D6CC);
  static const Color dividerDark = Color(0xFF4A403A);

  // Shadow Colors
  static const Color shadowLight = Color(0x1A000000);
  static const Color shadowDark = Color(0x3D000000);
}
