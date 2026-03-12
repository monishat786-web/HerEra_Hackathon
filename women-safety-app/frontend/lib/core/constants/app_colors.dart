import 'package:flutter/material.dart';

class AppColors {
  // Brand Palette
  static const Color primary = Color(0xFF8B5CF6); // Soft Purple
  static const Color secondary = Color(0xFFEC4899); // Warm Pink Accent
  static const Color mintGreen = Color(0xFF10B981); // Safety indicator
  static const Color sosRed = Color(0xFFDC2626); // SOS Red

  // Risk Palette
  static const Color safe = Color(0xFF10B981);      // Mint Green
  static const Color caution = Color(0xFFFFB020);   // Amber
  static const Color highRisk = Color(0xFFDC2626);  // SOS Red

  // Neutrals (Light)
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textMuted = Color(0xFF9CA3AF);
  static const Color border = Color(0xFFE5E7EB);
  static const Color softPurpleBorder = Color(0xFFF3E8FF);

  // Neutrals (Dark)
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color textPrimaryDark = Color(0xFFF9FAFB);
  static const Color textSecondaryDark = Color(0xFF9CA3AF);

  // Gradients
  static const LinearGradient sentinelGradient = LinearGradient(
    colors: [primary, Color(0xFFA78BFA)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static final LinearGradient sosGradient = const RadialGradient(
    colors: [sosRed, Color(0xFFB91C1C)],
    center: Alignment.center,
    radius: 0.8,
  ).asLinearGradient(); // Rough approximation or just use RadialGradient in code

  // Glassmorphism helpers
  static final Color glassSurface = Colors.white.withValues(alpha: 0.1);
  static final Color glassBorder = Colors.white.withValues(alpha: 0.2);
}

extension on RadialGradient {
  LinearGradient asLinearGradient() => LinearGradient(colors: colors);
}
