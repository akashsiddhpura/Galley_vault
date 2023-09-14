import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gallery_vault/controller/provider/gallery_data_provider.dart';
import 'package:gallery_vault/view/utils/navigation_utils/navigation.dart';
import 'package:gallery_vault/view/utils/navigation_utils/routes.dart';
import 'package:gallery_vault/view/widgets/custom_appbar.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';

import '../../controller/functions/gobal_functions.dart';
import '../res/app_colors.dart';

class FolderDataScreen extends StatefulWidget {
  const FolderDataScreen({super.key});

  @override
  State<FolderDataScreen> createState() => _FolderDataScreenState();
}

class _FolderDataScreenState extends State<FolderDataScreen> {
  List<AssetEntity> assetsList = [];
  int? index;

  void _loadAssetsInFolder() async {
    List<AssetEntity> assets = await Provider.of<GalleryDataProvider>(context, listen: false).loadAssetsInFolder(index);

    setState(() {
      assetsList = assets;
    });
  }

  @override
  void initState() {
    super.initState();
    index = Get.arguments;
    _loadAssetsInFolder();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GalleryDataProvider>(builder: (context, gallery, child) {
      return Scaffold(
          appBar: customAppBar(title: gallery.allGalleryFolders[index!].name, showLeading: true),
          body: assetsList.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : GridView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: assetsList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        // if (_videos[index].type == AssetType.video) {
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => VideoPLayerPage(
                        //         videoList: _videos,
                        //         initialIndex: index,
                        //       ),
                        //     ),
                        //   );
                        // }
                        // else {
                        //   final bytes = await XFile(File((await _videos[index].file)?.path ?? '').path).readAsBytes(); // Converts the file to UInt8List
                        //
                        //   var editedImage = await Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => ImageEditor(
                        //         image: bytes,
                        //       ),
                        //     ),
                        //   );
                        // }

                        Navigation.pushNamed(Routes.kPreviewPage, arg: {"assetsList": assetsList, "index": index}).then((value) {
                          setState(() {});
                        });
                      },
                      child: FutureBuilder<Uint8List?>(
                        future: assetsList[index].thumbnailData,
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
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Visibility(
                                    visible: assetsList[index].type == AssetType.video,
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
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Wrap(
                                              children: [
                                                Text(
                                                  durationToString(
                                                    assetsList[index].duration,
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
                    //   ListTile(
                    //   leading: FutureBuilder<Uint8List?>(
                    //     future: _videos[index].thumbnailData,
                    //     builder: (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
                    //       if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                    //         return ClipRRect(
                    //           borderRadius: BorderRadius.circular(8.0),
                    //           child: SizedBox(
                    //               height: 50,
                    //               width: 70,
                    //               child: Image.memory(
                    //                 snapshot.data!,
                    //                 fit: BoxFit.cover,
                    //               )),
                    //         );
                    //       } else {
                    //         return ClipRRect(
                    //             borderRadius: BorderRadius.circular(8.0),
                    //             child: const SizedBox(
                    //                 height: 50,
                    //                 width: 70,
                    //                 child: Icon(
                    //                   Icons.movie,
                    //                   color: Colors.white,
                    //                 )));
                    //       }
                    //     },
                    //   ),
                    //   title: Container(
                    //     margin: const EdgeInsets.only(bottom: 16),
                    //     child: Text(
                    //       _videos[index].title ?? 'Unnamed',
                    //       maxLines: 1,
                    //       style: const TextStyle(color: Colors.white),
                    //     ),
                    //   ),
                    //   onTap: () {
                    //     // Navigator.push(
                    //     //   context,
                    //     //   MaterialPageRoute(
                    //     //     builder: (context) => VideoPLayerPage(
                    //     //       videoList: _videos,
                    //     //       initialIndex: index,
                    //     //     ),
                    //     //   ),
                    //     // );
                    //   },
                    //   subtitle: Wrap(
                    //     children: [
                    //       Text(
                    //         durationToString(
                    //           _videos[index].duration,
                    //         ),
                    //         style: const TextStyle(color: Colors.white),
                    //       ),
                    //     ],
                    //   ),
                    //   // trailing: FavoriteMenuButton(favoriteVideo: _videos[index], indexKey: index)
                    // );
                  },
                ));
    });
  }
}
