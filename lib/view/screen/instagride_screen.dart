import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';

import '../../controller/provider/gallery_data_provider.dart';
import '../res/app_colors.dart';
import '../res/assets_path.dart';
import '../utils/navigation_utils/navigation.dart';

import '../utils/size_utils.dart';
import '../widgets/loder.dart';

// ignore: must_be_immutable
class InstaGrideScreen extends StatefulWidget {
  bool? isSelectImage;
  InstaGrideScreen({super.key, this.isSelectImage});

  @override
  State<InstaGrideScreen> createState() => _InstaGrideScreenState();
}

class _InstaGrideScreenState extends State<InstaGrideScreen> {
  bool show = false;
  String avi = 'Insta Grid';

  File? _selectedImage;
  final List<File?> _splitImages = List.generate(9, (index) => null);
  @override
  void initState() {
    super.initState();

    _selectedImage = Get.arguments;
    setState(() {});
    Future.delayed(Duration(milliseconds: 500), () {
      _splitImage();
    });
  }

  void showLoadingIndicator(BuildContext context) {
    Loader.show(context, overlayColor: Colors.black26, progressIndicator: const CircularProgressIndicator());
    Future.delayed(const Duration(seconds: 4), () {
      Loader.hide();
    });
  }

  Future _splitImage() async {
    showLoadingIndicator(context);
    if (_selectedImage == null) {
      return;
    }
    final imageBytes = await _selectedImage?.readAsBytes();
    final image = img.decodeImage(imageBytes!);

    if (image == null) {
      // Handle invalid image
      // ignore: use_build_context_synchronously
      return;
    }

    final width = image.width ~/ 3;
    final height = image.height ~/ 3;

    for (var i = 0; i < 9; i++) {
      final row = i ~/ 3;
      final col = i % 3;
      final croppedImage = img.copyCrop(
        image,
        x: col * width,
        y: row * height,
        width: width,
        height: height,
      );

      final tempDir = await getTemporaryDirectory();

      final tempFile = File('${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}_$i.png');
      await tempFile.writeAsBytes(img.encodePng(croppedImage));

      setState(() {
        _splitImages[i] = tempFile;
      });
    }
    // show = true;
  }

  Future<void> _saveImagesToGallery() async {
    for (var i = 0; i < 9; i++) {
      if (_splitImages[i] != null) {
        await GallerySaver.saveImage(_splitImages[i]!.path, albumName: "Insta Grid").then((value) {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GalleryDataProvider>(
      builder: (context, gallery, child) {
        return Scaffold(
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
              "Insta Grid",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: AppColor.white),
            ),
            centerTitle: true,
            backgroundColor: AppColor.blackdark,
          ),
          backgroundColor: AppColor.black,
          body: Container(
            height: SizeUtils.screenHeight,
            width: SizeUtils.screenWidth,
            color: AppColor.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // InkWell(
                //   onTap: () {
                //     showLoadingIndicator(context);
                //
                //   },
                //   child: Container(
                //     height: SizeUtils.verticalBlockSize * 6,
                //     width: SizeUtils.horizontalBlockSize * 40,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(30),
                //       color: AppColor.purpal,
                //     ),
                //     child: Center(
                //         child: Text(
                //       'Split Image',
                //       style: TextStyle(color: AppColor.white, fontWeight: FontWeight.bold),
                //     )),
                //   ),
                // ),
                const SizedBox(height: 40),
                if (_splitImages.every((img) => img != null))
                  GridView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
                    itemCount: 9,
                    itemBuilder: (context, index) {
                      final image = _splitImages[index];
                      return image != null
                          ? Image.file(
                              image,
                              fit: BoxFit.cover,
                            )
                          : Container();
                    },
                  ),
                const SizedBox(height: 40),
                if (_splitImages.every((img) => img != null))
                  InkWell(
                    onTap: () async {
                      _saveImagesToGallery().then((value) => Get.back());
                    },
                    child: Container(
                      height: SizeUtils.verticalBlockSize * 6,
                      width: SizeUtils.horizontalBlockSize * 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: AppColor.purpal,
                      ),
                      child: Center(
                          child: Text(
                        'Save Images to Gallery',
                        style: TextStyle(color: AppColor.white, fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
