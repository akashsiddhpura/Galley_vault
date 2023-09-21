//
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'dart:async';
// import 'dart:io';
//
// import 'package:gallery_saver/gallery_saver.dart';
//
//
// import 'package:photo_manager/photo_manager.dart';
//
//
//
// enum SortOption { name, lastModifiedDate, size, path }
//
// enum SortOrder { ascending, descending }
//
// class GalleryDataController extends GetxController {
//   RxBool isSelectImage = true.obs;
//   final List<AssetPathEntity> _nonEmptyFolderList = [];
//   List<AssetPathEntity> _allGalleryFolders = [];
//   List<AssetEntity> _allRecentList = [];
//   RxList<AssetEntity> selectedImageList = <AssetEntity>[].obs;
//   final List<List<AssetEntity>> _folderThumbnail = [];
//   bool getVideoThumb = false;
//   bool dummySet = false;
//   int columnCount = 3;
//
//
//   List<AssetPathEntity> get allGalleryFolders => _nonEmptyFolderList;
//   List<AssetEntity> get allRecentList => _allRecentList;
//   List<List<AssetEntity>> get folderThumbnail => _folderThumbnail;
//
//   fetchGalleryData() async {
//     _allGalleryFolders.clear();
//     _allRecentList.clear();
//     recentImagesList.clear();
//     final PermissionState ps = await PhotoManager.requestPermissionExtend();
//
//     final albums = await PhotoManager.getAssetPathList(type: RequestType.common);
//
//     final recentAlbum = albums.first;
//     final assetCount = await recentAlbum.assetCountAsync;
//     final recentAssets = await recentAlbum.getAssetListRange(start: 0, end: assetCount - 1);
//
//     albums.removeAt(0);
//     _allGalleryFolders = albums;
//     _allRecentList = recentAssets.toList();
//
//     sortRecentListWithModifiedDate();
//     fetchFolderThumbnail();
//     for (var image in _allRecentList) {
//       addImageToRecentList(image);
//     }
//     // notifyListeners();
//   }
//
//   void fetchFolderThumbnail() async {
//     _nonEmptyFolderList.clear();
//     _folderThumbnail.clear();
//     for (int i = 0; i < _allGalleryFolders.length; i++) {
//       List<AssetEntity> videos = await _allGalleryFolders[i].getAssetListRange(start: 0, end: 1);
//       if (videos.isNotEmpty) {
//         _nonEmptyFolderList.add(_allGalleryFolders[i]);
//         _folderThumbnail.add(videos);
//       }
//     }
//
//     getVideoThumb = true;
//   }
//
//   RxList<RecentImages> recentImagesList = <RecentImages>[].obs;
//
//   void addImageToRecentList(AssetEntity image) {
//     DateTime imageDate = image.modifiedDateTime;
//
//     int existingIndex = recentImagesList.indexWhere(
//             (item) => item.dateTime?.year == imageDate.year && item.dateTime?.month == imageDate.month && item.dateTime?.day == imageDate.day);
//
//     if (existingIndex != -1) {
//       recentImagesList[existingIndex].listOfImages?.add(image);
//     } else {
//       recentImagesList.add(RecentImages(
//         dateTime: DateTime(imageDate.year, imageDate.month, imageDate.day),
//         listOfImages: [image],
//       ));
//     }
//   }
//
//   void sortRecentListWithModifiedDate() {
//     _allRecentList.sort((a, b) {
//       int result = 0;
//       result = a.modifiedDateTime.compareTo(b.modifiedDateTime);
//       return -result;
//     });
//   }
//
//   int calculateCumulativeIndex(int listIndex, int imageIndex) {
//     int cumulativeIndex = imageIndex;
//     for (int i = 0; i < listIndex; i++) {
//       cumulativeIndex += recentImagesList[i].listOfImages!.length;
//     }
//     return cumulativeIndex;
//   }
//
//   Future<List<AssetEntity>> loadAssetsInFolder(index) async {
//     List<AssetEntity> assets = await _nonEmptyFolderList[index].getAssetListRange(start: 0, end: 10000);
//     return assets;
//   }
//
//   /// sorting
//   SortOption selectedSortOption = SortOption.name;
//   SortOrder selectedSortOrder = SortOrder.ascending;
//
//   void sortList() {
//     _nonEmptyFolderList.sort((a, b) {
//       int result = 0;
//       if (selectedSortOption == SortOption.name) {
//         result = a.name.compareTo(b.name);
//       } else if (selectedSortOption == SortOption.lastModifiedDate) {
//         if (a.lastModified != null && b.lastModified != null) {
//           result = a.lastModified!.compareTo(b.lastModified!);
//         }
//       } else if (selectedSortOption == SortOption.size) {
//         result = a.assetCount.compareTo(b.assetCount);
//       } else if (selectedSortOption == SortOption.path) {
//         // result = a..compareTo(b.relativePath);
//       }
//
//       if (selectedSortOrder == SortOrder.descending) {
//         result = -result;
//       }
//
//       return result;
//     });
//   }
//
//   String optionToString(SortOption option) {
//     switch (option) {
//       case SortOption.name:
//         return "Name";
//       case SortOption.lastModifiedDate:
//         return "Last Modified Date";
//       case SortOption.size:
//         return "Size";
//       case SortOption.path:
//         return "Path";
//       default:
//         return "";
//     }
//   }
//
//   String orderToString(SortOrder order) {
//     return order == SortOrder.ascending ? "Ascending" : "Descending";
//   }
//
//   /// scroll controller
//   final ScrollController _scrollController = ScrollController();
//   double _scrollPercentage = 0.0;
//   bool _showPercentage = false;
//   Timer? _hideTimer;
//
//   ScrollController get scrollController => _scrollController;
//   double get scrollPercentage => _scrollPercentage;
//   bool get showPercentage => _showPercentage;
//   Timer? get hideTimer => _hideTimer;
//
//   void updateScrollPercentage() {
//     _scrollPercentage = _scrollController.offset / _scrollController.position.maxScrollExtent;
//     _showPercentage = true;
//
//     _hideTimer?.cancel(); // Cancel previous timer
//     _hideTimer = Timer(Duration(seconds: 1), () {
//       _showPercentage = false;
//     });
//   }
//
//   void selectImage(AssetEntity assetEntity) {
//     if (selectedImageList.contains(assetEntity)) {
//       selectedImageList.remove(assetEntity);
//     } else {
//       selectedImageList.add(assetEntity);
//     }
//   }
//
//   Future<void> saveImagesToFolder(List<AssetEntity> images, {String? folderName}) async {
//     for (var i = 0; i < images.length; i++) {
//       File? file = await images[i].file;
//       await GallerySaver.saveImage(file!.path, albumName: folderName).then((value) {});
//
//     }
//   }
//
//
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
// }
// class RecentImages {
//   DateTime? dateTime;
//   List<AssetEntity>? listOfImages;
//
//   RecentImages({this.dateTime, this.listOfImages});
// }

/*


                 ListTile(
                                                iconColor: Colors.white,
                                                leading:
                                                FutureBuilder<Uint8List?>(
                                                  future: favoriteData[index]
                                                      .thumbnailData,
                                                  builder: (BuildContext
                                                  context,
                                                      AsyncSnapshot<Uint8List?>
                                                      snapshot) {
                                                    if (snapshot.connectionState ==
                                                        ConnectionState
                                                            .done &&
                                                        snapshot.data != null) {
                                                      return ClipRRect(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(8.0),
                                                        child: SizedBox(
                                                            height: 50,
                                                            width: 70,
                                                            child: Image.memory(
                                                              snapshot.data!,
                                                              fit: BoxFit.cover,
                                                            )),
                                                      );
                                                    } else {
                                                      return ClipRRect(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              8.0),
                                                          child: const SizedBox(
                                                              height: 50,
                                                              width: 70,
                                                              child: Icon(
                                                                Icons.movie,
                                                                color: Colors
                                                                    .white,
                                                              )));
                                                    }
                                                  },
                                                ),
                                                title: Text(
                                                  favoriteData[index].title!,
                                                  style: const TextStyle(
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                      color: Colors.white),
                                                ),
                                                subtitle: Text(
                                                  favoriteData[index]
                                                      .relativePath
                                                      .toString(),
                                                  style: const TextStyle(
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                      fontSize: 12,
                                                      color: Colors.blueGrey),
                                                ),
                                                trailing: IconButton(
                                                  icon: const Icon(
                                                      Icons.heart_broken),
                                                  onPressed: () {
                                                    FavoriteDb.favoriteVideos
                                                        .notifyListeners();
                                                    FavoriteDb.delete(
                                                        favoriteData[index].id);
                                                    const snackbar = SnackBar(
                                                      content: Text(
                                                        'Video Removed From  Favourites',
                                                      ),
                                                      duration:
                                                      Duration(seconds: 1),
                                                    );
                                                    ScaffoldMessenger.of(
                                                        context)
                                                        .showSnackBar(snackbar);
                                                  },
                                                ),
                                                onTap: () {
                                                  Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        VideoPLayerPage(
                                                            videoList:
                                                            favoriteData,
                                                            initialIndex:
                                                            index),
                                                  ));
                                                },
                                              ),







                                              FutureBuilder<Uint8List?>(
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
                                          child:SizedBox(
                                            height: double.infinity,
                                            width: double.infinity,
                                            child: Image.memory(
                                              snapshot.data!,
                                              cacheHeight: 250,
                                              cacheWidth: 250,
                                              fit: BoxFit.cover,
                                            ),
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
                            )


 */