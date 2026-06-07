import 'package:flutter/material.dart';
import '../../../../../core/theme/app_theme.dart';

class OfflineCameraTile extends StatelessWidget {
  final Function() onTap;
  const OfflineCameraTile({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE5E7EB), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Camera icon
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A2E),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.camera_alt_rounded,
                color: Colors.red,
                size: 26,
              ),
            ),

            const SizedBox(width: 14),

            // Text
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Offline Camera Inspection',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Capture without login · Select vehicle \ntype',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textGrey,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFFB0B5C0),
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}
