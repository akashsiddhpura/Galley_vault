import 'package:flutter/material.dart';
import 'package:gallery_vault/view/res/app_colors.dart';
import 'package:gallery_vault/view/res/assets_path.dart';
import 'package:gallery_vault/view/res/strings_utils.dart';
import 'package:gallery_vault/view/screen/information/pinch_zoom.dart';
import 'package:gallery_vault/view/utils/Share_Preference.dart';
import 'package:gallery_vault/view/utils/navigation_utils/navigation.dart';
import 'package:gallery_vault/view/utils/navigation_utils/routes.dart';
import 'package:gallery_vault/view/utils/size_utils.dart';
import 'package:gallery_vault/view/widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../demo.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  //
  // Future<void> setFirstTimeLoginStatus() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool('isFirstTimeLogin', false);
  // }
  // Future<bool> isFirstTimeLogin() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool isFirstTime = prefs.getBool('isFirstTimeLogin') ?? true;
  //   return isFirstTime;
  // }

  bool isFirstTimeLogin = true;

  @override
  void initState() {
    super.initState();
    checkFirstTimeLogin();
    // setFirstTimeLoginStatus();
  }

  Future<void> checkFirstTimeLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('firstTimeLogin') ?? true;

    setState(() {
      isFirstTimeLogin = isFirstTime;
    });

    if (isFirstTime) {
      prefs.setBool('firstTimeLogin', false); // Mark as not the first time
    }
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: FutureBuilder(
        future: checkFirstTimeLogin(),
        builder: (context, snapshot) {
          return Stack(
            children: [
              Container(
                height: SizeUtils.screenHeight,
                width: SizeUtils.screenWidth,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AssetsPath.splashbg), fit: BoxFit.cover)),
              ),
              Positioned(
                child: Container(
                  height: SizeUtils.screenHeight,
                  width: SizeUtils.screenWidth,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AssetsPath.welcomebg), fit: BoxFit.cover),
                  ),
                ),
              ),
              Positioned(
                  bottom: SizeUtils.verticalBlockSize * 5,
                  right: SizeUtils.horizontalBlockSize * 5,
                  child: Column(
                    children: [
                      Text(
                        "WELCOME TO",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          fontFamily: AppString.kMuseoModerno,
                          color: AppColor.white,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "GALLERY",
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: AppString.kMuseoModerno,
                          fontWeight: FontWeight.w700,
                          color: AppColor.white,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Most advance feature and smart gallery",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColor.grey,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      CustomButton2(
                        onPressed: () {
                          isFirstTimeLogin ?Navigation.pushNamed(Routes.kPinchZoom, arg: "").then((value) {
                            setState(() {});
                          }) :
                          Navigation.replaceAll(Routes.kMainScreen);

                        },
                        text: AppString.kContinue,
                        color: AppColor.purpal,
                      ),
                    ],
                  ))
            ],
          );
        },
      )
    );
  }
}
