import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:record/record.dart';
import 'dart:async';
import '../../../core/constants/app_colors.dart';
import 'sos_history_screen.dart';
import '../../profile/views/profile_screen.dart';
import '../../sos/views/sos_active_screen.dart';
import '../../guardian/views/guardian_call_screen.dart';
import '../../evidence_locker/views/evidence_locker_screen.dart';
import '../../map/views/map_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _glowController;
  late AudioRecorder _recorder;
  StreamSubscription? _accelerometerSubscription;
  bool _isRecording = false;
  double _dragOffset = 0.0;
  static const double _dragThreshold = 100.0;
  int _tapCount = 0;
  Timer? _tapTimer;

  @override
  void initState() {
    super.initState();
    _recorder = AudioRecorder();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _initSensors();
  }

  void _initSensors() {
    _accelerometerSubscription = userAccelerometerEventStream().listen((UserAccelerometerEvent event) {
      // Simple shake detection logic
      double acceleration = event.x.abs() + event.y.abs() + event.z.abs();
      if (acceleration > 30) {
        _triggerSOS("Shake Detected");
      }
    });
  }

  Future<void> _startRecording() async {
    if (await _recorder.hasPermission()) {
      setState(() => _isRecording = true);
      // In a real app, you'd specify a path
      await _recorder.start(const RecordConfig(), path: ''); 
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Scream Detect: Recording Active"), backgroundColor: AppColors.primary),
      );
    }
  }

  Future<void> _stopRecording() async {
    await _recorder.stop();
    setState(() => _isRecording = false);
  }

  void _triggerSOS(String source) {
    setState(() {
      _tapCount = 0;
      _tapTimer?.cancel();
    });
    Navigator.push(context, MaterialPageRoute(builder: (context) => const SOSActiveScreen()));
  }

  void _handleSOSClick() {
    setState(() {
      _tapCount++;
      _tapTimer?.cancel();
      _tapTimer = Timer(const Duration(seconds: 2), () {
        setState(() => _tapCount = 0);
      });
    });

    if (_tapCount >= 3) {
      _triggerSOS("Triple Tap");
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _glowController.dispose();
    _accelerometerSubscription?.cancel();
    _recorder.dispose();
    _tapTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 16),
              _buildTopBar(),
              const SizedBox(height: 32),
              _buildGreeting(),
              const SizedBox(height: 24),
              _buildLocationStatus(),
              const SizedBox(height: 40),
              _buildSOSSection(),
              const SizedBox(height: 48),
              _buildCardsSection(),
              const SizedBox(height: 24),
              _buildQuickActions(),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SOSHistoryScreen())),
          child: Row(
            children: [
              const Icon(Icons.calendar_today_outlined, color: AppColors.textPrimary, size: 22),
              const SizedBox(width: 8),
              Text(
                "Activities",
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen())),
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.3), width: 2),
            ),
            child: CircleAvatar(
              backgroundColor: AppColors.primary.withValues(alpha: 0.1),
              child: Text(
                "G",
                style: GoogleFonts.quicksand(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGreeting() {
    return Column(
      children: [
        Text(
          "Good Evening, Graceful",
          style: GoogleFonts.quicksand(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "Stay Brave, Stay Calm",
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildLocationStatus() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: const BoxDecoration(
            color: AppColors.mintGreen,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          "Location ON",
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildSOSSection() {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [

        // Left Hint: Scream Detect
        Positioned(
          left: -70,
          child: Column(
            children: [
              const Icon(Icons.arrow_downward_rounded, color: AppColors.textMuted, size: 24),
              const Icon(Icons.mic_none_rounded, color: AppColors.textSecondary, size: 32),
              const SizedBox(height: 4),
              Text(
                "Scream\nDetect",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textSecondary),
              ),
            ],
          ),
        ),

        // Right Hint: Shake 3x
        Positioned(
          right: -70,
          child: Column(
            children: [
              const Stack(
                alignment: Alignment.center,
                children: [
                   Icon(Icons.vibration_rounded, color: AppColors.textSecondary, size: 40),
                   Icon(Icons.phone_android_rounded, color: AppColors.textSecondary, size: 28),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                "Shake 3x",
                style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textSecondary),
              ),
            ],
          ),
        ),

        // Main SOS Button
        GestureDetector(
          onVerticalDragUpdate: (details) {
            setState(() {
              _dragOffset += details.primaryDelta!;
              if (_dragOffset > _dragThreshold && !_isRecording) {
                _startRecording();
              }
            });
          },
          onVerticalDragEnd: (details) {
            setState(() {
              _dragOffset = 0;
              if (_isRecording) {
                _stopRecording();
              }
            });
          },
          onTap: _handleSOSClick,
          child: AnimatedBuilder(
            animation: _glowController,
            builder: (context, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.sosRed,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.sosRed.withValues(alpha: 0.3 + (_glowController.value * 0.2)),
                          blurRadius: 30 + (_glowController.value * 15),
                          spreadRadius: 5 + (_glowController.value * 5),
                        ),
                      ],
                      gradient: const RadialGradient(
                        colors: [AppColors.sosRed, Color(0xFFB91C1C)],
                        center: Alignment(-0.2, -0.2),
                        radius: 0.6,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "SOS",
                        style: GoogleFonts.quicksand(
                          color: Colors.white,
                          fontSize: 54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  if (_tapCount > 0)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          "$_tapCount/3",
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppColors.sosRed,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),

        // Bottom text
        Positioned(
          bottom: -40,
          child: Text(
            "All evidence secured in blockchain vault",
            style: GoogleFonts.inter(
              fontSize: 12,
              color: AppColors.textMuted,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCardsSection() {
    return Row(
      children: [
        // Area Safety Card
        Expanded(
          child: Container(
            height: 200,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.softPurpleBorder, width: 2),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 15, offset: const Offset(0, 8)),
              ],
            ),
            child: Column(
              children: [
                Text(
                  "Area Safety",
                  style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 70,
                  child: SfRadialGauge(
                    axes: <RadialAxis>[
                      RadialAxis(
                        minimum: 0, maximum: 100, showLabels: false, showTicks: false,
                        startAngle: 180, endAngle: 0, radiusFactor: 1.4,
                        axisLineStyle: const AxisLineStyle(thickness: 8, color: Color(0xFFF3F4F6)),
                        pointers: const [RangePointer(value: 85, width: 8, color: AppColors.mintGreen)],
                        annotations: [
                          GaugeAnnotation(
                            widget: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("85%", style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold)),
                                Text("Safe", style: GoogleFonts.inter(fontSize: 8, color: AppColors.mintGreen, fontWeight: FontWeight.w600)),
                              ],
                            ),
                            angle: 90, positionFactor: 0.1,
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Well-lit area with frequent police patrols. Proceed with normal caution.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(fontSize: 9, color: AppColors.textSecondary, height: 1.4),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        // Map Preview Card
        Expanded(
          child: GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const MapScreen())),
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.softPurpleBorder, width: 2),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 15, offset: const Offset(0, 8)),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      "Safety Map Preview",
                      style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(22), bottomRight: Radius.circular(22)),
                      child: Stack(
                        children: [
                          Container(color: const Color(0xFFF8FAFC)),
                          CustomPaint(size: const Size(double.infinity, double.infinity), painter: MinimalMapPainter()),
                          Center(
                            child: Container(
                              width: 12, height: 12,
                              decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                            ),
                          ),
                          Positioned(
                            bottom: 0, left: 0, right: 0,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                              color: Colors.white.withValues(alpha: 0.9),
                              child: Column(
                                children: [
                                  Text("Live tracking", style: GoogleFonts.inter(fontSize: 9, fontWeight: FontWeight.bold)),
                                  Text("• 5 nearby herERA users", style: GoogleFonts.inter(fontSize: 8, color: AppColors.textSecondary)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.softPurpleBorder, width: 2),
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
          Text(
            "Quick actions",
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                _buildActionBtn(
                  icon: Icons.phone_callback_rounded,
                  label: "Fake Call",
                  color: AppColors.primary,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const GuardianCallScreen())),
                ),
                const SizedBox(width: 12),
                _buildActionBtn(
                  icon: Icons.alt_route_rounded,
                  label: "Safe Route",
                  color: AppColors.secondary,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const MapScreen())),
                ),
                const SizedBox(width: 12),
                _buildActionBtn(
                  icon: Icons.inventory_2_rounded,
                  label: "Evidence",
                  color: AppColors.mintGreen,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const EvidenceLockerScreen())),
                ),
                const SizedBox(width: 12),
                _buildActionBtn(
                  icon: Icons.near_me_rounded,
                  label: "Share Live Location",
                  color: AppColors.primary,
                  onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Live Location Sharing Activated!"), backgroundColor: AppColors.mintGreen),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionBtn({required IconData icon, required String label, required Color color, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: color.withValues(alpha: 0.3), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ],
      ),
      ),
    );
  }
}

class MinimalMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.1)
      ..strokeWidth = 1;

    for (double i = 0; i < size.width; i += 30) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += 30) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }

    final pathPaint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(0, size.height * 0.7);
    path.lineTo(size.width * 0.4, size.height * 0.5);
    path.lineTo(size.width, size.height * 0.2);
    canvas.drawPath(path, pathPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
