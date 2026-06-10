import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:cars_right/core/theme/app_theme.dart';
import 'package:cars_right/features/dashboard/home/data/capture_model.dart';
import 'package:cars_right/features/offline_camera/presentation/logic.dart/offline_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

class VehicleCameraScreen extends ConsumerStatefulWidget {
  final String title;
  const VehicleCameraScreen({super.key, required this.title});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VehicleCameraScreenState();
}

class _VehicleCameraScreenState extends ConsumerState<VehicleCameraScreen> {
  bool _showCaptureFlash = false;
  CameraController? _controller;
  bool _isCameraReady = false;
  bool _isCapturing = false;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Widget _guideBox({
    required String label,
    required String image,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: SizedBox(
        width: screenWidth * 0.99,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Image.asset(
          image,
          color: AppColors.primary,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();

    final backCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.back,
      orElse: () => cameras.first,
    );

    _controller = CameraController(
      backCamera,
      ResolutionPreset.high,
      enableAudio: false,
    );

    await _controller!.initialize();

    if (!mounted) return;

    setState(() {
      _isCameraReady = true;
    });
  }

  Future<void> _captureImage() async {
    if (_controller == null || !_controller!.value.isInitialized) return;
    if (_isCapturing) return;

    try {
      setState(() {
        _isCapturing = true;
        _showCaptureFlash = true;
      });

      await Future.delayed(const Duration(milliseconds: 120));

      if (mounted) {
        setState(() {
          _showCaptureFlash = false;
        });
      }

      final XFile image = await _controller!.takePicture();

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      if (!mounted) return;

      Navigator.pop(
        context,
        CapturedModel(
          imagePath: image.path,
          latitude: position.latitude,
          longitude: position.longitude,
          capturedAt: DateTime.now(),
        ),
      );
    } catch (e) {
      log('Camera capture error: $e');

      if (mounted) {
        setState(() {
          _isCapturing = false;
          _showCaptureFlash = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final logic = ref.watch(offlineLogicProvider);
    final guide = logic.getGuideData(widget.title);
    if (!_isCameraReady) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: CameraPreview(_controller!),
          ),

          // Top title
          Positioned(
            top: 50,
            left: 16,
            right: 16,
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(width: 48),
              ],
            ),
          ),

          // Vehicle  guide
          _guideBox(label: guide.label, image: guide.image),
          if (_showCaptureFlash)
            Positioned.fill(
              child: IgnorePointer(
                child: AnimatedOpacity(
                  opacity: _showCaptureFlash ? 0.75 : 0,
                  duration: const Duration(milliseconds: 120),
                  child: Container(color: Colors.white),
                ),
              ),
            ),

          // Capture button
          Positioned(
              left: 0,
              right: 0,
              bottom: 45,
              child: InkWell(
                onTap: _isCapturing ? null : _captureImage,
                borderRadius: BorderRadius.circular(50),
                child: AnimatedScale(
                  scale: _isCapturing ? 0.88 : 1.0,
                  duration: const Duration(milliseconds: 120),
                  child: Container(
                    width: 82,
                    height: 82,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 4,
                      ),
                    ),
                    child: Center(
                      child: Container(
                        width: 62,
                        height: 62,
                        decoration: BoxDecoration(
                          color: _isCapturing
                              ? Colors.grey.shade300
                              : Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
