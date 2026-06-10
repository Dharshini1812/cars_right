import 'package:cars_right/core/theme/app_theme.dart';
import 'package:cars_right/core/widgets/header_bottom.dart';
import 'package:cars_right/features/dashboard/home/presentation/widgets/header_count_card.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Profile extends ConsumerWidget {
  const Profile({super.key});

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
                title: 'Profile',
                subTitle: 'Senior Valuator - Chennai zone',
              ),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(12),
                  children: [
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.24),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white.withOpacity(.6),
                                width: 1.5,
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'VR',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Venkatesh ramakumar',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            'Senior Valuator',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _containerC('42 Done'),
                              _containerC('4.8 Rating'),
                              _containerC('12 Months'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    _tile(Icons.manage_accounts_outlined, 'Edit Profile'),
                    const SizedBox(height: 10),
                    _tile(Icons.history, 'Inspection History'),
                    const SizedBox(height: 10),
                    _tile(Icons.support_agent, 'Help & Support'),
                    const SizedBox(height: 10),
                    _logoutButton(context),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _containerC(String? text) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white.withOpacity(0.24),
      ),
      padding: const EdgeInsets.only(left: 20, right: 20, top: 6, bottom: 6),
      child: Text(
        text ?? '',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _tile(IconData icon, String? text) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(
          text ?? '',
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
        ),
        trailing: const Icon(Icons.keyboard_arrow_right),
      ),
    );
  }

  Widget _logoutButton(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Colors.red.shade100,
          width: .25,
        ),
      ),
      height: 55,
      elevation: 0,
      color: Color(0xfffff1f2),
      onPressed: () {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      },
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.logout, color: Colors.red, size: 18),
          Text(
            'Logout',
            style: TextStyle(
              color: Colors.red,
              fontSize: 14,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}
