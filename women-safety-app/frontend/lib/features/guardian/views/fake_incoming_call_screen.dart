import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'fake_active_call_screen.dart';

class FakeIncomingCallScreen extends StatelessWidget {
  final String callerName;

  const FakeIncomingCallScreen({
    super.key,
    this.callerName = "Mom",
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 80),
            // Caller Info
            _buildCallerInfo(),
            const Spacer(),
            // Action Buttons
            _buildActionButtons(context),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  Widget _buildCallerInfo() {
    return Column(
      children: [
        // Avatar Placeholder
        Container(
          width: 100,
          height: 100,
          decoration: const BoxDecoration(
            color: Color(0xFFE5E5EA),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.person,
            size: 60,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          callerName,
          style: GoogleFonts.quicksand(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1C1C1E),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "mobile",
          style: GoogleFonts.inter(
            fontSize: 18,
            color: const Color(0xFF8E8E93),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Decline Button
          _buildCallButton(
            icon: Icons.call_end,
            label: "Decline",
            color: const Color(0xFFFF3B30),
            onTap: () => Navigator.pop(context),
          ),
          // Accept Button
          _buildCallButton(
            icon: Icons.call,
            label: "Accept",
            color: const Color(0xFF34C759),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => FakeActiveCallScreen(callerName: callerName),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCallButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 32,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: const Color(0xFF8E8E93),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
