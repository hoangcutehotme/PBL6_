import 'package:camera/camera.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class CameraViewController extends GetxController {
  late CameraController cameraController;
  Future<void> cameraValue = Future.value();
  bool isFlashOn = false;
  bool isRearCamera = true;
  late List<CameraDescription> cameras;

  @override
  Future<void> onInit() async {
    super.onInit();
    await startCamera(0);
  }

  @override
  void onClose() {
    super.onClose();
    cameraController.dispose();
    cameras.clear();
  }

  // Future<File> saveImage(XFile image) async {
  //   final downlaodPath = await ExternalPath.getExternalStoragePublicDirectory(
  //       ExternalPath.DIRECTORY_DOWNLOADS);
  //   final fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
  //   final file = File('$downlaodPath/$fileName');

  //   try {
  //     await file.writeAsBytes(await image.readAsBytes());
  //   } catch (_) {}

  //   return file;
  // }

  Future<void> takePicture() async {
    XFile? image;

    try {
      // EasyLoading.show();
      if (cameraController.value.isTakingPicture ||
          !cameraController.value.isInitialized) {
        return;
      }

      if (isFlashOn == false) {
        await cameraController.setFlashMode(FlashMode.off);
      } else {
        await cameraController.setFlashMode(FlashMode.torch);
      }
      image = await cameraController.takePicture();

      if (cameraController.value.flashMode == FlashMode.torch) {
        cameraController.setFlashMode(FlashMode.off);
      }

      // final file = await saveImage(image);

      // imagesList.add(file);
      // if (index == 1 && imagesList.length == 1) {
      //   Get.to(() => CropImagePage(), arguments: [imagesList, 1]);
      // }
      // update();

      // MediaScanner.loadMedia(path: file.path);
    } catch (e) {
    } finally {
      // EasyLoading.dismiss();
    }
  }

  Future<void> startCamera(int camera) async {
    cameras = await availableCameras();

    cameraController = CameraController(
      cameras[camera],
      ResolutionPreset.max,
      enableAudio: false,
    );

    cameraValue = cameraController.initialize();
    update();
  }
}
