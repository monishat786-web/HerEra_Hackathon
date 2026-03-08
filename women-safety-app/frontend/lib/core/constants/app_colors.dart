import 'package:flutter/material.dart';

class AppColors {
  // Primary Gradient
  static const Color primarySoft = Color(0xFF9F7AEA);
  static const Color primaryDeep = Color(0xFF6B46C1);
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primarySoft, primaryDeep],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Secondary
  static const Color mintGreen = Color(0xFF68D391);
  
  // Accents
  static const Color coral = Color(0xFFFF6B6B);
  static const Color raspberry = Color(0xFFE53E3E);
  static const LinearGradient sosGradient = LinearGradient(
    colors: [coral, raspberry],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Backgrounds
  static const Color background = Color(0xFFFCFBFE);
  
  // Surface / Glassmorphism
  static Color glassSurface = Colors.white.withOpacity(0.7);

  // Text
  static const Color textPrimary = Color(0xFF2D3748);
  static const Color textSecondary = Color(0xFF718096);
  
  // Risk Levels
  static const Color safe = Color(0xFF68D391);
  static const Color moderate = Color(0xFFF6E05E);
  static const Color highRisk = Color(0xFFF56565);
}
