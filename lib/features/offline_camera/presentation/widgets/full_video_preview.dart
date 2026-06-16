import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FullVideoPreview extends StatefulWidget {
  final String videoPath;

  const FullVideoPreview({
    super.key,
    required this.videoPath,
  });

  @override
  State<FullVideoPreview> createState() => _FullVideoPreviewState();
}

class _FullVideoPreviewState extends State<FullVideoPreview> {
  late final VideoPlayerController _controller;
  bool isReady = false;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.file(File(widget.videoPath));

    _controller.initialize().then((_) {
      if (!mounted) return;
      setState(() {
        isReady = true;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggleVideo() {
    setState(() {
      _controller.value.isPlaying ? _controller.pause() : _controller.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Video Preview',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: isReady
          ? GestureDetector(
              onTap: toggleVideo,
              child: SizedBox.expand(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Center(
                      child: AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                    ),
                    if (!_controller.value.isPlaying)
                      const Icon(
                        Icons.play_circle_fill_rounded,
                        color: Colors.white,
                        size: 70,
                      ),
                  ],
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
