import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../core/constants/app_colors.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(12.9716, 77.5946), // Bangalore for demo
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Placeholder for Google Map
          Container(
            color: Colors.grey[200],
            child: const Center(
              child: Text("Google Map (Demo Mode)"),
            ),
          ),
          
          // Search Bar
          Positioned(
            top: 60,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 55,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Row(
                children: [
                  Icon(Icons.search, color: AppColors.textSecondary),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Where to?",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Markers (Conceptual)
          Positioned(
            bottom: 120,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.white,
              child: const Icon(Icons.legend_toggle, color: AppColors.primaryDeep),
            ),
          ),
          
          // Bottom Navigation (Simplified for this view)
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: _buildRoutePrompt(),
          ),
        ],
      ),
    );
  }

  Widget _buildRoutePrompt() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15),
        ],
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Suggested Safe Route", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Avoids 2 high-risk areas", style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.mintGreen,
              padding: const EdgeInsets.symmetric(horizontal: 15),
            ),
            child: const Text("Go"),
          ),
        ],
      ),
    );
  }
}
