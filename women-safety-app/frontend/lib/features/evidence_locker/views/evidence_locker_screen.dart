import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class EvidenceLockerScreen extends StatelessWidget {
  const EvidenceLockerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Evidence Vault", style: TextStyle(fontWeight: FontWeight.w800)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildVaultDashboard(),
          Expanded(child: _buildForensicTimeline()),
        ],
      ),
    );
  }

  Widget _buildVaultDashboard() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(color: AppColors.primary.withValues(alpha: 0.2), blurRadius: 20, offset: const Offset(0, 10)),
        ],
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Total Incidents", style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.bold)),
                  Text("12", style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900)),
                ],
              ),
              Icon(Icons.lock_rounded, color: Colors.white, size: 40),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _buildMetric("Storage", "85%", Icons.cloud_done_rounded),
              _buildDivider(),
              _buildMetric("Privacy", "Max", Icons.security_rounded),
              _buildDivider(),
              _buildMetric("Syncing", "Live", Icons.sync_rounded),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetric(String label, String value, IconData icon) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: Colors.white70, size: 16),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
          Text(label, style: const TextStyle(color: Colors.white60, fontSize: 10)),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(height: 30, width: 1, color: Colors.white12);
  }

  Widget _buildForensicTimeline() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      children: [
        const Text("PROFESSIONAL FORENSIC TIMELINE", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 2, color: AppColors.textMuted)),
        const SizedBox(height: 20),
        _buildIncidentCard("Mar 12, 10:45 PM", "Chennai - Anna Nagar", Icons.mic_rounded, "Audio Buffer", true),
        const SizedBox(height: 16),
        _buildIncidentCard("Mar 11, 08:20 PM", "Chennai - T. Nagar", Icons.videocam_rounded, "Video Log", true),
        const SizedBox(height: 16),
        _buildIncidentCard("Mar 09, 11:15 PM", "Chennai - Velachery", Icons.sensors_rounded, "Pulse Data", false),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildIncidentCard(String time, String location, IconData icon, String type, bool isSecured) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.1), shape: BoxShape.circle),
                child: Icon(icon, color: AppColors.primary, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(time, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    Text(location, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(type, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppColors.textPrimary)),
              if (isSecured)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.safe.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.verified_user_rounded, color: AppColors.safe, size: 12),
                      SizedBox(width: 6),
                      Text("Cryptographically Secured", style: TextStyle(color: AppColors.safe, fontSize: 9, fontWeight: FontWeight.w800)),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
