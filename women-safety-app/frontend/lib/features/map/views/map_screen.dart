import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:async';
import '../../../core/constants/app_colors.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  late AnimationController _sosPulseController;
  late Animation<double> _sosPulseAnimation;
  bool _showDangerAlert = true;

  @override
  void initState() {
    super.initState();
    _sosPulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: false);
    
    _sosPulseAnimation = Tween<double>(begin: 0.8, end: 1.4).animate(
      CurvedAnimation(parent: _sosPulseController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _sosPulseController.dispose();
    super.dispose();
  }

  void _showRouteComparison() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _buildRouteComparisonSheet(),
    );
  }

  Widget _glassContainer({
    required Widget child,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? padding,
    double? width,
    double? height,
    BoxShape shape = BoxShape.rectangle,
    Color? baseColor,
    Color? borderColor,
  }) {
    return ClipRRect(
      borderRadius: shape == BoxShape.circle ? BorderRadius.circular(100) : (borderRadius ?? BorderRadius.circular(24)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          width: width,
          height: height,
          padding: padding,
          decoration: BoxDecoration(
            color: baseColor ?? Colors.white.withOpacity(0.35),
            shape: shape,
            borderRadius: shape == BoxShape.circle ? null : (borderRadius ?? BorderRadius.circular(24)),
            border: Border.all(color: borderColor ?? Colors.white.withOpacity(0.6), width: 1.5),
          ),
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // 1. Main Map Area (Simulated for rich UI)
          _buildSimulatedMap(),

          // 2. Top Header
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 16,
            right: 16,
            child: _buildTopHeader(),
          ),

          // 3. Map Legend
          Positioned(
            top: MediaQuery.of(context).padding.top + 80,
            left: 16,
            child: _buildMapLegend(),
          ),

          // 4. Live Risk Alert Banner
          if (_showDangerAlert)
            Positioned(
              top: MediaQuery.of(context).padding.top + 80,
              left: 16,
              right: 16,
              child: _buildRiskAlertBanner(),
            ),

          // 6. Voice Command Button (Bottom Left)
          Positioned(
            bottom: 270,
            left: 16,
            child: _buildVoiceButton(),
          ),

          // 7. Floating SOS Button (Bottom Right)
          Positioned(
            bottom: 270,
            right: 16,
            child: _buildSOSFloatingButton(),
          ),

          // 5. Bottom Control Panel
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomControlPanel(),
          ),
        ],
      ),
    );
  }

  // --- MAP & LAYERS ---
  Widget _buildSimulatedMap() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFFE8ECEF), // Light map background
      ),
      child: Stack(
        children: [
          // Grid lines as map placeholder
          Positioned.fill(
            child: CustomPaint(
              painter: GridPainter(),
            ),
          ),
          
          // Heatmap Zones (Simulated with blurred circles)
          Positioned(
            top: 300,
            left: 50,
            child: _buildHeatmapZone(Colors.red.withOpacity(0.3), 250),
          ),
          Positioned(
            top: 150,
            right: -50,
            child: _buildHeatmapZone(Colors.yellow.withOpacity(0.3), 300),
          ),
          Positioned(
            bottom: 350,
            left: 100,
            child: _buildHeatmapZone(AppColors.mintGreen.withOpacity(0.3), 200),
          ),

          // Current User Location
          Positioned(
            top: 380,
            left: 150,
            child: _buildUserLocationMarker(),
          ),

          // Map Markers
          Positioned(top: 250, left: 100, child: _buildEmojiMarker("🏥", "City Hospital")),
          Positioned(top: 450, left: 80, child: _buildEmojiMarker("👮", "Police Station")),
          Positioned(top: 350, right: 100, child: _buildEmojiMarker("🏪", "24/7 Mart")),
          Positioned(top: 550, right: 150, child: _buildEmojiMarker("⛽", "Fuel Station")),
          Positioned(top: 200, right: 80, child: _buildEmojiMarker("🏠", "Safe House")),
          Positioned(top: 400, left: 220, child: _buildEmojiMarker("👤", "Volunteer")),
        ],
      ),
    );
  }

  Widget _buildHeatmapZone(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(color: Colors.transparent),
      ),
    );
  }

  Widget _buildEmojiMarker(String emoji, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _glassContainer(
          shape: BoxShape.circle,
          padding: const EdgeInsets.all(8),
          child: Text(emoji, style: const TextStyle(fontSize: 18)),
        ),
        const SizedBox(height: 4),
        _glassContainer(
          borderRadius: BorderRadius.circular(8),
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          child: Text(label, style: const TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  Widget _buildUserLocationMarker() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue.withOpacity(0.2),
          ),
        ),
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue,
            border: Border.all(color: Colors.white, width: 3),
            boxShadow: [
              BoxShadow(color: Colors.blue.withOpacity(0.5), blurRadius: 10),
            ],
          ),
        ),
      ],
    );
  }

  // --- UI COMPONENTS ---
  Widget _buildTopHeader() {
    return Row(
      children: [
        Expanded(
          child: _glassContainer(
            height: 55,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            borderRadius: BorderRadius.circular(30),
            child: const Row(
              children: [
                Icon(Icons.search, color: Colors.black),
                SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                    decoration: InputDecoration(
                      hintText: "Search destinations...",
                      hintStyle: TextStyle(color: Colors.black54, fontSize: 14, fontWeight: FontWeight.w600),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        _buildCircleIconButton(Icons.notifications_none),
        const SizedBox(width: 12),
        _buildCircleIconButton(Icons.settings_outlined),
      ],
    );
  }

  Widget _buildCircleIconButton(IconData icon) {
    return _glassContainer(
      width: 50,
      height: 50,
      shape: BoxShape.circle,
      child: Center(child: Icon(icon, color: Colors.black)),
    );
  }

  Widget _buildMapLegend() {
    if (_showDangerAlert) return const SizedBox.shrink(); // Hide if alert is showing
    
    return _glassContainer(
      padding: const EdgeInsets.all(12),
      borderRadius: BorderRadius.circular(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLegendRow(Colors.red.withOpacity(0.6), "High Risk"),
          const SizedBox(height: 8),
          _buildLegendRow(Colors.yellow[700]!.withOpacity(0.6), "Medium Risk"),
          const SizedBox(height: 8),
          _buildLegendRow(AppColors.mintGreen.withOpacity(0.6), "Safe Zone"),
        ],
      ),
    );
  }

  Widget _buildLegendRow(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4), border: Border.all(color: Colors.black, width: 0.5)),
        ),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black)),
      ],
    );
  }

  Widget _buildRiskAlertBanner() {
    return _glassContainer(
      padding: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(20),
      baseColor: Colors.redAccent.withOpacity(0.2),
      borderColor: Colors.redAccent.withOpacity(0.6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.warning_amber_rounded, color: Colors.black, size: 32),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("HIGH-RISK ZONE AHEAD", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 13, letterSpacing: 1)),
                SizedBox(height: 4),
                Text("You are approaching an area with low lighting and past security reports (200m).", style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => setState(() => _showDangerAlert = false),
            child: const Icon(Icons.close, color: Colors.black, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildVoiceButton() {
    return _glassContainer(
      width: 50,
      height: 50,
      shape: BoxShape.circle,
      child: const Center(child: Icon(Icons.mic, color: Colors.black)),
    );
  }

  Widget _buildSOSFloatingButton() {
    return AnimatedBuilder(
      animation: _sosPulseAnimation,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 70 * _sosPulseAnimation.value,
              height: 70 * _sosPulseAnimation.value,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red.withOpacity((1.0 - (_sosPulseAnimation.value - 0.8) * 1.5).clamp(0.0, 1.0)),
              ),
            ),
            _glassContainer(
              width: 70,
              height: 70,
              shape: BoxShape.circle,
              baseColor: Colors.redAccent.withOpacity(0.3),
              borderColor: Colors.redAccent.withOpacity(0.8),
              child: const Center(
                child: Text("SOS", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 20, letterSpacing: 1)),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBottomControlPanel() {
    return _glassContainer(
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(width: 50, height: 5, decoration: BoxDecoration(color: Colors.black.withOpacity(0.3), borderRadius: BorderRadius.circular(10))),
          const SizedBox(height: 20),
          
          // Live Stats Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatItem("Risk Level", "MEDIUM"),
              _buildVerticalDivider(),
              _buildStatItem("Safe Nearby", "12"),
              _buildVerticalDivider(),
              _buildStatItem("Volunteers", "4"),
            ],
          ),
          const SizedBox(height: 20),
          
          // Environmental Row
          _glassContainer(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            borderRadius: BorderRadius.circular(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildEnvIndicator(Icons.wb_sunny_outlined, "Well Lit"),
                Container(width: 1, height: 20, color: Colors.black.withOpacity(0.2)),
                _buildEnvIndicator(Icons.groups_outlined, "Moderate Crowd"),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Action Buttons Row
          Row(
            children: [
              Expanded(
                child: _glassContainer(
                  baseColor: AppColors.softPurple.withOpacity(0.35),
                  borderColor: AppColors.softPurple.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(16),
                  child: InkWell(
                    onTap: _showRouteComparison,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(child: Text("Safe Route", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black))),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _glassContainer(
                  baseColor: Colors.teal.withOpacity(0.35),
                  borderColor: Colors.teal.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(16),
                  child: InkWell(
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(child: Text("Safety Mode", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black))),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Quick Navigation Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildQuickNav(Icons.local_hospital_rounded, "Hospital", Colors.redAccent.withOpacity(0.2)),
              _buildQuickNav(Icons.local_police_rounded, "Police", Colors.blueAccent.withOpacity(0.2)),
              _buildQuickNav(Icons.local_gas_station_rounded, "Fuel", Colors.orangeAccent.withOpacity(0.2)),
              _buildQuickNav(Icons.storefront_rounded, "Shop", AppColors.softPurple.withOpacity(0.2)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String title, String value) {
    return Column(
      children: [
        Text(title, style: const TextStyle(color: Colors.black, fontSize: 11, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w900)),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(width: 1, height: 30, color: Colors.black.withOpacity(0.2));
  }

  Widget _buildEnvIndicator(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.black),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildQuickNav(IconData icon, String label, Color bgColor) {
    return Expanded(
      child: Column(
        children: [
          _glassContainer(
            width: 50,
            height: 50,
            shape: BoxShape.circle,
            baseColor: bgColor,
            child: Center(child: Icon(icon, color: Colors.black)),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black)),
        ],
      ),
    );
  }

  // --- ROUTE COMPARISON BOTTOM SHEET ---
  Widget _buildRouteComparisonSheet() {
    return _glassContainer(
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(width: 50, height: 5, decoration: BoxDecoration(color: Colors.black.withOpacity(0.3), borderRadius: BorderRadius.circular(10))),
          ),
          const SizedBox(height: 24),
          const Text("Select Route", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Colors.black)),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildRouteOptionCard(
                  title: "Safe Route",
                  time: "24 min",
                  distance: "6.2 km",
                  baseColor: AppColors.mintGreen.withOpacity(0.3),
                  isSelected: true,
                  features: ["Well-lit roads", "3 Police Stations", "Many active users"],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildRouteOptionCard(
                  title: "Shortest Route",
                  time: "18 min",
                  distance: "4.5 km",
                  baseColor: Colors.redAccent.withOpacity(0.3),
                  isSelected: false,
                  features: ["Low lighting", "High crime area", "Fewer shops nearby"],
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: _glassContainer(
              baseColor: Colors.black.withOpacity(0.15),
              borderColor: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.circular(16),
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 18),
                  child: Center(child: Text("Start Safe Navigation", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.black))),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRouteOptionCard({required String title, required String time, required String distance, required Color baseColor, required bool isSelected, required List<String> features}) {
    return _glassContainer(
      padding: const EdgeInsets.all(16),
      baseColor: isSelected ? baseColor : Colors.white.withOpacity(0.1),
      borderColor: isSelected ? Colors.black.withOpacity(0.6) : Colors.white.withOpacity(0.3),
      borderRadius: BorderRadius.circular(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 13)),
              if (isSelected) const Icon(Icons.check_circle, color: Colors.black, size: 18),
            ],
          ),
          const SizedBox(height: 8),
          Text(time, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.black)),
          Text(distance, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black)),
          const SizedBox(height: 16),
          ...features.map((f) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(isSelected ? Icons.check : Icons.warning_amber_rounded, size: 14, color: Colors.black),
                const SizedBox(width: 4),
                Expanded(child: Text(f, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.black))),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

// Background painter for simulated map grid
class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..strokeWidth = 1.0;
      
    double step = 50;
    
    // Vertical lines
    for (double i = 0; i < size.width; i += step) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    
    // Horizontal lines
    for (double i = 0; i < size.height; i += step) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
