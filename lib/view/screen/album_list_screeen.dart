import 'dart:typed_data';

import 'package:gallery_vault/view/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:gallery_vault/controller/provider/gallery_data_provider.dart';
import 'package:gallery_vault/view/res/app_colors.dart';
import 'package:gallery_vault/view/utils/navigation_utils/navigation.dart';
import 'package:gallery_vault/view/utils/navigation_utils/routes.dart';
import 'package:gallery_vault/view/widgets/bottomsheets.dart';
import 'package:provider/provider.dart';

class AlbumListScreen extends StatefulWidget {
  const AlbumListScreen({super.key});

  @override
  State<AlbumListScreen> createState() => _AlbumListScreenState();
}

class _AlbumListScreenState extends State<AlbumListScreen> {



  TextEditingController name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<GalleryDataProvider>(builder: (context, gallery, child) {
      return Scaffold(
        floatingActionButton: Container(
          height: SizeUtils.verticalBlockSize * 5.5,
          width: SizeUtils.horizontalBlockSize * 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: AppColor.purpal,
          ),
          child: FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30)
            ),
            backgroundColor: AppColor.purpal,
            onPressed: () {
              AppBottomSheets().openAlbumsBottomSheet(context);
            },
            child:  Center(child:
            Text("+ Create Albums",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: AppColor.white),),),
          ),
        ),
        body: gallery.folderThumbnail.isEmpty || gallery.getVideoThumb == false
            ? Container(
          height: SizeUtils.screenHeight,
          width: SizeUtils.screenWidth,
          color: AppColor.black,
              child: const Column(
                children: [
                  Center(
                      child: CircularProgressIndicator(
                        color: AppColor.purpal,
                      ),
                    ),
                ],
              ),
            )
            : Container(
          height: SizeUtils.screenHeight,
              width: SizeUtils.screenWidth,
              color: AppColor.black,
              child: RefreshIndicator(
                  onRefresh: () async {
                    gallery.fetchGalleryData();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: SafeArea(
                      child: Column(
                        children: [
                          Center(child: Image.asset("asset/images/upgrade.png",height: SizeUtils.verticalBlockSize*16,width: SizeUtils.horizontalBlockSize * 90,)),
                          Expanded(
                            child: GridView.builder(
                              itemCount: gallery.folderThumbnail.length,
                              physics: const AlwaysScrollableScrollPhysics(),
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ),
      );
    });
  }
}
