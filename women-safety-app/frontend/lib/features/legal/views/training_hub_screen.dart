import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import '../../../core/constants/app_colors.dart';

class TrainingHubScreen extends StatefulWidget {
  const TrainingHubScreen({super.key});

  @override
  State<TrainingHubScreen> createState() => _TrainingHubScreenState();
}

class _TrainingHubScreenState extends State<TrainingHubScreen> {
  final List<Map<String, dynamic>> _lessons = [
    {
      "title": "Wrist Grab from Behind",
      "scenario": "Someone grabbing your wrist from behind",
      "duration": "5 min",
      "difficulty": "Beginner",
      "color": Colors.green
    },
    {
      "title": "Walking Home at Night",
      "scenario": "Followed while walking home at night",
      "duration": "8 min",
      "difficulty": "Intermediate",
      "color": Colors.orange
    },
    {
      "title": "Stranger Help Trap",
      "scenario": "Stranger asking for help to trap you",
      "duration": "6 min",
      "difficulty": "Advanced",
      "color": Colors.red
    },
    {
      "title": "Vehicle Abduction",
      "scenario": "Someone trying to pull you into a vehicle",
      "duration": "10 min",
      "difficulty": "Critical",
      "color": Colors.purple
    },
    {
      "title": "Public Transport Safety",
      "scenario": "Harassment in crowded public transport",
      "duration": "7 min",
      "difficulty": "Beginner",
      "color": Colors.green
    },
    {
      "title": "Break Bear Hug",
      "scenario": "Break free from bear hug",
      "duration": "5 min",
      "difficulty": "Intermediate",
      "color": Colors.orange
    },
  ];

  final List<Map<String, dynamic>> _travelEssentials = [
    {"icon": "🔦", "item": "Mini Torch", "proTip": "Keychain size, always accessible"},
    {"icon": "🔑", "item": "Safety Keychain", "proTip": "Keep between fingers"},
    {"icon": "📱", "item": "Power Bank", "proTip": "Charge before leaving"},
    {"icon": "💧", "item": "Pepper Spray", "proTip": "Quick access, not in bag"},
    {"icon": "🆔", "item": "Emergency ID", "proTip": "Keep in wallet"},
    {"icon": "📍", "item": "Location App", "proTip": "Pre-set trusted contacts"},
    {"icon": "🚨", "item": "Personal Alarm", "proTip": "Clip to bag zipper"},
    {"icon": "🩹", "item": "First Aid", "proTip": "Band-aids & antiseptic"},
    {"icon": "💊", "item": "Meds", "proTip": "Always in carry-on bag"},
    {"icon": "🧥", "item": "Scarf/Wrap", "proTip": "Lightweight multipurpose"},
  ];

  final List<String> _quickTips = [
    "Share live location before every solo trip",
    "Trust your intuition – if it feels wrong, leave",
    "Keep essentials in outer pocket, not deep in bag",
    "Learn one strong move perfectly, not many poorly"
  ];

  final Set<int> _packedItems = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFE9D5FF), Color(0xFFF3E8FF), Color(0xFFFFFFFF)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                _buildHeader(),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildProgressBanner(),
                        const SizedBox(height: 24),
                        _buildSectionHeader("Self Defense Scenarios", Icons.shield_rounded),
                        const SizedBox(height: 16),
                        _buildLessonsGrid(),
                        const SizedBox(height: 32),
                        _buildSectionHeader("Travel Essentials Checklist", Icons.backpack_rounded),
                        const SizedBox(height: 16),
                        _buildTravelChecklist(),
                        const SizedBox(height: 32),
                        _buildQuickTipsBanner(),
                        const SizedBox(height: 32),
                        _buildActionButtons(),
                        const SizedBox(height: 48),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF1E3A8A)),
        onPressed: () => Navigator.pop(context),
      ),
      expandedHeight: 120,
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.fromLTRB(60, 20, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Color(0xFF8B5CF6), Color(0xFF1E3A8A)],
                ).createShader(bounds),
                child: Text(
                  "Training Hub",
                  style: GoogleFonts.quicksand(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                "Learn to protect yourself – real scenarios, practical skills",
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: const Color(0xFF1E3A8A).withValues(alpha: 0.7),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
      pinned: true,
    );
  }

  Widget _buildProgressBanner() {
    return _buildGlassContainer(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF8B5CF6).withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.auto_awesome_rounded, color: Color(0xFF8B5CF6), size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "You've completed 2/6 lessons",
                  style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 4),
                LinearProgressIndicator(
                  value: 2 / 6,
                  backgroundColor: Colors.white.withValues(alpha: 0.5),
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF8B5CF6)),
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF1E3A8A), size: 24),
        const SizedBox(width: 12),
        Text(
          title,
          style: GoogleFonts.quicksand(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1E3A8A),
          ),
        ),
      ],
    );
  }

  Widget _buildLessonsGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemCount: _lessons.length,
      itemBuilder: (context, index) {
        final lesson = _lessons[index];
        return _buildLessonCard(lesson);
      },
    );
  }

  Widget _buildLessonCard(Map<String, dynamic> lesson) {
    return _buildGlassContainer(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: lesson['color'].withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  lesson['difficulty'],
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: lesson['color'],
                  ),
                ),
              ),
              Text(
                lesson['duration'],
                style: GoogleFonts.inter(fontSize: 10, color: Colors.grey[600]),
              ),
            ],
          ),
          const Spacer(),
          const Icon(Icons.play_circle_fill_rounded, color: Color(0xFF8B5CF6), size: 32),
          const SizedBox(height: 8),
          Text(
            lesson['title'],
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.quicksand(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          const SizedBox(height: 4),
          Text(
            lesson['scenario'],
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(fontSize: 10, color: Colors.grey[700]),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF8B5CF6)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: EdgeInsets.zero,
              ),
              child: Text(
                "Start Lesson",
                style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.bold, color: const Color(0xFF8B5CF6)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTravelChecklist() {
    return _buildGlassContainer(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _travelEssentials.length,
            itemBuilder: (context, index) {
              final item = _travelEssentials[index];
              final isPacked = _packedItems.contains(index);
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (isPacked) {
                      _packedItems.remove(index);
                    } else {
                      _packedItems.add(index);
                    }
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Text(item['icon'], style: const TextStyle(fontSize: 24)),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['item'],
                              style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            Text(
                              item['proTip'],
                              style: GoogleFonts.inter(fontSize: 11, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        isPacked ? Icons.check_box_rounded : Icons.check_box_outline_blank_rounded,
                        color: isPacked ? AppColors.mintGreen : Colors.grey[400],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.bookmark_rounded, size: 18),
                  label: const Text("Save Checklist"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E3A8A),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.share_rounded, color: Color(0xFF1E3A8A)),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white.withValues(alpha: 0.5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickTipsBanner() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Safety Quick Tips",
          style: GoogleFonts.quicksand(fontWeight: FontWeight.bold, color: const Color(0xFF1E3A8A)),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: _quickTips.length,
            itemBuilder: (context, index) {
              return Container(
                width: 250,
                margin: const EdgeInsets.only(right: 16),
                child: _buildGlassContainer(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(Icons.lightbulb_outline_rounded, color: Colors.orange, size: 30),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _quickTips[index],
                          style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500, height: 1.4),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        _buildBottomTile(
          icon: Icons.download_for_offline_rounded,
          title: "Download All Lessons",
          subtitle: "Offline PDF/Video pack",
          onTap: () {},
        ),
        const SizedBox(height: 12),
        _buildBottomTile(
          icon: Icons.notifications_active_rounded,
          title: "Setup Practice Reminders",
          subtitle: "Notification scheduler",
          onTap: () {},
        ),
        const SizedBox(height: 12),
        _buildBottomTile(
          icon: Icons.ios_share_rounded,
          title: "Share with Friends",
          subtitle: "Spread awareness",
          color: const Color(0xFF8B5CF6),
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildBottomTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: _buildGlassContainer(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Icon(icon, color: color ?? const Color(0xFF1E3A8A), size: 28),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: GoogleFonts.quicksand(fontWeight: FontWeight.bold, fontSize: 15)),
                  Text(subtitle, style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[600])),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassContainer({required Widget child, EdgeInsetsGeometry? padding}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: padding ?? const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withValues(alpha: 0.6), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}
