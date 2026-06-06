import 'package:cars_right/features/onboarding/data/model/onboarding_model.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class OnboardingCard extends StatelessWidget {
  final OnboardingModel page;

  const OnboardingCard({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Hero image flush to top, no padding ───────────────────────────
        _HeroImage(
          imagePath: page.imagePath,
          page: page,
          height: 390, // 50% of screen height
        ),

        const SizedBox(height: 24),

        // ── Badge ─────────────────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: _Badge(
              emoji: page.badgeEmoji, label: 'Vehicle Inspection & Valuation'),
        ),

        const SizedBox(height: 14),

        // ── Title ─────────────────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            page.title,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              color: AppColors.textDark,
              height: 1.2,
            ),
          ),
        ),

        const SizedBox(height: 10),

        // ── Description ───────────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            page.description,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textGrey,
              height: 1.6,
            ),
          ),
        ),

        const SizedBox(height: 24),

        // ── CarsRight logo ────────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Image.asset(
            'images/carsright.png',
            height: 70,
            fit: BoxFit.contain,
            alignment: Alignment.centerLeft,
          ),
        ),

        // Extra space so content doesn't hide behind bottom bar
        const SizedBox(height: 90),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _HeroImage extends StatelessWidget {
  final String imagePath;
  final OnboardingModel page;
  final double height;

  const _HeroImage({
    required this.imagePath,
    required this.page,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // ── Full bleed image, no clipping on top ────────────────────────
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              // Align to top so the subject isn't cropped
              alignment: Alignment.topCenter,
            ),
          ),

          // ── Gradient only at bottom — NO blur on sides ──────────────────
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.45),
                  ],
                  stops: const [0.6, 1.0],
                ),
              ),
            ),
          ),

          // ── Frosted pill label ───────────────────────────────────────────
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 11),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.82),
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  page.imageTopWord,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textGrey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _Badge extends StatelessWidget {
  final String emoji;
  final String label;
  const _Badge({required this.emoji, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 3,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }
}
