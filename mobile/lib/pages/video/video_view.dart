import 'package:app_detection_littering/pages/video/mjpeg.dart';
import 'package:app_detection_littering/pages/video/video.dart';
import 'package:app_detection_littering/pages/video/video_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends GetView<VideoController> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VideoController());
    return Scaffold(
      appBar: AppBar(title: Text('Video ')),
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => MyHomePage());
                },
                child: Text("Mở Camera"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
