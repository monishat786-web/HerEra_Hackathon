import 'package:flutter/material.dart';
import 'dart:ui';
import '../../../core/constants/app_colors.dart';

class LegalScreen extends StatefulWidget {
  const LegalScreen({super.key});

  @override
  State<LegalScreen> createState() => _LegalScreenState();
}

class _LegalScreenState extends State<LegalScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildHeader(),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                physics: const BouncingScrollPhysics(),
                children: [
                  _buildLegalActsSection(),
                  const SizedBox(height: 100), // Padding for bottom nav
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        borderRadius: BorderRadius.circular(50),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(color: Colors.transparent),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2), // slightly more opaque for black text contrast
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: AppColors.glassBorder),
              ),
              child: const Text(
                "Legal Rights & Consent",
                style: TextStyle(
                  fontFamily: 'Playfair Display',
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegalActsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.gavel_rounded, color: Colors.black, size: 28),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                "Your Legal Protection - Indian Acts",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _buildActCard(
          "The Protection of Women from Domestic Violence Act, 2005",
          "Protection from domestic abuse including physical, emotional, sexual, and economic violence. Provides right to reside in shared household and protection orders.",
        ),
        const SizedBox(height: 12),
        _buildActCard(
          "The Sexual Harassment of Women at Workplace (POSH) Act, 2013",
          "Ensures safe working environment through Internal Complaints Committees and mandates annual awareness programs.",
        ),
        const SizedBox(height: 12),
        _buildActCard(
          "Dowry Prohibition Act, 1961",
          "Penalizes giving, taking, or demanding dowry. Imprisonment up to 5 years and fine up to ₹15,000.",
        ),
        const SizedBox(height: 12),
        _buildActCard(
          "The Indecent Representation of Women (Prohibition) Act, 1986",
          "Prohibits derogatory portrayal of women in advertisements, publications, and media.",
        ),
        const SizedBox(height: 12),
        _buildActCard(
          "The Criminal Law (Amendment) Act, 2013",
          "Expanded definition of rape, increased punishment, introduced new offenses like stalking and voyeurism.",
        ),
        const SizedBox(height: 12),
        _buildActCard(
          "The Medical Termination of Pregnancy Act, 1971",
          "Legalizes abortion up to 24 weeks for survivors of rape, incest, and other vulnerable women.",
        ),
        const SizedBox(height: 12),
        _buildActCard(
          "The Pre-Conception & Pre-Natal Diagnostic Techniques Act, 1994",
          "Prohibits sex determination and female foeticide. Regulates ultrasound and genetic clinics.",
        ),
        const SizedBox(height: 12),
        _buildActCard(
          "The Equal Remuneration Act, 1976",
          "Mandates equal pay for equal work regardless of gender. Prevents discrimination in recruitment and employment.",
        ),
        const SizedBox(height: 12),
        _buildActCard(
          "The National Commission for Women Act, 1990",
          "Established NCW to investigate legal violations, advise government, and protect women's rights.",
        ),
        const SizedBox(height: 12),
        _buildActCard(
          "The Prohibition of Child Marriage Act, 2006",
          "Declares child marriage voidable, punishes those who perform or promote it, and provides maintenance and custody rights.",
        ),
        
        const SizedBox(height: 24),
        Center(
          child: TextButton(
            onPressed: () {},
            child: const Text(
              "Know Your Rights",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Center(
          child: Text(
            "These acts empower and protect you. For detailed legal advice, consult an attorney.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActCard(String title, String description) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(color: Colors.transparent),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.35), // Higher opacity for black text contrast
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.glassBorder),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.05),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.article_outlined, color: Colors.black, size: 24),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            color: Colors.black, // BOLD BLACK TEXT
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          description,
                          style: const TextStyle(
                            color: Colors.black87, // REGULAR BLACK TEXT
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
