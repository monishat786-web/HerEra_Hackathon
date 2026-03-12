import 'package:flutter/material.dart';

class AppColors {
  // Brand Palette
  static const Color primary = Color(0xFF6C4CF1); // Intelligent Safety Purple
  static const Color secondary = Color(0xFF8B5CF6);
  static const Color accent = Color(0xFF6C4CF1);

  // Risk Palette
  static const Color safe = Color(0xFF22C55E);      // Green
  static const Color caution = Color(0xFFFFB020);   // Amber
  static const Color highRisk = Color(0xFFFF3B30);  // Emergency Red

  // Neutrals (Light)
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF9FAFB);
  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF4B5563);
  static const Color textMuted = Color(0xFF9CA3AF);
  static const Color border = Color(0xFFE5E7EB);

  // Neutrals (Dark)
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color textPrimaryDark = Color(0xFFF9FAFB);
  static const Color textSecondaryDark = Color(0xFF9CA3AF);

  // Gradients
  static const LinearGradient sentinelGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [primary, Color(0xFF5A3DD1)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient dangerGradient = LinearGradient(
    colors: [highRisk, Color(0xFFD32F2F)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Glassmorphism helpers
  static final Color glassSurface = Colors.white.withValues(alpha: 0.1);
  static final Color glassBorder = Colors.white.withValues(alpha: 0.2);
}
