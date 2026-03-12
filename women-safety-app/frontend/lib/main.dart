import 'package:flutter/material.dart';
import 'core/constants/app_themes.dart';
import 'features/auth/views/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const HerEraApp());
}

class HerEraApp extends StatelessWidget {
  const HerEraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HerEra Safety',
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
