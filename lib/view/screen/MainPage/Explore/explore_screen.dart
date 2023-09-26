// import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gallery_vault/view/res/app_colors.dart';
import 'package:gallery_vault/view/res/assets_path.dart';

import 'package:gallery_vault/view/utils/navigation_utils/navigation.dart';
import 'package:gallery_vault/view/utils/navigation_utils/routes.dart';

import 'package:gallery_vault/view/utils/size_utils.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../controller/provider/gallery_data_provider.dart';
import '../../../../controller/provider/preview_page_provider.dart';
import '../../VideoPlayer/video_screen.dart';


class Explore_Screen extends StatefulWidget {
  const Explore_Screen({super.key});

  @override
  State<Explore_Screen> createState() => _Explore_ScreenState();
}

class _Explore_ScreenState extends State<Explore_Screen> {
  String? privateSafePin;
  String avi = 'Insta Grid';
  @override
  void initState() {
    super.initState();
    checkFirstTimeSetPin();
    // setFirstTimeLoginStatus();
  }

  Future<void> checkFirstTimeSetPin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    privateSafePin = prefs.getString('privateSafePin');

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GalleryDataProvider>(builder: (context, gallery, child) {
      return Consumer<PreviewPageProvider>(builder: (context, preview, child) {
        return Scaffold(
          body: Container(
            height: SizeUtils.screenHeight,
            width: SizeUtils.screenWidth,
            color: AppColor.black,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    children: List.generate(
                        3,
                        (index) => InkWell(
                              onTap: () {
                                if (index == 0) {
                                  Navigation.pushNamed(Routes.kVideoScreen);
                                } else if (index == 1) {
                                  Navigation.pushNamed(privateSafePin == null ? Routes.kSecurityScreen : Routes.kConfirmPin2, arg: privateSafePin)
                                      .then((value) {
                                    setState(() {});
                                  });
                                } else if(index == 2) {
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      backgroundColor: AppColor.blackdark,
                                      shape: InputBorder.none,
                                      duration: const Duration(seconds: 2),content: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          const SizedBox(height: 10,),
                                          Container(
                                          height: 20,
                                          child: const Text("Up Coming fetcher")),
                                          const SizedBox(height: 10,),
                                        ],
                                      ))) ;
                                }
                              },
                              child: Container(
                                height: SizeUtils.verticalBlockSize * 21,
                                width: SizeUtils.horizontalBlockSize * 41,
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColor.blackdark,
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Center(
                                      child: Image.asset(
                                        gallery.images[index],
                                        height: SizeUtils.verticalBlockSize * 9,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      gallery.text1[index],
                                      textAlign: TextAlign.start,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: AppColor.white, fontSize: 14, fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      index==0? "${gallery.allVideoList.length}":gallery.text2[index],
                                      textAlign: TextAlign.start,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(color: AppColor.greyText, fontSize: 12, fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                  ),
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 10.0),
                 child: Column(mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     const SizedBox(
                       height: 30,
                     ),
                     Padding(
                       padding: const EdgeInsets.symmetric(horizontal: 10.0),
                       child: Text(
                         "Create Your Photos",
                         style: TextStyle(color: AppColor.white, fontSize: 14, fontWeight: FontWeight.w600),
                       ),
                     ),
                     const SizedBox(
                       height: 20,
                     ),
                     InkWell(
                       onTap: () {
                         Navigation.pushNamed(Routes.kImageSelectionScreen, arg: avi);
                       },
                       child: Container(
                         height: SizeUtils.verticalBlockSize * 10,
                         width: SizeUtils.screenWidth,
                         decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(10),
                             color: AppColor.blackdark,
                             border: Border.all(width: 0.5, color: AppColor.white.withOpacity(0.5))),
                         child: Padding(
                           padding: const EdgeInsets.all(2.0),
                           child: ListTile(
                             leading: Stack(
                               clipBehavior: Clip.none,
                               children: [
                                 Image.asset(AssetsPath.ellipse),
                                 Positioned(
                                     top: 0,
                                     bottom: 0,
                                     left: 0,
                                     right: 0,
                                     child: Center(
                                         child: Image.asset(
                                           AssetsPath.frame,
                                           height: SizeUtils.verticalBlockSize * 15,
                                         )))
                               ],
                             ),
                             title: Text(
                               "Insta Grid",
                               style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: AppColor.white),
                             ),
                             subtitle: const Text(
                               "Edit Photo Like Pro",
                               style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: AppColor.greyText),
                             ),
                             trailing: Icon(
                               Icons.arrow_forward_ios_outlined,
                               color: AppColor.white,
                             ),
                           ),
                         ),
                       ),
                     ),
                     const SizedBox(
                       height: 20,
                     ),
                     InkWell(
                       onTap: () {
                         Navigation.pushNamed(Routes.kPhotoEdit, );
                       },
                       child: Container(
                         height: SizeUtils.verticalBlockSize * 10,
                         width: SizeUtils.screenWidth,
                         decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(10),
                             color: AppColor.blackdark,
                             border: Border.all(width: 0.5, color: AppColor.white.withOpacity(0.5))),
                         child: Padding(
                           padding: const EdgeInsets.all(2.0),
                           child: ListTile(
                             leading: Stack(
                               clipBehavior: Clip.none,
                               children: [
                                 Image.asset(AssetsPath.ellipse),
                                 Positioned(
                                     top: 0,
                                     bottom: 0,
                                     left: 0,
                                     right: 0,
                                     child: Center(
                                         child: Image.asset(
                                           AssetsPath.frame2,
                                           height: SizeUtils.verticalBlockSize * 15,
                                         )))
                               ],
                             ),
                             title: Text(
                               "Photo Editor",
                               style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: AppColor.white),
                             ),
                             subtitle: const Text(
                               "Edit Photo Like Pro",
                               style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: AppColor.greyText),
                             ),
                             trailing: Icon(
                               Icons.arrow_forward_ios_outlined,
                               color: AppColor.white,
                             ),
                           ),
                         ),
                       ),
                     ),
                   ],
                 ),
               )
                ],
              ),
            ),
          ),
        );
      });
    });
  }
}
