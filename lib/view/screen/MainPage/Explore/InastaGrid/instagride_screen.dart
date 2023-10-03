import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';

import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:image_cropper/image_cropper.dart';

import 'package:path_provider/path_provider.dart';

import 'package:provider/provider.dart';

import '../../../../../controller/provider/gallery_data_provider.dart';
import '../../../../res/app_colors.dart';
import '../../../../utils/navigation_utils/navigation.dart';
import '../../../../utils/size_utils.dart';

// ignore: must_be_immutable
class InstaGrideScreen extends StatefulWidget {
  bool? isSelectImage;

  InstaGrideScreen({super.key, this.isSelectImage});

  @override
  State<InstaGrideScreen> createState() => _InstaGrideScreenState();
}

class _InstaGrideScreenState extends State<InstaGrideScreen> {
  int select = 1;
  bool show = false;
  String avi = 'Insta Grid';
  List iconss = [
    Icons.refresh,
    Icons.crop,
  ];
  File? _selectedImage;
  final List<File?> _splitImages = List.generate(9, (index) => null);

  @override
  void initState() {
    super.initState();

    _selectedImage = Get.arguments;
    setState(() {});
    cropImage();
  }

  Future<void> cropImage() async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: _selectedImage!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        // CropAspectRatioPreset.ratio3x2,
        // CropAspectRatioPreset.original,
        // CropAspectRatioPreset.ratio4x3,
        // CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: AppColor.blackdark,
            toolbarWidgetColor: Colors.white,
            backgroundColor: AppColor.primaryClr,
            cropFrameColor: AppColor.white,
            cropGridColor: AppColor.white.withOpacity(0.5),
            activeControlsWidgetColor: AppColor.purpal,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
        IOSUiSettings(
          title: 'Cropper',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );
    if (croppedFile == null) {
      Get.back();
    } else {
      _selectedImage = File(croppedFile.path);
      _splitImage();
    }
  }

  Future _splitImage() async {
    // showLoadingIndicator(context);
    if (_selectedImage == null) {
      return;
    }
    final imageBytes = await _selectedImage?.readAsBytes();
    final image = img.decodeImage(imageBytes!);

    if (image == null) {
      // Handle invalid image
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
        show = true;
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
          body: show == false
              ? const Center(
                  child: CircularProgressIndicator(
                    color: AppColor.purpal,
                  ),
                )
              : Container(
                  height: SizeUtils.screenHeight,
                  width: SizeUtils.screenWidth,
                  color: Color(0xff181A20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: GridView.builder(
                          shrinkWrap: true,
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
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      if (_splitImages.every((img) => img != null))
                        InkWell(
                          onTap: () async {
                            if (_splitImages.every((img) => img != null)) {
                              _saveImagesToGallery().then((value) => Get.back());
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  backgroundColor: AppColor.blackdark,
                                  shape: InputBorder.none,
                                  duration: const Duration(seconds: 2),
                                  content: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(height: 20, child: const Text("Successfully Photo Save")),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  )));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  backgroundColor: AppColor.blackdark,
                                  shape: InputBorder.none,
                                  duration: const Duration(seconds: 2),
                                  content: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                          height: 20,
                                          child: const Text(
                                            "Please Select Only Image",
                                            style: TextStyle(color: AppColor.red),
                                          )),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  )));
                            }
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
