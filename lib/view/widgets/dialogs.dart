import 'package:gallery_vault/view/utils/size_utils.dart';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_vault/view/utils/navigation_utils/routes.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

import '../res/app_colors.dart';
import '../utils/navigation_utils/navigation.dart';
import 'common_textstyle.dart';
import 'custom_button.dart';

class AppDialogs {
  void permissionDialog(BuildContext context, {String? displayText, void Function()? onPressed}) {
    showDialog(
        context: context,
        barrierDismissible: false, // Prevent users from dismissing the dialog by tapping outside
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: Dialog(
              backgroundColor: Colors.white,
              surfaceTintColor: AppColor.bgClr,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 20.0),
                    Icon(CupertinoIcons.settings, size: SizeUtils.horizontalBlockSize * 30),
                    SizedBox(height: 20.0),
                    Text(
                      "Allow Permission",
                      style: CommonTextStyle.titleStyle,
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      displayText ?? "",
                      textAlign: TextAlign.center,
                      style: CommonTextStyle.listTileBold,
                    ),
                    SizedBox(height: 20.0),
                    CustomButton(
                      onPressed: onPressed,
                      text: "Allow",
                      width: SizeUtils.horizontalBlockSize * 40,
                      height: 50, color: AppColor.black,
                    ),
                    SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
          );
        });
  }

  showDeveloperOptionDialog({void Function()? onRecheck, bool isBack = false}) {
    Get.defaultDialog(
      onWillPop: () async => false,

      title: "Developer Option ON",
      middleText: "Please Turn Off Developer Option and Enjoy App Continue",
      titleStyle: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
      middleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      // content: getContent(),
      barrierDismissible: false,
      radius: 20.0,
      confirm: ElevatedButton(
        onPressed: onRecheck,
        child: Text(
          "Recheck",
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.green),
        ),
      ),

      cancel: ElevatedButton(
        onPressed: () {
          if (isBack) Get.back();
          AppSettings.openAppSettings(type: AppSettingsType.developer, asAnotherTask: true);
        },
        child: Text(
          "Turn Off",
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.red),
        ),
      ),
    );
  }

  Widget _deleteImageDialog(BuildContext context, AssetEntity assetEntity) {
    return Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: AppColor.bgClr,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(alignment: Alignment.centerRight, child: InkWell(onTap: Get.back, child: Icon(Icons.close, color: Colors.grey, size: 25))),
            SizedBox(
              height: 10,
            ),
            Text(
              "Are you sure you want to\nDelete File?",
              textAlign: TextAlign.center,
              style: CommonTextStyle.listTileBold,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: CustomButton(
                onPressed: () {},
                text: "ADD TO RECYCLE BIN",
                width: SizeUtils.horizontalBlockSize * 50,
                height: 40,
                radius: 5,
                textStyle: TextStyle(fontSize: 15, color: Colors.white),  color: AppColor.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: CustomButton(
                onPressed: () async {
                  final List<String> result = await PhotoManager.editor.deleteWithIds(
                    <String>[assetEntity.id],
                  );
                  Navigation.doublePop();
                },
                buttonColor: Colors.grey,
                text: "DELETE",
                width: SizeUtils.horizontalBlockSize * 50,
                height: 40,
                radius: 5,
                textStyle: TextStyle(fontSize: 15, color: Colors.white), color: AppColor.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void scaleDialog(BuildContext context, AssetEntity assetEntity) {
    showGeneralDialog(
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        return Transform.scale(
          scale: curve,
          child: _deleteImageDialog(ctx, assetEntity),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
