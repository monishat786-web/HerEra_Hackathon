import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import '../../../core/constants/app_colors.dart';
import '../../legal/views/legal_rights_consent_screen.dart';
import '../../map/views/map_screen.dart';
import '../../evidence_locker/views/evidence_locker_screen.dart';
import '../../guardian/views/fake_incoming_call_screen.dart';

class AppGuideScreen extends StatefulWidget {
  const AppGuideScreen({super.key});

  @override
  State<AppGuideScreen> createState() => _AppGuideScreenState();
}

class _AppGuideScreenState extends State<AppGuideScreen> with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> _standardFeatures = const [
    {
      "title": "SOS BUTTON",
      "icon": Icons.emergency_rounded,
      "color": AppColors.sosRed,
      "desc": "Instant emergency trigger that alerts your trusted contacts with your live location. Activates recording and notifies nearby community volunteers."
    },
    {
      "title": "SCREAM DETECTION",
      "icon": Icons.mic_external_on_rounded,
      "color": Colors.redAccent,
      "desc": "Listens for distress screams and automatically triggers SOS if you cannot reach your phone. Works even when app is in background."
    },
    {
      "title": "SAFE ROUTE",
      "icon": Icons.alt_route_rounded,
      "color": AppColors.mintGreen,
      "desc": "Calculates the safest path to your destination considering crime data, lighting, and crowd density. Avoids high-risk areas automatically."
    },
    {
      "title": "EVIDENCE LOCKER",
      "icon": Icons.inventory_2_rounded,
      "color": Colors.lightBlue,
      "desc": "Securely stores photos, videos, and audio recordings captured during emergencies. Encrypted and accessible only to you and authorities."
    },
    {
      "title": "FAKE CALL",
      "icon": Icons.phone_callback_rounded,
      "color": Colors.purpleAccent,
      "desc": "Triggers a realistic fake incoming call to help you exit uncomfortable situations gracefully. Customize caller name and ringtone."
    },
    {
      "title": "AI ASSISTANCE",
      "icon": Icons.auto_awesome_rounded,
      "color": Color(0xFF8B5CF6),
      "desc": "Voice-activated safety companion that can guide you to safe zones, suggest actions, and discreetly call for help using natural language."
    },
    {
      "title": "COMMUNITY ALERTS",
      "icon": Icons.warning_amber_rounded,
      "color": Colors.orange,
      "desc": "Real-time reports of unsafe locations and suspicious activities from nearby users. Help others by reporting incidents anonymously."
    },
    {
      "title": "MAP",
      "icon": Icons.map_rounded,
      "color": Colors.green,
      "desc": "Interactive safety map showing risk zones, safe places, police stations, and active community volunteers in your area."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFE9D5FF), Color(0xFFC084FC), Color(0xFF1E3A8A)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Blurred background effect
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
            child: Container(color: Colors.transparent),
          ),
          
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      _buildProminentRightsCard(context),
                      const SizedBox(height: 32), // Visual Separator
                      ..._standardFeatures.map((feature) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _buildStandardFeatureCard(context, feature),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Pagination Indicator (Visual only)
          Positioned(
            right: 12,
            top: 200,
            bottom: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => Container(
                  width: 4,
                  height: index == 0 ? 20 : 8,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: index == 0 ? 0.8 : 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 24),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 24),
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Colors.white, Color(0xFFE9D5FF)],
            ).createShader(bounds),
            child: Text(
              "App Guide",
              style: GoogleFonts.quicksand(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
                ),
                child: Text(
                  "Hi Graceful",
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProminentRightsCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withValues(alpha: 0.3),
            blurRadius: 30,
            spreadRadius: 5,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: InkWell(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LegalRightsConsentScreen())),
            child: Container(
              padding: const EdgeInsets.all(28), // 20-25% Larger padding
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.6),
                  width: 2.0,
                ),
              ),
              child: Stack(
                children: [
                  // Decorative Corner Accents
                  const Positioned(
                    top: -5,
                    left: -5,
                    child: Icon(Icons.star_rounded, color: Colors.amber, size: 16),
                  ),
                  const Positioned(
                    bottom: -5,
                    right: -5,
                    child: Icon(Icons.star_rounded, color: Colors.amber, size: 16),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ScaleTransition(
                        scale: _pulseAnimation,
                        child: Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: Colors.purple.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.purple.withValues(alpha: 0.2),
                                blurRadius: 15,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: const Icon(Icons.gavel_rounded, color: Colors.purple, size: 40),
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ShaderMask(
                              shaderCallback: (bounds) => const LinearGradient(
                                colors: [Color(0xFF7C3AED), Color(0xFF4C1D95)],
                              ).createShader(bounds),
                              child: Text(
                                "KNOW YOUR RIGHTS",
                                style: GoogleFonts.quicksand(
                                  fontSize: 24, // Larger font
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Your complete guide to Indian women's legal protections and rights",
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                color: Colors.black,
                                height: 1.4,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStandardFeatureCard(BuildContext context, Map<String, dynamic> feature) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: InkWell(
          onTap: () {
            if (feature['title'] == "SAFE ROUTE" || feature['title'] == "MAP") {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const MapScreen()));
            } else if (feature['title'] == "EVIDENCE LOCKER") {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const EvidenceLockerScreen()));
            } else if (feature['title'] == "FAKE CALL") {
              final caller = (DateTime.now().second % 2 == 0) ? "Mom" : "Dad";
              Navigator.push(context, MaterialPageRoute(builder: (context) => FakeIncomingCallScreen(callerName: caller)));
            }
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withValues(alpha: 0.4), width: 1.5),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: feature['color'].withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(feature['icon'], color: feature['color'], size: 28),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        feature['title'],
                        style: GoogleFonts.quicksand(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        feature['desc'],
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: Colors.black,
                          height: 1.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
