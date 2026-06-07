import 'package:cars_right/core/theme/app_theme.dart';
import 'package:cars_right/core/widgets/header_bottom.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FourWPhotosBottomSheet extends StatelessWidget {
  FourWPhotosBottomSheet({super.key});
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(
    BuildContext context,
    ImageSource source,
  ) async {
    final XFile? image = await _picker.pickImage(
      source: source,
      imageQuality: 80,
    );

    if (image != null) {
      Navigator.pop(context); // close add photo sheet

      // Here you will get real selected image path
      print(image.path);

      // Example:
      // File selectedImage = File(image.path);
    }
  }

  final List<String> shots = const [
    'Front View',
    'Rear View',
    'Left Side',
    'Right Side',
    'Engine Bay',
    'Engine No.',
    'Odometer',
    'Chassis No.',
    'Tyre FR',
    'Tyre FL',
    'Tyre RR',
    'Tyre RL',
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
              top: Radius.circular(32),
            ),
          ),
          child: Column(
            children: [
              Header(
                title: '4W Photos',
                subTitle: 'Ford EcoSport 1.5 Titanium - 16 required shots',
              ),
              const SizedBox(height: 10),
              Expanded(
                child: GridView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.all(12),
                  itemCount: shots.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.75,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        _showAddPhotoSheet(context);
                      },
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        color: const Color(0xFFBFD7EE),
                        strokeWidth: 1.5,
                        dashPattern: const [6, 4],
                        radius: const Radius.circular(18),
                        child: Container(
                          height: 140,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.camera_alt_rounded,
                                size: 22,
                                color: Color(0xFF8FA1B8),
                              ),
                              const SizedBox(height: 7),
                              Text(
                                shots[index],
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.textGrey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAddPhotoSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          padding: const EdgeInsets.fromLTRB(28, 28, 28, 34),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(32),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add photo',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1F2937),
                ),
              ),
              const SizedBox(height: 22),
              _photoOption(
                context,
                Icons.camera_alt_rounded,
                'Camera',
                ImageSource.camera,
              ),
              const SizedBox(height: 14),
              _photoOption(
                context,
                Icons.folder_rounded,
                'Upload file',
                ImageSource.gallery,
              ),
              const SizedBox(height: 14),
              _cancelButton(context),
            ],
          ),
        );
      },
    );
  }

  Widget _photoOption(
    BuildContext context,
    IconData icon,
    String title,
    ImageSource source,
  ) {
    return InkWell(
      onTap: () => _pickImage(context, source),
      child: Container(
        height: 74,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFD8E1EC)),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: AppColors.primary, size: 26),
              const SizedBox(width: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cancelButton(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Container(
        height: 74,
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFD8E1EC)),
        ),
        child: const Center(
          child: Text(
            'Cancel',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.textGrey,
            ),
          ),
        ),
      ),
    );
  }
}
