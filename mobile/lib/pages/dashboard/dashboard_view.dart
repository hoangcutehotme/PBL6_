import 'package:app_detection_littering/core/lazy_index_stack.dart';
import 'package:app_detection_littering/pages/camera_page/camera_page.dart';
import 'package:app_detection_littering/pages/dashboard/dashboard_controller.dart';
import 'package:app_detection_littering/pages/history/history_view.dart';
import 'package:app_detection_littering/pages/video/video_view.dart';
import 'package:app_detection_littering/utils/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/color_resourse.dart';

class DashBoardPage extends GetView<DashBoardController> {
  final List<Widget> screens = [CameraPage(), VideoPage(), HistoryPage()];

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashBoardController());
    return GetBuilder<DashBoardController>(builder: (contextController) {
      return Scaffold(
          backgroundColor: ColorResources.WHITE,
          // drawer: DrawerWidget(),
          body: Column(
            children: [
              // body
              Expanded(
                child: Obx(
                  () => LazyIndexedStack(
                    index: controller.currentIndex.value,
                    children: [...screens],
                  ),
                ),
              ),
              SizedBox(
                height: 6.h,
              ),
              // bottom bar
              _bottomBarSection(),

              // Ads
            ],
          ));
    });
  }

  Widget _bottomBarSection() {
    return Obx(
      () => SizedBox(
        height: 77.h,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: ColorResources.WHITE,
          selectedItemColor: ColorResources.SELECT_DASHBOARD,
          unselectedItemColor: ColorResources.UN_SELECT_DASHBOARD,
          selectedLabelStyle: AppText.text14,
          items: controller.dashBoardData.map((element) {
            return BottomNavigationBarItem(
              activeIcon: Center(
                child: Icon(element.iconSelected),
              ),
              icon: Center(child: Icon(element.icon)),
              label: element.title,
            );
          }).toList(),
          currentIndex: controller.currentIndex.value,
          onTap: controller.onItemTapped,
        ),
      ),
    );
  }
}
