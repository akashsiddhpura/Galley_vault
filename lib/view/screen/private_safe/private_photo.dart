
import 'dart:io';
import 'dart:typed_data';

import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:gallery_vault/view/utils/size_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';

import '../../../controller/functions/gobal_functions.dart';
import '../../../controller/provider/gallery_data_provider.dart';
import '../../res/app_colors.dart';
import '../../res/assets_path.dart';
import '../../utils/navigation_utils/navigation.dart';
import '../../utils/navigation_utils/routes.dart';

class PrivatePhoto extends StatefulWidget {
  const PrivatePhoto({super.key});

  @override
  State<PrivatePhoto> createState() => _PrivatePhotoState();
}

class _PrivatePhotoState extends State<PrivatePhoto> {
  ScrollController scrollController = ScrollController();
  bool empty = false;
  Future<List<File>> getImagesFromPrivateFolder() async {
    final appDir = await getApplicationDocumentsDirectory();
    final privateDir = Directory('${appDir.path}/.private');
    if (!privateDir.existsSync()) {
      return [];
    }

    final files = privateDir.listSync();
    final imageFiles = files.where((file) =>
    file is File && file.path.toLowerCase().endsWith('.jpg')); // Change the file extension to the desired image format

    return imageFiles.cast<File>().toList();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      empty = true;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GalleryDataProvider>(
      builder: (context, gallery, child) {
        return empty==true? Scaffold(
          floatingActionButton: FloatingActionButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
            ),
            backgroundColor: AppColor.purpal,
            onPressed: () {
            },
            child:  Center(child: Icon(Icons.add,color: AppColor.white,)
           ),
          ),

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
              "Private Safe",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: AppColor.white),
            ),
            centerTitle: true,
            backgroundColor: AppColor.blackdark,

          ),
          backgroundColor: AppColor.black,
          body: gallery.allRecentList.isEmpty && !gallery.dummySet
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
                              height: 10,
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
                                      Navigation.pushNamed(Routes.kPreviewPage, arg: {"assetsList": gallery.allRecentList, "index": cumulativeIndex})
                                          .then((value) {
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
                                              Positioned(
                                                top: 0,
                                                right: 0,
                                                bottom: 0,
                                                left: 0,
                                                child: Visibility(
                                                  visible: data.type == AssetType.video,
                                                  child: Container(
                                                    height: SizeUtils.verticalBlockSize * 5,
                                                    width: SizeUtils.horizontalBlockSize *10,
                                                    decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(5)),
                                                    // margin: const EdgeInsets.all(5.0),
                                                    padding: const EdgeInsets.all(2.0),
                                                    child: Center(
                                                      child: Icon(
                                                        Icons.play_circle_fill_rounded,
                                                        color: AppColor.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Visibility(
                                                visible: data.type == AssetType.video,
                                                child: FittedBox(
                                                  child: Container(
                                                    height: SizeUtils.verticalBlockSize * 3,
                                                    width: SizeUtils.horizontalBlockSize * 12,
                                                    decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(5)),
                                                    margin: const EdgeInsets.all(5.0),
                                                    padding: const EdgeInsets.all(2.0),
                                                    child: Text(
                                                      durationToString(
                                                        data.duration,
                                                      ),
                                                      style: const TextStyle(color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
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
                ),
        ):Scaffold(
          floatingActionButton: FloatingActionButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
            ),
            backgroundColor: AppColor.purpal,
            onPressed: () {

            },
            child:  Center(child: Icon(Icons.add,color: AppColor.white,)
            ),
          ),

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
              "Private Safe",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: AppColor.white),
            ),
            centerTitle: true,
            backgroundColor: AppColor.blackdark,

          ),
          backgroundColor: AppColor.black,
          body: Align(
            alignment: Alignment.center,
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child: Image.asset(AssetsPath.private,height: 100,)),
                SizedBox(
                  height: 20,
                ),
                Text("No Photos and Videos",style: TextStyle(color: AppColor.white,fontSize: 22,fontWeight: FontWeight.w600),)
              ],
            ),
          ),
        );
      },
    );
  }
}
