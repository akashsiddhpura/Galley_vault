import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'package:photo_manager/photo_manager.dart';

import 'package:video_player/video_player.dart';

class PreviewPageProvider extends ChangeNotifier {
  PageController pageController = PageController();
  bool isVideo = false;
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  int currentIndex = 0;
  int initialIndex = 0;
  bool loaded = false;
  List<AssetEntity> assetsList = [];
  bool _isPrivacyScreenVisible = false;
  bool _camera = false;
  bool get isPrivacyScreenVisible => _isPrivacyScreenVisible;
  bool get camera => _camera;




  void togglePrivacyScreen() {
    _isPrivacyScreenVisible = !_isPrivacyScreenVisible;
    notifyListeners();
  }
  void cameraHide(){
    _camera = !_camera;
    notifyListeners();
  }

  void initializeData() {
    assetsList = Get.arguments["assetsList"];
    initialIndex = Get.arguments["index"];
    currentIndex = Get.arguments["index"];
    isVideo = assetsList[initialIndex].type == AssetType.video;
    if (isVideo) {
      isVideo = true;
      _initializeVideoPlayer();
    }
    pageController = PageController(initialPage: initialIndex);
  }

  Future<void> handlePageChange(int page) async {
    currentIndex = page;
    if (assetsList[page].type == AssetType.video) {
      isVideo = true;
      _initializeVideoPlayer();
    } else {
      if (isVideo) {
        isVideo = false;
        await chewieController.pause();
        await videoPlayerController.pause();
        chewieController.dispose();
        await videoPlayerController.dispose();
        loaded = false;

        notifyListeners();
      } else {
        notifyListeners();
      }
    }
  }

  void _initializeVideoPlayer() async {
    videoPlayerController = VideoPlayerController.file(File((await assetsList[currentIndex].file)?.path ?? ''));
    await videoPlayerController.initialize();
    loaded = true;
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: true,
    );
    notifyListeners();
  }

  AssetEntity get yourEntity => yourEntity;

  AssetPathEntity get accessiblePath => accessiblePath;



  @override
  void dispose() {
    pageController.dispose();
    if (isVideo) {
      videoPlayerController.dispose();
      chewieController.dispose();
    }
    super.dispose();
  }
}
