import 'package:flutter/material.dart';
import 'dart:async';
import '../../home/views/home_screen.dart'; // For the map painter

class SOSActiveScreen extends StatefulWidget {
  const SOSActiveScreen({super.key});

  @override
  State<SOSActiveScreen> createState() => _SOSActiveScreenState();
}

class _SOSActiveScreenState extends State<SOSActiveScreen> with TickerProviderStateMixin {
  late AnimationController _pulseController;
  int _countdown = 5;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        setState(() => _countdown--);
      }
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFB71C1C), Color(0xFFE53935)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 48),
              _buildPulsingHeader(),
              const Spacer(),
              _buildMiniMap(),
              const Spacer(),
              _buildStatusPanel(),
              const SizedBox(height: 40),
              _buildCancelButton(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPulsingHeader() {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withValues(alpha: 0.2 + (_pulseController.value * 0.4)), width: 2),
              ),
              child: const Icon(Icons.emergency_rounded, color: Colors.white, size: 60),
            ),
            const SizedBox(height: 32),
            const Text(
              "Emergency Signal Broadcasting",
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
                const SizedBox(width: 8),
                const Text("LIVE RECORDING ACTIVE", style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildMiniMap() {
    return Container(
      width: 280,
      height: 280,
      decoration: BoxDecoration(
        color: Colors.white10,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white24, width: 4),
      ),
      child: ClipOval(
        child: Stack(
          children: [
            CustomPaint(
              size: const Size(280, 280),
              painter: TamilNaduMapPainter(),
            ),
            const Center(
              child: Icon(Icons.my_location_rounded, color: Colors.blue, size: 30),
            ),
            const Positioned(
              bottom: 40,
              left: 40,
              right: 40,
              child: Center(
                child: Text(
                  "LAT: 13.0827 | LNG: 80.2707",
                  style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusPanel() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: const Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)),
              SizedBox(width: 16),
              Text("Nearby Helpers Connecting...", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
            ],
          ),
          SizedBox(height: 16),
          Text("Network Relay Status: ENCRYPTED & ACTIVE", style: TextStyle(color: Colors.white54, fontSize: 10, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildCancelButton() {
    return Column(
      children: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(
            backgroundColor: Colors.black.withValues(alpha: 0.3),
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          child: Text(
            "Cancel SOS ($_countdown)",
            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 12),
        const Text("Release to trigger if not in safe zone", style: TextStyle(color: Colors.white38, fontSize: 11)),
      ],
    );
  }
}
