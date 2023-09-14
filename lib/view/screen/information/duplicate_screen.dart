import 'package:flutter/material.dart';
import 'package:gallery_vault/view/res/app_colors.dart';
import 'package:gallery_vault/view/res/assets_path.dart';
import 'package:gallery_vault/view/res/strings_utils.dart';
import 'package:gallery_vault/view/screen/information/insta.dart';
import 'package:gallery_vault/view/screen/main_screen.dart';
import 'package:gallery_vault/view/utils/size_utils.dart';
import 'package:get/get.dart';

class Duplicate_Screen extends StatefulWidget {
  const Duplicate_Screen({super.key});

  @override
  State<Duplicate_Screen> createState() => _Duplicate_ScreenState();
}

class _Duplicate_ScreenState extends State<Duplicate_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Stack(
        children: [
          Container(
            height: SizeUtils.screenHeight ,
            width: SizeUtils.screenWidth,
            color: AppColor.black,
            child: Image.asset(AssetsPath.duplicat),
          ),
          Positioned(
            bottom: SizeUtils.verticalBlockSize * 0,
            child: Container(height: SizeUtils.verticalBlockSize * 40,
              width: SizeUtils.screenWidth,
              color: const Color(0xff1F222A),
              child: Column(crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30,),
                  Image.asset(AssetsPath.p3),
                  const SizedBox(
                    height: 30,
                  ),
                  Text("Duplicate Scan",style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Urbanist',
                    fontStyle: FontStyle.italic,
                    color: AppColor.white,
                  ),),
                  const SizedBox(height: 10,),

                  const Text("Scan for similar photos remove duplicate",style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Urbanist',
                    fontStyle: FontStyle.italic,
                    color: AppColor.grey,
                  ),),
                  const SizedBox(height: 5,),

                  const Text(" Photos with ease.",style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Urbanist',
                    fontStyle: FontStyle.italic,
                    color: AppColor.grey,
                  ),),
                  const SizedBox(height: 30,),
                  InkWell(
                    onTap: () {
                      Get.to(Insta());
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
      ),
    );
  }
}
