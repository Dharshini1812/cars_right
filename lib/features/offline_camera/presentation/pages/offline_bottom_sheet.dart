import 'package:cars_right/core/theme/app_theme.dart';
import 'package:cars_right/core/widgets/header_bottom.dart';
import 'package:cars_right/features/offline_camera/presentation/pages/images_selection.dart';
import 'package:flutter/material.dart';

class OfflineCameraBottomSheet extends StatelessWidget {
  const OfflineCameraBottomSheet({super.key});
  final List<Map<String, String>> vehicleTypes = const [
    {'title': '4-Wheeler', 'subTitle': 'Car / SUV / MUV'},
    {'title': '2-Wheeler', 'subTitle': 'Bike / Scooter'},
    {'title': 'Commercial', 'subTitle': 'Truck / Pickup'},
    {'title': 'CE', 'subTitle': 'Construction Equipment'},
    {'title': 'FE', 'subTitle': 'Farm Equipment'},
  ];

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.93,
      minChildSize: 0.60,
      maxChildSize: 0.93,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFFEFF4F8),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              const Header(
                title: 'Select Vehicle Type',
                subTitle: 'Choose to start camera',
              ),
              const SizedBox(height: 20),
              GridView.builder(
                padding: const EdgeInsets.all(12),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 2.35,
                ),
                itemCount: vehicleTypes.length,
                itemBuilder: (context, index) {
                  final item = vehicleTypes[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pop(context);

                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (_) => FourWPhotosBottomSheet(),
                      );
                    },
                    child: containerVType(
                        context, item['title'], item['subTitle']),
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }

  Widget containerVType(
    BuildContext context,
    String? title,
    String? subTitle,
  ) {
    return Container(
      padding: const EdgeInsets.only(left: 12),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.2),
              blurRadius: 10,
            )
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? '',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              letterSpacing: .5,
            ),
          ),
          Text(
            subTitle ?? '',
            style: const TextStyle(color: AppColors.textGrey, fontSize: 13),
          )
        ],
      ),
    );
  }
}
