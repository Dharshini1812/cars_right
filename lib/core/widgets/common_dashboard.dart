import 'package:cars_right/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CommonDashboardAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CommonDashboardAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(76);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      elevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: 76,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _iconBox(
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Icon(Icons.notifications, color: Colors.white),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    width: 9,
                    height: 9,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Text(
            'Dashboard',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          _iconBox(
            child: const Icon(Icons.person, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _iconBox({required Widget child}) {
    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}
