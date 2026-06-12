import 'package:cars_right/features/dashboard/home/data/guide_model.dart';
import 'package:cars_right/features/offline_camera/data/model/vehicle_type_model.dart';
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

  final vehicleTypes = [
    VehicleTypeModel(
      title: "4-Wheeler",
      subtitle: "Car/SUV/MUV",
      icon: Icons.directions_car_filled_outlined,
      iconColor: const Color(0xFF3B6CE1),
      bgColor: const Color(0xFFDDE7F7),
    ),
    VehicleTypeModel(
      title: "2-Wheeler",
      subtitle: "Bike/Scooter",
      icon: Icons.two_wheeler,
      iconColor: const Color(0xFFD08A2D),
      bgColor: const Color(0xFFF4E8B5),
    ),
    VehicleTypeModel(
      title: "Commercial",
      subtitle: "Truck/Pickup",
      icon: Icons.local_shipping_outlined,
      iconColor: const Color(0xFF4B9A6B),
      bgColor: const Color(0xFFD8F0E2),
    ),
    VehicleTypeModel(
      title: "CE",
      subtitle: "Equipments",
      icon: Icons.construction,
      iconColor: const Color(0xFF8A4DE8),
      bgColor: const Color(0xFFE8DDF7),
    ),
    VehicleTypeModel(
      title: "FE",
      subtitle: "Farm Mach.",
      icon: Icons.agriculture,
      iconColor: const Color(0xFF4B5563),
      bgColor: const Color(0xFFE5E7EB),
    ),
  ];

  OfflineCameraLogic(this.ref);
}
