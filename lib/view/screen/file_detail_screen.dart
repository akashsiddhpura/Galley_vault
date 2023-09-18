import 'dart:io';

import 'package:gallery_vault/view/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_vault/view/widgets/custom_appbar.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../controller/functions/gobal_functions.dart';
import '../res/app_colors.dart';

class FileDetailScreen extends StatefulWidget {
  const FileDetailScreen({super.key});

  @override
  State<FileDetailScreen> createState() => _FileDetailScreenState();
}

class _FileDetailScreenState extends State<FileDetailScreen> {
  AssetEntity? assetEntity;
  @override
  void initState() {
    // TODO: implement initState
    assetEntity = Get.arguments;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.blackdark,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
            icon: Icon(Icons.arrow_back_ios_new,color: AppColor.white,)),
        title: Text("Details",style: TextStyle(color: AppColor.white),),
        centerTitle: true,
      ),
      backgroundColor: AppColor.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: AppColor.blackdark,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: Colors.grey.shade300, spreadRadius: 2, blurRadius: 5)],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: SizeUtils.verticalBlockSize * 5),
                  child: FutureBuilder<Uint8List?>(
                    future: assetEntity?.thumbnailData,
                    builder: (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                height: SizeUtils.horizontalBlockSize * 35,
                                width: SizeUtils.horizontalBlockSize * 35,
                                child: Image.memory(
                                  snapshot.data!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Visibility(
                                visible: assetEntity?.type == AssetType.video,
                                child: FittedBox(
                                  child: Container(
                                    decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(5)),
                                    margin: const EdgeInsets.all(5.0),
                                    padding: const EdgeInsets.all(2.0),
                                    child: Icon(
                                      Icons.play_circle_fill_rounded,
                                      color: AppColor.white,
                                    ),
                                  ),
                                ),
                              )
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
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColor.blackdark,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(color: Colors.grey.shade200, spreadRadius: 1, blurRadius: 2)],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      fileDetailTile(title: "Name", detail: assetEntity?.title?.split(".").first),
                      fileDetailTile(title: "Folder", detail: "../${assetEntity?.relativePath?.split("/").reversed.toList()[1]}"),
                      fileDetailTile(title: "Type", detail: assetEntity?.mimeType),
                      if (assetEntity?.type == AssetType.video)
                        fileDetailTile(
                          title: "Duration",
                          detail: durationToString(
                            assetEntity?.duration ?? 0,
                          ),
                        ),
                      FutureBuilder<FileDetails?>(
                          future: getFileDetails(assetEntity!),
                          builder: (BuildContext context, AsyncSnapshot<FileDetails?> snapshot) {
                            if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                              return Column(
                                children: [
                                  fileDetailTile(title: "Date", detail: "${snapshot.data?.dateTime}"),
                                  fileDetailTile(title: "Resolution", detail: "${assetEntity?.size.width.toInt()}x${assetEntity?.size.height.toInt()} px"),
                                  fileDetailTile(title: "Size", detail: "${snapshot.data?.fileSize}"),
                                ],
                              );
                            } else {
                              return SizedBox();
                            }
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget fileDetailTile({String? title, String? detail}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? "",
          style: TextStyle(
            color: AppColor.white,
            fontSize: 15,
          ),
        ),
        Text(
          detail ?? "",
          style: TextStyle(
            color:AppColor.greyText,
            fontSize: 18,
          ),
        ),
        Divider(
          color: AppColor.dividercolor,
        )
      ],
    );
  }
}
