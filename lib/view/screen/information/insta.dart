import 'package:flutter/material.dart';
import 'package:gallery_vault/view/res/app_colors.dart';
import 'package:gallery_vault/view/res/assets_path.dart';
import 'package:gallery_vault/view/res/strings_utils.dart';
import 'package:gallery_vault/view/utils/navigation_utils/navigation.dart';
import 'package:gallery_vault/view/utils/navigation_utils/routes.dart';
import 'package:gallery_vault/view/utils/size_utils.dart';
import 'package:gallery_vault/view/widgets/custom_button.dart';

class Insta extends StatefulWidget {
  const Insta({super.key});

  @override
  State<Insta> createState() => _InstaState();
}

class _InstaState extends State<Insta> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: SizeUtils.screenHeight,
            width: SizeUtils.screenWidth,
            color: AppColor.black,
            child: Center(
                child: Image.asset(
              AssetsPath.insta,
              height: SizeUtils.verticalBlockSize * 85,
            )),
          ),
          Positioned(
            bottom: SizeUtils.verticalBlockSize * 0,
            child: Container(
              height: SizeUtils.verticalBlockSize * 40,
              width: SizeUtils.screenWidth,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                color: AppColor.blackdark,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Image.asset(AssetsPath.p2),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Insta Grid",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: AppColor.white,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Make your photo Instagram grid with",
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                      color: AppColor.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    " high resolution.",
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                      color: AppColor.grey,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomButton2(
                    onPressed: () {
                      Navigation.replaceAll(Routes.kMainScreen);
                    },
                    text: AppString.kNext,
                    color: AppColor.purpal,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigation.replaceAll(Routes.kMainScreen);
                    },
                    child: const Text(
                      AppString.kSkip,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColor.purpal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
