import 'package:app_detection_littering/data/domain/end_points.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoStreamView extends StatefulWidget {
  @override
  State<VideoStreamView> createState() => _VideoStreamViewState();
}

class _VideoStreamViewState extends State<VideoStreamView> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
        Uri.parse('${EndPoints.BASE_URL}/webapp'));

    _initializeVideo();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _initializeVideo() async {
    await _controller.initialize();
    setState(() {}); // Update UI to show the video player
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
        : const Center(
            child:
                CircularProgressIndicator()); // Show progress indicator while loading
  }
}
