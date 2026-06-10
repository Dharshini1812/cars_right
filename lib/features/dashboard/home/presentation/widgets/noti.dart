import 'package:cars_right/core/widgets/header_bottom.dart';
import 'package:cars_right/features/dashboard/home/presentation/widgets/header_count_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Notifications extends ConsumerWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DraggableScrollableSheet(
      initialChildSize: .65,
      minChildSize: .65,
      maxChildSize: .70,
      builder: (context, scrollController) {
        return Container(
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            color: Color(0xFFEFF4F8),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              const Header(
                title: 'Notifications',
                subTitle: 'Latest Valuator Updates',
              ),
              Expanded(
                  child: ListView(
                padding: const EdgeInsets.all(12),
                children: [
                  PendingFlowTile(
                    isNoti: true,
                    icon: Icons.car_crash,
                    title: 'New Lead Assigned',
                    subtitle: 'Hyundai i20 - Porur - High priority',
                    notiSec: '2 seconds',
                  ),
                ],
              ))
            ],
          ),
        );
      },
    );
  }
}
