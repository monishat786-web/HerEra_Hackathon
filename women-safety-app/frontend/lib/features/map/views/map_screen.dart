import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../home/views/home_screen.dart'; // Import for the painter

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Full Screen Map Background
          Container(
            color: const Color(0xFFF3F4F6),
            child: CustomPaint(
              size: MediaQuery.of(context).size,
              painter: TamilNaduMapPainter(),
            ),
          ),
          
          // AI Monitoring Active Floating Chip
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10)],
                border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle)),
                  const SizedBox(width: 8),
                  const Text("AI Monitoring Active", style: TextStyle(color: AppColors.primary, fontSize: 11, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),

          // Floating Search Bar
          Positioned(
            top: MediaQuery.of(context).padding.top + 70,
            left: 20,
            right: 20,
            child: _buildSearchBar(),
          ),

          // Gesture Hint
          const Positioned(
            top: 200,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                children: [
                  Icon(Icons.zoom_in_rounded, color: Colors.black26, size: 32),
                  Text("Pinch to zoom Tamil Nadu", style: TextStyle(color: Colors.black26, fontSize: 12, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),

          // Bottom Sheet Panel
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildSafetyBottomSheet(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 20, offset: const Offset(0, 10)),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: const Row(
        children: [
          Icon(Icons.search_rounded, color: AppColors.textMuted),
          SizedBox(width: 12),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search destination in Tamil Nadu",
                border: InputBorder.none,
                hintStyle: TextStyle(color: AppColors.textMuted, fontSize: 14),
              ),
            ),
          ),
          Icon(Icons.mic_none_rounded, color: AppColors.primary),
        ],
      ),
    );
  }

  Widget _buildSafetyBottomSheet() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 40, offset: Offset(0, -10))],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2)),
            ),
          ),
          const SizedBox(height: 24),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Risk Forecast (Next 30 min)", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
              Text("LOW", style: TextStyle(color: AppColors.safe, fontWeight: FontWeight.w900)),
            ],
          ),
          const SizedBox(height: 20),
          _buildMetricRow("Crowd density", "Normal", 0.7, AppColors.safe),
          _buildMetricRow("Lighting risk", "Low", 0.9, AppColors.safe),
          _buildMetricRow("Police presence", "Moderate", 0.4, AppColors.caution),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 0,
              ),
              child: const Text(
                "Navigate Safely",
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 100), // Navigation spacing
        ],
      ),
    );
  }

  Widget _buildMetricRow(String label, String value, double progress, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(fontSize: 13, color: AppColors.textSecondary, fontWeight: FontWeight.w500)),
              Text(value, style: TextStyle(fontSize: 13, color: color, fontWeight: FontWeight.w800)),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: AppColors.border,
            color: color,
            minHeight: 6,
            borderRadius: BorderRadius.circular(3),
          ),
        ],
      ),
    );
  }
}
