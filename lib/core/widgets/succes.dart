import 'package:flutter/material.dart';

class SuccessOverlay extends StatelessWidget {
  final String title;
  final String subtitle;

  const SuccessOverlay({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              radius: 42,
              backgroundColor: Color(0xFF27AE60),
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 46,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF667085),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
