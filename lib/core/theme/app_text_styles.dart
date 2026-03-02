import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Application typography styles
/// Uses Nunito for headlines (rounded, friendly) and system default for body (Mongolian support)
abstract final class AppTextStyles {
  // Headlines - Nunito (friendly, rounded)
  static TextStyle displayLarge = GoogleFonts.nunito(
    fontSize: 57,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.25,
  );

  static TextStyle displayMedium = GoogleFonts.nunito(
    fontSize: 45,
    fontWeight: FontWeight.w400,
  );

  static TextStyle displaySmall = GoogleFonts.nunito(
    fontSize: 36,
    fontWeight: FontWeight.w400,
  );

  static TextStyle headlineLarge = GoogleFonts.nunito(
    fontSize: 32,
    fontWeight: FontWeight.w600,
  );

  static TextStyle headlineMedium = GoogleFonts.nunito(
    fontSize: 28,
    fontWeight: FontWeight.w600,
  );

  static TextStyle headlineSmall = GoogleFonts.nunito(
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  // Titles
  static TextStyle titleLarge = GoogleFonts.nunito(
    fontSize: 22,
    fontWeight: FontWeight.w600,
  );

  static TextStyle titleMedium = GoogleFonts.nunito(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
  );

  static TextStyle titleSmall = GoogleFonts.nunito(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
  );

  // Body - System default for Mongolian support
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.5,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    height: 1.4,
  );

  // Labels
  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );
}
