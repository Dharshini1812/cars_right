import 'package:cars_right/features/dashboard/home/presentation/pages/home_page.dart';
import 'package:cars_right/features/dashboard/home/presentation/pages/leads/lead_page.dart';
import 'package:flutter/material.dart';
import 'custom_bottom_nav.dart';

class BottomNavPage extends StatefulWidget {
  const BottomNavPage({super.key});

  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  int currentIndex = 0;

  final pages = const [
    HomeScreen(),
    LeadsScreen(),
    Placeholder(),
    Placeholder(),
    Placeholder()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: SafeArea(
        child: BottomNavBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
