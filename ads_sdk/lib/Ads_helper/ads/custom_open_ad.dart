import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/qureka_ad_widget.dart';
import '../../helper/size_utils.dart';
import '../ad_constant.dart';

class CustomOpenAd {
  void showOpenAd() {
    if (!Get.isDialogOpen!) {
      Get.dialog(
          name: "",
          WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Column(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkResponse(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        alignment: Alignment.topRight,
                        width: SizeUtils.horizontalBlockSize * 55,
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                            color: const Color(0xFF343436),
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: SizeUtils.horizontalBlockSize * 10,
                              width: SizeUtils.horizontalBlockSize * 10,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "${AdConstants.adsModel.customAdData?.logo}"),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            const Text(
                              "Continue to app",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                            Container(
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  gradient: LinearGradient(
                                    colors: [
                                      primaryClr.withOpacity(0.8),
                                      primaryClr
                                    ],
                                  ),
                                ),
                                child: Icon(
                                  Icons.arrow_forward,
                                  size: 18,
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                        color: const Color(0xFF343436),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            "Advertisement",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                          Expanded(
                            flex: 6,
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFF3A4056),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${AdConstants.adsModel.customAdData?.appName}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 20),
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(10),
                                      color: const Color(0xFF313134),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets
                                                  .symmetric(
                                                  vertical: 1,
                                                  horizontal: 10),
                                              margin:
                                              EdgeInsets.only(right: 5),
                                              decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      50)),
                                              child: const Text(
                                                "AD",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                    FontWeight.w500,
                                                    fontSize: 12),
                                              ),
                                            ),
                                            Container(
                                              width: SizeUtils
                                                  .horizontalBlockSize *
                                                  60,
                                              height: SizeUtils
                                                  .verticalBlockSize *
                                                  20,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    2),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        "${AdConstants.adsModel.customAdData?.banner}"),
                                                    fit: BoxFit.contain),
                                              ),
                                            ),
                                          ],
                                        ),
                                        ConstrainedBox(
                                          constraints: BoxConstraints(
                                              maxWidth: SizeUtils
                                                  .horizontalBlockSize *
                                                  65),
                                          child: Text(
                                            "${AdConstants.adsModel.customAdData?.appName}gmnghmg nmhm",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Container(
                                              height: SizeUtils
                                                  .horizontalBlockSize *
                                                  12,
                                              width: SizeUtils
                                                  .horizontalBlockSize *
                                                  12,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    10),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        "${AdConstants.adsModel.customAdData?.logo}"),
                                                    fit: BoxFit.cover),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                MyURLLauncher.launchURL(
                                                    "${AdConstants.adsModel.customAdData?.packageName}");
                                              },
                                              child: Ink(
                                                child: Container(
                                                  height: SizeUtils
                                                      .verticalBlockSize *
                                                      5,
                                                  width: SizeUtils
                                                      .horizontalBlockSize *
                                                      30,
                                                  alignment:
                                                  Alignment.center,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(10),
                                                      color: primaryClr),
                                                  child: Text(
                                                    "${AdConstants.adsModel.customAdData?.buttonName}",
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        color:
                                                        Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    "${AdConstants.adsModel.customAdData?.shortDesc}",
                                    style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      MyURLLauncher.launchURL(
                                          "${AdConstants.adsModel.customAdData?.packageName}");
                                    },
                                    child: Ink(
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                        height:
                                        SizeUtils.verticalBlockSize * 6,
                                        width: double.infinity,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            color: primaryClr),
                                        child: Text(
                                          "${AdConstants.adsModel.customAdData?.buttonName}",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          barrierDismissible: false,
          barrierColor: Colors.black54,
          useSafeArea: true)
          .then((value) {});
    }
  }
}
