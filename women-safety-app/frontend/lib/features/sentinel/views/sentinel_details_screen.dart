import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class SentinelDetailsScreen extends StatefulWidget {
  const SentinelDetailsScreen({super.key});

  @override
  State<SentinelDetailsScreen> createState() => _SentinelDetailsScreenState();
}

class _SentinelDetailsScreenState extends State<SentinelDetailsScreen> {
  double _sensitivity = 0.75;
  bool _shakeSOS = true;
  bool _fearDetection = true;
  bool _nightMode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Sentinel Configuration", style: TextStyle(fontWeight: FontWeight.w800)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildIllustrationCard(),
            const SizedBox(height: 32),
            const Text("SENSITIVITY SETTINGS", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 2, color: AppColors.textMuted)),
            const SizedBox(height: 16),
            _buildSensitivitySection(),
            const SizedBox(height: 32),
            const Text("ADVANCED CONTROLS", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 2, color: AppColors.textMuted)),
            const SizedBox(height: 16),
            _buildToggleItem(Icons.vibration_rounded, "Shake SOS", "Trigger alert by shaking your device rapidly", _shakeSOS, (v) => setState(() => _shakeSOS = v)),
            _buildToggleItem(Icons.psychology_rounded, "Fear Detection", "AI pulse and gait monitoring for distress", _fearDetection, (v) => setState(() => _fearDetection = v)),
            _buildToggleItem(Icons.nightlight_round, "Night Autonomous Mode", "Automatic elevation of risk sensitivity after sunset", _nightMode, (v) => setState(() => _nightMode = v)),
            _buildToggleItem(Icons.history_toggle_off_rounded, "Pre-Incident Buffer", "Continuous 10s audio/video caching for evidence", true, (v) {}),
          ],
        ),
      ),
    );
  }

  Widget _buildIllustrationCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
      ),
      child: const Column(
        children: [
          Icon(Icons.auto_awesome_rounded, color: AppColors.primary, size: 60),
          SizedBox(height: 20),
          Text(
            "Adaptive Protection Engine",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(height: 8),
          Text(
            "Sentinel AI adjusts to your surroundings to predict and prevent incidents.",
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textSecondary, fontSize: 13, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildSensitivitySection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("AI Risk Sensitivity", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("${(_sensitivity * 100).toInt()}%", style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w900)),
            ],
          ),
          const SizedBox(height: 12),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: AppColors.primary,
              inactiveTrackColor: AppColors.border,
              thumbColor: AppColors.primary,
              overlayColor: AppColors.primary.withValues(alpha: 0.1),
              trackHeight: 8,
            ),
            child: Slider(
              value: _sensitivity,
              onChanged: (v) => setState(() => _sensitivity = v),
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Conservative", style: TextStyle(fontSize: 10, color: AppColors.textMuted)),
              Text("High Protection", style: TextStyle(fontSize: 10, color: AppColors.textMuted)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildToggleItem(IconData icon, String title, String desc, bool value, ValueChanged<bool> onChanged) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(color: AppColors.surface, shape: BoxShape.circle),
            child: Icon(icon, color: AppColors.textPrimary, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                Text(desc, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11, height: 1.4)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Switch(
            value: value,
            onChanged: onChanged,
            activeTrackColor: AppColors.primary.withValues(alpha: 0.5),
            activeThumbColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
