import 'package:cars_right/core/theme/app_theme.dart';
import 'package:cars_right/core/widgets/header_bottom.dart';
import 'package:cars_right/features/offline_camera/presentation/logic.dart/offline_logic.dart';
import 'package:cars_right/features/offline_camera/presentation/pages/images_selection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OfflineCameraBottomSheet extends ConsumerStatefulWidget {
  const OfflineCameraBottomSheet({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OfflineCameraBottomSheetState();
}

class _OfflineCameraBottomSheetState
    extends ConsumerState<OfflineCameraBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final logic = ref.watch(offlineLogicProvider);

    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return DraggableScrollableSheet(
      initialChildSize: isLandscape ? 0.85 : 0.70,
      minChildSize: isLandscape ? 0.85 : 0.70,
      maxChildSize: isLandscape ? 0.85 : 0.70,
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
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.28,
                  ),
                  itemCount: logic.vehicleTypes.length,
                  itemBuilder: (context, index) {
                    final item = logic.vehicleTypes[index];
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
                        context,
                        item.title,
                        item.subtitle,
                        item.bgColor,
                        item.icon,
                        item.iconColor,
                      ),
                    );
                  },
                ),
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
    Color? innerCColor,
    IconData? icon,
    Color? iconColor,
  ) {
    return Container(
      padding: const EdgeInsets.only(left: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: AppColors.primary),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.1),
            blurRadius: 10,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: innerCColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 28,
            ),
          ),
          const SizedBox(height: 8),
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
            style: const TextStyle(
              color: AppColors.textGrey,
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }
}
