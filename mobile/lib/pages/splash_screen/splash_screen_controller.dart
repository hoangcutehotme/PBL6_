import 'package:app_detection_littering/config/routes/home_route.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Future.delayed(Duration(milliseconds: 3))
        .then((value) => Get.offAllNamed(HomeRouters.DASH_BOARD));
  }

  @override
  Future<void> onReady() async {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
