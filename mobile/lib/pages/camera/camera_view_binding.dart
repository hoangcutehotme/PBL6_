import 'package:app_detection_littering/pages/camera/camera_controller.dart';
import 'package:get/get.dart';

class CameraViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CameraViewController>(() => CameraViewController());
  }
}
