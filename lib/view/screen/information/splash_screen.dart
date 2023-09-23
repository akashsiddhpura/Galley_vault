import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:gallery_vault/controller/provider/gallery_data_provider.dart';
import 'package:gallery_vault/main.dart';
import 'package:gallery_vault/view/res/app_colors.dart';
import 'package:gallery_vault/view/res/assets_path.dart';
import 'package:gallery_vault/view/screen/information/welcome_screen.dart';
import 'package:gallery_vault/view/screen/main_screen.dart';
import 'package:gallery_vault/view/utils/Share_Preference.dart';
import 'package:gallery_vault/view/utils/navigation_utils/navigation.dart';
import 'package:gallery_vault/view/utils/navigation_utils/routes.dart';
import 'package:gallery_vault/view/utils/size_utils.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoading = false;

  bool isFirstTimeLogin = true;

  @override
  void initState() {
    super.initState();
    checkFirstTimeLogin();
    _loadData();
  }

  void showLoadingIndicator(BuildContext context) {
    // Use the Loader.show method to show the loading indicator.
    Loader.show(
      context,
      progressIndicator: Lottie.asset(AssetsPath.loader,),
    );
    Future.delayed(const Duration(seconds: 3), () {
      // After the task is complete, you can hide the loading indicator.
      Loader.hide();
    });
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

  void _loadData() async {
    await Provider.of<GalleryDataProvider>(context, listen: false).fetchGalleryData();
    isFirstTimeLogin ?Navigation.pushNamed(Routes.kWelcomeScreen, arg: "").then((value) {
      setState(() {});
    }) :
    Navigation.replaceAll(Routes.kMainScreen);
    // Navigation.replaceAll(Routes.kWelcomeScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.black,
        body: FutureBuilder(
          builder: (context, snapshot) {
            return Stack(
              children: [
                Container(
                  height: SizeUtils.screenHeight,
                  width: SizeUtils.screenWidth,
                  color: AppColor.black,
                ),
                Positioned(top: SizeUtils.verticalBlockSize * 15, right: SizeUtils.horizontalBlockSize * 15, child: Image.asset(AssetsPath.bg_1)),
                Positioned(
                    top: SizeUtils.verticalBlockSize * 43,
                    right: SizeUtils.horizontalBlockSize * 2,
                    child: Image.asset(AssetsPath.splash)),
              ],
            );
          },
        ));
  }
}
