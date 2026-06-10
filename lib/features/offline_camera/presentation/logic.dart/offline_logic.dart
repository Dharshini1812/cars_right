import 'package:cars_right/features/dashboard/home/data/guide_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final offlineLogicProvider =
    ChangeNotifierProvider((ref) => OfflineCameraLogic(ref));

class OfflineCameraLogic extends ChangeNotifier {
  final Ref ref;
  GuideModel getGuideData(String title) {
    switch (title) {
      case 'Front View':
        return GuideModel(
          label: 'Front',
          image: 'images/overlays/4w/front_4w.png',
        );

      // case 'Rear View':
      //   return GuideModel(
      //     label: 'Rear',
      //     image: 'assets/images/rear.png',
      //   );

      // case 'Left Side':
      //   return GuideModel(
      //     label: 'Left',
      //     image: 'assets/images/left.png',
      //   );

      // case 'Right Side':
      //   return GuideModel(
      //     label: 'Right',
      //     image: 'assets/images/right.png',
      //   );

      default:
        return GuideModel(
          label: title,
          image: 'images/overlays/4w/front_4w.png',
        );
    }
  }

  OfflineCameraLogic(this.ref);
}
