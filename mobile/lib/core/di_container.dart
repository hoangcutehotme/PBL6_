import 'package:app_detection_littering/data/data_source/dio/dio_client.dart';
import 'package:app_detection_littering/data/res/repo_detection.dart';
import 'package:get_it/get_it.dart';

// final sl = GetIt.instance;
GetIt sl = GetIt.instance;

Future<void> init() async {
  // final sharedPreferences = await SharedPreferences.getInstance();
  // Core
  sl.registerSingleton<DioClient>(DioClient());
  sl.registerSingleton<DetectionRepository>(DetectionRepository());

  
  // sl.registerLazySingleton(() => EditStudentController());
}
