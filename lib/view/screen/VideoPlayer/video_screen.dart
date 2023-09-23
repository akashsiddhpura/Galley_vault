import 'dart:typed_data';

import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:gallery_vault/view/utils/size_utils.dart';

import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';

import '../../../controller/functions/gobal_functions.dart';
import '../../../controller/provider/gallery_data_provider.dart';
import '../../res/app_colors.dart';
import '../../utils/navigation_utils/navigation.dart';
import '../../utils/navigation_utils/routes.dart';


class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GalleryDataProvider>(
      builder: (context, gallery, child) {
        return Scaffold(
          backgroundColor: AppColor.black,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigation.pop();
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: AppColor.white,
              ),
            ),
            title: Text(
              "Video",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: AppColor.white),
            ),
            centerTitle: true,
            backgroundColor: AppColor.blackdark,
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: RefreshIndicator(
              onRefresh: () async {
                gallery.fetchVideos();
              },
              child: Container(
                height: SizeUtils.screenHeight,
                width: SizeUtils.screenWidth,
                color: AppColor.black,
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(10),
                  itemCount: gallery.allVideoList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    AssetEntity data = gallery.allVideoList[index];
                    return InkWell(
                      onTap: () async {
                        if (index >= 0 && index < gallery.allVideoList.length) {
                          Navigation.pushNamed(Routes.kPreviewPage, arg: {"assetsList": gallery.allVideoList, "index": index}).then((value) {
                            setState(() {});
                          });
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
                                  Visibility(
                                    visible: data.type == AssetType.video,
                                    child: data.type == AssetType.video
                                        ? SizedBox(
                                            height: double.infinity,
                                            width: double.infinity,
                                            child: Image.memory(
                                              snapshot.data!,
                                              cacheHeight: 250,
                                              cacheWidth: 250,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : Container(
                                            height: double.infinity,
                                            width: double.infinity,
                                            color: AppColor.red,
                                          ),
                                  ),
                                  Visibility(
                                    visible: data.type == AssetType.video,
                                    child: FittedBox(
                                      child: Container(
                                        width: SizeUtils.horizontalBlockSize * 12,
                                        decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(8)),
                                        margin: const EdgeInsets.all(5.0),
                                        padding: const EdgeInsets.all(2.0),
                                        child:
                                        Center(
                                          child: Wrap(
                                            children: [
                                              Text(
                                                durationToString(
                                                  data.duration,
                                                ),
                                                style:  TextStyle(color: AppColor.white),
                                              ),
                                            ],
                                          ),
                                        ),

                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    bottom: 0,
                                    right: 0,
                                    left: 0,
                                    child:   Visibility(
                                      visible:data.type == AssetType.video,
                                      child:  Center(
                                        child: Icon(
                                          Icons.play_circle_outline,
                                          color: AppColor.white,
                                          size: 35,
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
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
