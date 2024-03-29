import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:gallery_vault/view/res/app_colors.dart';
import 'package:gallery_vault/view/res/assets_path.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/navigation_utils/navigation.dart';
import '../../../../utils/navigation_utils/routes.dart';
import '../../../../utils/size_utils.dart';
import '../../../../widgets/loder.dart';




class ConfirmPin2 extends StatefulWidget {
  const ConfirmPin2({super.key});

  @override
  State<ConfirmPin2> createState() => _ConfirmPin2State();
}

class _ConfirmPin2State extends State<ConfirmPin2> {
  int select = 0;
  bool SelectedColor = false;
  bool onSubmit = false;
  bool isMatch = false;
  List allname = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
  ];
  String confirmpin = ''; //s
  int selectedIndex = -1;
Map<String, String> avi = {
  "avi":"kano"
};
  // Navigation.pushNamed(Routes.kFolderDataScreen).then((value) => const Duration(milliseconds: 300));

  Future<void> addToPin(String digit, bool selectcolor) async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      if (confirmpin.length < 4) {
        confirmpin += digit;
        selectcolor = true;
        SelectedColor = selectcolor;
      }
      if (confirmpin.length == 4) {
        onSubmit = true;
        isMatch = Get.arguments == confirmpin;
        if (isMatch) {
          prefs.setString('privateSafePin', Get.arguments);
          Get.parameters.isNotEmpty ?  Navigation.pushNamed(Routes.kSecurityScreen,params: avi):
          Navigation.replace(Routes.kPrivatePhoto);
          setState(() {

          });
        }
      }
    });
  }

  void removeLastDigit() {
    setState(() {
      onSubmit = false;
      if (confirmpin.isNotEmpty) {
        confirmpin = confirmpin.substring(0, confirmpin.length - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigation.pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: AppColor.white,
          ),
        ),
        title: Text(
          "Private Safe",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: AppColor.white),
        ),
        centerTitle: true,
        backgroundColor: AppColor.blackdark,
      ),
      backgroundColor: AppColor.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            Center(child: Lottie.asset(AssetsPath.loaderLock,height: SizeUtils.verticalBlockSize * 12),),
            const SizedBox(height: 20),
            Text(
              "Confirm PIN here",
              style: TextStyle(color: AppColor.white, fontWeight: FontWeight.w700, fontSize: 20),
            ),
            const SizedBox(height: 30),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  4,
                      (index) => InkWell(
                    onTap: () {
                      setState(() {
                        select = index;
                      });
                    },
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (onSubmit && isMatch == true && confirmpin.length > index)
                            ? AppColor.green
                            : (onSubmit && isMatch == false && confirmpin.length > index)
                            ? AppColor.red
                            : confirmpin.length > index
                            ? AppColor.purpal
                            : AppColor.blackdark,
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                )),
            SizedBox(
              height: 20,
            ),
            if (onSubmit && isMatch == false)
              const Text(
                "Confirm PIN not Match",
                style: TextStyle(color: AppColor.red, fontSize: 12, fontWeight: FontWeight.w700),
              ),
            SizedBox(
              height: 30,
            ),
            Stack(
              children: [
                Column(
                  children: [
                    Wrap(
                      children: List.generate(
                        9,
                            (index) => Column(
                          children: [
                            InkResponse(
                              hoverColor: AppColor.purpal,
                              radius: 25,
                              highlightColor: AppColor.purpal.withOpacity(.3),
                              onTap: () {
                                setState(() {
                                  addToPin('${index + 1}', SelectedColor == true);
                                });
                              },
                              child: Container(
                                height: SizeUtils.verticalBlockSize * 8,
                                width: SizeUtils.horizontalBlockSize * 17,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  // color: AppColor.borderClr,
                                ),
                                margin: const EdgeInsets.only(left: 30, right: 30),
                                child: Center(
                                  child: Text(
                                    allname[index],
                                    style: TextStyle(color: AppColor.white, fontSize: 24, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                    InkResponse(
                      hoverColor: AppColor.purpal,
                      highlightColor: AppColor.purpal.withOpacity(.3),
                      onTap: () {
                        setState(() {
                          addToPin('0', SelectedColor == true);
                        });
                      },
                      child: Container(
                        height: SizeUtils.verticalBlockSize * 8,
                        width: SizeUtils.horizontalBlockSize * 17,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          // color: AppColor.blackdark,
                        ),
                        margin: const EdgeInsets.only(left: 30, right: 30),
                        child: Center(
                          child: Text(
                            "0",
                            style: TextStyle(color: AppColor.white, fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                    bottom: 15,
                    left: 55,
                    child: InkResponse(
                        hoverColor: AppColor.purpal,
                        highlightColor: AppColor.purpal.withOpacity(.8),
                        onTap: () async {
                          onSubmit = true;
                          isMatch = Get.arguments == confirmpin;
                          // Get.arguments == confirmpin ? AppBottomSheets().openPrivateSafeBinBottomSheet(context) : const SizedBox();

                          setState(() {});
                        },
                        child: Icon(
                          Icons.done,
                          color: AppColor.white,
                        ))),
                Positioned(
                    bottom: 15,
                    right: 55,
                    child: InkResponse(
                        hoverColor: AppColor.purpal,
                        highlightColor: AppColor.purpal.withOpacity(.8),
                        onTap: () {
                          setState(() {
                            removeLastDigit();
                          });
                        },
                        child: Icon(
                          Icons.backspace,
                          color: AppColor.white,
                        )))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
