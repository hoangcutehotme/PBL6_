import 'dart:io';

import 'package:app_detection_littering/config/routes/home_route.dart';
import 'package:app_detection_littering/core/size_screen.dart';
import 'package:app_detection_littering/pages/camera_page/camera_page_controller.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CameraPage extends GetView<CameraPageController> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CameraPageController());
    return GetBuilder<CameraPageController>(builder: (context) {
      return Scaffold(
          appBar: AppBar(title: Text('Camera')),
          body: SingleChildScrollView(
              child: Column(
            children: [
              Center(
                child: controller.seletctedImage != null
                    ? ConstrainedBox(
                        constraints: BoxConstraints(
                            minHeight: SizeUtil.getMaxHeight() / 2,
                            minWidth: SizeUtil.getMaxWidth() - 20.w),
                        child: Container(
                          child: Image.file(
                            height: SizeUtil.getMaxHeight() * 2 / 3,
                            File(controller.seletctedImage!.path),
                            fit: BoxFit.contain,
                          ),
                        ),
                      )
                    : DottedBorder(
                        color: Colors.black,
                        dashPattern: [6, 3],
                        strokeWidth: 2,
                        borderType: BorderType.RRect,
                        radius: Radius.circular(12),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                              minHeight: SizeUtil.getMaxHeight() / 2),
                          child: Container(
                            width: SizeUtil.getMaxWidth() - 20.w,
                            child: Center(child: Text("Empty image")),
                          ),
                        ),
                      ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        controller.pickImageFromCamera();
                      },
                      child: Text('Camera')),
                  ElevatedButton(
                      onPressed: () {
                        controller.pickImageFromGallery();
                      },
                      child: Text('Chọn ảnh')),
                  ElevatedButton(
                      onPressed: () {
                        if (controller.seletctedImage != null) {
                          controller.processImage();
                        } else {
                          EasyLoading.showError("Chưa chọn ảnh",
                              duration: Duration(milliseconds: 2000));
                        }
                      },
                      child: Text('Nhận dạng'))
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
            ],
          )));
    });
  }
}
