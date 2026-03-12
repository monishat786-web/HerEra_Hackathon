import 'package:flutter/material.dart';

class AppColors {
  // Primary Palette
  static const Color primaryDeep = Color(0xFF6B46C1);
  static const Color primarySoft = Color(0xFF9F7AEA);
  static const Color primaryLight = Color(0xFFF3E8FF);
  
  // Professional Neutrals
  static const Color deepBlue = Color(0xFF1A237E);
  static const Color lavender = Color(0xFFE6E6FA);
  static const Color skyBlue = Color(0xFF87CEEB);
  static const Color softPurple = Color(0xFFB39DDB);
  
  // Accent Colors
  static const Color mintGreen = Color(0xFF00A67E); // Slightly more professional green
  static const Color coral = Color(0xFFFF4D4D);
  static const Color raspberry = Color(0xFFD32F2F);
  
  static const LinearGradient premiumGradient = LinearGradient(
    colors: [Colors.white, Color(0xFFF8F9FE), Color(0xFFF0F4FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient sosGradient = LinearGradient(
    colors: [coral, raspberry],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Backgrounds & Surfaces
  static const Color background = Colors.white;
  static const Color surface = Color(0xFFF9FAFB);
  static const Color cardShadow = Color(0x0F000000);
  
  // Professional Glassmorphism (Adjusted for white background)
  static Color glassSurface = Colors.white.withValues(alpha: 0.8);
  static Color glassBorder = Colors.grey.withValues(alpha: 0.15);

  // Text Colors
  static const Color textPrimary = Color(0xFF111827); // Darker for readability
  static const Color textSecondary = Color(0xFF4B5563);
  static const Color textMuted = Color(0xFF9CA3AF);
  
  // Risk Levels (Professional palette)
  static const Color safe = Color(0xFF10B981);
  static const Color moderate = Color(0xFFF59E0B);
  static const Color highRisk = Color(0xFFEF4444);
}
