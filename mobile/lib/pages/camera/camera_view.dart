import 'package:app_detection_littering/core/size_screen.dart';
import 'package:app_detection_littering/pages/camera/camera_controller.dart';
import 'package:app_detection_littering/utils/app_text.dart';
import 'package:app_detection_littering/utils/color_resourse.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CameraViewPage extends GetView<CameraViewController> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CameraViewController());

    return GetBuilder<CameraViewController>(builder: (context) {
      return Scaffold(
          appBar: AppBar(
              title: Text(
            'Camera',
            style: AppText.text18.copyWith(fontWeight: FontWeight.w600),
          )),
          body: Stack(
            children: [_cameraView(controller), _sectionBottom(controller)],
          ));
    });
  }

  FutureBuilder<void> _cameraView(CameraViewController controller) {
    return FutureBuilder(
      future: controller.cameraValue,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return SizedBox(
            width: SizeUtil.getMaxWidth(),
            height: SizeUtil.getMaxHeight(),
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: 100.h,
                child: CameraPreview(controller.cameraController),
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Positioned _sectionBottom(CameraViewController controller) {
    return Positioned(
        bottom: 0,
        child: Container(
          width: SizeUtil.getMaxWidth(),
          color: ColorResources.BLACK,
          height: 100.h,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  // controller.toggleFlash();
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(50, 0, 0, 0),
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: controller.isFlashOn
                        ? const Icon(
                            Icons.flash_on,
                            color: Colors.white,
                            size: 30,
                          )
                        : const Icon(
                            Icons.flash_off,
                            color: Colors.white,
                            size: 30,
                          ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller.takePicture();
                },
                child: Container(
                  width: 55.w,
                  height: 55.h,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: ColorResources.WHITE),
                  child: const Icon(
                    Icons.camera_alt,
                    size: 40,
                    color: Colors.black87,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // controller.onTapShowCropImage();
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(50, 0, 0, 0),
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(10),
                      child:
                          // controller.imagesList.isEmpty
                          //     ?
                          const Icon(
                        Icons.image_rounded,
                        color: Colors.white,
                        size: 30,
                      )
                      // :
                      //  const Icon(
                      //     Icons.camera_front,
                      //     color: Colors.white,
                      //     size: 30,
                      //   ),
                      ),
                ),
              ),
            ],
          ),
        ));
  }
}
