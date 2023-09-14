import 'package:flutter/material.dart';
import 'package:gallery_vault/controller/provider/gallery_data_provider.dart';
import 'package:gallery_vault/view/res/app_colors.dart';
import 'package:gallery_vault/view/res/assets_path.dart';
import 'package:gallery_vault/view/screen/information/welcome_screen.dart';
import 'package:gallery_vault/view/utils/navigation_utils/navigation.dart';
import 'package:gallery_vault/view/utils/navigation_utils/routes.dart';
import 'package:gallery_vault/view/utils/size_utils.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    // PermissionHandler().getPermission();
    _loadData();
  }

  void _loadData() async {
    await Provider.of<GalleryDataProvider>(context, listen: false).fetchGalleryData();
    Navigation.replaceAll(Routes.kWelcomeScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:  Stack(
        children: [
          Container(
            height: SizeUtils.screenHeight ,
            width: SizeUtils.screenWidth,
            color: AppColor.black,
          ),
          Positioned(
              top: SizeUtils.verticalBlockSize * 15,
              right: SizeUtils.horizontalBlockSize * 15,
              child: Image.asset(AssetsPath.bg_1)),
          Positioned(
              top: SizeUtils.verticalBlockSize * 43,
              right: SizeUtils.horizontalBlockSize * 2,
              child: InkWell(
                  onTap: () {
                    Get.to(const WelcomeScreen());
                  },
                  child: Image.asset(AssetsPath.splash))),
        ],
      ),
    );
  }
}
