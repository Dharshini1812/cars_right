import 'package:flutter/material.dart';
import '../../../../../core/theme/app_theme.dart';

class ShieldIcon extends StatelessWidget {
  const ShieldIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.verified_user_rounded,
          size: 76,
          color: AppColors.loginColor,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Color(0xFFD8D4F5),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 4),
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.loginColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 10)
          ],
        ),
      ],
    );
  }
}
