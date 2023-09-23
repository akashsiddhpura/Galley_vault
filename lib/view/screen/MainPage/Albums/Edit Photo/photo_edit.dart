
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'dart:typed_data';

import 'package:gallery_vault/view/utils/size_utils.dart';

import 'package:gallery_vault/controller/provider/gallery_data_provider.dart';
import 'package:gallery_vault/view/res/app_colors.dart';
import 'package:gallery_vault/view/utils/navigation_utils/navigation.dart';
import 'package:gallery_vault/view/utils/navigation_utils/routes.dart';




class PhotoEdit extends StatefulWidget {
  const PhotoEdit({super.key});

  @override
  State<PhotoEdit> createState() => _PhotoEditState();
}

class _PhotoEditState extends State<PhotoEdit> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Consumer<GalleryDataProvider>(builder: (context, gallery, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.blackdark,
          leading: InkWell(
            onTap: () {
              Navigation.pop();
            },
            child: Icon(
              Icons.arrow_back_ios_new,
              color: AppColor.white,
            ),
          ),
          title: Text("Photo - Video Editor",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18,color: AppColor.white),),
          centerTitle: true,
        ),

        body: gallery.folderThumbnail.isEmpty  == true
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
          child: Stack(
            children: [
              RefreshIndicator(
                onRefresh: () async {
                  gallery.fetchGalleryData();
                },
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SafeArea(
                    child: Column(
                      children: [
                        Expanded(
                          child: GridView.builder(
                            itemCount: gallery.folderThumbnail.length,
                            padding: EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize * 2, vertical: SizeUtils.verticalBlockSize * 1),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: (0.92 - (gallery.columnCount * 0.04)),
                              crossAxisCount: gallery.columnCount,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                            ),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigation.pushNamed(Routes.kFolderDataScreen, arg: index);
                                },
                                child: InkWell(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: gallery.folderThumbnail[index].isNotEmpty
                                            ? FutureBuilder<Uint8List?>(
                                            future: gallery.folderThumbnail[index].first.thumbnailData,
                                            builder: (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
                                              if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                                                return SizedBox(
                                                    width: SizeUtils.screenWidth / gallery.columnCount,
                                                    height: (SizeUtils.screenWidth / gallery.columnCount) - (SizeUtils.verticalBlockSize * 2),
                                                    child: Image.memory(
                                                      snapshot.data!,
                                                      fit: BoxFit.cover,
                                                    ));
                                              } else {
                                                return ClipRRect(
                                                  borderRadius: BorderRadius.circular(8.0),
                                                  child: SizedBox(
                                                    width: SizeUtils.screenWidth / gallery.columnCount,
                                                    height: (SizeUtils.screenWidth / gallery.columnCount) - (SizeUtils.verticalBlockSize * 2),
                                                    child: const Icon(
                                                      Icons.photo,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                );
                                              }
                                            })
                                            : ClipRRect(
                                          borderRadius: BorderRadius.circular(8.0),
                                          child: SizedBox(
                                            width: SizeUtils.screenWidth / gallery.columnCount,
                                            height: (SizeUtils.screenWidth / gallery.columnCount) - (SizeUtils.verticalBlockSize * 2),
                                            child: const Icon(
                                              Icons.photo,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: double.infinity / 3.5,
                                        child: Container(
                                          padding: const EdgeInsets.only(top: 5),
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            gallery.allGalleryFolders[index].name,
                                            textAlign: TextAlign.start,
                                            maxLines: gallery.columnCount > 2 ? 1 : 2,
                                            overflow: TextOverflow.ellipsis,
                                            style:  TextStyle(color: AppColor.white, fontSize: 11, height: 1, fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "${gallery.allGalleryFolders[index].assetCount} Items",
                                          textAlign: TextAlign.start,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(color: AppColor.greyText, fontSize: 9, fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });



  }
}
