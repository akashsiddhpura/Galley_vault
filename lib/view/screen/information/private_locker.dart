import 'package:flutter/material.dart';
import 'package:gallery_vault/view/res/app_colors.dart';
import 'package:gallery_vault/view/res/strings_utils.dart';
import 'package:gallery_vault/view/screen/information/duplicate_screen.dart';
import 'package:get/get.dart';

import '../../res/assets_path.dart';
import '../../utils/size_utils.dart';
import '../main_screen.dart';

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
            child: Image.asset(AssetsPath.lock),
          ),
          Positioned(
            bottom: SizeUtils.verticalBlockSize * 0,
            child: Container(height: SizeUtils.verticalBlockSize * 40,
              width: SizeUtils.screenWidth,
              color: const Color(0xff1F222A),
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
                    fontFamily: 'Urbanist',
                    fontStyle: FontStyle.italic,
                    color: AppColor.white,
                  ),),
                  const SizedBox(height: 10,),

                  const Text("Protect your photos & videos lock your ",style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Urbanist',
                    fontStyle: FontStyle.italic,
                    color: AppColor.grey,
                  ),),
                  const SizedBox(height: 5,),

                  const Text(" private Photos & Videos.",style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Urbanist',
                    fontStyle: FontStyle.italic,
                    color: AppColor.grey,
                  ),),
                  const SizedBox(height: 30,),
                  InkWell(
                    onTap: () {
                      Get.to(Duplicate_Screen());
                    },
                    child: Container(
                      height: SizeUtils.verticalBlockSize * 7,
                      width: SizeUtils.horizontalBlockSize * 80,
                      decoration: BoxDecoration(
                          color: AppColor.purpal,
                          borderRadius: BorderRadius.circular(30)
                      ),
                      child: Center(child: Text(AppString.kNext,style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic,
                        color: AppColor.white,
                      )),),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  InkWell(
                    onTap: () {
                      Get.to(const MainScreen());
                    },
                    child: const Text(AppString.kSkip,style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'MuseoModerno',
                      fontStyle: FontStyle.italic,
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
