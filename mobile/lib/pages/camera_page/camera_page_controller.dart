import 'dart:io';

import 'package:app_detection_littering/data/res/repo_detection.dart';
import 'package:app_detection_littering/pages/image_show/image_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';

class CameraPageController extends GetxController {
  XFile? seletctedImage;
  bool isloading = false;
  final ImagePicker picker = ImagePicker();
  final DetectionRepository _detectionRepository =
      GetIt.I.get<DetectionRepository>();

  Future<void> pickImageFromGallery() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    seletctedImage = image;
    update();
  }

  Future<void> pickImageFromCamera() async {
    // final ImagePicker picker = ImagePicker();

    final XFile? photo = await picker.pickImage(source: ImageSource.camera);

    if (photo == null) return;

    seletctedImage = photo;
    update();
  }

  processImage() async {
    EasyLoading.show();
    try {
      if (seletctedImage == null) {
        EasyLoading.dismiss();
        return;
      }
      // Dio dio = Dio();

      // final response = await dio.get('http://10.0.2.2:5000/api/detection');
      // print(response);

      final result = await _detectionRepository.processImage(
          image: File(seletctedImage!.path));

      if (result != '') {
        print(result);
        Get.to(() => ImageScreen(imageUrl: result));
      }
      // _detectionRepository.get(onSuccess: (data) {
      //   print(data);
      // }, onError: (data) {
      //   print("Error : $data");
      // });
      // _detectionRepository.
    } catch (e) {
      print("Error : $e");
    } finally {
      EasyLoading.dismiss();
    }
  }
}
