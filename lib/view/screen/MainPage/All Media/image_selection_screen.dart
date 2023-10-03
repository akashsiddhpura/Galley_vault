import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_vault/controller/functions/hide_image.dart';
import 'package:gallery_vault/view/screen/MainPage/All%20Media/recent_gallery_list.dart';

import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

import 'package:provider/provider.dart';

import '../../../../controller/provider/gallery_data_provider.dart';
import '../../../res/app_colors.dart';
import '../../../widgets/loder.dart';

class ImageSelectionScreen extends StatefulWidget {
  const ImageSelectionScreen({super.key});

  @override
  State<ImageSelectionScreen> createState() => _ImageSelectionScreenState();
}

class _ImageSelectionScreenState extends State<ImageSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GalleryDataProvider>(builder: (context, gallery, child) {
      return Scaffold(
        appBar: AppBar(
            backgroundColor: AppColor.blackdark,
            title: Row(
              children: [
                Text(
                  "${gallery.selectedImageList.length}",
                  style: TextStyle(color: AppColor.white, fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "Select",
                  style: TextStyle(color: AppColor.white, fontSize: 18, fontWeight: FontWeight.w600),
                )
              ],
            ),
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColor.white,
                )),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () async {
                    if (Get.arguments == "hideImage") {
                      AppLoader.sw(context);
                      for (var i = 0; i < gallery.selectedImageList.length; i++) {
                        File? file = await gallery.selectedImageList[i].file;

                        await HideImage().hideImage(file!.path);
                      }
                      AppLoader.hd();
                      gallery.selectedImageList.clear();
                      Get.back();
                    } else {
                      if (gallery.selectedImageList.isNotEmpty) {
                        await gallery.saveImagesToFolder(gallery.selectedImageList, folderName: Get.arguments).then((value) {
                          gallery.selectedImageList.clear();
                          Get.back();
                        });
                      }
                    }
                  },
                  icon: const Icon(
                    Icons.done,
                    color: AppColor.green,
                  )),
              const SizedBox(
                width: 5,
              )
            ]),
        body: RecentGalleryList(
          isSelectImage: true,
          isSelectImage2: false,
        ),
      );
    });
  }
}
