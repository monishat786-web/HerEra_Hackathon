import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';

class GuardianCallScreen extends StatefulWidget {
  const GuardianCallScreen({super.key});

  @override
  State<GuardianCallScreen> createState() => _GuardianCallScreenState();
}

class _GuardianCallScreenState extends State<GuardianCallScreen> with TickerProviderStateMixin {
  late AnimationController _waveController;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 60),
              _buildCallerInfo(),
              const Spacer(),
              _buildWaveform(),
              const SizedBox(height: 48),
              _buildTranscriptionPanel(),
              const Spacer(),
              _buildCallControls(),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCallerInfo() {
    return Column(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primary.withValues(alpha: 0.2), width: 8),
            boxShadow: [
              BoxShadow(color: AppColors.primary.withValues(alpha: 0.1), blurRadius: 40, spreadRadius: 10),
            ],
          ),
          child: CircleAvatar(
            backgroundColor: AppColors.primary.withValues(alpha: 0.1),
            child: const Icon(Icons.shield_moon_rounded, size: 60, color: AppColors.primary),
          ),
        ),
        const SizedBox(height: 32),
        Text(
          "Guardian AI",
          style: GoogleFonts.quicksand(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)),
            const SizedBox(width: 8),
            Text(
              "00:42 • ACTIVE MONITORING",
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.6),
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWaveform() {
    return AnimatedBuilder(
      animation: _waveController,
      builder: (context, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(15, (index) {
            double height = 15 + (50 * (0.5 * (1 + (index % 4 == 0 ? _waveController.value : 0.9 - _waveController.value))));
            return Container(
              width: 5,
              height: height,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: (index % 2 == 0) ? 0.9 : 0.5),
                borderRadius: BorderRadius.circular(2.5),
              ),
            );
          }),
        );
      },
    );
  }

  Widget _buildTranscriptionPanel() {
    return Container(
      padding: const EdgeInsets.all(28),
      margin: const EdgeInsets.symmetric(horizontal: 32),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          Text(
            "\"Grace, I am tracking your location. You are near a safe zone. Stay on the main road and I will keep monitoring.\"",
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 15,
              height: 1.6,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.emergency_recording_rounded, color: Colors.red, size: 14),
              const SizedBox(width: 8),
              Text(
                "FORENSIC TRANSCRIPTION ACTIVE",
                style: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.4),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCallControls() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildControlIcon(Icons.mic_off_rounded, "Mute"),
              _buildControlIcon(Icons.dialpad_rounded, "Keypad"),
              _buildControlIcon(Icons.volume_up_rounded, "Speaker"),
            ],
          ),
          const SizedBox(height: 48),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 72,
              height: 72,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: Colors.redAccent, blurRadius: 20, offset: Offset(0, 8)),
                ],
              ),
              child: const Icon(Icons.call_end_rounded, color: Colors.white, size: 36),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "End Session",
            style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildControlIcon(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 28),
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.7), fontSize: 12),
        ),
      ],
    );
  }
}
