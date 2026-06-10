import 'package:cars_right/features/dashboard/completed/presentation/widgets/completed_card.dart';
import 'package:cars_right/features/dashboard/leads/presentation/widgets/lead_filter_card.dart';
import 'package:cars_right/features/dashboard/leads/presentation/widgets/lead_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CompletedScreen extends ConsumerStatefulWidget {
  const CompletedScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CompletedScreenState();
}

class _CompletedScreenState extends ConsumerState<CompletedScreen> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
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
        const SizedBox(height: 18),
        LeadSearchBar(
          controller: controller,
          onChanged: (val) {},
          hinttext: 'Search report,vehicle,id',
        ),
        const SizedBox(height: 16),
        LeadFilterCard(
          isComplete: true,
          fromDate: DateTime.now(),
          toDate: DateTime.now(),
          selectedPriority: '',
          onFromTap: () {},
          onToTap: () {},
          onPriorityChanged: (value) {
            setState(() {});
          },
        ),
        const SizedBox(height: 15),
        ListView.separated(
          shrinkWrap: true,
          itemBuilder: (_, i) {
            return const CompletedCard();
          },
          separatorBuilder: (_, i) => const SizedBox(height: 15),
          itemCount: 2,
        )
      ],
    );
  }
}
