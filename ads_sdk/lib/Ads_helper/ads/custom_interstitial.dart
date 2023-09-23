// import 'package:ads_sdk/Ads_helper/ad_constant.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../helper/qureka_ad_widget.dart';
// import '../../helper/size_utils.dart';
//
// class CustomInter {
//   void showInter(
//       {String? routeName,
//         dynamic arg,
//         Map<String, String>? params,
//         bool? only1Pop}) {
//     Get.dialog(
//         WillPopScope(
//           onWillPop: () {
//             return Future.value(false);
//           },
//           child: Scaffold(
//             backgroundColor: Colors.transparent,
//             body: Padding(
//               padding:
//               const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 5, horizontal: 10),
//                         decoration: BoxDecoration(
//                             color: primaryClr,
//                             borderRadius: BorderRadius.circular(5)),
//                         child: const Text(
//                           "AD",
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.w500,
//                               fontSize: 15),
//                         ),
//                       ),
//                       IconButton(
//                           padding: EdgeInsets.zero,
//                           alignment: Alignment.centerRight,
//                           onPressed: () async {
//                             Get.back();
//                             MyURLLauncher().launchGameUrl();
//                             if (routeName != null) {
//                               await Get.toNamed<dynamic>(
//                                 routeName,
//                                 arguments: arg,
//                                 parameters: params,
//                               );
//                             } else {
//                               if (only1Pop != true) Get.back();
//                             }
//                           },
//                           icon: const Icon(
//                             Icons.highlight_off_rounded,
//                             color: Colors.white,
//                             size: 30,
//                           ))
//                     ],
//                   ),
//                   Expanded(
//                     child: Container(
//                       margin: const EdgeInsets.symmetric(vertical: 10),
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 15, horizontal: 15),
//                       decoration: BoxDecoration(
//                         color: const Color(0xFF292931),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Column(
//                         children: [
//                           Expanded(
//                             flex: 6,
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 image: DecorationImage(
//                                     image: NetworkImage(
//                                         "${AdConstants.adsModel.customAdData?.banner}"),
//                                     fit: BoxFit.fill),
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             flex: 1,
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   height:
//                                   SizeUtils.horizontalBlockSize * 13,
//                                   width: SizeUtils.horizontalBlockSize * 13,
//                                   decoration: BoxDecoration(
//                                     borderRadius:
//                                     BorderRadius.circular(100),
//                                     image: DecorationImage(
//                                         image: NetworkImage(
//                                             "${AdConstants.adsModel.customAdData?.logo}"),
//                                         fit: BoxFit.cover),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: SizeUtils.horizontalBlockSize * 4,
//                                 ),
//                                 Column(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   crossAxisAlignment:
//                                   CrossAxisAlignment.start,
//                                   children: [
//                                     ConstrainedBox(
//                                       constraints: BoxConstraints(
//                                           maxWidth: SizeUtils
//                                               .horizontalBlockSize *
//                                               65),
//                                       child: FittedBox(
//                                         child: Text(
//                                           "${AdConstants.adsModel.customAdData?.appName}",
//                                           style: TextStyle(
//                                               fontSize: 18,
//                                               fontWeight: FontWeight.w600,
//                                               color: Colors.white),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height:
//                                       SizeUtils.horizontalBlockSize * 2,
//                                     ),
//                                     ConstrainedBox(
//                                       constraints: BoxConstraints(
//                                           maxWidth: SizeUtils
//                                               .horizontalBlockSize *
//                                               65),
//                                       child: Text(
//                                         "${AdConstants.adsModel.customAdData?.shortDesc}",
//                                         overflow: TextOverflow.ellipsis,
//                                         style: TextStyle(
//                                             fontSize: 15,
//                                             fontWeight: FontWeight.w500,
//                                             color: Colors.white),
//                                       ),
//                                     )
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//                           Expanded(
//                             flex: 1,
//                             child: Row(
//                               mainAxisAlignment:
//                               MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: [
//                                 InkWell(
//                                   onTap: () {
//                                     MyURLLauncher.launchURL(
//                                         "${AdConstants.adsModel.customAdData?.packageName}");
//                                   },
//                                   child: Ink(
//                                     child: Container(
//                                       height:
//                                       SizeUtils.verticalBlockSize * 7,
//                                       width: SizeUtils.horizontalBlockSize *
//                                           40,
//                                       alignment: Alignment.center,
//                                       decoration: BoxDecoration(
//                                           borderRadius:
//                                           BorderRadius.circular(10),
//                                           color: Colors.blueGrey),
//                                       child: Text(
//                                         "${AdConstants.adsModel.customAdData?.buttonName}",
//                                         style: TextStyle(
//                                             fontSize: 15,
//                                             fontWeight: FontWeight.w600,
//                                             color: Colors.white),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 InkWell(
//                                   onTap: () async {
//                                     Get.back();
//                                     MyURLLauncher().launchGameUrl();
//
//                                     if (routeName != null) {
//                                       await Get.toNamed<dynamic>(
//                                         routeName,
//                                         arguments: arg,
//                                         parameters: params,
//                                       );
//                                     } else {
//                                       if (only1Pop != true) Get.back();
//                                     }
//                                   },
//                                   child: Ink(
//                                     child: Container(
//                                       height:
//                                       SizeUtils.verticalBlockSize * 7,
//                                       width: SizeUtils.horizontalBlockSize *
//                                           40,
//                                       alignment: Alignment.center,
//                                       decoration: BoxDecoration(
//                                           borderRadius:
//                                           BorderRadius.circular(10),
//                                           color: primaryClr),
//                                       child: const Text(
//                                         "Close",
//                                         style: TextStyle(
//                                             fontSize: 15,
//                                             fontWeight: FontWeight.w600,
//                                             color: Colors.white),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//         barrierColor: Colors.black,
//         useSafeArea: true)
//         .then((value) => null);
//   }
// }
