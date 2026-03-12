import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../../features/legal/views/legal_screen.dart';
import '../../features/home/views/sos_history_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.background,
      child: Column(
        children: [
          _buildDrawerHeader(),
          const SizedBox(height: 20),
          _buildDrawerItem(
            context,
            Icons.history_rounded,
            "SOS History",
            () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SOSHistoryScreen())),
          ),
          _buildDrawerItem(
            context,
            Icons.gavel_rounded,
            "Legal & Regulations",
            () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LegalScreen())),
          ),
          _buildDrawerItem(context, Icons.shield_rounded, "Safety Guidelines", () {}),
          _buildDrawerItem(context, Icons.contact_support_rounded, "Support Center", () {}),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.all(24.0),
            child: Text(
              "herERA Sentinel v2.1.0",
              style: TextStyle(color: AppColors.textMuted, fontSize: 11, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 60, bottom: 30, left: 24, right: 24),
      decoration: const BoxDecoration(
        gradient: AppColors.sentinelGradient,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.security_rounded, color: Colors.white, size: 32),
          ),
          const SizedBox(height: 20),
          const Text(
            "herERA Sentinel",
            style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(
            "Personal AI Safety Assistant",
            style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textPrimary),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
      ),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
    );
  }
}
