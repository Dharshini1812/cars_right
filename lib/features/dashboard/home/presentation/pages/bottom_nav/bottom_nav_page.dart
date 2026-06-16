import 'package:cars_right/core/widgets/common_appbar.dart';
import 'package:cars_right/features/dashboard/completed/presentation/pages/completed_page.dart';
import 'package:cars_right/features/dashboard/home/presentation/pages/home_page.dart';
import 'package:cars_right/features/dashboard/leads/presentation/pages/lead_page.dart';
import 'package:cars_right/features/dashboard/pending/presenattion/pages/pending_page.dart';
import 'package:cars_right/features/otherleads/presentation/pages/other_leads.dart';
import 'package:flutter/material.dart';
import 'custom_bottom_nav.dart';

class BottomNavPage extends StatefulWidget {
  const BottomNavPage({super.key});

  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  int currentIndex = 0;

  void changeTab(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomeScreen(),
      const LeadsScreen(),
      const PendingScreen(),
      const CompletedScreen(),
      OtherLeadsScreen(onLeadPicked: () {
        changeTab(1);
      }),
    ];
    return Scaffold(
      appBar: const CommonDashboardAppBar(),
      backgroundColor: const Color(0xffF5F6FA),
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: SafeArea(
        child: BottomNavBar(
          currentIndex: currentIndex,
          onTap: (index) {
            changeTab(index);
          },
        ),
      ),
    );
  }
}
