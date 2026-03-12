import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';

class EvidenceLockerScreen extends StatelessWidget {
  const EvidenceLockerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 24),
            _buildVaultSummaryCard(),
            const SizedBox(height: 32),
            _buildFilterTabs(),
            const SizedBox(height: 24),
            _buildEvidenceList(),
            const SizedBox(height: 48),
          ],
        ),
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
        "Evidence Vault",
        style: GoogleFonts.quicksand(
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
          fontSize: 22,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search_rounded, color: AppColors.textSecondary),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.tune_rounded, color: AppColors.textSecondary),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildVaultSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColors.softPurpleBorder, width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Total Evidence Stored", style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
                  Text("24 Items", style: GoogleFonts.quicksand(fontSize: 24, fontWeight: FontWeight.bold)),
                ],
              ),
              const Icon(Icons.lock_outline_rounded, color: AppColors.primary, size: 32),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Storage: 1.2 GB / 5 GB", style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600)),
                        Text("24%", style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primary)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: 0.24,
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
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.mintGreen.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.link_rounded, color: AppColors.mintGreen, size: 14),
                    const SizedBox(width: 6),
                    Text(
                      "All Evidence Anchored",
                      style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.mintGreen),
                    ),
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.primary),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                child: Text(
                  "Verify Integrity",
                  style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primary),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          _buildTab("All", 24, true, Icons.grid_view_rounded),
          _buildTab("Audio", 12, false, Icons.mic_none_rounded),
          _buildTab("Video", 5, false, Icons.videocam_outlined),
          _buildTab("Photos", 4, false, Icons.image_outlined),
          _buildTab("Location", 3, false, Icons.location_on_outlined),
        ],
      ),
    );
  }

  Widget _buildTab(String label, int count, bool isActive, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: isActive ? AppColors.primary : AppColors.softPurpleBorder),
      ),
      child: Row(
        children: [
          Icon(icon, color: isActive ? Colors.white : AppColors.textSecondary, size: 16),
          const SizedBox(width: 8),
          Text(
            "$label $count",
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isActive ? Colors.white : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEvidenceList() {
    return Column(
      children: [
        _buildEvidenceCard(
          trigger: "SOS Activated",
          triggerColor: AppColors.sosRed,
          timestamp: "Monday, March 12 · 10:34 PM",
          location: "T. Nagar, Chennai",
          mediaTypes: ["audio", "location"],
          isVerified: true,
        ),
        const SizedBox(height: 16),
        _buildEvidenceCard(
          trigger: "Scream Detected",
          triggerColor: AppColors.sosRed,
          timestamp: "Monday, March 12 · 09:20 PM",
          location: "Anna Nagar, Chennai",
          mediaTypes: ["audio", "video"],
          isVerified: true,
        ),
        const SizedBox(height: 16),
        _buildEvidenceCard(
          trigger: "Manual Recording",
          triggerColor: AppColors.primary,
          timestamp: "Sunday, March 11 · 04:15 PM",
          location: "Marina Beach, Chennai",
          mediaTypes: ["photo", "location"],
          isVerified: true,
        ),
      ],
    );
  }

  Widget _buildEvidenceCard({
    required String trigger,
    required Color triggerColor,
    required String timestamp,
    required String location,
    required List<String> mediaTypes,
    required bool isVerified,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(width: 6, color: triggerColor),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(timestamp, style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary)),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(Icons.emergency_rounded, size: 14, color: triggerColor),
                                    const SizedBox(width: 6),
                                    Text(
                                      trigger,
                                      style: GoogleFonts.quicksand(fontSize: 16, fontWeight: FontWeight.bold, color: triggerColor),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          if (isVerified)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.mintGreen.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Row(
                                children: [
                                  Icon(Icons.verified_rounded, color: AppColors.mintGreen, size: 12),
                                  SizedBox(width: 4),
                                  Text("Verified", style: TextStyle(color: AppColors.mintGreen, fontSize: 9, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildMediaPreviews(mediaTypes),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined, size: 14, color: AppColors.textMuted),
                          const SizedBox(width: 6),
                          Text(location, style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
                        ],
                      ),
                      const Divider(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("View forensic details", style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primary)),
                          Row(
                            children: [
                              const Icon(Icons.ios_share_rounded, size: 18, color: AppColors.textSecondary),
                              const SizedBox(width: 16),
                              Icon(Icons.delete_outline_rounded, size: 18, color: Colors.grey.withValues(alpha: 0.5)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMediaPreviews(List<String> types) {
    return Row(
      children: types.map((type) {
        return Container(
          margin: const EdgeInsets.only(right: 12),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border.withValues(alpha: 0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(_getMediaIcon(type), size: 16, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(_getMediaLabel(type), style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.bold)),
            ],
          ),
        );
      }).toList(),
    );
  }

  IconData _getMediaIcon(String type) {
    switch (type) {
      case "audio": return Icons.graphic_eq_rounded;
      case "video": return Icons.play_circle_outline_rounded;
      case "photo": return Icons.image_outlined;
      case "location": return Icons.map_outlined;
      default: return Icons.insert_drive_file_outlined;
    }
  }

  String _getMediaLabel(String type) {
    switch (type) {
      case "audio": return "2:34 Audio";
      case "video": return "0:45 Video";
      case "photo": return "3 Photos";
      case "location": return "Route Path";
      default: return "Media";
    }
  }
}
