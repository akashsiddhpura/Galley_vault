import 'dart:io';
import 'dart:typed_data';

import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:gallery_vault/view/utils/size_utils.dart';
import 'package:get/get.dart';

import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';

import '../../controller/functions/gobal_functions.dart';
import '../../controller/provider/gallery_data_provider.dart';
import '../res/app_colors.dart';
import '../utils/date_formatter.dart';
import '../utils/navigation_utils/navigation.dart';
import '../utils/navigation_utils/routes.dart';

// ignore: must_be_immutable
class RecentGalleryList extends StatefulWidget {
  bool? isSelectImage;
  bool? isSelectImage2;
  RecentGalleryList({super.key, this.isSelectImage, this.isSelectImage2});

  @override
  State<RecentGalleryList> createState() => _RecentGalleryListState();
}

class _RecentGalleryListState extends State<RecentGalleryList> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Consumer<GalleryDataProvider>(
      builder: (context, gallery, child) {
        return gallery.allRecentList.isEmpty && !gallery.dummySet
            ? Container(
                height: SizeUtils.screenHeight,
                width: SizeUtils.screenWidth,
                color: AppColor.black,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: AppColor.purpal,
                  ),
                ),
              )
            : Container(
                height: SizeUtils.screenHeight,
                width: SizeUtils.screenWidth,
                color: AppColor.black,
                child: DraggableScrollbar.semicircle(
                  controller: scrollController,
                  heightScrollThumb: 48.0,
                  padding: const EdgeInsets.only(right: 10),
                  backgroundColor: Colors.deepPurple,
                  labelConstraints: const BoxConstraints.tightFor(width: 80.0, height: 30.0),
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: gallery.recentImagesList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text(
                              daysBetween(apiDate: gallery.recentImagesList[index].dateTime!, now: DateTime.now()) == 0
                                  ? "Today"
                                  : daysBetween(apiDate: gallery.recentImagesList[index].dateTime!, now: DateTime.now()) == -1
                                      ? "Yesterday"
                                      : formatDateTime(
                                          gallery.recentImagesList[index].dateTime!,
                                        ),
                              style: TextStyle(color: AppColor.white),
                            ),
                          ),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(10),
                            itemCount: gallery.recentImagesList[index].listOfImages!.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemBuilder: (context, i) {
                              AssetEntity data = gallery.recentImagesList[index].listOfImages![i];
                              return InkWell(
                                onTap: () async {
                                  if (Get.arguments == "Insta Grid" && widget.isSelectImage2 == false) {
                                    AssetEntity data2 = gallery.recentImagesList[index].listOfImages![i];
                                    // gallery.selectInstaGridImage(data2);
                                    // gallery.clearSelectedImageList();

                                    File? imageFile = await data2.file.then((value) {
                                      Navigation.replace(
                                        Routes.kInstaGrideScreen,
                                        arguments: value,
                                      );
                                    });
                                  } else {
                                    if (widget.isSelectImage == true) {
                                      gallery.selectImage(data);
                                    } else {
                                      if (index >= 0 && index < gallery.recentImagesList.length) {
                                        int cumulativeIndex = gallery.calculateCumulativeIndex(index, i);
                                        Navigation.pushNamed(Routes.kPreviewPage,
                                            arg: {"assetsList": gallery.allRecentList, "index": cumulativeIndex}).then((value) {
                                          setState(() {});
                                        });
                                      }
                                    }
                                  }
                                },
                                child: FutureBuilder<Uint8List?>(
                                  future: data.thumbnailData,
                                  builder: (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
                                    if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(15.0),
                                        child: Stack(
                                          alignment: Alignment.bottomLeft,
                                          children: [
                                            SizedBox(
                                              height: double.infinity,
                                              width: double.infinity,
                                              child: Image.memory(
                                                snapshot.data!,
                                                cacheHeight: 250,
                                                cacheWidth: 250,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Visibility(
                                              visible: data.type == AssetType.video,
                                              child: FittedBox(
                                                child: Container(
                                                  decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(5)),
                                                  margin: const EdgeInsets.all(5.0),
                                                  padding: const EdgeInsets.all(2.0),
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Icon(
                                                        Icons.play_circle_fill_rounded,
                                                        color: AppColor.white,
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Wrap(
                                                        children: [
                                                          Text(
                                                            durationToString(
                                                              data.duration,
                                                            ),
                                                            style: const TextStyle(color: Colors.white),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Visibility(
                                              visible: gallery.selectedImageList.contains(data),
                                              child: Container(
                                                alignment: Alignment.center,
                                                color: AppColor.deeppurple.withOpacity(0.8),
                                              ),
                                            ),
                                            Positioned(
                                              top: -2,
                                              right: 5,
                                              child: Visibility(
                                                visible: gallery.selectedImageList.contains(data),
                                                child: Container(
                                                  height: SizeUtils.verticalBlockSize * 4,
                                                  width: SizeUtils.horizontalBlockSize * 5,
                                                  decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: AppColor.green,
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Icon(
                                                    Icons.done,
                                                    color: AppColor.white,
                                                    size: 15,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    } else {
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(8.0),
                                        child: const SizedBox(
                                          height: 50,
                                          width: 70,
                                          child: Icon(
                                            Icons.movie,
                                            color: Colors.white,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              );
                            },
                          )
                        ],
                      );
                    },
                  ),
                ),
              );
      },
    );
  }
}
