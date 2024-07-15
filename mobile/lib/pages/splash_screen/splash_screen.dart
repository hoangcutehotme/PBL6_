import 'package:app_detection_littering/pages/splash_screen/splash_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashPage extends GetView<SplashController> {
  final SplashController _controller = Get.put(SplashController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Icon(
          Icons.camera,
          size: 30.h,
        ),
      ),
    );
  }
}
