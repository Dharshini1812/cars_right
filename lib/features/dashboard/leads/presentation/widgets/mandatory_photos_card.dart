import 'package:cars_right/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class MandatoryPhotosCard extends StatelessWidget {
  const MandatoryPhotosCard({super.key});

  @override
  Widget build(BuildContext context) {
    final photos = [
      'Front View',
      'Rear View',
      'Left Side',
      'Right Side',
      'Engine Bay',
      'Hour Meter',
      'PTO',
      'Hydraulics',
      'Rear Axle',
      'RC Copy',
    ];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFDDE7F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Mandatory Photos',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w900,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFEAF2FA),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Row(
              children: [
                Icon(Icons.camera_alt, color: AppColors.primary, size: 18),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Tap a holder, then choose Camera or Upload file',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          GridView.builder(
            itemCount: photos.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.45,
            ),
            itemBuilder: (context, index) {
              final uploaded = index < 4;

              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color:
                        uploaded ? AppColors.primary : const Color(0xFFBFD8EE),
                    style: BorderStyle.solid,
                  ),
                ),
                child: Center(
                  child: uploaded
                      ? Text(
                          photos[index],
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w900,
                          ),
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.camera_alt,
                              color: Color(0xFF98A2B3),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              photos[index],
                              style: const TextStyle(
                                color: Color(0xFF667085),
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
