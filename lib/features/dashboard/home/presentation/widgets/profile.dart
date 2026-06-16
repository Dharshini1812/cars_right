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
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return DraggableScrollableSheet(
      initialChildSize: isLandscape ? .90 : .65,
      minChildSize: isLandscape ? .90 : .65,
      maxChildSize: .95,
      builder: (context, scrollController) {
        return SafeArea(
          top: false,
          child: Container(
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
                        padding: EdgeInsets.all(isLandscape ? 12 : 20),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: isLandscape ? 56 : 80,
                              width: isLandscape ? 56 : 80,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.24),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white.withOpacity(.6),
                                  width: 1.5,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'VR',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: isLandscape ? 20 : 28,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: isLandscape ? 2 : 4),
                            Text(
                              'Venkatesh ramakumar',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: isLandscape ? 14 : 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Senior Valuator',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: isLandscape ? 12 : 14,
                              ),
                            ),
                            SizedBox(height: isLandscape ? 6 : 10),
                            Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 8,
                              runSpacing: 8,
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
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
      color: const Color(0xfffff1f2),
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
