import 'package:cars_right/core/theme/app_theme.dart';
import 'package:cars_right/features/dashboard/completed/presentation/pages/view_reports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CompletedCard extends ConsumerWidget {
  const CompletedCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(
              'images/onboarding/img1.jpg',
              height: 130,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Maruti Swift Dzire VXI',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          const Text(
            'CR-4W-2026-00184 - Approved',
            style: TextStyle(
              color: Color(0xFF667085),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (_) => const InspectionReportBottomSheet(),
              );
            },
            child: const Text(
              'View Report',
              style: TextStyle(
                color: Color(0xFFD0132F),
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
