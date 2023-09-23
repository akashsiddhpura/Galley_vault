import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:gallery_vault/view/res/assets_path.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'package:photo_manager/photo_manager.dart';

enum SortOption { name, lastModifiedDate, size, path }

enum SortOrder { ascending, descending }

class GalleryDataProvider extends ChangeNotifier {
  final List<AssetPathEntity> _nonEmptyFolderList = [];
  List<AssetPathEntity> _allGalleryFolders = [];
  List<AssetEntity> _allVideoList = [];
  List<AssetEntity> _allRecentList = [];
  List<AssetEntity> selectedImageList = [];
  List<AssetEntity> selectedImageList2 = [];
  final List<List<AssetEntity>> _folderThumbnail = [];
  bool getVideoThumb = false;
  bool dummySet = false;
  int columnCount = 3;
  List images = [
    AssetsPath.video,
    AssetsPath.lock2,
    AssetsPath.cleaner,
  ];
  List text1 = [
    "Video",
    "Private Safe",
    "Cleaner",
  ];
  List text2 = [
    "25 item",
    "0 item",
    "",
  ];
  List text3 = [
    "Photo Editor",
    "Private Safe",
    "Favorites",
    "Recycle Bin",
    "Duplicate",
    "Language",
    "Settings",
  ];
  List images2 = [
    AssetsPath.photoedit,
    AssetsPath.privatesafe,
    AssetsPath.star,
    AssetsPath.recyclebin,
    AssetsPath.duplicate,
    AssetsPath.language,
    AssetsPath.settings,
  ];

  List<AssetEntity> get allVideoList => _allVideoList;
  List<AssetPathEntity> get allGalleryFolders => _nonEmptyFolderList;
  List<AssetEntity> get allRecentList => _allRecentList;
  List<List<AssetEntity>> get folderThumbnail => _folderThumbnail;

  fetchGalleryData() async {
    _allGalleryFolders.clear();
    _allRecentList.clear();
    recentImagesList.clear();
    final PermissionState ps = await PhotoManager.requestPermissionExtend();

    final albums = await PhotoManager.getAssetPathList(type: RequestType.common);
    final recentAlbum = albums.first;
    final assetCount = await recentAlbum.assetCountAsync;
    final recentAssets = await recentAlbum.getAssetListRange(start: 0, end: assetCount - 1);

    albums.removeAt(0);
    _allGalleryFolders = albums;
    _allRecentList = recentAssets.toList();

    sortRecentListWithModifiedDate();
    fetchFolderThumbnail();
    for (var image in _allRecentList) {
      addImageToRecentList(image);
    }
    fetchVideos();

    // notifyListeners();
  }

  Future<void> fetchVideos() async {
    _allVideoList.clear();

    _allVideoList = _allRecentList.where((element) => element.type == AssetType.video).toList();
    notifyListeners();
  }

  void fetchFolderThumbnail() async {
    _nonEmptyFolderList.clear();
    _folderThumbnail.clear();
    for (int i = 0; i < _allGalleryFolders.length; i++) {
      List<AssetEntity> videos = await _allGalleryFolders[i].getAssetListRange(start: 0, end: 1);
      if (videos.isNotEmpty) {
        _nonEmptyFolderList.add(_allGalleryFolders[i]);
        _folderThumbnail.add(videos);
      }
    }

    getVideoThumb = true;
    notifyListeners();
  }

  List<RecentImages> recentImagesList = [];
  List<RecentVideo> recentVideoList = [];

  void addImageToRecentList(AssetEntity image) {
    DateTime imageDate = image.modifiedDateTime;

    int existingIndex = recentImagesList.indexWhere(
        (item) => item.dateTime?.year == imageDate.year && item.dateTime?.month == imageDate.month && item.dateTime?.day == imageDate.day);

    if (existingIndex != -1) {
      recentImagesList[existingIndex].listOfImages?.add(image);
    } else {
      recentImagesList.add(RecentImages(
        dateTime: DateTime(imageDate.year, imageDate.month, imageDate.day),
        listOfImages: [image],
      ));
    }
  }

  void addVideoToRecentList(AssetEntity video) {
    // DateTime imageDate = image.modifiedDateTime;
    DateTime videoDate = video.modifiedDateTime;

    int existingIndex = recentVideoList.indexWhere(
        (item) => item.dateTime?.year == videoDate.year && item.dateTime?.month == videoDate.month && item.dateTime?.day == videoDate.day);

    if (existingIndex != -1) {
      recentVideoList[existingIndex].listOfVideo?.add(video);
    } else {
      recentVideoList.add(RecentVideo(
        dateTime: DateTime(videoDate.year, videoDate.month, videoDate.day),
        listOfVideo: [video],
      ));
    }
  }

  void sortRecentListWithModifiedDate() {
    _allRecentList.sort((a, b) {
      int result = 0;
      result = a.modifiedDateTime.compareTo(b.modifiedDateTime);
      return -result;
    });
  }

  void sortRecentListWithModifiedDate2() {
    _allVideoList.sort((a, b) {
      int result = 0;
      result = a.modifiedDateTime.compareTo(b.modifiedDateTime);
      return -result;
    });
  }

  int calculateCumulativeIndex(int listIndex, int imageIndex) {
    int cumulativeIndex = imageIndex;
    for (int i = 0; i < listIndex; i++) {
      cumulativeIndex += recentImagesList[i].listOfImages!.length;
    }
    return cumulativeIndex;
  }

  int calculateCumulativeIndex2(int listIndex, int videoIndex) {
    int cumulativeIndex1 = videoIndex;
    for (int i = 0; i < listIndex; i++) {
      cumulativeIndex1 += allVideoList.length;
    }
    return cumulativeIndex1;
  }

  Future<List<AssetEntity>> loadAssetsInFolder(index) async {
    List<AssetEntity> assets = await _nonEmptyFolderList[index].getAssetListRange(start: 0, end: 10000);
    return assets;
  }

  /// sorting
  SortOption selectedSortOption = SortOption.name;
  SortOrder selectedSortOrder = SortOrder.ascending;

  void sortList() {
    _nonEmptyFolderList.sort((a, b) {
      int result = 0;
      if (selectedSortOption == SortOption.name) {
        result = a.name.compareTo(b.name);
      } else if (selectedSortOption == SortOption.lastModifiedDate) {
        if (a.lastModified != null && b.lastModified != null) {
          result = a.lastModified!.compareTo(b.lastModified!);
        }
      } else if (selectedSortOption == SortOption.size) {
        result = a.assetCount.compareTo(b.assetCount);
      } else if (selectedSortOption == SortOption.path) {
        // result = a..compareTo(b.relativePath);
      }

      if (selectedSortOrder == SortOrder.descending) {
        result = -result;
      }

      return result;
    });
    notifyListeners();
  }

  String optionToString(SortOption option) {
    switch (option) {
      case SortOption.name:
        return "Name";
      case SortOption.lastModifiedDate:
        return "Last Modified Date";
      case SortOption.size:
        return "Size";
      case SortOption.path:
        return "Path";
      default:
        return "";
    }
  }

  String orderToString(SortOrder order) {
    return order == SortOrder.ascending ? "Ascending" : "Descending";
  }

  /// scroll controller
  final ScrollController _scrollController = ScrollController();
  double _scrollPercentage = 0.0;
  bool _showPercentage = false;
  Timer? _hideTimer;

  ScrollController get scrollController => _scrollController;
  double get scrollPercentage => _scrollPercentage;
  bool get showPercentage => _showPercentage;
  Timer? get hideTimer => _hideTimer;

  void updateScrollPercentage() {
    _scrollPercentage = _scrollController.offset / _scrollController.position.maxScrollExtent;
    _showPercentage = true;

    _hideTimer?.cancel(); // Cancel previous timer
    _hideTimer = Timer(Duration(seconds: 1), () {
      _showPercentage = false;
      notifyListeners();
    });
    notifyListeners();
  }

  void selectImage(AssetEntity assetEntity) {
    if (selectedImageList.contains(assetEntity)) {
      selectedImageList.remove(assetEntity);
      notifyListeners();
    } else {
      selectedImageList.add(assetEntity);
      notifyListeners();
    }
  }

  void selectInstaGridImage(AssetEntity assetEntity) {
    if (selectedImageList.contains(assetEntity)) {
      selectedImageList.remove(assetEntity);
      notifyListeners();
    } else {
      selectedImageList.add(assetEntity);
      notifyListeners();
    }
  }

  void clearSelectedImageList() {
    selectedImageList.clear();
    notifyListeners();
  }

  Future<void> saveImagesToFolder(List<AssetEntity> images, {String? folderName}) async {
    for (var i = 0; i < images.length; i++) {
      File? file = await images[i].file;
      await GallerySaver.saveImage(file!.path, albumName: folderName).then((value) {});
    }
  }

  void movePhoto(AssetPathEntity accessiblePath, AssetEntity yourEntity) async {
    // Make sure your path entity is accessible.
    final AssetPathEntity pathEntity = accessiblePath;
    final AssetEntity entity = yourEntity;

    File? file = await entity.file;
    final fileName = file!.path.split('/').last;
// copy the file to a new path
//     final File newImage = file.copySync('${accessiblePath.path}/$fileName');

    // bool response = await PhotoManager.editor.android.moveAssetToAnother(
    //   entity: entity,
    //   target: pathEntity,
    // );
    // print(response);
  }

  void copyPhoto(AssetPathEntity accessiblePath, AssetEntity yourEntity) async {
    // Make sure your path entity is accessible.
    // Make sure your path entity is accessible.
    final AssetPathEntity anotherPathEntity = accessiblePath;
    final AssetEntity entity = yourEntity;
    final AssetEntity? newEntity = await PhotoManager.editor.copyAssetToPath(
      asset: entity,
      pathEntity: anotherPathEntity,
    );
// copy the file to a new path
//     final File newImage = file.copySync('${accessiblePath.path}/$fileName');

    // bool response = await PhotoManager.editor.android.moveAssetToAnother(
    //   entity: entity,
    //   target: pathEntity,
    // );
    // print(response);
  }
}

class FavoriteDb {
  static bool isInitialized = false;
  static final favoriteDB = Hive.box<String>('FavoriteDB');
  static ValueNotifier<List<AssetEntity>> favoriteVideos = ValueNotifier([]);

  static initialize(List<AssetEntity> videos) {
    for (AssetEntity video in videos) {
      if (isFavor(video)) {
        favoriteVideos.value.add(video);
      }
    }
    isInitialized = true;
  }

  static isFavor(AssetEntity video) {
    if (favoriteDB.values.contains(video.id)) {
      return true;
    }
    return false;
  }

  static add(AssetEntity video) async {
    favoriteDB.add(video.id);
    favoriteVideos.value.add(video);
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    FavoriteDb.favoriteVideos.notifyListeners();
  }

  static delete(String id) async {
    int deletekey = 0;
    if (!favoriteDB.values.contains(id)) {
      return;
    }
    final Map<dynamic, String> favorMap = favoriteDB.toMap();
    favorMap.forEach((key, value) {
      if (value == id) {
        deletekey = key;
      }
    });
    favoriteDB.delete(deletekey);
    favoriteVideos.value.removeWhere((song) => song.id == id);
  }

  static clear() async {
    FavoriteDb.favoriteVideos.value.clear();
  }
}

class RecentImages {
  DateTime? dateTime;
  List<AssetEntity>? listOfImages;

  RecentImages({this.dateTime, this.listOfImages});
}

class RecentVideo {
  DateTime? dateTime;
  List<AssetEntity>? listOfVideo;

  RecentVideo({this.dateTime, this.listOfVideo});
}
