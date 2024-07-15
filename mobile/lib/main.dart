import 'package:app_detection_littering/config/routes/home_route.dart';
import 'package:app_detection_littering/utils/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'core/di_container.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dep.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      ensureScreenSize: true,
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(375, 812),
      useInheritedMediaQuery: true,
      builder: (context, index) {
        return GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              appBarTheme: AppBarTheme(
                  shadowColor: Colors.white, backgroundColor: Colors.white),
              primarySwatch: Colors.blueGrey,
              scaffoldBackgroundColor: Colors.white,
              fontFamily: AppFonts.poppins,
            ),
            initialRoute: HomeRouters.SPLASH,
            defaultTransition: Transition.leftToRight,
            transitionDuration: const Duration(),
            getPages: HomeRouters.listPage,
            builder: EasyLoading.init(),
          ),
        );
      },
    );
  }
}
