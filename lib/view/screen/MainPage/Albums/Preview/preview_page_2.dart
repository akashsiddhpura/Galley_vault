import 'dart:io';
import 'package:gallery_vault/controller/Getx/preview_page_controller.dart';
import 'package:gallery_vault/controller/provider/preview_page_provider.dart';
import 'package:gallery_vault/view/res/assets_path.dart';
import 'package:gallery_vault/view/utils/size_utils.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_vault/view/res/app_colors.dart';
import 'package:gallery_vault/view/utils/navigation_utils/navigation.dart';
import 'package:gallery_vault/view/widgets/dialogs.dart';
import 'package:get/get.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:image_editor_plus/utils.dart';
import 'package:open_file/open_file.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';
import '../../../../../controller/functions/favoritedb.dart';
import '../../../../utils/navigation_utils/routes.dart';
import '../../../../widgets/bottomsheets.dart';

class PriviewPage2 extends StatefulWidget {
  PriviewPage2({super.key});

  @override
  State<PriviewPage2> createState() => _PriviewPage2State();
}

class _PriviewPage2State extends State<PriviewPage2> {
  CounterController controller = Get.put(CounterController());
  PageController pageController = PageController();
  bool isVideo = false;
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  int currentIndex = 0;
  bool loaded = false;

  Future<void> handlePageChange(int page) async {
    currentIndex = page;
    if (FavoriteDb.favoriteVideos.value[page].type == AssetType.video) {
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

        setState(() {});
      }
    }
  }

  void _initializeVideoPlayer() async {
    videoPlayerController = VideoPlayerController.file(File((await FavoriteDb.favoriteVideos.value[Get.arguments].file)?.path ?? ''));
    await videoPlayerController.initialize();
    loaded = true;
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: true,
    );
  }

  @override
  void initState() {
    super.initState();

    _initializeVideoPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PreviewPageProvider>(builder: (context, preview, child) {
      return WillPopScope(
        onWillPop: () async {
          preview.pageController.dispose();
          if (preview.isVideo) {
            preview.chewieController.dispose();
            preview.videoPlayerController.dispose();
          }
          return false;
        },
        child: ValueListenableBuilder(
            valueListenable: FavoriteDb.favoriteVideos,
            builder: (BuildContext ctx, List<AssetEntity> favoriteData, Widget? child) {
              return Scaffold(
                appBar: AppBar(
                    title: Text(
                      favoriteData[Get.arguments].title.toString(),
                      style: TextStyle(color: AppColor.white, fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    backgroundColor: AppColor.blackdark,
                    leading: InkWell(
                        onTap: () {
                          Navigation.pop();
                        },
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: AppColor.white,
                        )),
                    actions: [
                      ValueListenableBuilder(
                          valueListenable: FavoriteDb.favoriteVideos,
                          builder: (BuildContext ctx, List<AssetEntity> favoriteVideos, Widget? child) {
                            return IconButton(
                              onPressed: () {
                                if (FavoriteDb.isFavor(favoriteVideos[Get.arguments])) {
                                  FavoriteDb.delete(favoriteVideos[Get.arguments].id);
                                  const snackBar = SnackBar(
                                    content: Text('Removed From Favorite'),
                                    duration: Duration(seconds: 1),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                } else {
                                  FavoriteDb.add(favoriteVideos[Get.arguments]);
                                  const snackBar = SnackBar(
                                    content: Text('video Added to Favorite'),
                                    duration: Duration(seconds: 1),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                }
                                // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                                FavoriteDb.favoriteVideos.notifyListeners();
                              },
                              icon: FavoriteDb.isFavor(favoriteData[Get.arguments])
                                  ? const Icon(
                                      CupertinoIcons.heart_fill,
                                      color: Colors.red,
                                    )
                                  : Icon(
                                      CupertinoIcons.heart,
                                      color: AppColor.white,
                                    ),
                            );
                          }),
                      IconButton(
                          onPressed: () {
                            Navigation.pushNamed(Routes.kFileDetailScreen, arg: favoriteData[Get.arguments]);
                          },
                          icon: Icon(
                            Icons.info_outline_rounded,
                            color: AppColor.white,
                          ))
                    ]),
                body: Container(
                  height: SizeUtils.screenHeight,
                  width: SizeUtils.screenWidth,
                  color: AppColor.black,
                  // padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: PageView.builder(
                      controller: pageController,
                      itemCount: favoriteData.length,
                      onPageChanged: handlePageChange,
                      itemBuilder: (context, index) {
                        final mediaItem = favoriteData[index];
                        return FutureBuilder<File?>(
                          future: favoriteData[index].file,
                          builder: (BuildContext context, AsyncSnapshot<File?> snapshot) {
                            if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                              if (mediaItem.type == AssetType.image) {
                                return SizedBox(
                                  height: double.infinity,
                                  width: double.infinity,
                                  child: PhotoView(
                                    enableRotation: true,
                                    minScale: 0.0,
                                    maxScale: 1.0,
                                    loadingBuilder: (context, imageChunkEvent) {
                                      return Container(
                                        alignment: Alignment.center,
                                        color: Colors.black,
                                        child: const CircularProgressIndicator(),
                                      );
                                    },
                                    backgroundDecoration: const BoxDecoration(color: Colors.black),
                                    imageProvider: FileImage(snapshot.data!),
                                  ),
                                );
                              } else if (mediaItem.type == AssetType.video) {
                                return loaded && chewieController.videoPlayerController.value.isInitialized
                                    ? GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            chewieController.pause();
                                          });
                                        },
                                        child: Center(
                                          child: SizedBox(
                                            // height: MediaQuery.of(context).size.height / 2,
                                            height: double.infinity,
                                            child: Chewie(
                                              controller: chewieController,
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        alignment: Alignment.center,
                                        color: Colors.black,
                                        child: const CircularProgressIndicator(),
                                      );
                              } else {
                                return const Center(child: Text('Unsupported media type'));
                              }
                            } else {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: const SizedBox(
                                  height: 50,
                                  width: 70,
                                  child: Icon(
                                    Icons.image,
                                    color: Colors.grey,
                                  ),
                                ),
                              );
                            }
                          },
                        );
                      }),
                ),
                bottomNavigationBar: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                    color: Colors.black,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            5,
                            (index) => index == 0
                                ? Stack(
                                    children: [
                                      Center(
                                          child: Image.asset(
                                        AssetsPath.iconbottem,
                                        height: SizeUtils.verticalBlockSize * 7,
                                      )),
                                      Positioned(
                                        top: 0,
                                        bottom: 0,
                                        right: 0,
                                        left: 0,
                                        child: IconButton(
                                          hoverColor: AppColor.purpal,
                                          highlightColor: AppColor.purpal.withOpacity(.3),
                                          onPressed: () async {
                                            await Share.shareFiles([(await favoriteData[Get.arguments].file)!.path]);
                                          },
                                          icon: Icon(
                                            Icons.share,
                                            color: AppColor.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                : index == 1
                                    ? Stack(
                                        children: [
                                          Center(
                                              child: Image.asset(
                                            AssetsPath.iconbottem,
                                            height: SizeUtils.verticalBlockSize * 7,
                                          )),
                                          Positioned(
                                            top: 0,
                                            bottom: 0,
                                            right: 0,
                                            left: 0,
                                            child: IconButton(
                                              hoverColor: AppColor.purpal,
                                              highlightColor: AppColor.purpal,
                                              onPressed: () {
                                                AppDialogs().scaleDialog(context, favoriteData[Get.arguments]);
                                              },
                                              icon: Icon(
                                                Icons.delete_outlined,
                                                color: AppColor.white,
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    : index == 2
                                        ? Stack(
                                            children: [
                                              Center(
                                                  child: Image.asset(
                                                AssetsPath.iconbottem,
                                                height: SizeUtils.verticalBlockSize * 7,
                                              )),
                                              Positioned(
                                                top: 0,
                                                bottom: 0,
                                                right: 0,
                                                left: 0,
                                                child: IconButton(
                                                  hoverColor: AppColor.purpal,
                                                  highlightColor: AppColor.purpal.withOpacity(.3),
                                                  onPressed: () async {
                                                    final bytes = await XFile(File((await favoriteData[Get.arguments].file)?.path ?? '').path)
                                                        .readAsBytes(); // Converts the file to UInt8List

                                                    var editedImage = await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) => ImageEditor(
                                                          image: bytes,
                                                          features: ImageEditorFeatures(
                                                            pickFromGallery: false,
                                                            captureFromCamera: false,
                                                            crop: true,
                                                            blur: true,
                                                            brush: true,
                                                            emoji: true,
                                                            filters: true,
                                                            flip: true,
                                                            rotate: true,
                                                            text: true,
                                                          ),
                                                        ),
                                                      ),
                                                    );

                                                    final Uint8List rawData = editedImage;
                                                    String fileName = "${DateTime.now().hashCode}_${DateTime.now().millisecondsSinceEpoch}";

                                                    final AssetEntity? entity = await PhotoManager.editor.saveImage(
                                                      rawData,
                                                      relativePath: favoriteData[Get.arguments].relativePath,
                                                      title: '$fileName.jpg',
                                                    );
                                                    print((await entity?.file)!.path);
                                                  },
                                                  icon: Icon(
                                                    Icons.photo_filter_rounded,
                                                    color: AppColor.white,
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        : index == 3
                                            ? Stack(
                                                children: [
                                                  Center(
                                                      child: Image.asset(
                                                    AssetsPath.iconbottem,
                                                    height: SizeUtils.verticalBlockSize * 7,
                                                  )),
                                                  Positioned(
                                                    top: 0,
                                                    bottom: 0,
                                                    right: 0,
                                                    left: 0,
                                                    child: IconButton(
                                                      hoverColor: AppColor.purpal,
                                                      highlightColor: AppColor.purpal.withOpacity(.3),
                                                      onPressed: () {},
                                                      icon: Icon(
                                                        Icons.lock_outline_rounded,
                                                        color: AppColor.white,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )
                                            : Stack(
                                                children: [
                                                  Center(
                                                      child: Image.asset(
                                                    AssetsPath.iconbottem,
                                                    height: SizeUtils.verticalBlockSize * 7,
                                                  )),
                                                  Positioned(
                                                    top: 0,
                                                    bottom: 0,
                                                    right: 0,
                                                    left: 0,
                                                    child: PopupMenuButton(
                                                        itemBuilder: (context) => [
                                                              PopupMenuItem(
                                                                value: 1,
                                                                child: Text(
                                                                  "Open with",
                                                                  style: TextStyle(color: AppColor.white, fontSize: 15),
                                                                ),
                                                              ),
                                                              if (favoriteData[Get.arguments].type == AssetType.image)
                                                                PopupMenuItem(
                                                                  value: 2,
                                                                  child: Text(
                                                                    "Set as wallpaper",
                                                                    style: TextStyle(color: AppColor.white, fontSize: 15),
                                                                  ),
                                                                ),
                                                              PopupMenuItem(
                                                                value: 3,
                                                                child: Text(
                                                                  "Move To",
                                                                  style: TextStyle(color: AppColor.white, fontSize: 15),
                                                                ),
                                                              ),
                                                              PopupMenuItem(
                                                                value: 4,
                                                                child: Text(
                                                                  "Copy To",
                                                                  style: TextStyle(color: AppColor.white, fontSize: 15),
                                                                ),
                                                              ),
                                                            ],
                                                        onSelected: (value) async {
                                                          controller.select.value = index;
                                                          if (value == 1) {
                                                            OpenFile.open((await favoriteData[Get.arguments].file)!.path);
                                                          } else if (value == 2) {
                                                            AppBottomSheets().openWallpaperBottomSheet(
                                                                imagePath: (await favoriteData[Get.arguments].file)?.path ?? '');
                                                          } else if (value == 3) {
                                                          } else if (value == 4) {}
                                                        },
                                                        offset: Offset(0, (favoriteData[Get.arguments].type == AssetType.video ? -185 : -230)),
                                                        color: AppColor.blackdark,
                                                        elevation: 2,
                                                        child: Obx(() {
                                                          return Icon(
                                                            Icons.more_vert_rounded,
                                                            color: controller.select.value == index ? AppColor.purpal : AppColor.white,
                                                          );
                                                        })),
                                                  )
                                                ],
                                              ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      );
    });
  }
}
