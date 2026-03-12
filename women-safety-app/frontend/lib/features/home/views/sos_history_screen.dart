import 'package:flutter/material.dart';
import 'dart:ui';
import '../../../core/constants/app_colors.dart';

class SOSHistoryScreen extends StatelessWidget {
  const SOSHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for SOS history
    final List<Map<String, String>> mockHistory = [
      {
        'date': '2024-05-20',
        'time': '22:15',
        'location': 'Chennai Central',
        'reason': 'Triple Tap SOS',
        'recording': 'scream_1716221700.m4a'
      },
      {
        'date': '2024-05-18',
        'time': '19:40',
        'location': 'Besant Nagar',
        'reason': 'Automatic Scream Detection',
        'recording': 'scream_1716042000.m4a'
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("SOS HISTORY", style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.primaryDeep,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: mockHistory.length,
        itemBuilder: (context, index) {
          final item = mockHistory[index];
          return _buildHistoryCard(context, item);
        },
      ),
    );
  }

  Widget _buildHistoryCard(BuildContext context, Map<String, String> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.glassBorder),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.raspberry.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        item['reason']!,
                        style: const TextStyle(
                          color: AppColors.raspberry,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    Text(
                      "${item['date']} | ${item['time']}",
                      style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: AppColors.primaryDeep, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      item['location']!,
                      style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildPlaybackBar(context, item['recording']!),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlaybackBar(BuildContext context, String fileName) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.primaryLight.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.play_arrow_rounded, color: AppColors.primaryDeep),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Emergency Recording", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                SizedBox(height: 4),
                LinearProgressIndicator(
                  value: 0.4,
                  backgroundColor: Colors.white24,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryDeep),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.download_rounded, color: AppColors.primaryDeep, size: 20),
          ),
        ],
      ),
    );
  }
}
