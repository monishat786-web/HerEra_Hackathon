import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';

class LegalScreen extends StatefulWidget {
  const LegalScreen({super.key});

  @override
  State<LegalScreen> createState() => _LegalScreenState();
}

class _LegalScreenState extends State<LegalScreen> {
  String _selectedCategory = "All";
  final List<String> _categories = ["All", "Domestic", "Workplace", "Cyber", "Social"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          _buildCategoryFilter(),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              children: [
                _buildSectionHeader("Indian Constitutional Rights", Icons.balance_outlined),
                const SizedBox(height: 16),
                _buildLegalCard(
                  "POSH Act, 2013",
                  "Sexual Harassment of Women at Workplace Prevention, Prohibition and Redressal.",
                  "Workplace",
                  Icons.business_center_rounded,
                  AppColors.primary,
                ),
                _buildLegalCard(
                  "Domestic Violence Act, 2005",
                  "Protection from physical, emotional, and social abuse within the household.",
                  "Domestic",
                  Icons.house_rounded,
                  AppColors.secondary,
                ),
                _buildLegalCard(
                  "IT Act - Section 66E",
                  "Fundamental protection against cyber-stalking, voyeurism, and identity theft.",
                  "Cyber",
                  Icons.pin_outlined,
                  AppColors.mintGreen,
                ),
                _buildLegalCard(
                  "Equal Remuneration Act",
                  "Right to equal pay for equal work regardless of gender or seniority.",
                  "Social",
                  Icons.payments_outlined,
                  Colors.orange,
                ),
                _buildLegalCard(
                  "Criminal Law Amendment, 2013",
                  "Strict penalties for stalking, voyeurism, and acid attack threats.",
                  "Social",
                  Icons.gavel_rounded,
                  AppColors.sosRed,
                ),
                const SizedBox(height: 32),
                _buildLegalAidBanner(),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary, size: 20),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        "Legal Rights",
        style: GoogleFonts.quicksand(
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
          fontSize: 22,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search_rounded, color: AppColors.textSecondary),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildCategoryFilter() {
    return Container(
      height: 60,
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          bool isActive = _selectedCategory == _categories[index];
          return GestureDetector(
            onTap: () => setState(() => _selectedCategory = _categories[index]),
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: isActive ? AppColors.primary : AppColors.background,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: isActive ? AppColors.primary : AppColors.border),
              ),
              child: Center(
                child: Text(
                  _categories[index],
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isActive ? Colors.white : AppColors.textSecondary,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.primary),
        const SizedBox(width: 10),
        Text(
          title,
          style: GoogleFonts.quicksand(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.textMuted,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildLegalCard(String title, String desc, String category, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.quicksand(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      category,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: color,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            desc,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegalAidBanner() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(Icons.volunteer_activism_rounded, color: Colors.white, size: 40),
          const SizedBox(height: 16),
          Text(
            "Need Legal Assistance?",
            style: GoogleFonts.quicksand(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            "Connect with verified women's rights advocates and free legal aid services.",
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.8), fontSize: 12, height: 1.5),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.primary,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: Text(
              "Get Legal Aid",
              style: GoogleFonts.inter(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
