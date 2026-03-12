import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../../features/legal/views/legal_screen.dart';
import '../../features/home/views/sos_history_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: AppColors.primaryDeep,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      width: 80,
                      height: 80,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "herERA Menu",
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.history, color: AppColors.primaryDeep),
              title: const Text("SOS History"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SOSHistoryScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.gavel, color: AppColors.primaryDeep),
              title: const Text("Legal Consent & Regulations"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LegalScreen()),
                );
              },
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Version 1.0.0",
                style: TextStyle(color: AppColors.textMuted, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
