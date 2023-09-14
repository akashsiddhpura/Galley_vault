import 'package:gallery_vault/view/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../res/app_colors.dart';
import '../res/strings_utils.dart';

class VersionPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)), //this right here
        child: SingleChildScrollView(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.bgClr,
              ),
              child: Container(
                color: AppColor.bgClr,
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'App Update Required!',
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                    SizedBox(
                      height: SizeUtils.verticalBlockSize * 1,
                    ),
                    const Text(
                      'You need to update your app, new version is available in Play Store.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
                    ),
                    SizedBox(
                      height: SizeUtils.verticalBlockSize * 1.5,
                    ),
                    // NativeAds(),
                    SizedBox(
                      height: SizeUtils.verticalBlockSize * 1.5,
                    ),
                    Container(
                      width: SizeUtils.horizontalBlockSize * 80,
                      child: InkWell(
                        onTap: () async {
                          if (await canLaunch("https://play.google.com/store/apps/details?id=${AppString.kPackageName}")) {
                            await launch(
                              "https://play.google.com/store/apps/details?id=${AppString.kPackageName}",
                            );
                          } else {
                            throw 'Could not launch "https://play.google.com/store/apps/details?id=${AppString.kPackageName}"';
                          }
                        },
                        child: Ink(
                          child: Container(
                            height: SizeUtils.verticalBlockSize * 7,
                            width: SizeUtils.horizontalBlockSize * 35,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColor.primaryClr),
                            child: const Text(
                              "Update Now",
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
