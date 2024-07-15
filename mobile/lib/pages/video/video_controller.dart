import 'package:app_detection_littering/data/domain/end_points.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoController extends GetxController {
  late VideoPlayerController videoController;
  String? _videoUrl;

  String? get videoUrl => _videoUrl;
  @override
  void onInit() {
    _initializeVideo('${EndPoints.BASE_URL}/webapp');
    super.onInit();
  }

  @override
  void dispose() {
    videoController.dispose();
    super.dispose();
  }

  Future<void> _initializeVideo(String url) async {
    videoController = VideoPlayerController.networkUrl(Uri.parse(url));
    await videoController.initialize();
    update();
  }
}
