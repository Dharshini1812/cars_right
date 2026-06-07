import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String? title;
  final String? subTitle;
  const Header({super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(34),
        ),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            borderRadius: BorderRadius.circular(18),
            child: Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                color: const Color(0xFFEAF2FA),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Color(0xFF07558E),
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title ?? '',
                style: const TextStyle(
                  color: Color(0xFF07558E),
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subTitle ?? '',
                style: const TextStyle(
                  color: Color(0xFF667085),
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
