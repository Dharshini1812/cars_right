import 'package:cars_right/core/widgets/header_bottom.dart';
import 'package:flutter/material.dart';

class ReturnedCasesBottomSheet extends StatelessWidget {
  const ReturnedCasesBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.94,
      minChildSize: 0.50,
      maxChildSize: 0.94,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFFEFF4F8),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(34),
            ),
          ),
          child: ListView(
            controller: scrollController,
            children: const [
              Header(
                title: 'Returned Cases',
                subTitle: '2 leads need correction',
              ),
              Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                    ReturnedCaseCard(
                      image: 'images/onboarding/img2.webp',
                      tag: '4W - RETURNED TODAY',
                      title: 'Maruti Swift Dzire',
                      description:
                          'TN 09 AB 1234 - RC back image missing. Re-capture vehicle images and resubmit.',
                    ),
                    SizedBox(height: 16),
                    ReturnedCaseCard(
                      image: 'images/onboarding/img1.jpg',
                      tag: '2W - RETURNED TODAY',
                      title: 'Honda Activa 6G',
                      description:
                          'TN 22 GH 5566 - Odometer photo is blurred. Re-capture odometer and left side image.',
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ReturnedCaseCard extends StatelessWidget {
  final String image;
  final String tag;
  final String title;
  final String description;

  const ReturnedCaseCard({
    super.key,
    required this.image,
    required this.tag,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFDDE6EE)),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(
              image,
              height: 76,
              width: 92,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tag,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFFD90429),
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF17233C),
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF667085),
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 4),
          const Icon(
            Icons.chevron_right_rounded,
            color: Color(0xFF98A2B3),
            size: 28,
          ),
        ],
      ),
    );
  }
}
