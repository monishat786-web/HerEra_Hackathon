import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  GoogleMapController? _mapController;

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(11.1271, 78.6569), // Center of Tamil Nadu
    zoom: 7.0,
  );

  final Set<Marker> _markers = {};

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

    _loadDistrictMarkers();
  }

  void _loadDistrictMarkers() {
    final districts = [
      {'name': 'Chennai', 'lat': 13.0827, 'lng': 80.2707, 'risk': 'Low'},
      {'name': 'Coimbatore', 'lat': 11.0168, 'lng': 76.9558, 'risk': 'Medium'},
      {'name': 'Madurai', 'lat': 9.9252, 'lng': 78.1198, 'risk': 'Low'},
      {'name': 'Trichy', 'lat': 10.7905, 'lng': 78.7047, 'risk': 'Safe'},
      {'name': 'Salem', 'lat': 11.6643, 'lng': 78.1460, 'risk': 'Medium'},
      {'name': 'Erode', 'lat': 11.3410, 'lng': 77.7172, 'risk': 'Safe'},
      {'name': 'Tirunelveli', 'lat': 8.7139, 'lng': 77.7567, 'risk': 'Low'},
      {'name': 'Vellore', 'lat': 12.9165, 'lng': 79.1325, 'risk': 'Medium'},
      {'name': 'Thanjavur', 'lat': 10.7870, 'lng': 79.1378, 'risk': 'Safe'},
      {'name': 'Kanchipuram', 'lat': 12.8342, 'lng': 79.7036, 'risk': 'Low'},
    ];

    for (var d in districts) {
      _markers.add(
        Marker(
          markerId: MarkerId(d['name'] as String),
          position: LatLng(d['lat'] as double, d['lng'] as double),
          infoWindow: InfoWindow(
            title: d['name'] as String,
            snippet: 'Risk Level: ${d['risk']}',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            d['risk'] == 'Safe' ? BitmapDescriptor.hueGreen : 
            d['risk'] == 'Medium' ? BitmapDescriptor.hueYellow : BitmapDescriptor.hueRed
          ),
        ),
      );
    }
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
            color: baseColor ?? Colors.white.withValues(alpha: 0.8),
            shape: shape,
            borderRadius: shape == BoxShape.circle ? null : (borderRadius ?? BorderRadius.circular(24)),
            border: Border.all(color: borderColor ?? AppColors.glassBorder, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // 1. REAL GOOGLE MAP AREA
          GoogleMap(
            initialCameraPosition: _initialPosition,
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            onMapCreated: (controller) => _mapController = controller,
            style: _mapStyle, // Optional: You can add custom styling here
          ),

          // 2. Top Header
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 16,
            right: 16,
            child: _buildTopHeader(),
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

  // --- UI COMPONENTS ---
  Widget _buildTopHeader() {
    return Row(
      children: [
        Expanded(
          child: _glassContainer(
            height: 55,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            borderRadius: BorderRadius.circular(30),
            child: Row(
              children: [
                const Icon(Icons.search, color: AppColors.primaryDeep),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600),
                    decoration: InputDecoration(
                      hintText: "Search areas in Tamil Nadu...",
                      hintStyle: TextStyle(color: AppColors.textMuted.withValues(alpha: 0.7), fontSize: 14, fontWeight: FontWeight.w600),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        _buildCircleIconButton(Icons.my_location, () {
          _mapController?.animateCamera(CameraUpdate.newCameraPosition(_initialPosition));
        }),
      ],
    );
  }

  Widget _buildCircleIconButton(IconData icon, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: _glassContainer(
        width: 50,
        height: 50,
        shape: BoxShape.circle,
        child: Center(child: Icon(icon, color: AppColors.primaryDeep)),
      ),
    );
  }

  Widget _buildRiskAlertBanner() {
    return _glassContainer(
      padding: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(20),
      baseColor: Colors.redAccent.withValues(alpha: 0.1),
      borderColor: Colors.redAccent.withValues(alpha: 0.4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.warning_amber_rounded, color: AppColors.raspberry, size: 32),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("LIVE SAFETY ALERT", style: TextStyle(color: AppColors.raspberry, fontWeight: FontWeight.w900, fontSize: 13, letterSpacing: 1)),
                SizedBox(height: 4),
                Text("Analyzing real-time reports in Tamil Nadu. Stay alert in crowded areas.", style: TextStyle(color: AppColors.textPrimary, fontSize: 12, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => setState(() => _showDangerAlert = false),
            child: const Icon(Icons.close, color: AppColors.textMuted, size: 20),
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
      child: const Center(child: Icon(Icons.mic, color: AppColors.coral)),
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
                color: AppColors.raspberry.withValues(alpha: (1.0 - (_sosPulseAnimation.value - 0.8) * 1.5).clamp(0.0, 1.0)),
              ),
            ),
            _glassContainer(
              width: 70,
              height: 70,
              shape: BoxShape.circle,
              baseColor: AppColors.raspberry.withValues(alpha: 0.3),
              borderColor: AppColors.raspberry.withValues(alpha: 0.8),
              child: const Center(
                child: Text("SOS", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 20, letterSpacing: 1)),
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
      baseColor: Colors.white.withValues(alpha: 0.95),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 50, height: 5, decoration: BoxDecoration(color: AppColors.textMuted.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(10))),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatItem("Zone Status", "SAFE"),
              _buildVerticalDivider(),
              _buildStatItem("Nearby Help", "24"),
              _buildVerticalDivider(),
              _buildStatItem("Alerts", "0"),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _glassContainer(
                  baseColor: AppColors.primaryLight.withValues(alpha: 0.5),
                  borderColor: AppColors.primaryDeep.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(16),
                  child: InkWell(
                    onTap: _showRouteComparison,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(child: Text("Tamil Nadu Districts", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryDeep))),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _glassContainer(
                  baseColor: AppColors.mintGreen.withValues(alpha: 0.3),
                  borderColor: AppColors.mintGreen,
                  borderRadius: BorderRadius.circular(16),
                  child: InkWell(
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(child: Text("Safe Route", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary))),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildQuickNav(Icons.local_hospital_rounded, "Hospital", Colors.redAccent.withValues(alpha: 0.1)),
              _buildQuickNav(Icons.local_police_rounded, "Police", Colors.blueAccent.withValues(alpha: 0.1)),
              _buildQuickNav(Icons.local_gas_station_rounded, "Fuel", Colors.orangeAccent.withValues(alpha: 0.1)),
              _buildQuickNav(Icons.storefront_rounded, "24x7", AppColors.softPurple.withValues(alpha: 0.1)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String title, String value) {
    return Column(
      children: [
        Text(title, style: const TextStyle(color: AppColors.textMuted, fontSize: 11, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.w900)),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(width: 1, height: 30, color: AppColors.textMuted.withValues(alpha: 0.2));
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
            child: Center(child: Icon(icon, color: AppColors.primaryDeep)),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
        ],
      ),
    );
  }

  Widget _buildRouteComparisonSheet() {
    return _glassContainer(
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      padding: const EdgeInsets.all(24),
      baseColor: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(width: 50, height: 5, decoration: BoxDecoration(color: AppColors.textMuted.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(10))),
          ),
          const SizedBox(height: 24),
          const Text("District Insights", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: AppColors.textPrimary)),
          const SizedBox(height: 20),
          _buildDistrictItem("Chennai", "Strategic Surveillance Active"),
          _buildDistrictItem("Coimbatore", "Enhanced Patrol Zones"),
          _buildDistrictItem("Madurai", "24/7 Safety Corridors"),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryDeep,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text("CLOSE", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDistrictItem(String name, String status) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          const Icon(Icons.location_on, color: AppColors.coral),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text(status, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
            ],
          )
        ],
      ),
    );
  }

  // Optional: Custom Map Style String (JSON)
  final String _mapStyle = ""; 
}
