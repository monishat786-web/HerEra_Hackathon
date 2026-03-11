import 'package:flutter/material.dart';
import 'dart:ui';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Use a map to track expanded state of each card
  final Map<String, bool> _expandedState = {
    'sos': true,
    'helplines': true,
    'personal': false,
    'contacts': false,
    'location': false,
    'privacy': false,
    'history': false,
    'settings': false,
  };

  void _toggleExpansion(String key) {
    setState(() {
      _expandedState[key] = !(_expandedState[key] ?? false);
    });
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch phone dialer for $phoneNumber')),
        );
      }
    }
  }

  void _confirmAndCall(String title, String number) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white.withOpacity(0.95),
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("Emergency Call", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        content: Text("Call $number for $title?", style: const TextStyle(color: Colors.black87)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: Colors.black54)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              Navigator.pop(context);
              _makePhoneCall(number);
            },
            child: const Text("Call Now", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppColors.premiumGradient,
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              _buildGreetingHeader(),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildGlassCollapsibleCard(
                      'sos',
                      'SOS Preferences',
                      Icons.error_outline_rounded,
                      Colors.redAccent,
                      _buildSOSPreferencesContent(),
                    ),
                    _buildGlassCollapsibleCard(
                      'helplines',
                      'Emergency Helplines',
                      Icons.phone_callback_rounded,
                      AppColors.mintGreen,
                      _buildHelplinesContent(),
                    ),
                    _buildGlassCollapsibleCard(
                      'personal',
                      'Basic Personal Info',
                      Icons.person_outline_rounded,
                      AppColors.softPurple,
                      _buildPersonalInfoContent(),
                    ),
                    _buildGlassCollapsibleCard(
                      'contacts',
                      'Emergency Contacts',
                      Icons.people_outline_rounded,
                      AppColors.skyBlue,
                      _buildEmergencyContactsContent(),
                    ),
                    _buildGlassCollapsibleCard(
                      'location',
                      'Location & Safety',
                      Icons.map_outlined,
                      AppColors.mintGreen,
                      _buildLocationSafetyContent(),
                    ),
                    _buildGlassCollapsibleCard(
                      'privacy',
                      'Privacy & Security',
                      Icons.lock_outline_rounded,
                      AppColors.softPurple,
                      _buildPrivacySecurityContent(),
                    ),
                    _buildGlassCollapsibleCard(
                      'history',
                      'Safety Activity History',
                      Icons.history_rounded,
                      AppColors.skyBlue,
                      _buildHistoryContent(),
                    ),
                    _buildGlassCollapsibleCard(
                      'settings',
                      'App Settings',
                      Icons.settings_outlined,
                      Colors.white70,
                      _buildAppSettingsContent(),
                    ),
                    const SizedBox(height: 80), // Padding for bottom nav
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGreetingHeader() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
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
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: AppColors.glassBorder),
              ),
              child: const Text(
                "Hi Graceful",
                style: TextStyle(
                  fontFamily: 'Playfair Display',
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                  color: Colors.black,
                  letterSpacing: 0.5,
                  shadows: [
                    Shadow(color: Colors.black26, offset: Offset(0, 2), blurRadius: 4),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassCollapsibleCard(
    String key,
    String title,
    IconData icon,
    Color iconColor,
    Widget content,
  ) {
    bool isExpanded = _expandedState[key] ?? false;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
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
                color: AppColors.glassSurface,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.glassBorder),
              ),
              child: Column(
                children: [
                  InkWell(
                    onTap: () => _toggleExpansion(key),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: iconColor.withOpacity(0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(icon, color: iconColor, size: 28),
                              ),
                              const SizedBox(width: 16),
                              Text(
                                title,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                            color: Colors.black,
                            size: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                  AnimatedCrossFade(
                    firstChild: Container(),
                    secondChild: Padding(
                      padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                      child: content,
                    ),
                    crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 300),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Card Contents ---

  Widget _buildSOSPreferencesContent() {
    return Column(
      children: [
        _buildSettingRow(
          "Auto-call Emergency Services",
          Switch(
            value: true,
            onChanged: (v) {},
            activeColor: AppColors.mintGreen,
          ),
        ),
        const SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Custom SOS Message", style: TextStyle(color: Colors.black87, fontSize: 13)),
            const SizedBox(height: 8),
            TextField(
              maxLines: 2,
              style: const TextStyle(color: Colors.black, fontSize: 14),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withOpacity(0.05),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppColors.glassBorder)),
                hintText: "I am in an emergency...",
                hintStyle: const TextStyle(color: Colors.white38),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHelplinesContent() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildHelplineGridItem(
                iconWidget: const Text("👮", style: TextStyle(fontSize: 32)),
                label: "Police",
                number: AppConstants.policeEmergencyNumber,
                color: AppColors.skyBlue,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildHelplineGridItem(
                iconWidget: const Text("🚑", style: TextStyle(fontSize: 32)),
                label: "Ambulance",
                number: AppConstants.ambulanceEmergencyNumber,
                color: Colors.redAccent,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildHelplineGridItem(
                iconWidget: const Text("🛡️", style: TextStyle(fontSize: 32)),
                label: "Women\nHelpline",
                number: AppConstants.womenHelplineNumber,
                color: AppColors.softPurple,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildInteractiveHelplineBtn(
          iconWidget: const Text("📞", style: TextStyle(fontSize: 26)),
          label: "Test Call",
          number: AppConstants.testCallNumber,
          isTest: true,
        ),
      ],
    );
  }

  Widget _buildHelplineGridItem({
    required Widget iconWidget,
    required String label,
    required String number,
    required Color color,
  }) {
    return InkWell(
      onTap: () => _confirmAndCall(label.replaceAll('\n', ' '), number),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.glassBorder),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: iconWidget,
            ),
            const SizedBox(height: 12),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.bold,
                height: 1.1,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              number,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.redAccent.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.call, color: Colors.white, size: 14),
                  SizedBox(width: 4),
                  Text("Call", style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalInfoContent() {
    return Column(
      children: [
        _buildInfoItem("Full Name", "Graceful One"),
        _buildInfoItem("DOB / Age", "12/05/1998 (27)"),
        _buildInfoItem("Phone", "+91 98765 43210"),
        _buildInfoItem("Email", "graceful@herera.com"),
      ],
    );
  }

  Widget _buildEmergencyContactsContent() {
    return Column(
      children: [
        _buildContactItem("Sarah (Mother)", "+91 91234 56789"),
        const SizedBox(height: 10),
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add_circle_outline, color: AppColors.skyBlue),
          label: const Text("Add New Contact", style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }

  Widget _buildLocationSafetyContent() {
    return Column(
      children: [
        _buildSettingRow("Live Location Sharing", Switch(value: false, onChanged: (v) {}, activeColor: AppColors.mintGreen)),
        _buildSettingRow("Auto-share location on SOS", const Icon(Icons.check_box, color: AppColors.skyBlue)),
        const SizedBox(height: 10),
        const Row(
          children: [
            Chip(label: Text("Home"), avatar: Icon(Icons.home, size: 16)),
            SizedBox(width: 8),
            Chip(label: Text("Office"), avatar: Icon(Icons.work, size: 16)),
          ],
        ),
      ],
    );
  }

  Widget _buildPrivacySecurityContent() {
    return Column(
      children: [
        _buildSettingRow("Change Password", const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.black87)),
        _buildSettingRow("Biometric Auth", Switch(value: true, onChanged: (v) {}, activeColor: AppColors.mintGreen)),
      ],
    );
  }

  Widget _buildHistoryContent() {
    return const Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text("SOS Alert Triggered", style: TextStyle(color: Colors.black, fontSize: 14)),
          subtitle: Text("Mar 08, 22:45", style: TextStyle(color: Colors.black54, fontSize: 12)),
          trailing: Icon(Icons.chevron_right, color: Colors.white30),
        ),
      ],
    );
  }

  Widget _buildAppSettingsContent() {
    return Column(
      children: [
        _buildSettingRow("Language", const Text("English", style: TextStyle(color: Colors.black))),
        const SizedBox(height: 10),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Vibration Intensity", style: TextStyle(color: Colors.black87, fontSize: 13)),
            Slider(value: 0.7, onChanged: null),
          ],
        ),
      ],
    );
  }

  // --- Helper Widgets ---

  Widget _buildSettingRow(String label, Widget action) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.black87, fontSize: 14)),
          action,
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(color: Colors.black54, fontSize: 12)),
              Text(value, style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500)),
            ],
          ),
          const Icon(Icons.edit_outlined, size: 16, color: AppColors.skyBlue),
        ],
      ),
    );
  }

  Widget _buildInteractiveHelplineBtn({
    required Widget iconWidget,
    required String label,
    required String number,
    bool isTest = false,
  }) {
    return InkWell(
      onTap: () => _confirmAndCall(label, number),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isTest ? Colors.white.withOpacity(0.1) : Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.glassBorder),
        ),
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isTest ? Colors.grey.withOpacity(0.2) : Colors.redAccent.withOpacity(0.2), 
                shape: BoxShape.circle
              ),
              child: iconWidget,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 2),
                  Text("Tap to call $number", style: const TextStyle(color: Colors.black54, fontSize: 13)),
                ],
              ),
            ),
            IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Added $label to Speed Dial/SOS Quick Access.')),
                );
              },
              icon: Icon(Icons.star_border, color: AppColors.softPurple),
              tooltip: "Add to SOS Quick Access",
            ),
            const SizedBox(width: 12),
            Icon(Icons.call, color: isTest ? Colors.grey : Colors.redAccent),
          ],
        ),
      ),
    );
  }


  Widget _buildContactItem(String name, String phone) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500)),
            Text(phone, style: const TextStyle(color: Colors.black54, fontSize: 12)),
          ],
        ),
        const Row(
          children: [
            Icon(Icons.edit, size: 18, color: Colors.black54),
            SizedBox(width: 15),
            Icon(Icons.delete_outline_rounded, size: 18, color: Colors.black54),
          ],
        ),
      ],
    );
  }
}
