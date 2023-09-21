import 'package:flutter/material.dart';
import 'package:gallery_vault/view/res/app_colors.dart';
import 'package:gallery_vault/view/res/assets_path.dart';
import 'package:gallery_vault/view/utils/size_utils.dart';
import 'package:gallery_vault/view/widgets/bottomsheets.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../controller/provider/gallery_data_provider.dart';
import '../../utils/navigation_utils/navigation.dart';
import '../../utils/navigation_utils/routes.dart';

class ConfirmPin extends StatefulWidget {
  const ConfirmPin({super.key});

  @override
  State<ConfirmPin> createState() => _ConfirmPinState();
}

class _ConfirmPinState extends State<ConfirmPin> {
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

  // store the entered PIN
  // Navigation.pushNamed(Routes.kFolderDataScreen).then((value) => const Duration(milliseconds: 300));

  void addToPin(String digit, bool selectcolor) {
    setState(() {
      if (confirmpin.length < 4) {
        confirmpin += digit;
        selectcolor = true;
        SelectedColor = selectcolor;
      }
      if (confirmpin.length == 4) {
        onSubmit = true;
        isMatch = Get.arguments == confirmpin;
        Future.delayed(Duration(milliseconds: 300), () {
          Get.arguments == confirmpin ? AppBottomSheets().openPrivateSafeBinBottomSheet(context) : const SizedBox();
        });
        setState(() {});
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
      backgroundColor: AppColor.black,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 170),
            Center(child: Image.asset(AssetsPath.security)),
            const SizedBox(height: 20),
            Text(
              "Set Confirm PIN here",
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
              Text(
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
                          Get.arguments == confirmpin ? AppBottomSheets().openPrivateSafeBinBottomSheet(context) : const SizedBox();

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
