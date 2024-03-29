import 'package:flutter/material.dart';
import 'package:gallery_vault/view/res/app_colors.dart';
import 'package:gallery_vault/view/res/assets_path.dart';
import 'package:gallery_vault/view/res/strings_utils.dart';
import 'package:gallery_vault/view/utils/navigation_utils/navigation.dart';
import 'package:gallery_vault/view/utils/navigation_utils/routes.dart';
import 'package:gallery_vault/view/utils/size_utils.dart';
import 'package:gallery_vault/view/widgets/custom_button.dart';



class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Stack(
      children: [
        Container(
          height: SizeUtils.screenHeight,
          width: SizeUtils.screenWidth,
          decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(AssetsPath.splashbg), fit: BoxFit.cover)),
        ),
        Positioned(
          child: Container(
            height: SizeUtils.screenHeight,
            width: SizeUtils.screenWidth,
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage(AssetsPath.welcomebg), fit: BoxFit.cover),
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
                    Navigation.pushNamed(Routes.kPinchZoom, arg: "").then((value) {
                      setState(() {});
                    });
                  },
                  text: AppString.kContinue,
                  color: AppColor.purpal,
                ),
              ],
            ))
      ],
    ));
  }
}
