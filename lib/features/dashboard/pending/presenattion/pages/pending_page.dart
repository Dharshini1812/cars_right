import 'package:cars_right/features/dashboard/pending/presenattion/widgets/returned_cases_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PendingScreen extends ConsumerStatefulWidget {
  const PendingScreen({super.key});

  @override
  ConsumerState<PendingScreen> createState() => _PendingScreenState();
}

class _PendingScreenState extends ConsumerState<PendingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF4F8),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Pending Cases",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0B4F86),
                  ),
                ),
                Text(
                  "Inspection queue",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF667085),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFCF8),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: const Color(0xFFFFC983),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Returned Cases",
                          style: TextStyle(
                            color: Color(0xFFA33412),
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          "2 leads need correction",
                          style: TextStyle(
                            color: Color(0xFF1F2937),
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Returned cases include vehicle images and previous inspection data.",
                          style: TextStyle(
                            color: Color(0xFFA33412),
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            height: 1.25,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    width: 70,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF07558E),
                        elevation: 0,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (_) => const ReturnedCasesBottomSheet(),
                        );
                      },
                      child: const Text(
                        "Open",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            const PendingStepCard(
              icon: Icons.person_rounded,
              number: "1",
              title: "Lead, customer and RC details",
            ),
            const SizedBox(height: 14),
            const PendingStepCard(
              icon: Icons.car_crash_rounded,
              number: "2",
              title: "Exterior, interior and mechanical checkpoints",
            ),
            const SizedBox(height: 14),
            const PendingStepCard(
              icon: Icons.camera_alt_rounded,
              number: "3",
              title: "Capture mandatory photos by vehicle type",
            ),
            const SizedBox(height: 14),
            const PendingStepCard(
              icon: Icons.assignment_turned_in_rounded,
              number: "4",
              title: "Submit inspection",
            ),
          ],
        ),
      ),
    );
  }
}

class PendingStepCard extends StatelessWidget {
  final IconData icon;
  final String number;
  final String title;

  const PendingStepCard({
    super.key,
    required this.icon,
    required this.number,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFDDE6EE)),
      ),
      child: Row(
        children: [
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF2FA),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF07558E),
              size: 26,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            number,
            style: const TextStyle(
              color: Color(0xFFD90429),
              fontSize: 23,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(width: 28),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Color(0xFF17233C),
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
