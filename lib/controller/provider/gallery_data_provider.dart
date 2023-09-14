import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:gallery_vault/controller/functions/gobal_functions.dart';
import 'package:photo_manager/photo_manager.dart';

enum SortOption { name, lastModifiedDate, size, path }

enum SortOrder { ascending, descending }

class GalleryDataProvider extends ChangeNotifier {
  List<AssetPathEntity> _nonEmptyFolderList = [];
  List<AssetPathEntity> _allGalleryFolders = [];
  List<AssetEntity> _allRecentList = [];
  final List<List<AssetEntity>> _folderThumbnail = [];
  bool getVideoThumb = false;
  bool dummySet = false;
  int columnCount = 3;

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

    // notifyListeners();
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

  void addImageToRecentList(AssetEntity image) {
    DateTime imageDate = image.modifiedDateTime;

    int existingIndex = recentImagesList.indexWhere((item) => item.dateTime?.year == imageDate.year && item.dateTime?.month == imageDate.month && item.dateTime?.day == imageDate.day);

    if (existingIndex != -1) {
      recentImagesList[existingIndex].listOfImages?.add(image);
    } else {
      recentImagesList.add(RecentImages(
        dateTime: DateTime(imageDate.year, imageDate.month, imageDate.day),
        listOfImages: [image],
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

  int calculateCumulativeIndex(int listIndex, int imageIndex) {
    int cumulativeIndex = imageIndex;
    for (int i = 0; i < listIndex; i++) {
      cumulativeIndex += recentImagesList[i].listOfImages!.length;
    }
    return cumulativeIndex;
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
}

class RecentImages {
  DateTime? dateTime;
  List<AssetEntity>? listOfImages;

  RecentImages({this.dateTime, this.listOfImages});
}
