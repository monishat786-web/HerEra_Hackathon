import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';

class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({super.key});

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
  int _selectedDateIndex = 3; // Today

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDateSelector(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                children: [
                   _buildSummaryCard(),
                   const SizedBox(height: 24),
                   _buildTimeline(),
                   const SizedBox(height: 32),
                   _buildFooter(),
                   const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary, size: 20),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        "Activities",
        style: GoogleFonts.quicksand(
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
          fontSize: 22,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.calendar_month_outlined, color: AppColors.textSecondary),
          onPressed: () {},
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildDateSelector() {
    final List<String> days = ["Fri 8", "Sat 9", "Sun 10", "Today", "Tue 13"];
    return Container(
      height: 60,
      margin: const EdgeInsets.only(top: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: days.length,
        itemBuilder: (context, index) {
          final isSelected = index == _selectedDateIndex;
          return GestureDetector(
            onTap: () => setState(() => _selectedDateIndex = index),
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: isSelected ? AppColors.primary : AppColors.softPurpleBorder),
                boxShadow: isSelected
                    ? [BoxShadow(color: AppColors.primary.withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 4))]
                    : [],
              ),
              alignment: Alignment.center,
              child: Text(
                days[index],
                style: GoogleFonts.inter(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                  color: isSelected ? Colors.white : AppColors.textSecondary,
                  fontSize: 14,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.softPurpleBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Today's Summary", style: GoogleFonts.quicksand(fontWeight: FontWeight.bold, fontSize: 16)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.mintGreen.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text("March 12", style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.mintGreen)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSummaryStat("8 hrs", "Tracked", Icons.timer_outlined),
              _buildSummaryStat("5", "Stops", Icons.location_on_outlined),
              _buildSummaryStat("3", "Safe Zones", Icons.security_rounded),
              _buildSummaryStat("1", "Caution", Icons.warning_amber_rounded),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryStat(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primary, size: 24),
        const SizedBox(height: 8),
        Text(value, style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textPrimary)),
        Text(label, style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary)),
      ],
    );
  }

  Widget _buildTimeline() {
    return Column(
      children: [
        _buildTimelineEntry(
          timeRange: "10:30 AM – 12:15 PM",
          duration: "1 hr 45 min",
          title: "Office / Workplace",
          address: "123 Main St, Chennai",
          type: "stop",
          status: "safe",
          statusText: "Safe area",
        ),
        _buildTimelineEntry(
          timeRange: "12:15 PM – 12:45 PM",
          duration: "30 min",
          title: "Traveling",
          address: "From: Office\nTo: Coffee Shop via Anna Salai",
          type: "transit",
          status: "caution",
          statusText: "Moderate risk",
        ),
        _buildTimelineEntry(
          timeRange: "12:45 PM – 01:30 PM",
          duration: "45 min",
          title: "Coffee Shop",
          address: "45 Cafe Ave, Chennai",
          type: "stop",
          status: "safe",
          statusText: "Safe area",
        ),
        _buildTimelineEntry(
          timeRange: "6:30 PM – 7:00 PM",
          duration: "30 min",
          title: "City Park",
          address: "Park Ave, Chennai",
          type: "stop",
          status: "alert",
          statusText: "Incident reported nearby",
          alertNote: "Suspicious activity at 6:45 PM",
          actionTriggered: "Fake call used",
        ),
      ],
    );
  }

  Widget _buildTimelineEntry({
    required String timeRange,
    required String duration,
    required String title,
    required String address,
    required String type,
    required String status,
    required String statusText,
    String? alertNote,
    String? actionTriggered,
  }) {
    Color getStatusColor() {
      switch (status) {
        case "safe": return AppColors.mintGreen;
        case "caution": return const Color(0xFFF59E0B); // Amber/Yellow
        case "alert": return AppColors.sosRed;
        default: return AppColors.border;
      }
    }

    IconData getStatusIcon() {
      switch (status) {
        case "safe": return Icons.check_circle_rounded;
        case "caution": return Icons.error_rounded;
        case "alert": return Icons.warning_rounded;
        default: return Icons.info_rounded;
      }
    }

    final statusColor = getStatusColor();

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Timeline indicator
          SizedBox(
            width: 30,
            child: Column(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: type == "stop" ? AppColors.primary : Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.primary, width: 3),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 2,
                    color: AppColors.border.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Content Card
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.withValues(alpha: 0.15)),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 10, offset: const Offset(0, 4)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(timeRange, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                                        const SizedBox(width: 8),
                                        const Icon(Icons.circle, size: 4, color: AppColors.textMuted),
                                        const SizedBox(width: 8),
                                        const Icon(Icons.access_time_rounded, size: 12, color: AppColors.textSecondary),
                                        const SizedBox(width: 4),
                                        Text(duration, style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Text(title, style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                                    const SizedBox(height: 6),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(top: 2),
                                          child: Icon(Icons.location_on_rounded, size: 14, color: AppColors.textMuted),
                                        ),
                                        const SizedBox(width: 6),
                                        Expanded(
                                          child: Text(
                                            address,
                                            style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary, height: 1.4),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: AppColors.background,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Stack(
                                    children: [
                                      Center(
                                        child: Icon(type == "stop" ? Icons.map_outlined : Icons.route_outlined, color: AppColors.primary.withValues(alpha: 0.3), size: 30),
                                      ),
                                      Center(
                                        child: Icon(Icons.location_on, color: type == "stop" ? AppColors.primary : Colors.transparent, size: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: statusColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(getStatusIcon(), size: 14, color: statusColor),
                                const SizedBox(width: 6),
                                Text(
                                  statusText,
                                  style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: statusColor),
                                ),
                              ],
                            ),
                          ),
                          if (alertNote != null || actionTriggered != null) ...[
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.background,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: AppColors.sosRed.withValues(alpha: 0.2)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (alertNote != null)
                                    Row(
                                      children: [
                                        const Icon(Icons.circle, size: 6, color: AppColors.sosRed),
                                        const SizedBox(width: 8),
                                        Expanded(child: Text(alertNote, style: GoogleFonts.inter(fontSize: 12, color: AppColors.textPrimary, fontWeight: FontWeight.w500))),
                                      ],
                                    ),
                                  if (alertNote != null && actionTriggered != null)
                                    const SizedBox(height: 8),
                                  if (actionTriggered != null)
                                    Row(
                                      children: [
                                        const Icon(Icons.phone_in_talk_rounded, size: 14, color: AppColors.primary),
                                        const SizedBox(width: 8),
                                        Text(actionTriggered, style: GoogleFonts.inter(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w600)),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.file_download_outlined, size: 20),
            label: Text("Export Daily Report", style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 14)),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primary,
              side: const BorderSide(color: AppColors.primary, width: 1.5),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock_outline_rounded, size: 14, color: AppColors.textMuted),
            const SizedBox(width: 6),
            Text(
              "Your history is stored encrypted on your device. Only you can access it.",
              style: GoogleFonts.inter(fontSize: 10, color: AppColors.textMuted),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ],
    );
  }
}
