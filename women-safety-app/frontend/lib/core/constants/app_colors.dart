import 'package:flutter/material.dart';

class AppColors {
  // Primary Gradient (Lavender to Deep Blue)
  static const Color lavender = Color(0xFFE6E6FA);
  static const Color deepBlue = Color(0xFF1A237E);
  static const Color softPurple = Color(0xFFB39DDB);
  static const Color skyBlue = Color(0xFF87CEEB);
  
  static const LinearGradient premiumGradient = LinearGradient(
    colors: [lavender, Color(0xFFD1C4E9), Color(0xFF5C6BC0), deepBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.3, 0.6, 1.0],
  );

  static const Color primarySoft = Color(0xFF9F7AEA);
  static const Color primaryDeep = Color(0xFF6B46C1);
  
  // Secondary
  static const Color mintGreen = Color(0xFF50C878);
  
  // Accents
  static const Color coral = Color(0xFFFF3B30);
  static const Color raspberry = Color(0xFFD32F2F);
  
  static const LinearGradient sosGradient = LinearGradient(
    colors: [coral, raspberry],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Backgrounds
  static const Color background = Color(0xFFFCFBFE);
  
  // Surface / Glassmorphism
  static Color glassSurface = Colors.white.withOpacity(0.15);
  static Color glassBorder = Colors.white.withOpacity(0.25);

  // Text
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xDAFFFFFF);
  
  // Risk Levels
  static const Color safe = Color(0xFF68D391);
  static const Color moderate = Color(0xFFF6E05E);
  static const Color highRisk = Color(0xFFF56565);
}
