import 'package:flutter/material.dart';
import 'dart:ui';
import '../../../core/constants/app_colors.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
            children: [
              const SizedBox(height: 20),
              _buildHeader(),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildSectionTitle("ACTIVE SOS ALERTS", Colors.redAccent),
                    const SizedBox(height: 15),
                    _buildPrimarySOSAlert(),
                    const SizedBox(height: 15),
                    _buildSecondarySOSAlert("Sarah M.", "0.8 miles away", "5 min ago"),
                    const SizedBox(height: 10),
                    _buildSecondarySOSAlert("Priya K.", "1.2 miles away", "12 min ago"),
                    
                    const SizedBox(height: 35),
                    
                    _buildSectionTitle("UNSAFE LOCATION REPORTS", Colors.orangeAccent),
                    const SizedBox(height: 15),
                    _buildReportCard(
                      title: "Harassment reported",
                      badge: "Suspicious Activity",
                      location: "Market Area",
                      time: "15 min ago",
                      badgeColor: Colors.orangeAccent,
                      description: "Group of men making inappropriate comments near the metro station exit.",
                      isExpandable: true,
                    ),
                    const SizedBox(height: 12),
                    _buildReportCard(
                      title: "Poor street lighting",
                      badge: "Unsafe Location",
                      location: "5th Avenue, Park Street",
                      time: "2 hours ago",
                      badgeColor: Colors.amber,
                    ),
                    const SizedBox(height: 12),
                    _buildReportCard(
                      title: "Group of men loitering",
                      badge: "Suspicious Activity",
                      location: "Metro Station Exit B",
                      time: "4 hours ago",
                      badgeColor: Colors.orangeAccent,
                    ),
                    
                    const SizedBox(height: 30),
                    _buildReportButton(),
                    const SizedBox(height: 100), // Padding for bottom nav
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        borderRadius: BorderRadius.circular(50),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(color: Colors.transparent),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: AppColors.glassBorder),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.cardShadow,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: const Text(
                "Community Alerts",
                style: TextStyle(
                  fontFamily: 'Playfair Display',
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                  color: AppColors.textPrimary,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, Color accentColor) {
    return Row(
      children: [
        Icon(Icons.circle, size: 10, color: accentColor),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildPrimarySOSAlert() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.redAccent.withValues(alpha: 0.3),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                child: Container(color: Colors.transparent),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.redAccent.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.redAccent.withValues(alpha: 0.5), width: 1.5),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withValues(alpha: 0.2),
                            border: Border.all(color: Colors.redAccent, width: 2),
                          ),
                          child: const Icon(Icons.person, color: Colors.black, size: 28),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "SOS ALERT",
                                    style: TextStyle(
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.redAccent.withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Text(
                                      "2 min ago",
                                      style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                "0.3 miles away",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Container(
                                     padding: const EdgeInsets.all(4),
                                     decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.1), shape: BoxShape.circle),
                                     child: const Icon(Icons.location_on, size: 14, color: Colors.black)
                                  ),
                                  const SizedBox(width: 6),
                                  const Text(
                                    "View Live Location Map",
                                    style: TextStyle(color: Colors.black, fontSize: 13, decoration: TextDecoration.underline),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.1),
                      border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.1))),
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mintGreen,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                      ),
                      icon: const Icon(Icons.directions_run_rounded, size: 22),
                      label: const Text(
                        "Provide Assistance",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
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

  Widget _buildSecondarySOSAlert(String name, String distance, String time) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(color: Colors.transparent),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.glassBorder),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.cardShadow,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.redAccent.withValues(alpha: 0.05),
                      border: Border.all(color: Colors.redAccent.withValues(alpha: 0.2)),
                    ),
                    child: const Icon(Icons.warning_amber_rounded, color: Colors.redAccent, size: 24),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "SOS from $name",
                          style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          distance,
                          style: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    time,
                    style: const TextStyle(color: AppColors.textMuted, fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportCard({
    required String title,
    required String badge,
    required String location,
    required String time,
    required Color badgeColor,
    String? description,
    bool isExpandable = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(color: Colors.transparent),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.glassBorder),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.cardShadow,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const CircleAvatar(
                                  radius: 14,
                                  backgroundColor: AppColors.primaryLight,
                                  child: Icon(Icons.person_outline, size: 16, color: AppColors.primaryDeep),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: badgeColor.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: badgeColor.withValues(alpha: 0.3)),
                                  ),
                                  child: Text(
                                    badge,
                                    style: TextStyle(color: badgeColor, fontSize: 11, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              time,
                              style: const TextStyle(color: AppColors.textMuted, fontSize: 12, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Text(
                          title,
                          style: const TextStyle(color: AppColors.textPrimary, fontSize: 17, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.location_on_outlined, color: AppColors.textSecondary, size: 18),
                            const SizedBox(width: 6),
                            Text(
                              location,
                              style: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
                            ),
                          ],
                        ),
                        if (isExpandable && description != null) ...[
                          const SizedBox(height: 12),
                          Text(
                            description,
                            style: const TextStyle(color: AppColors.textSecondary, fontSize: 14, height: 1.4),
                          ),
                        ]
                      ],
                    ),
                  ),
                  if (isExpandable)
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border(top: BorderSide(color: AppColors.glassBorder)),
                      ),
                      child: const Padding(
                         padding: EdgeInsets.symmetric(vertical: 8),
                         child: Icon(Icons.keyboard_arrow_up, color: AppColors.textMuted),
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportButton() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(color: Colors.transparent),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange.withValues(alpha: 0.8),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 18),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: Colors.orangeAccent.withValues(alpha: 0.5)),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_alert_rounded, size: 22),
                  SizedBox(width: 10),
                  Text(
                    "Report Suspicious Activity",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
