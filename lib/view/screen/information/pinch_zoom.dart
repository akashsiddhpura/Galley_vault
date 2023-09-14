import 'package:flutter/material.dart';
import 'package:gallery_vault/view/res/app_colors.dart';
import 'package:gallery_vault/view/res/strings_utils.dart';
import 'package:gallery_vault/view/screen/information/private_locker.dart';
import 'package:gallery_vault/view/screen/main_screen.dart';

import 'package:gallery_vault/view/utils/size_utils.dart';
import 'package:gallery_vault/view/widgets/custom_button.dart';
import 'package:get/get.dart';

import '../../res/assets_path.dart';


class PinchZoom extends StatefulWidget {
  const PinchZoom({super.key});

  @override
  State<PinchZoom> createState() => _PinchZoomState();
}

class _PinchZoomState extends State<PinchZoom> with TickerProviderStateMixin {

  @override


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          Container(
            height: SizeUtils.screenHeight ,
            width: SizeUtils.screenWidth,
            color: AppColor.black,
            child: Image.asset(AssetsPath.pinchzoom),
          ),
          Positioned(
            bottom: SizeUtils.verticalBlockSize * 0,
            child: Container(height: SizeUtils.verticalBlockSize * 40,
            width: SizeUtils.screenWidth,
            color: const Color(0xff1F222A),
            child: Column(crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30,),
                Image.asset(AssetsPath.g2),
                const SizedBox(
                  height: 30,
                ),
                Text("Pinch Zoom",style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'MuseoModerno',
                  fontStyle: FontStyle.italic,
                  color: AppColor.white,
                ),),
                const SizedBox(height: 10,),

                const Text("Set your gallery grid image for better ",style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'MuseoModerno',
                  fontStyle: FontStyle.italic,
                  color: AppColor.grey,
                ),),
                const SizedBox(height: 5,),

                const Text("view by finger tips.",style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'MuseoModerno',
                  fontStyle: FontStyle.italic,
                  color: AppColor.grey,
                ),),
                const SizedBox(height: 30,),
             CustomButton2(onPressed: (){
               Get.to(PrivateLocker());

             }, text: AppString.kNext, color: AppColor.purpal,),
                const SizedBox(height: 10,),
                InkWell(
                  onTap: () {
                    Get.to(MainScreen());
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
