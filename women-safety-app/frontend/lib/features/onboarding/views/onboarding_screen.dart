import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/main_navigation.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentPage = index),
            children: [
              _buildSlide(
                title: "Your Safety, Our Priority",
                subtitle: "Smart features to keep you protected.",
                icon: Icons.security_rounded,
                color: AppColors.primarySoft,
              ),
              _buildSlide(
                title: "We listen only when you need us.",
                subtitle: "Your privacy is paramount. Activate features only when you feel unsafe.",
                icon: Icons.mic_none_rounded,
                color: AppColors.mintGreen,
                hasConsent: true,
              ),
              _buildSlide(
                title: "Enable Permissions",
                subtitle: "To work effectively, we need access to location, microphone, and notifications.",
                icon: Icons.settings_input_component_rounded,
                color: AppColors.coral,
                isFinal: true,
              ),
            ],
          ),
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDots(),
                ElevatedButton(
                  onPressed: () {
                    if (_currentPage < 2) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const MainNavigation()),
                      );
                    }
                  },
                  child: Text(_currentPage == 2 ? "Get Started" : "Next"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlide({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    bool hasConsent = false,
    bool isFinal = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 100, color: color),
          const SizedBox(height: 40),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          if (hasConsent) ...[
            const SizedBox(height: 40),
            Row(
              children: [
                Checkbox(value: true, onChanged: (_) {}),
                const Expanded(
                  child: Text(
                    "I agree to activate features only during emergencies.",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDots() {
    return Row(
      children: List.generate(
        3,
        (index) => Container(
          margin: const EdgeInsets.only(right: 5),
          width: _currentPage == index ? 20 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: _currentPage == index ? AppColors.primaryDeep : Colors.grey[300],
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
