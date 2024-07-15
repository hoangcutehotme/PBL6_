import 'package:app_detection_littering/data/res/repo_detection.dart';
import 'package:app_detection_littering/model/detection_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class HistoryController extends GetxController {
  DateTime startDay = DateTime.now();
  DateTime endDay = DateTime.now();

  List<Detection> listDetections = [];

  int currentPage = 1;
  int maxPage = 1;

  @override
  void onInit() {
    super.onInit();
    getDetection(page: currentPage);
  }

  final DetectionRepository _detectionRepository =
      GetIt.I.get<DetectionRepository>();

  Future<void> selectedStartDate() async {
    startDay = (await showDatePicker(
        context: Get.context!,
        firstDate: DateTime(2000),
        lastDate: DateTime.now()))!;

    getDetection(startDay: startDay, endDay: endDay);

    update();
  }

  tapPrevious() {
    if (currentPage > 1) {
      currentPage -= 1;
      update();
      getDetection(page: currentPage, startDay: startDay, endDay: endDay);
    }
  }

  tapNext() {
    if (currentPage < maxPage) {
      currentPage += 1;
      update();
      getDetection(page: currentPage, startDay: startDay, endDay: endDay);
    }
  }

  Future<void> selectedEndDate() async {
    endDay = (await showDatePicker(
        context: Get.context!,
        firstDate: DateTime(2000),
        lastDate: DateTime.now()))!;
    currentPage = 1;
    getDetection(startDay: startDay, endDay: endDay);
    update();
  }

  String dateFomart(DateTime datetime) {
    return DateFormat('dd/MM/yyyy').format(datetime);
  }

  String dateFomart2(DateTime datetime) {
    return DateFormat('dd-MM-yyyy').format(datetime);
  }

  getDetection(
      {int limit = 10,
      int page = 1,
      DateTime? startDay,
      DateTime? endDay}) async {
    EasyLoading.show();
    try {
      Map<String, dynamic> query = {
        "limit": limit,
        "page": page,
        "start_day": startDay == null ? '' : dateFomart(startDay),
        "end_day": endDay == null ? '' : dateFomart(endDay)
      };

      await _detectionRepository.get(
          queryParameters: query,
          onSuccess: (data, page) {
            listDetections = data;
            maxPage = page;
            print(page);
            update();
          },
          onError: (data) {
            print("Error : $data");
          });
    } catch (e) {
      print(e);
    } finally {
      EasyLoading.dismiss();
    }
  }
}
