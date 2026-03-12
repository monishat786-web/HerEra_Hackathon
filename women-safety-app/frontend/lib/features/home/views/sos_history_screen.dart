import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';

class SOSHistoryScreen extends StatelessWidget {
  const SOSHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for Safety Activities
    final List<Map<String, dynamic>> mockHistory = [
      {
        'date': 'Today, March 12',
        'time': '10:34 PM',
        'location': 'T. Nagar, Chennai',
        'reason': 'Triple Tap SOS',
        'type': 'Emergency',
        'icon': Icons.emergency_rounded,
        'color': AppColors.sosRed,
        'recording': '0:45 Record'
      },
      {
        'date': 'March 10, 2024',
        'time': '08:15 PM',
        'location': 'Anna Nagar, Chennai',
        'reason': 'Scream Detected',
        'type': 'AI Alert',
        'icon': Icons.graphic_eq_rounded,
        'color': AppColors.sosRed,
        'recording': '1:20 Record'
      },
      {
        'date': 'March 08, 2024',
        'time': '04:40 PM',
        'location': 'Marina Beach, Chennai',
        'reason': 'Manual Video Log',
        'type': 'Manual',
        'icon': Icons.videocam_rounded,
        'color': AppColors.primary,
        'recording': '3:10 Video'
      },
      {
        'date': 'March 05, 2024',
        'time': '09:00 AM',
        'location': 'Central Station',
        'reason': 'Fall Detected',
        'type': 'Safety Assist',
        'icon': Icons.sensors_rounded,
        'color': Colors.orange,
        'recording': 'No Media'
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          _buildFilterBar(),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(20),
              itemCount: mockHistory.length,
              itemBuilder: (context, index) {
                return _buildHistoryCard(context, mockHistory[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary, size: 20),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        "Safety Activities",
        style: GoogleFonts.quicksand(
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
          fontSize: 22,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.download_outlined, color: AppColors.textSecondary),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildFilterBar() {
    return Container(
      height: 60,
      color: Colors.white,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          _buildFilterChip("All Logs", true),
          _buildFilterChip("SOS Alerts", false),
          _buildFilterChip("AI Sessions", false),
          _buildFilterChip("Manual", false),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isActive) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : AppColors.background,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: isActive ? AppColors.primary : AppColors.border),
      ),
      child: Center(
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isActive ? Colors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryCard(BuildContext context, Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(width: 6, color: item['color']),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: (item['color'] as Color).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Icon(item['icon'], color: item['color'], size: 14),
                                const SizedBox(width: 6),
                                Text(
                                  item['type'],
                                  style: GoogleFonts.inter(
                                    color: item['color'],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            item['time'],
                            style: GoogleFonts.inter(color: AppColors.textSecondary, fontSize: 11),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        item['reason'],
                        style: GoogleFonts.quicksand(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined, color: AppColors.textSecondary, size: 14),
                          const SizedBox(width: 4),
                          Text(
                            "${item['location']} • ${item['date']}",
                            style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                      if (item['recording'] != 'No Media') ...[
                        const SizedBox(height: 20),
                        _buildMiniPlayback(item['recording']),
                      ],
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMiniPlayback(String duration) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(Icons.play_circle_fill_rounded, color: AppColors.primary, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Safety Evidence", style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.bold)),
                    Text(duration, style: GoogleFonts.inter(fontSize: 10, color: AppColors.textSecondary)),
                  ],
                ),
                const SizedBox(height: 4),
                ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: const LinearProgressIndicator(
                    value: 0.4,
                    minHeight: 3,
                    backgroundColor: Colors.white,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
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
