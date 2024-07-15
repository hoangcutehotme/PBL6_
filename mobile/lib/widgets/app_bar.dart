// import 'package:app_detection_littering/config/routes/home_route.dart';
// import 'package:app_detection_littering/core/size_screen.dart';
// import 'package:app_detection_littering/utils/app_text.dart';
// import 'package:app_detection_littering/utils/color_resourse.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// class AppBarBased extends StatelessWidget {
//   const AppBarBased({
//     super.key,
//     required this.leadingTap,
//     required this.title,
//     required this.iconLeading,
//     this.isSearch = true,
//   });
//   final Function() leadingTap;
//   final String title;
//   final Widget iconLeading;
//   final bool isSearch;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(
//           height: 50.h,
//         ),
//         Container(
//           width: SizeUtil.getMaxWidth(),
//           height: 30.h,
//           color: ColorResources.WHITE,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Padding(
//                 padding: SizeUtil.setEdgeInsetsOnly(left: 23.w),
//                 child: SizedBox(
//                   width: 64.w,
//                   child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: GestureDetector(onTap: leadingTap, child: iconLeading

//                         // ImageIcon(
//                         //   AssetImage(iconLeading),
//                         //   color: ColorResources.BLACK,
//                         //   size: 25.w,
//                         // ),
//                         ),
//                   ),
//                 ),
//               ),
//               Text(
//                 title,
//                 style: AppText.text18.copyWith(
//                     color: ColorResources.COLOR_TITLE_TEXT,
//                     fontWeight: FontWeight.w700),
//               ),
//               Padding(
//                 padding: SizeUtil.setEdgeInsetsOnly(right: 13.w),
//                 child: GestureDetector(
//                   onTap: () {
//                     Get.toNamed(HomeRouters.PREMIUM);
//                   },
//                   child: Container(
//                     width: 64.w,
//                     height: 28.h,
//                     decoration: BoxDecoration(
//                         border: const GradientBoxBorder(
//                           gradient: LinearGradient(
//                             colors: [
//                               ColorResources.COLOR_00FFF0,
//                               ColorResources.COLOR_88A2FF
//                             ],
//                           ),
//                           width: 0.7,
//                         ),
//                         borderRadius: BorderRadius.circular(10)),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           'Pro',
//                           style: AppText.text14.copyWith(
//                               fontWeight: FontWeight.w700,
//                               color: ColorResources.MAIN_COLOR),
//                         ),
//                         SizedBox(
//                           width: 5.w,
//                         ),
//                         IZIImage(
//                           ImagesPath.icCrown,
//                           width: 24.w,
//                           height: 24.w,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: 14.h,
//         ),
//         // _searchBar(context),
//         // search bar

//         Visibility(
//           visible: isSearch,
//           child: Column(
//             children: [
//               // _searchBar(),
//               SizedBox(
//                 height: 13.h,
//               ),
//             ],
//           ),
//         ),
//         // SizedBox(
//         //   height: 13.h,
//         // ),
//       ],
//     );
//   }

//   // Widget _searchBar() {
//   //   return GestureDetector(
//   //     onTap: () {
//   //       Get.toNamed(HomeRouters.SEARCH);
//   //     },
//   //     child: Container(
//   //       width: SizeUtil.getMaxWidth() - 30,
//   //       height: 46.h,
//   //       decoration: BoxDecoration(
//   //         borderRadius: BorderRadius.circular(10),
//   //         boxShadow: [
//   //           BoxShadow(
//   //             color: ColorResources.COLOR_BORDER_SEARCH
//   //                 .withOpacity(0.6), // Color with opacity
//   //             blurRadius: 5.6, // Adjust blur radius as needed
//   //             blurStyle: BlurStyle.outer,
//   //             // offset:
//   //             //     const Offset(0.0, 3.0), // Adjust offset for shadow position
//   //           ),
//   //         ],
//   //       ),
//   //       child: Padding(
//   //         padding: SizeUtil.setEdgeInsetsSymmetric(vertical: 0.h),
//   //         child: Row(
//   //           crossAxisAlignment: CrossAxisAlignment.center,
//   //           children: [
//   //             SizedBox(
//   //               width: 20.w,
//   //             ),
//   //             Text(
//   //               'dashboard_0005'.tr,
//   //               style:
//   //                   AppText.text14.copyWith(color: ColorResources.COLOR_B9B9B9),
//   //             ),
//   //           ],
//   //         ),
//   //       ),
//   //     ),
//   //   );
//   // }
// }
