import 'package:flutter/material.dart';
import 'package:gallery_vault/view/res/app_colors.dart';
import 'package:gallery_vault/view/res/assets_path.dart';
import 'package:gallery_vault/view/res/strings_utils.dart';
import 'package:gallery_vault/view/screen/information/duplicate_screen.dart';
import 'package:gallery_vault/view/screen/main_screen.dart';
import 'package:gallery_vault/view/utils/navigation_utils/navigation.dart';
import 'package:gallery_vault/view/utils/navigation_utils/routes.dart';
import 'package:gallery_vault/view/utils/size_utils.dart';
import 'package:gallery_vault/view/widgets/custom_button.dart';
import 'package:get/get.dart';



class PrivateLocker extends StatefulWidget {
  const PrivateLocker({super.key});

  @override
  State<PrivateLocker> createState() => _PrivateLockerState();
}

class _PrivateLockerState extends State<PrivateLocker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:   Stack(
        children: [
          Container(
            height: SizeUtils.screenHeight ,
            width: SizeUtils.screenWidth,
            color: AppColor.black,
            child: Center(child: Image.asset(AssetsPath.lock,height: SizeUtils.verticalBlockSize * 85,)),
          ),
          Positioned(
            bottom: SizeUtils.verticalBlockSize * 0,
            child: Container(height: SizeUtils.verticalBlockSize * 40,
              width: SizeUtils.screenWidth,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                  color:AppColor.blackdark
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30,),
                  Image.asset(AssetsPath.p1),
                  const SizedBox(
                    height: 30,
                  ),
                  Text("Private Locker",style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: AppColor.white,
                  ),),
                  const SizedBox(height: 10,),
                  const Text("Protect your photos & videos lock your ",style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                    color: AppColor.grey,
                  ),),
                  const SizedBox(height: 5,),
                  const Text(" private Photos & Videos.",style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                    color: AppColor.grey,
                  ),),
                  const SizedBox(height: 30,),
                  CustomButton2(onPressed: (){
                    Navigation.pushNamed(Routes.kDuplicateScreen, arg: "").then((value) {
                      setState(() {});
                    });
                  }, text: AppString.kNext, color: AppColor.purpal,),
                  const SizedBox(height: 10,),
                  InkWell(
                    onTap: () {
                      Navigation.replaceAll(Routes.kMainScreen);

                    },
                    child: const Text(AppString.kSkip,style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                        color: AppColor.purpal,
                    ),),
                  ),
                ],
              ),
            ),)
        ],
      )
    );
  }
}
