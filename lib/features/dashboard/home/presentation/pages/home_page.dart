import 'package:cars_right/core/theme/app_theme.dart';
import 'package:cars_right/features/dashboard/home/presentation/widgets/header_count_card.dart';
import 'package:cars_right/features/dashboard/home/presentation/widgets/next_pending_lead_card.dart';
import 'package:cars_right/features/dashboard/home/presentation/widgets/returned_lead_card.dart';
import 'package:cars_right/features/dashboard/home/presentation/widgets/valuation_bucket_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Hello,',
                style: TextStyle(
                  color: AppColors.textGrey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Venkastesh Ramakumar',
                style: TextStyle(
                    color: AppColors.textDark,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              )
            ],
          ),
          const SizedBox(height: 15),
          // Header Row
          const Row(
            children: [
              Expanded(
                child: HeaderCount(
                    data: 'NEW LEADS', count: 150, color: AppColors.primary),
              ),
              Expanded(
                  child: HeaderCount(
                      data: 'PENDING', count: 72, color: Colors.red)),
              Expanded(
                  child: HeaderCount(
                      data: 'RETURNED', count: 2, color: AppColors.primary)),
            ],
          ),
          const SizedBox(height: 15),
          const ValuationBucketCard(),
          const SizedBox(height: 15),
          const NextPendingLeadCard(),
          const SizedBox(height: 15),
          const Text(
            'RETURNED LEADS',
            style: TextStyle(
              color: AppColors.textDark,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          const ReturnedLeadCard(),
          const SizedBox(height: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'PENDING FLOW',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF344054),
                ),
              ),
              const SizedBox(height: 16),
              PendingFlowTile(
                icon: Icons.badge_outlined,
                title: 'Case & RC',
                subtitle: 'Customer, vehicle and documents',
                onTap: () {},
              ),
              const SizedBox(height: 16),
              PendingFlowTile(
                icon: Icons.checklist_rounded,
                title: 'Checkpoints',
                subtitle: 'Body, engine, interior, tyres',
                onTap: () {},
              ),
              const SizedBox(height: 16),
              PendingFlowTile(
                icon: Icons.camera_alt_outlined,
                title: 'Offline Photos',
                subtitle: 'Vehicle type based image route',
                onTap: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}
