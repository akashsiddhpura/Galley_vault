import 'package:flutter/material.dart';
import 'package:gallery_vault/view/res/app_colors.dart';
import 'package:gallery_vault/view/res/assets_path.dart';
import 'package:gallery_vault/view/utils/size_utils.dart';
import 'package:provider/provider.dart';

import '../../../controller/provider/gallery_data_provider.dart';
import '../../utils/navigation_utils/navigation.dart';
import '../../utils/navigation_utils/routes.dart';

class SecurityScreen extends StatefulWidget {
  // final TextEditingController controller;

  const SecurityScreen({
    super.key,
  });

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  int select = 0;
  dynamic save;
  bool demo = false;

  bool SelectedColor = false;
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
  String pin = ''; //s
  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    // PermissionHandler().getPermission();
  }

  void addToPin(String digit, bool selectcolor) {
    setState(() {
      if (pin.length < 4) {
        pin += digit;
        selectcolor = true;
        SelectedColor = selectcolor;
      }
      if (pin.length == 4) {
        setState(() {
          save = pin;
        });
        Navigation.pushNamed(Routes.kConfirmPin, arg: save);
      }
    });
  }

  void removeLastDigit() {
    setState(() {
      if (pin.isNotEmpty) {
        pin = pin.substring(0, pin.length - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 50),
          Text(
            pin,
            style: TextStyle(fontSize: 20, color: AppColor.white),
          ),
          Center(child: Image.asset(AssetsPath.security)),
          const SizedBox(height: 20),
          Text(
            "Set New PIN here",
            style: TextStyle(color: AppColor.white, fontWeight: FontWeight.w700, fontSize: 20),
          ),
          const SizedBox(height: 20),
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
                      color: pin.length > index ? AppColor.purpal : AppColor.blackdark,
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
              )),
          SizedBox(
            height: 60,
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
                            highlightColor: AppColor.purpal.withOpacity(.3),
                            onTap: () {
                              setState(() {
                                addToPin('${index + 1}', SelectedColor == true);
                                save = pin;
                              });
                              demo = true;
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
                        addToPin('${0}', SelectedColor == true);
                        save = pin;
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
                      onTap: () {
                        // Navigation.pushNamed(Routes.k).then((value) => const Duration(milliseconds: 300));
                        // Navigator.pushNamed(context, "/ConfirmPin",);

                        setState(() {
                          save = pin;
                        });
                        Navigation.pushNamed(Routes.kConfirmPin, arg: save);
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
    );
  }
}
