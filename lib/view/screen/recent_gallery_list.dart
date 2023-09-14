import 'dart:async';
import 'dart:typed_data';

import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';

import '../../controller/functions/gobal_functions.dart';
import '../../controller/provider/gallery_data_provider.dart';
import '../res/app_colors.dart';
import '../utils/navigation_utils/navigation.dart';
import '../utils/navigation_utils/routes.dart';

class RecentGalleryList extends StatefulWidget {
  const RecentGalleryList({super.key});

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
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : DraggableScrollbar.semicircle(
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
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(formatDateTime(gallery.recentImagesList[index].dateTime!)),
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
                                if (index >= 0 && index < gallery.recentImagesList.length) {
                                  int cumulativeIndex = gallery.calculateCumulativeIndex(index, i);
                                  Navigation.pushNamed(Routes.kPreviewPage, arg: {"assetsList": gallery.allRecentList, "index": cumulativeIndex}).then((value) {
                                    setState(() {});
                                  });
                                }
                              },
                              child: FutureBuilder<Uint8List?>(
                                future: data.thumbnailData,
                                builder: (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
                                  if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
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
              );
      },
    );
  }
}
