import 'package:app_detection_littering/model/icon_model.dart';
import 'package:app_detection_littering/utils/color_resourse.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashBoardController extends GetxController {
  RxInt currentIndex = 0.obs;
  Color backgroundColor = ColorResources.BACKGROUND_MAIN;
  @override
  void onInit() {
    super.onInit();
    initBackground();
  }

  final GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();

  List<ItemIconModel> dashBoardData = [
    ItemIconModel(
      title: 'Camera',
      icon: Icons.camera_alt_outlined,
      iconSelected: Icons.camera_alt_rounded,
    ),
    ItemIconModel(
      title: 'Video',
      icon: Icons.video_collection_outlined,
      iconSelected: Icons.video_collection_rounded,
    ),
    ItemIconModel(
      title: 'History',
      icon: Icons.history,
      iconSelected: Icons.history,
    ),
  ];

  // ignore: use_setters_to_change_properties
  void onItemTapped(int index) {
    currentIndex.value = index;
    initBackground();
    update();
  }

  void updateBackground(Color color) {
    backgroundColor = color;
    update();
  }

  void initBackground() {
    backgroundColor = ColorResources.BACKGROUND_MAIN;
    update();
  }
}