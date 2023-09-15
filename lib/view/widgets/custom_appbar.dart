import 'package:gallery_vault/view/utils/size_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../res/app_colors.dart';
import '../res/assets_path.dart';
import 'common_textstyle.dart';

PreferredSize customAppBar(
    {Color? bgClr,
    double? appBarHeight,
    Widget? leadingIcon,
    required String? title,
    List<Widget>? action,
    PreferredSizeWidget? bottom,
    bool? showLeading,
    void Function()? onLeadingTap}) {
  return PreferredSize(
    preferredSize:
        Size.fromHeight(SizeUtils.verticalBlockSize * (appBarHeight ?? 8)),
    child: AppBar(
      backgroundColor: bgClr ?? AppColor.blackdark,
      surfaceTintColor: AppColor.bgClr,
      toolbarHeight: SizeUtils.verticalBlockSize * 8,
      title: Text(
        title ?? "",
        style :   CommonTextStyle.title,
      ),
      centerTitle: true,
      // titleSpacing: SizeUtils.horizontalBlockSize * 10,
      actions: action ?? [],
      elevation: 5,
      shadowColor: Colors.grey.withOpacity(0.2),
      bottom: bottom,
      titleSpacing: 30,
      leadingWidth: SizeUtils.horizontalBlockSize * 11,
      leading: leadingIcon ??
          (showLeading == true
              ? Padding(
                  padding:
                      EdgeInsets.only(left: SizeUtils.horizontalBlockSize * 4),
                  child: InkResponse(
                      radius: 18,
                      onTap: onLeadingTap ??
                          () {
                            // if (AdConstants.adsModel.adStatus == true &&
                            //     AdConstants.adsModel.backAd == true) {
                            //   if (AdConstants.adsModel.showCustomAd == true) {
                            //     CustomInter().showInter();
                            //   } else {
                            //     InterstitialAdClass()
                            //         .showInterstitialAds()
                            //         .then(
                            //           (value) => Future.delayed(
                            //             const Duration(milliseconds: 800),
                            //             () {
                            //               Get.back();
                            //             },
                            //           ),
                            //         );
                            //   }
                            // } else {
                              Get.back();
                            // }
                          },
                      child: const Icon(CupertinoIcons.back)
                      // Image.asset(
                      //   AssetsPath.backIc,
                      // ),
                      ),
                )
              : const SizedBox()),
    ),
  );
}
