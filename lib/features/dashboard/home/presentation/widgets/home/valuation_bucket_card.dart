import 'package:cars_right/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class ValuationBucketCard extends StatelessWidget {
  const ValuationBucketCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            height: 90,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularStepProgressIndicator(
                  totalSteps: 100,
                  currentStep: 100,
                  stepSize: 10,
                  selectedColor: Colors.transparent,
                  unselectedColor: Colors.transparent,
                  customColor: (index) {
                    if (index < 35) {
                      return const Color(0xFF20C96B); // Green
                    } else if (index < 65) {
                      return Colors.white.withOpacity(0.15);
                    } else {
                      return const Color(0xFFE31B23); // Red
                    }
                  },
                ),
                const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '64%',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Today',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 28),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Valuator bucket',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '72 pending leads and 2 returned cases\nneed action. New leads stay clean until\ninspection photos are captured.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    height: 1.45,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 4,
                      backgroundColor: Color(0xFF20C96B),
                    ),
                    SizedBox(width: 7),
                    Text(
                      'LIVE ASSIGNMENT QUEUE',
                      style: TextStyle(
                        color: Color(0xFFB9D9F2),
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
