import 'package:app_detection_littering/pages/camera/camera_view.dart';
import 'package:app_detection_littering/pages/camera/camera_view_binding.dart';
import 'package:app_detection_littering/pages/camera_page/camera_page.dart';
import 'package:app_detection_littering/pages/dashboard/dashboard_view.dart';
import 'package:app_detection_littering/pages/history/history_view.dart';
import 'package:app_detection_littering/pages/splash_screen/splash_screen.dart';
import 'package:app_detection_littering/pages/video/video_view.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

mixin HomeRouters {
  static const String DASH_BOARD = '/dashboard';
  static const String HISTORY= '/history';
  static const String VIDEO = '/video';
  static const String CAMERA = '/camera';
  static const String CAMERA_VIEW = '/camera_view';
  static const String SPLASH = '/splash';

  static List<GetPage> listPage = [
    GetPage(
      name: SPLASH,
      page: () => SplashPage(),
      // binding: DashBoardBinding(),
    ),
    GetPage(
      name: DASH_BOARD,
      page: () => DashBoardPage(),
      // binding: DashBoardBinding(),
    ),
    GetPage(
      name: CAMERA,
      page: () => CameraPage(),
      // binding: DashBoardBinding(),
    ),
    GetPage(
      name: CAMERA_VIEW,
      page: () => CameraViewPage(),
      binding: CameraViewBinding(),
    ),
    GetPage(
      name: VIDEO,
      page: () => VideoPage(),
      // binding: DashBoardBinding(),
    ),
    GetPage(
      name: HISTORY,
      page: () => HistoryPage(),
      // binding: DashBoardBinding(),
    )
  ];
}
