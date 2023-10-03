import 'dart:io';
import 'dart:typed_data';

import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/material.dart';
import 'package:gallery_vault/controller/functions/hide_image.dart';
import 'package:gallery_vault/view/screen/VideoPlayer/video_screen.dart';
import 'package:gallery_vault/view/utils/size_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../../../../controller/functions/gobal_functions.dart';
import '../../../../../controller/provider/gallery_data_provider.dart';
import '../../../../res/app_colors.dart';
import '../../../../res/assets_path.dart';
import '../../../../utils/navigation_utils/navigation.dart';
import '../../../../utils/navigation_utils/routes.dart';

class PrivatePhoto extends StatefulWidget {
  const PrivatePhoto({super.key});

  @override
  State<PrivatePhoto> createState() => _PrivatePhotoState();
}

class _PrivatePhotoState extends State<PrivatePhoto> {
  ScrollController scrollController = ScrollController();
  Future<List<File>> getImagesFromPrivateFolder() async {
    final appDir = await getApplicationDocumentsDirectory();
    final privateDir = Directory('${appDir.path}/.private');
    if (!privateDir.existsSync()) {
      return [];
    }

    final files = privateDir.listSync();
    final imageFiles =
        files.where((file) => file is File && file.path.toLowerCase().endsWith('.jpg')); // Change the file extension to the desired image format

    return imageFiles.cast<File>().toList();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GalleryDataProvider>(
      builder: (context, gallery, child) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            backgroundColor: AppColor.purpal,
            onPressed: () {
              Navigation.pushNamed(Routes.kImageSelectionScreen, arg: "hideImage").then((value) {
                setState(() {});
                gallery.fetchGalleryData();
              });
            },
            child: Center(
                child: Icon(
              Icons.add,
              color: AppColor.white,
            )),
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
          body: FutureBuilder<List<FileSystemEntity>>(
            future: HideImage().getMediaFromHideFolder(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                          child: Image.asset(
                        AssetsPath.private,
                        height: 100,
                      )),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "No Photos and Videos",
                        style: TextStyle(color: AppColor.white, fontSize: 22, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                );
              } else {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(10),
                  itemCount: snapshot.data!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    final mediaFile = snapshot.data![index];
                    return InkWell(
                      onTap: () async {
                        if (index >= 0 && index < gallery.recentImagesList.length) {
                          // Navigation.pushNamed(Routes.kPreviewPage, arg: {"assetsList": gallery.allRecentList, "index": index}).then((value) {
                          //   setState(() {});
                          // });
                        }
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            SizedBox(
                              height: double.infinity,
                              width: double.infinity,
                              child: Image.file(
                                File(mediaFile!.path),
                                cacheHeight: 250,
                                cacheWidth: 250,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Visibility(
                              visible: (mediaFile.path.endsWith('.mp4') || mediaFile.path.endsWith('.mov') || mediaFile.path.endsWith('.avi')),
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
                                              VideoPlayerController.file(File(mediaFile.path)).value.duration.inSeconds,
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
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        );
      },
    );
  }
}
