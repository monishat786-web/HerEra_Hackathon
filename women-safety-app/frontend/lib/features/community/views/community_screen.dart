import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.secondary,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              _buildTopBar(),
              const SizedBox(height: 32),
              _buildImpactCard(),
              const SizedBox(height: 40),
              _buildLiveSOSSection(),
              const SizedBox(height: 40),
              _buildReportsSection(),
              const SizedBox(height: 40),
              _buildTrustedRespondersSection(),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(Icons.search_rounded, color: AppColors.textSecondary, size: 26),
        Text(
          "Community",
          style: GoogleFonts.quicksand(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const Icon(Icons.tune_rounded, color: AppColors.textSecondary, size: 26),
      ],
    );
  }

  Widget _buildImpactCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColors.softPurpleBorder, width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Your Impact",
                style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const Icon(Icons.verified_user_rounded, color: AppColors.primary, size: 22),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Trust Score: 85%", style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: 0.85,
                        backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                        minHeight: 6,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatEntry(Icons.favorite_rounded, "12", "Helped"),
              _buildStatEntry(Icons.check_circle_rounded, "8", "Verified"),
              _buildStatEntry(Icons.military_tech_rounded, "Gold", "Badge"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatEntry(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primary, size: 20),
        const SizedBox(height: 4),
        Text(value, style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16)),
        Text(label, style: GoogleFonts.inter(fontSize: 10, color: AppColors.textSecondary)),
      ],
    );
  }

  Widget _buildLiveSOSSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Text("🚨", style: TextStyle(fontSize: 18)),
                const SizedBox(width: 8),
                Text(
                  "Live SOS Alerts",
                  style: GoogleFonts.quicksand(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              children: [
                Text("2 nearby", style: GoogleFonts.inter(fontSize: 12, color: AppColors.sosRed, fontWeight: FontWeight.bold)),
                const SizedBox(width: 8),
                const Icon(Icons.refresh_rounded, color: AppColors.textMuted, size: 20),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        _buildSOSAlertCard(
          distance: "0.3 miles away",
          time: "2 min ago",
          status: "Active",
          statusColor: AppColors.sosRed,
          showHelp: true,
        ),
        const SizedBox(height: 16),
        _buildSOSAlertCard(
          distance: "1.2 miles away",
          time: "8 min ago",
          status: "Being Assisted",
          statusColor: Colors.orange,
          showHelp: false,
        ),
      ],
    );
  }

  Widget _buildSOSAlertCard({
    required String distance,
    required String time,
    required String status,
    required Color statusColor,
    required bool showHelp,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                radius: 20,
                child: const Icon(Icons.person_rounded, color: AppColors.primary, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("$distance · $time", style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        status,
                        style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.bold, color: statusColor),
                      ),
                    ),
                  ],
                ),
              ),
              if (showHelp)
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mintGreen,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                  child: Text("Help", style: GoogleFonts.inter(fontWeight: FontWeight.bold)),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReportsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Text("⚠️", style: TextStyle(fontSize: 18)),
                const SizedBox(width: 8),
                Text(
                  "Community Reports",
                  style: GoogleFonts.quicksand(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add_circle_outline_rounded, color: AppColors.primary),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildReportCard(
          location: "5th Ave & Main St",
          type: "Poor Lighting",
          icon: Icons.lightbulb_outline_rounded,
          verifiedBY: 3,
          time: "1 hour ago",
        ),
        const SizedBox(height: 12),
        _buildReportCard(
          location: "Besant Nagar Beach",
          type: "Suspicious Activity",
          icon: Icons.visibility_outlined,
          verifiedBY: 0,
          time: "45 mins ago",
        ),
      ],
    );
  }

  Widget _buildReportCard({
    required String location,
    required String type,
    required IconData icon,
    required int verifiedBY,
    required String time,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.textSecondary, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(location, style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 14)),
                    Text(type, style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
                  ],
                ),
              ),
              Text(time, style: GoogleFonts.inter(fontSize: 11, color: AppColors.textMuted)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    verifiedBY > 0 ? Icons.verified_rounded : Icons.info_outline_rounded,
                    size: 14,
                    color: verifiedBY > 0 ? AppColors.mintGreen : AppColors.textMuted,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    verifiedBY > 0 ? "Confirmed by $verifiedBY people" : "Unverified",
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: verifiedBY > 0 ? AppColors.mintGreen : AppColors.textMuted,
                      fontWeight: verifiedBY > 0 ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.thumb_up_alt_outlined, size: 14),
                label: Text("Verify", style: GoogleFonts.inter(fontSize: 12)),
                style: TextButton.styleFrom(visualDensity: VisualDensity.compact),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrustedRespondersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
             const Text("🤝", style: TextStyle(fontSize: 18)),
             const SizedBox(width: 8),
             Text(
               "Trusted Responders",
               style: GoogleFonts.quicksand(fontSize: 20, fontWeight: FontWeight.bold),
             ),
             const SizedBox(width: 4),
             const Icon(Icons.info_outline_rounded, size: 16, color: AppColors.textMuted),
          ],
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 140,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            children: [
              _buildResponderCard("Helper123", "98%", true),
              _buildResponderCard("SafetyFirst", "95%", true),
              _buildResponderCard("BraveHeart", "92%", false),
              _buildResponderCard("Guardian", "99%", true),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildResponderCard(String name, String score, bool isAvailable) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.softPurpleBorder, width: 1.5),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                radius: 22,
                child: const Icon(Icons.person_outline_rounded, color: AppColors.primary),
              ),
              if (isAvailable)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: AppColors.mintGreen,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Text(name, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
          Text(score, style: GoogleFonts.inter(fontSize: 12, color: AppColors.mintGreen, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
