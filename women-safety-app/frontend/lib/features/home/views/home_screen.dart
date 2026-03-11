import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:async';
import '../../../core/constants/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  
  // Night Safety Mode state
  bool _isNightModeActive = false;
  late AnimationController _nightPulseController;
  late Animation<double> _nightPulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
    _pulseAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeOut),
    );

    _nightPulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _nightPulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _nightPulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _nightPulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppColors.premiumGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                _buildStylishHeader(),
                const SizedBox(height: 40),
                _buildDetectionCenter(),
                const SizedBox(height: 50),
                _buildQuickActionsCard(),
                const SizedBox(height: 40),
                _buildNightSafetyModeCard(),
                const SizedBox(height: 40),
                _buildRiskLevelCard(),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStylishHeader() {
    return Column(
      children: [
        const Text(
          "herERA",
          style: TextStyle(
            fontFamily: 'Playfair Display',
            fontSize: 56,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Colors.black,
            letterSpacing: -2,
            height: 1.0,
          ),
        ),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Colors.white, Colors.white70],
          ).createShader(bounds),
          child: const Text(
            "Hi Graceful",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w300,
              color: Colors.black,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetectionCenter() {
    return Column(
      children: [
        Container(
          width: 250,
          height: 250,
          constraints: const BoxConstraints(
            maxWidth: 250,
            maxHeight: 250,
            minWidth: 250,
            minHeight: 250,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Pulsating Rings
              for (int i = 0; i < 3; i++)
                AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) {
                    double delay = i * 0.33;
                    double progress = (_pulseAnimation.value + delay) % 1.0;
                    return Opacity(
                      opacity: (1.0 - progress) * 0.5,
                      child: Container(
                        width: 70 + (progress * 180),
                        height: 70 + (progress * 180),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.coral, width: 2),
                        ),
                      ),
                    );
                  },
                ),
              // Mic Icon Wrapper
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned.fill(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(color: Colors.transparent),
                      ),
                    ),
                    Container(
                      width: 76,
                      height: 76,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.glassBorder),
                      ),
                      child: const Icon(Icons.mic, color: AppColors.coral, size: 40),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 25),
        const Text(
          "ACTIVE SCREAM DETECTION",
          style: TextStyle(
            color: Colors.black87,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
          ),
        ),
        const SizedBox(height: 40),
        _buildSOSButton(),
      ],
    );
  }

  Widget _buildSOSButton() {
    return Container(
      width: 160,
      height: 160,
      constraints: const BoxConstraints(
        maxWidth: 160,
        maxHeight: 160,
        minWidth: 160,
        minHeight: 160,
      ),
      decoration: const BoxDecoration(shape: BoxShape.circle),
      child: AspectRatio(
        aspectRatio: 1.0,
        child: GestureDetector(
          onTap: () {
            // Trigger SOS logic
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("SOS ALERT TRIGGERED!")),
            );
          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const RadialGradient(
                colors: [AppColors.coral, AppColors.raspberry],
                center: Alignment.center,
                radius: 0.8,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.coral.withOpacity(0.6),
                  blurRadius: 40,
                  spreadRadius: 5,
                ),
                const BoxShadow(
                  color: Colors.black26,
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: const Center(
              child: Text(
                "SOS",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActionsCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                child: Container(color: Colors.transparent),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.glassSurface,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: AppColors.glassBorder),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Quick Actions",
                    style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 120,
                    constraints: const BoxConstraints(maxHeight: 120, minHeight: 120),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildActionIcon(Icons.navigation_rounded, "Safe Route", AppColors.mintGreen),
                        _buildActionIcon(Icons.phone_in_talk_rounded, "Fake Call", Colors.teal, onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Fake Call triggered")),
                          );
                        }),
                        _buildActionIcon(Icons.folder_shared_rounded, "Evidence", AppColors.skyBlue),
                        _buildActionIcon(Icons.auto_awesome_rounded, "AI Assist", AppColors.softPurple),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionIcon(IconData icon, String label, Color color, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 70,
        height: 120,
        constraints: const BoxConstraints(
          maxWidth: 70,
          maxHeight: 120,
          minWidth: 70,
          minHeight: 120,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.12),
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.glassBorder),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(color: Colors.black, fontSize: 11, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNightSafetyModeCard() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: _isNightModeActive
            ? LinearGradient(
                colors: [const Color(0xFF1A1A2E).withOpacity(0.9), const Color(0xFF16213E).withOpacity(0.9)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: !_isNightModeActive ? AppColors.glassSurface : null,
        border: Border.all(color: _isNightModeActive ? AppColors.softPurple.withOpacity(0.5) : AppColors.glassBorder),
        boxShadow: [
          if (_isNightModeActive)
            BoxShadow(
              color: AppColors.softPurple.withOpacity(0.3),
              blurRadius: 20,
              spreadRadius: 2,
            ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // Moon Icon with animated glow
                        AnimatedBuilder(
                          animation: _nightPulseAnimation,
                          builder: (context, child) {
                            return Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                boxShadow: _isNightModeActive
                                    ? [
                                        BoxShadow(
                                          color: AppColors.softPurple.withOpacity(0.6),
                                          blurRadius: 15 * _nightPulseAnimation.value,
                                          spreadRadius: 2 * _nightPulseAnimation.value,
                                        ),
                                      ]
                                    : [],
                              ),
                              child: Icon(
                                Icons.nightlight_round,
                                color: _isNightModeActive ? AppColors.softPurple : Colors.grey[600],
                                size: 28,
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Night Safety Mode",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: _isNightModeActive ? Colors.white : Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: _isNightModeActive ? AppColors.softPurple.withOpacity(0.2) : Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: _isNightModeActive ? AppColors.softPurple : Colors.transparent,
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                _isNightModeActive ? "ACTIVE" : "INACTIVE",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: _isNightModeActive ? AppColors.softPurple : Colors.grey[600],
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Switch(
                      value: _isNightModeActive,
                      onChanged: (val) {
                        setState(() {
                          _isNightModeActive = val;
                          if (val) {
                            _nightPulseController.repeat(reverse: true);
                          } else {
                            _nightPulseController.stop();
                          }
                        });
                      },
                      activeColor: Colors.white,
                      activeTrackColor: AppColors.softPurple,
                      inactiveThumbColor: Colors.grey[400],
                      inactiveTrackColor: Colors.grey[300],
                    ),
                  ],
                ),
                
                // Collapsible Content
                AnimatedCrossFade(
                  firstChild: const SizedBox(width: double.infinity, height: 0),
                  secondChild: Column(
                    children: [
                      const SizedBox(height: 24),
                      // Risk & Safe Zones Row
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white.withOpacity(0.1)),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: AppColors.mintGreen, width: 3),
                              ),
                              child: const Center(
                                child: Text("LOW", style: TextStyle(color: AppColors.mintGreen, fontWeight: FontWeight.bold, fontSize: 12)),
                              ),
                            ),
                            const SizedBox(width: 16),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Protection ends in 5h 23m", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on, color: AppColors.skyBlue, size: 14),
                                      SizedBox(width: 4),
                                      Text("12 safe places nearby", style: TextStyle(color: Colors.white70, fontSize: 12)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Protection Features Grid
                      GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        childAspectRatio: 4.5,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        children: [
                          _buildTickItem("High-frequency tracking"),
                          _buildTickItem("Danger zone alerts"),
                          _buildTickItem("Accelerated SOS"),
                          _buildTickItem("Live location sharing"),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Quick Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal.withOpacity(0.8),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                              ),
                              onPressed: () {},
                              child: const Text("Share Live Trip", style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.softPurple.withOpacity(0.8),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                padding: const EdgeInsets.symmetric(vertical: 14),
                              ),
                              onPressed: () {},
                              child: const Text("Find Safe Route", style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Smart Alert Ticker
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.campaign_outlined, color: Colors.amber, size: 16),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "⚠️ Risk zone ahead - 500m • 🏪 Safe haven nearby - 24/7 pharmacy",
                                style: TextStyle(color: Colors.white70, fontSize: 12),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  crossFadeState: _isNightModeActive ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 300),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTickItem(String text) {
    return Row(
      children: [
        const Icon(Icons.check_circle, color: AppColors.mintGreen, size: 16),
        const SizedBox(width: 8),
        Expanded(child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 11), maxLines: 1, overflow: TextOverflow.ellipsis)),
      ],
    );
  }

  Widget _buildRiskLevelCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(color: Colors.transparent),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.glassBorder),
            ),
            child: Row(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: AppColors.mintGreen.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.verified_user_rounded, color: AppColors.mintGreen, size: 32),
                ),
                const SizedBox(width: 20),
                const Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Risk Level: Low", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
                      SizedBox(height: 4),
                      Text("Your area is safe. Stay aware.", style: TextStyle(color: Colors.black87, fontSize: 14)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
