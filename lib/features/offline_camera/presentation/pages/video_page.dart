import 'package:cars_right/core/theme/app_theme.dart';
import 'package:cars_right/core/widgets/header_bottom.dart';
import 'package:cars_right/features/offline_camera/presentation/widgets/full_video_preview.dart';
import 'package:cars_right/features/offline_camera/presentation/widgets/video_preview.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class VehicleVideoBottomSheet extends StatefulWidget {
  const VehicleVideoBottomSheet({super.key});

  @override
  State<VehicleVideoBottomSheet> createState() =>
      _VehicleVideoBottomSheetState();
}

class _VehicleVideoBottomSheetState extends State<VehicleVideoBottomSheet> {
  final ImagePicker _picker = ImagePicker();
  String? selectedVideoPath;

  Future<void> _pickVideo(ImageSource source) async {
    final XFile? video = await _picker.pickVideo(
      source: source,
      maxDuration: const Duration(minutes: 2),
    );

    if (video != null) {
      setState(() {
        selectedVideoPath = video.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.55,
      minChildSize: 0.45,
      maxChildSize: 0.85,
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
              const Header(
                title: 'Vehicle Video',
                subTitle: 'Record or upload vehicle walkaround video',
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _videoPreviewBox(),
                      const SizedBox(height: 18),
                      _videoOption(
                        icon: Icons.videocam_rounded,
                        title: 'Record Video',
                        source: ImageSource.camera,
                      ),
                      const SizedBox(height: 12),
                      _videoOption(
                        icon: Icons.video_library_rounded,
                        title: 'Upload Video',
                        source: ImageSource.gallery,
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          onPressed: selectedVideoPath == null
                              ? null
                              : () {
                                  Navigator.pop(context, selectedVideoPath);
                                },
                          child: const Text(
                            'Submit Video',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      _cancelButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _videoPreviewBox() {
    return Container(
        width: double.infinity,
        height: 190,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          // color: Colors.black,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: const Color(0xFFD8E1EC),
          ),
        ),
        child: selectedVideoPath == null
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.play_circle_fill_rounded,
                    size: 46,
                    color: AppColors.primary,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'No video selected',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textGrey,
                    ),
                  ),
                ],
              )
            : InkWell(
                onTap: () {
                  if (selectedVideoPath != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => FullVideoPreview(
                          videoPath: selectedVideoPath!,
                        ),
                      ),
                    );
                  }
                },
                child: VideoPreview(
                  key: ValueKey(selectedVideoPath),
                  videoPath: selectedVideoPath!,
                ),
              ));
  }

  Widget _videoOption({
    required IconData icon,
    required String title,
    required ImageSource source,
  }) {
    return InkWell(
      onTap: () => _pickVideo(source),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: const Color(0xFFD8E1EC),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.primary),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _cancelButton() {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: const Color(0xFFD8E1EC),
          ),
        ),
        child: const Center(
          child: Text(
            'Cancel',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: AppColors.textGrey,
            ),
          ),
        ),
      ),
    );
  }
}
