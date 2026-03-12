import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../../../core/constants/app_colors.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  double _zoomLevel = 1.0;
  final TransformationController _mapController = TransformationController();
  bool _showHeatmap = true;
  final bool _showSafeZones = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. Base Map Layer (Simulated Satellite View)
          _buildMapBase(),

          // 2. Risk Heatmap Layer (Custom Painter)
          if (_showHeatmap) _buildHeatmapLayer(),

          // 3. Markers Layer (SOS, Safe Zones, Community)
          _buildMarkersLayer(),

          // 4. UI Controls Overlay
          _buildTopOverlay(),
          _buildFloatingControls(),

          // 5. Draggable Bottom Sheet
          _buildDraggableBottomSheet(),
        ],
      ),
    );
  }

  Widget _buildMapBase() {
    return InteractiveViewer(
      transformationController: _mapController,
      maxScale: 5.0,
      minScale: 0.8,
      onInteractionUpdate: (details) {
        setState(() {
          _zoomLevel = _mapController.value.getMaxScaleOnAxis();
        });
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("https://images.unsplash.com/photo-1526370417033-6e34ac12f558?q=80&w=2070&auto=format&fit=crop"), // Mock satellite texture
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
          ),
        ),
        child: CustomPaint(
          painter: _SatelliteLabelsPainter(zoom: _zoomLevel),
        ),
      ),
    );
  }

  Widget _buildHeatmapLayer() {
    return IgnorePointer(
      child: CustomPaint(
        size: Size.infinite,
        painter: _HeatmapPainter(),
      ),
    );
  }

  Widget _buildMarkersLayer() {
    return Stack(
      children: [
        // Pulsing User Location
        Center(
          child: _PulseMarker(
            color: AppColors.primary,
            child: Container(
              width: 16,
              height: 16,
              decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
            ),
          ),
        ),

        // Danger Zone: T. Nagar
        _buildMarker(
          top: 300,
          left: 150,
          icon: Icons.warning_rounded,
          color: AppColors.sosRed,
          label: "High Risk Area",
        ),

        // Safe Zone: Police Station
        if (_showSafeZones)
          _buildMarker(
            top: 250,
            right: 100,
            icon: Icons.shield_rounded,
            color: AppColors.mintGreen,
            label: "Police Station",
          ),

        // Community Cluster
        _buildMarker(
          bottom: 350,
          left: 100,
          isCluster: true,
          label: "12 Nearby",
        ),
      ],
    );
  }

  Widget _buildMarker({
    double? top,
    double? left,
    double? right,
    double? bottom,
    IconData? icon,
    Color? color,
    required String label,
    bool isCluster = false,
  }) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Column(
        children: [
          if (isCluster)
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.3), blurRadius: 10)],
              ),
              child: Text(
                label.split(" ")[0],
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
              ),
            )
          else
            _PulseMarker(
              color: color!,
              child: Icon(icon, color: color, size: 28),
            ),
          if (!isCluster)
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(4)),
              child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 8)),
            ),
        ],
      ),
    );
  }

  Widget _buildTopOverlay() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, left: 20, right: 20, bottom: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black.withValues(alpha: 0.6), Colors.transparent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildIconButton(Icons.arrow_back_ios_new_rounded, () => Navigator.pop(context)),
                Text(
                  "Safety Map",
                  style: GoogleFonts.quicksand(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                _buildIconButton(Icons.layers_rounded, () {
                  setState(() => _showHeatmap = !_showHeatmap);
                }),
              ],
            ),
            const SizedBox(height: 16),
            _buildSearchBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Icon(Icons.search_rounded, color: AppColors.textSecondary),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search safe zones, hospitals...",
                border: InputBorder.none,
                hintStyle: GoogleFonts.inter(color: AppColors.textMuted, fontSize: 14),
              ),
            ),
          ),
          const Icon(Icons.mic_none_rounded, color: AppColors.primary),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }

  Widget _buildFloatingControls() {
    return Positioned(
      right: 20,
      top: 250,
      child: Column(
        children: [
          _buildFAB(Icons.my_location_rounded, () {}),
          const SizedBox(height: 12),
          _buildFAB(Icons.add_rounded, () {
            _mapController.value *= Matrix4.diagonal3Values(1.2, 1.2, 1.0);
          }),
          _buildFAB(Icons.remove_rounded, () {
            _mapController.value *= Matrix4.diagonal3Values(0.8, 0.8, 1.0);
          }),
          const SizedBox(height: 12),
          _buildFAB(Icons.view_in_ar_rounded, () {}),
        ],
      ),
    );
  }

  Widget _buildFAB(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
        ),
        child: Icon(icon, color: AppColors.textPrimary, size: 22),
      ),
    );
  }

  Widget _buildDraggableBottomSheet() {
    return DraggableScrollableSheet(
      initialChildSize: 0.28,
      minChildSize: 0.15,
      maxChildSize: 0.7,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 40, offset: Offset(0, -10))],
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40, height: 4,
                      decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2)),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Current Location", style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
                          Text("T. Nagar, Chennai", style: GoogleFonts.quicksand(fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(color: AppColors.mintGreen.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                        child: Text("78% Safe", style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.mintGreen)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  _buildSafetyGauge(),
                  const SizedBox(height: 24),
                  _buildAISummary(),
                  const SizedBox(height: 32),
                  _buildActionButtons(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSafetyGauge() {
    return Row(
      children: [
        SizedBox(
          height: 100,
          width: 100,
          child: SfRadialGauge(
            axes: [
              RadialAxis(
                minimum: 0, maximum: 100, showLabels: false, showTicks: false,
                startAngle: 180, endAngle: 0, radiusFactor: 1.2,
                axisLineStyle: const AxisLineStyle(thickness: 8, color: Color(0xFFF1F5F9)),
                pointers: const [RangePointer(value: 78, width: 8, color: AppColors.mintGreen)],
              )
            ],
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Area Safety Score", style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16)),
              Text("Well-lit area with active community presence. Safe for solo travel.", style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAISummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome_rounded, color: AppColors.primary, size: 18),
              const SizedBox(width: 8),
              Text("AI Smart Insight", style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: AppColors.primary)),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "Police patrol frequent on High St. Avoid the 4th Cross alleyway due to reported poor lighting.",
            style: GoogleFonts.inter(fontSize: 12, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        _buildActionButton(Icons.route_rounded, "Find Safe Route Home", AppColors.primary),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildActionButton(Icons.share_location_rounded, "Share Live", AppColors.secondary)),
            const SizedBox(width: 12),
            Expanded(child: _buildActionButton(Icons.report_problem_rounded, "Report", AppColors.sosRed)),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label, Color color) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: color.withValues(alpha: 0.2), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(width: 8),
          Text(label, style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _PulseMarker extends StatefulWidget {
  final Widget child;
  final Color color;
  const _PulseMarker({required this.child, required this.color});

  @override
  State<_PulseMarker> createState() => _PulseMarkerState();
}

class _PulseMarkerState extends State<_PulseMarker> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat();
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 30 + (20 * _controller.value),
              height: 30 + (20 * _controller.value),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: widget.color.withValues(alpha: 1 - _controller.value), width: 2),
              ),
            ),
            widget.child,
          ],
        );
      },
    );
  }
  @override
  void dispose() { _controller.dispose(); super.dispose(); }
}

class _HeatmapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..maskFilter = const MaskFilter.blur(BlurStyle.normal, 30);
    
    // Danger zones (Red)
    canvas.drawCircle(Offset(size.width * 0.4, size.height * 0.4), 80, paint..color = AppColors.sosRed.withValues(alpha: 0.3));
    canvas.drawCircle(Offset(size.width * 0.7, size.height * 0.6), 100, paint..color = AppColors.sosRed.withValues(alpha: 0.2));

    // Caution zones (Yellow)
    canvas.drawCircle(Offset(size.width * 0.3, size.height * 0.6), 120, paint..color = AppColors.caution.withValues(alpha: 0.2));

    // Safe zones (Green)
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.3), 150, paint..color = AppColors.mintGreen.withValues(alpha: 0.2));
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _SatelliteLabelsPainter extends CustomPainter {
  final double zoom;
  _SatelliteLabelsPainter({required this.zoom});

  @override
  void paint(Canvas canvas, Size size) {
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    void drawLabel(String text, Offset offset, {bool isMajor = false}) {
      textPainter.text = TextSpan(
        text: text,
        style: GoogleFonts.inter(
          color: Colors.white,
          fontSize: (isMajor ? 14 : 10) * zoom.clamp(1.0, 1.5),
          fontWeight: isMajor ? FontWeight.bold : FontWeight.w500,
          shadows: [const Shadow(blurRadius: 4, color: Colors.black)],
        ),
      );
      textPainter.layout();
      textPainter.paint(canvas, offset);
    }

    if (zoom > 1.2) {
      drawLabel("Chennai Central", const Offset(100, 200), isMajor: true);
      drawLabel("Marina Beach", const Offset(300, 350));
      drawLabel("T. Nagar", const Offset(150, 450));
    }
  }
  @override
  bool shouldRepaint(covariant _SatelliteLabelsPainter oldDelegate) => oldDelegate.zoom != zoom;
}
