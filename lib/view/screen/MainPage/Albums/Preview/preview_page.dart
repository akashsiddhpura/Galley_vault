// ignore_for_file: use_build_context_synchronously

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
import 'package:get/get.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:image_editor_plus/utils.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../../controller/functions/favoritedb.dart';
import '../../../../utils/navigation_utils/routes.dart';
import '../../../../widgets/bottomsheets.dart';

class PreviewPage extends StatefulWidget {
  const PreviewPage({super.key});

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  CounterController controller = Get.put(CounterController());

  @override
  void initState() {
    super.initState();
    Provider.of<PreviewPageProvider>(context, listen: false).initializeData();
  }

  Future<void> moveImageToPrivateFolder(File imageFile) async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final privateDir = Directory('${appDir.path}/.private'); // Hidden folder with a dot prefix
      if (!privateDir.existsSync()) {
        privateDir.createSync();
      }

      final fileName = imageFile.path.split('/').last;
      final newPath = '${privateDir.path}/$fileName';

      await imageFile.rename(newPath);
    } catch (e) {
      print('Error moving image: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PreviewPageProvider>(builder: (context, preview, child) {
      return Scaffold(
        appBar: AppBar(
            title: Text(
              preview.assetsList[preview.currentIndex].title.toString(),
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
                        setState(() {
                          setState(() {
                            preview.assetsList[preview.currentIndex].id;
                          });
                        });
                        if (FavoriteDb.isFavor(preview.assetsList[preview.currentIndex])) {
                          FavoriteDb.delete(preview.assetsList[preview.currentIndex].id);
                          const snackBar = SnackBar(
                            content: Text('Removed From Favorite'),
                            duration: Duration(seconds: 1),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          FavoriteDb.add(preview.assetsList[preview.currentIndex]);
                          const snackBar = SnackBar(
                            content: Text('video Added to Favorite'),
                            duration: Duration(seconds: 1),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                        // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                        FavoriteDb.favoriteVideos.notifyListeners();
                      },
                      icon: FavoriteDb.isFavor(preview.assetsList[preview.currentIndex])
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
                    Navigation.pushNamed(Routes.kFileDetailScreen, arg: preview.assetsList[preview.currentIndex]);
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
              controller: preview.pageController,
              itemCount: preview.assetsList.length,
              onPageChanged: preview.handlePageChange,
              itemBuilder: (context, index) {
                final mediaItem = preview.assetsList[index];
                return FutureBuilder<File?>(
                  future: preview.assetsList[index].file,
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
                        return preview.loaded && preview.chewieController.videoPlayerController.value.isInitialized
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    preview.chewieController.pause();
                                  });
                                },
                                child: Center(
                                  child: SizedBox(
                                    // height: MediaQuery.of(context).size.height / 2,
                                    height: double.infinity,
                                    child: Chewie(
                                      controller: preview.chewieController,
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
                                    await Share.shareFiles([(await preview.assetsList[preview.currentIndex].file)!.path]);
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
                                        AppBottomSheets().openDeleteBottomSheet(context, preview.assetsList[preview.currentIndex]);
                                        // AppDialogs().scaleDialog(
                                        //     context,
                                        //     preview.assetsList[
                                        //     preview.currentIndex]);
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
                                            final bytes = await XFile(File((await preview.assetsList[preview.currentIndex].file)?.path ?? '').path)
                                                .readAsBytes(); // Converts the file to UInt8List

                                            var editedImage = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => ImageEditor(

                                                  image: bytes,

                                                  features: const ImageEditorFeatures(

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
                                              relativePath: preview.assetsList[preview.currentIndex].relativePath,
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
                                              onPressed: () async {
                                                File? imageFile = await preview.assetsList[preview.currentIndex].file;
                                                moveImageToPrivateFolder(imageFile!);
                                                AppBottomSheets()
                                                    .openPrivateBottomSheet(context, preview.assetsList[preview.currentIndex], index, imageFile);
                                              },
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
                                                      if (!preview.isVideo)
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
                                                    OpenFile.open((await preview.assetsList[preview.currentIndex].file)!.path);
                                                  } else if (value == 2) {
                                                    AppBottomSheets().openWallpaperBottomSheet(
                                                        imagePath: (await preview.assetsList[preview.currentIndex].file)?.path ?? '');
                                                  } else if (value == 3) {
                                                    File? imageFile = await preview.assetsList[preview.currentIndex].file;

                                                    AppBottomSheets()
                                                        .openMoveToBottomSheet(context, preview.assetsList[preview.currentIndex], index, imageFile!);
                                                  } else if (value == 4) {
                                                    File? imageFile = await preview.assetsList[preview.currentIndex].file;
                                                    AppBottomSheets()
                                                        .openCopyToBottomSheet(context, preview.assetsList[preview.currentIndex], index, imageFile!);
                                                  }
                                                },
                                                offset: Offset(0, (preview.isVideo ? -185 : -230)),
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
    });
  }
}

/// A full-sized view that displays the given image, supporting pinch & zoom
class EasyImageView extends StatefulWidget {
  /// The image to display
  final ImageProvider imageProvider;

  /// Minimum scale factor
  final double minScale;

  /// Maximum scale factor
  final double maxScale;

  /// Callback for when the scale has changed, only invoked at the end of
  /// an interaction.
  final void Function(double)? onScaleChanged;

  /// Create a new instance
  const EasyImageView({
    Key? key,
    required this.imageProvider,
    this.minScale = 1.0,
    this.maxScale = 5.0,
    this.onScaleChanged,
  }) : super(key: key);

  @override
  _EasyImageViewState createState() => _EasyImageViewState();
}

class _EasyImageViewState extends State<EasyImageView> {
  final TransformationController _transformationController = TransformationController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: InteractiveViewer(
          transformationController: _transformationController,
          minScale: widget.minScale,
          maxScale: widget.maxScale,
          child: Image(image: widget.imageProvider),
          onInteractionEnd: (scaleEndDetails) {
            double scale = _transformationController.value.getMaxScaleOnAxis();

            if (widget.onScaleChanged != null) {
              widget.onScaleChanged!(scale);
            }
          },
        ));
  }
}
