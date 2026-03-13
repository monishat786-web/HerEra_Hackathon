import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

class FakeActiveCallScreen extends StatefulWidget {
  final String callerName;

  const FakeActiveCallScreen({
    super.key,
    this.callerName = "Mom",
  });

  @override
  State<FakeActiveCallScreen> createState() => _FakeActiveCallScreenState();
}

class _FakeActiveCallScreenState extends State<FakeActiveCallScreen> {
  int _seconds = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _seconds++;
        });
      }
    });
  }

  String _formatDuration(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 60),
            // Timer & Caller Info
            _buildCallStatus(),
            const Spacer(),
            // Control Grid
            _buildControlGrid(),
            const SizedBox(height: 48),
            // End Call Button
            _buildEndCallButton(),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  Widget _buildCallStatus() {
    return Column(
      children: [
        Text(
          _formatDuration(_seconds),
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1C1C1E),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          widget.callerName,
          style: GoogleFonts.quicksand(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1C1C1E),
          ),
        ),
      ],
    );
  }

  Widget _buildControlGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Wrap(
        spacing: 40,
        runSpacing: 32,
        alignment: WrapAlignment.center,
        children: [
          _buildControlBtn(Icons.mic_off, "mute"),
          _buildControlBtn(Icons.dialpad, "keypad"),
          _buildControlBtn(Icons.volume_up, "speaker"),
          _buildControlBtn(Icons.add, "add call"),
          _buildControlBtn(Icons.videocam_off, "FaceTime"),
          _buildControlBtn(Icons.contacts, "contacts"),
        ],
      ),
    );
  }

  Widget _buildControlBtn(IconData icon, String label) {
    return SizedBox(
      width: 72,
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFE5E5EA), width: 1),
            ),
            child: Icon(icon, color: const Color(0xFF1C1C1E), size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: const Color(0xFF1C1C1E),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEndCallButton() {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        width: 72,
        height: 72,
        decoration: const BoxDecoration(
          color: Color(0xFFFF3B30),
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.call_end,
          color: Colors.white,
          size: 32,
        ),
      ),
    );
  }
}
