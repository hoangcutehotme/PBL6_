import 'package:app_detection_littering/pages/history/history_controller.dart';
import 'package:app_detection_littering/utils/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HistoryPage extends GetView<HistoryController> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HistoryController());
    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<HistoryController>(builder: (context) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 40.h, left: 20.w, bottom: 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('History',
                      style:
                          AppText.text20.copyWith(fontWeight: FontWeight.w600)),
                ),
              ),
              _selectDaySection(controller),
              SizedBox(
                height: 8.h,
              ),
              _listDection(controller),
              _navipage(controller)
            ],
          );
        }));
  }

  Widget _navipage(HistoryController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            controller.tapPrevious();
          },
          child: Icon(
            Icons.arrow_back_ios_outlined,
            size: 15.h,
          ),
        ),
        Text('${controller.currentPage}'),
        Text(' - ${controller.maxPage == 0 ? 1 : controller.maxPage}'),
        GestureDetector(
          onTap: () {
            controller.tapNext();
          },
          child: Icon(
            Icons.arrow_forward_ios_outlined,
            size: 15.h,
          ),
        )
      ],
    );
  }

  Widget _listDection(HistoryController controller) {
    return Expanded(
        child: 
        controller.maxPage == 0 ? Center(child: Text("Không có dữ liệu"),)
        :
        ListView.builder(
            itemCount: controller.listDetections.length,
            itemBuilder: (context, index) {
              var detection = controller.listDetections[index];
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                child: Container(
                  decoration: BoxDecoration(border: Border.all(width: 0.2)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 150.w,
                        height: 100.h,
                        child: Image.network(detection.image!),
                      ),
                      Column(
                        children: [
                          Text(
                            detection.name ?? '',
                            style: AppText.text10,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }));
  }

  Widget _selectDaySection(HistoryController controller) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w),
      child: Row(
        children: [
          Text(
            'Start day',
            style: AppText.text12.copyWith(fontWeight: FontWeight.w500),
          ),
          SizedBox(
            width: 8.w,
          ),
          InkWell(
            onTap: () {
              controller.selectedStartDate();
            },
            borderRadius: BorderRadius.circular(5),
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(width: 0.5),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                controller.dateFomart(controller.startDay),
              ),
            ),
          ),
          SizedBox(
            width: 15.w,
          ),
          Text(
            'End day',
            style: AppText.text12.copyWith(fontWeight: FontWeight.w500),
          ),
          SizedBox(
            width: 8.w,
          ),
          InkWell(
            onTap: () {
              controller.selectedEndDate();
            },
            borderRadius: BorderRadius.circular(5),
            child: Container(
              padding: EdgeInsets.all(5.h),
              decoration: BoxDecoration(
                border: Border.all(width: 0.5),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                controller.dateFomart(controller.endDay),
              ),
            ),
          )
        ],
      ),
    );
  }
}
