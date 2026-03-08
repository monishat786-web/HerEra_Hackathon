import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'dart:ui';
import '../../../core/constants/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildTopBar(),
              const SizedBox(height: 40),
              Center(child: _buildSOSButton()),
              const SizedBox(height: 40),
              _buildRiskScoreCard(),
              const SizedBox(height: 40),
              _buildQuickActions(),
              const SizedBox(height: 40),
              _buildRecentAlerts(),
              const SizedBox(height: 20),
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
        Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: AppColors.primarySoft,
              child: const Icon(Icons.person, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Hi, Sarah", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                Text("You're safe now", style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
              ],
            ),
          ],
        ),
        Stack(
          children: [
            const Icon(Icons.notifications_none_rounded, size: 30),
            Positioned(
              right: 2,
              top: 2,
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: AppColors.coral,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSOSButton() {
    return Column(
      children: [
        Container(
          width: 170,
          height: 170,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppColors.sosGradient,
            boxShadow: [
              BoxShadow(
                color: AppColors.coral.withOpacity(0.4),
                blurRadius: 30,
                spreadRadius: 10,
              ),
            ],
          ),
          child: const Center(
            child: Text(
              "SOS",
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          "Tap 3 times for quick alert",
          style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildRiskScoreCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: SfRadialGauge(
                  axes: <RadialAxis>[
                    RadialAxis(
                      minimum: 0,
                      maximum: 100,
                      showLabels: false,
                      showTicks: false,
                      axisLineStyle: const AxisLineStyle(
                        thickness: 0.2,
                        cornerStyle: CornerStyle.bothCurve,
                        color: Color(0xFFE8E8E8),
                        thicknessUnit: GaugeSizeUnit.factor,
                      ),
                      pointers: const <GaugePointer>[
                        RangePointer(
                          value: 20,
                          cornerStyle: CornerStyle.bothCurve,
                          width: 0.2,
                          sizeUnit: GaugeSizeUnit.factor,
                          gradient: SweepGradient(
                            colors: <Color>[AppColors.mintGreen, AppColors.mintGreen],
                            stops: <double>[0.25, 0.75],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Risk Level: Low", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(height: 5),
                    Text("Your area is safe. Stay aware.", style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    final actions = [
      {"icon": Icons.phone_callback_rounded, "label": "Fake Call"},
      {"icon": Icons.videocam_rounded, "label": "Start Rec"},
      {"icon": Icons.navigation_rounded, "label": "Safe Route"},
      {"icon": Icons.mic_rounded, "label": "Assistant"},
      {"icon": Icons.folder_shared_rounded, "label": "Locker"},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Quick Actions", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 20),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: actions.map((action) {
              return Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Column(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Icon(action["icon"] as IconData, color: AppColors.primaryDeep),
                    ),
                    const SizedBox(height: 10),
                    Text(action["label"] as String, style: const TextStyle(fontSize: 12)),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentAlerts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Community Alerts", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 15, spreadRadius: 5),
            ],
          ),
          child: Row(
            children: [
              const CircleAvatar(backgroundColor: AppColors.primarySoft, radius: 20),
              const SizedBox(width: 15),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("SOS near City Park", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("5 min ago", style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text("I'm Safe", style: TextStyle(color: AppColors.mintGreen)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
