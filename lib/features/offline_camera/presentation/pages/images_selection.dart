import 'dart:io';

import 'package:cars_right/core/theme/app_theme.dart';
import 'package:cars_right/core/widgets/header_bottom.dart';
import 'package:cars_right/features/dashboard/home/data/capture_model.dart';
import 'package:cars_right/features/offline_camera/presentation/pages/inbuild_camera_screen.dart';
import 'package:cars_right/features/offline_camera/presentation/pages/video_page.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class FourWPhotosBottomSheet extends ConsumerStatefulWidget {
  const FourWPhotosBottomSheet({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FourWPhotosBottomSheetState();
}

class _FourWPhotosBottomSheetState
    extends ConsumerState<FourWPhotosBottomSheet> {
  final ImagePicker _picker = ImagePicker();
  final List<CapturedModel?> selectedImages = List.generate(16, (_) => null);

  void _showPhotoPreview(BuildContext context, int index) {
    final photo = selectedImages[index];

    if (photo == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              Positioned.fill(
                child: InteractiveViewer(
                  minScale: 1,
                  maxScale: 4,
                  child: Center(
                    child: Image.file(
                      File(photo.imagePath),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 50, 16, 18),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.85),
                        Colors.black.withOpacity(0.0),
                      ],
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          shots[index],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.18),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 16,
                right: 16,
                bottom: 24,
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.55),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.18),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _previewActionButton(
                          icon: Icons.camera_alt_rounded,
                          title: 'Retake',
                          bgColor: Colors.white,
                          textColor: AppColors.primary,
                          onTap: () {
                            Navigator.pop(context);
                            _showAddPhotoSheet(context, index);
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _previewActionButton(
                          icon: Icons.delete_rounded,
                          title: 'Delete',
                          bgColor: const Color(0xFFFF3B30),
                          textColor: Colors.white,
                          onTap: () {
                            setState(() {
                              selectedImages[index] = null;
                            });
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _previewActionButton({
    required IconData icon,
    required String title,
    required Color bgColor,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        height: 54,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: textColor, size: 18),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: textColor,
                fontSize: 15,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(
    BuildContext context,
    ImageSource source,
    int index,
  ) async {
    final XFile? image = await _picker.pickImage(
      source: source,
      imageQuality: 80,
    );
    if (image != null) {
      setState(() {
        selectedImages[index] = CapturedModel(
          imagePath: image.path,
          latitude: null,
          longitude: null,
          capturedAt: DateTime.now(),
        );
      });
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
    'RC Copy',
    'RC Back',
    'Insurance',
    'Damage Photo'
  ];

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return DraggableScrollableSheet(
      initialChildSize: isLandscape ? 0.85 : 0.93,
      minChildSize: isLandscape ? 0.85 : 0.60,
      maxChildSize: isLandscape ? 0.85 : 0.93,
      builder: (context, scrollController) {
        return SafeArea(
            top: false,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFEFF4F8),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(32),
                ),
              ),
              child: Column(
                children: [
                  const Header(
                    title: '4W Photos',
                    subTitle: 'Ford EcoSport 1.5 Titanium - 16 required shots',
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: RawScrollbar(
                      controller: scrollController,
                      thumbColor: AppColors.primary,
                      thumbVisibility: true,
                      radius: const Radius.circular(8),
                      thickness: 4,
                      child: SingleChildScrollView(
                        controller: scrollController,
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: shots.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                                childAspectRatio: 1.75,
                              ),
                              itemBuilder: (context, index) {
                                final imagePath = selectedImages[index];

                                return InkWell(
                                  onTap: () {
                                    // selectedImages[index] =
                                    //     'images/onboarding/img1.jpg';

                                    if (selectedImages[index] != null) {
                                      _showPhotoPreview(context, index);
                                    } else {
                                      _showAddPhotoSheet(context, index);
                                    }
                                  },
                                  child: DottedBorder(
                                    borderType: BorderType.RRect,
                                    color: const Color(0xFFBFD7EE),
                                    strokeWidth: 1.5,
                                    dashPattern: const [6, 4],
                                    radius: const Radius.circular(18),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(18),
                                      child: Container(
                                        width: double.infinity,
                                        color: Colors.white,
                                        child: imagePath != null
                                            ? Stack(
                                                fit: StackFit.expand,
                                                children: [
                                                  Image.file(
                                                    File(imagePath.imagePath),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  Container(
                                                    color: Colors.black
                                                        .withOpacity(0.35),
                                                  ),
                                                  const Positioned(
                                                    left: 12,
                                                    bottom: 35,
                                                    child: CircleAvatar(
                                                      radius: 10,
                                                      backgroundColor:
                                                          Colors.white,
                                                      child: Icon(
                                                        Icons.check,
                                                        size: 14,
                                                        color:
                                                            AppColors.primary,
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    left: 12,
                                                    bottom: 12,
                                                    child: Text(
                                                      shots[index],
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
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
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: AppColors.textGrey,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  elevation: 0,
                                ),
                                onPressed: () async {
                                  final videoPath =
                                      await showModalBottomSheet<String>(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    builder: (_) =>
                                        const VehicleVideoBottomSheet(),
                                  );

                                  if (videoPath != null) {
                                    // save videoPath here
                                    print(videoPath);
                                  }
                                },
                                child: const Text(
                                  'Next',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }

  void _showAddPhotoSheet(BuildContext context, int index) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return SafeArea(
          top: false,
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.90,
            ),
            padding: EdgeInsets.fromLTRB(
              20,
              20,
              20,
              MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(32),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Add photo',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  const SizedBox(height: 14),
                  _photoOption(
                    context,
                    Icons.camera_alt_rounded,
                    'Camera',
                    ImageSource.camera,
                    index,
                  ),
                  SizedBox(height: isLandscape ? 8 : 10),
                  _photoOption(
                    context,
                    Icons.folder_rounded,
                    'Upload file',
                    ImageSource.gallery,
                    index,
                  ),
                  SizedBox(height: isLandscape ? 8 : 10),
                  _cancelButton(context),
                ],
              ),
            ),
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
    int index,
  ) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return InkWell(
      onTap: () async {
        Navigator.pop(context);

        if (source == ImageSource.camera) {
          final imagePath = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => VehicleCameraScreen(title: shots[index]),
            ),
          );

          if (imagePath != null) {
            setState(() {
              selectedImages[index] = imagePath;
            });
          }
        } else {
          _pickImage(context, source, index);
        }
      },
      child: Container(
        height: isLandscape ? 48 : 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFD8E1EC)),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: AppColors.primary, size: 16),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: isLandscape ? 15 : 18,
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
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Container(
        height: isLandscape ? 48 : 60,
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFD8E1EC)),
        ),
        child: Center(
          child: Text(
            'Cancel',
            style: TextStyle(
              fontSize: isLandscape ? 15 : 18,
              fontWeight: FontWeight.w800,
              color: AppColors.textGrey,
            ),
          ),
        ),
      ),
    );
  }
}
