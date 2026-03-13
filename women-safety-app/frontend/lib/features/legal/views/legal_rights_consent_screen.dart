import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import '../../../core/constants/app_colors.dart';
import 'training_hub_screen.dart';

class LegalRightsConsentScreen extends StatefulWidget {
  const LegalRightsConsentScreen({super.key});

  @override
  State<LegalRightsConsentScreen> createState() => _LegalRightsConsentScreenState();
}

class _LegalRightsConsentScreenState extends State<LegalRightsConsentScreen> {

  final List<Map<String, String>> _indianActs = [
    {
      "name": "The Protection of Women from Domestic Violence Act, 2005",
      "brief": "Protection from domestic abuse including physical, emotional, sexual, and economic violence. Provides right to reside in shared household and protection orders."
    },
    {
      "name": "The Sexual Harassment of Women at Workplace (POSH) Act, 2013",
      "brief": "Ensures safe working environment through Internal Complaints Committees and mandates annual awareness programs."
    },
    {
      "name": "Dowry Prohibition Act, 1961",
      "brief": "Penalizes giving, taking, or demanding dowry. Imprisonment up to 5 years and fine up to ₹15,000."
    },
    {
      "name": "The Indecent Representation of Women (Prohibition) Act, 1986",
      "brief": "Prohibits derogatory portrayal of women in advertisements, publications, and media."
    },
    {
      "name": "The Criminal Law (Amendment) Act, 2013",
      "brief": "Expanded definition of rape, increased punishment, introduced new offenses like stalking and voyeurism."
    },
    {
      "name": "The Medical Termination of Pregnancy Act, 1971",
      "brief": "Legalizes abortion up to 24 weeks for survivors of rape, incest, and other vulnerable women."
    },
    {
      "name": "The Pre-Conception & Pre-Natal Diagnostic Techniques Act, 1994",
      "brief": "Prohibits sex determination and female foeticide. Regulates ultrasound and genetic clinics."
    },
    {
      "name": "The Equal Remuneration Act, 1976",
      "brief": "Mandates equal pay for equal work regardless of gender. Prevents discrimination in recruitment and employment."
    },
    {
      "name": "The National Commission for Women Act, 1990",
      "brief": "Established NCW to investigate legal violations, advise government, and protect women's rights."
    },
    {
      "name": "The Prohibition of Child Marriage Act, 2006",
      "brief": "Declares child marriage voidable, punishes those who perform or promote it, and provides maintenance and custody rights."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Dynamic Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFF3E8FF), Color(0xFFFFE4E6), Color(0xFFF0FDFA)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Floating Shapes for better glass effect
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: 0.15),
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            left: -30,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.secondary.withValues(alpha: 0.1),
              ),
            ),
          ),
          
          SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                _buildHeader(),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTrainingHubCard(),
                        const SizedBox(height: 32),
                        _buildActsSectionTitle(),
                        const SizedBox(height: 16),
                        ..._indianActs.map((act) => _buildActCard(act)),
                        _buildDisclaimer(),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black, size: 20),
        onPressed: () => Navigator.pop(context),
      ),
      centerTitle: true,
      title: Text(
        "Legal Rights",
        style: GoogleFonts.quicksand(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      pinned: true,
    );
  }


  Widget _buildActsSectionTitle() {
    return Row(
      children: [
        const Icon(Icons.gavel_rounded, color: Colors.black, size: 24),
        const SizedBox(width: 12),
        Text(
          "Your Legal Protection - Indian Acts",
          style: GoogleFonts.quicksand(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildActCard(Map<String, String> act) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: _buildGlassContainer(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.05),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.balance_rounded, color: Colors.black, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    act['name']!,
                    style: GoogleFonts.quicksand(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    act['brief']!,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      height: 1.5,
                      color: Colors.black.withValues(alpha: 0.8),
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

  Widget _buildDisclaimer() {
    return Column(
      children: [
        const SizedBox(height: 24),
        Center(
          child: InkWell(
            onTap: () {},
            child: Text(
              "Know Your Rights →",
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "These acts empower and protect you. For detailed legal advice, consult an attorney.",
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
              fontSize: 12, color: Colors.black.withValues(alpha: 0.6), fontStyle: FontStyle.italic),
        ),
      ],
    );
  }

  Widget _buildGlassContainer({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withValues(alpha: 0.4), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
  Widget _buildTrainingHubCard() {
    return _buildGlassContainer(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.school_rounded, color: AppColors.primary, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Training Hub",
                      style: GoogleFonts.quicksand(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "Scenario-based safety modules",
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: Colors.black.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios_rounded, color: Colors.black45, size: 16),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TrainingHubScreen()),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: Text(
              "Access Learning Modules",
              style: GoogleFonts.inter(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
