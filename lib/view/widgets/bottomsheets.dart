import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:gallery_vault/controller/provider/gallery_data_provider.dart';
import 'package:gallery_vault/view/res/app_colors.dart';
import 'package:gallery_vault/view/utils/size_utils.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AppBottomSheets {
  bool isLoading = false;
  SnackBar successSnackBar = const SnackBar(
    content: Text('Wallpaper set successfully...'),
    duration: Duration(seconds: 1),
  );
  SnackBar failedSnackBar = const SnackBar(
    content: Text('Something went wrong!. please try again.'),
    duration: Duration(seconds: 1),
  );

  void openWallpaperBottomSheet({required String? imagePath}) {
    Get.bottomSheet(
      StatefulBuilder(
        builder: (context, setState) {
          return SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Container(
              width: double.maxFinite,
              decoration: const BoxDecoration(
                color: AppColor.blackdark,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeUtils.horizontalBlockSize * 5,
                    vertical: SizeUtils.verticalBlockSize * 1.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        height: 3,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: SizeUtils.verticalBlockSize * 1.5,
                          bottom: SizeUtils.verticalBlockSize * 1),
                      child: Text(
                        "Set a wallpaper",
                        style: TextStyle(
                            color: AppColor.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                      color: AppColor.dividercolor,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () async {
                                  isLoading = true;
                                  setState(() {});
                                  bool result = await WallpaperManager
                                      .setWallpaperFromFile(imagePath!,
                                          WallpaperManager.HOME_SCREEN);
                                  setState(() {
                                    isLoading = false;
                                    Get.back();
                                    if (result) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(successSnackBar);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(failedSnackBar);
                                    }
                                  });
                                },
                                child: Text(
                                  "Home Screen",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: AppColor.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              InkWell(
                                onTap: () async {
                                  isLoading = true;
                                  setState(() {});
                                  bool result = await WallpaperManager
                                      .setWallpaperFromFile(imagePath!,
                                          WallpaperManager.LOCK_SCREEN);
                                  setState(() {
                                    isLoading = false;
                                    Get.back();
                                    if (result) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(successSnackBar);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(failedSnackBar);
                                    }
                                  });
                                },
                                child: Text(
                                  "Lock Screen",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: AppColor.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              InkWell(
                                onTap: () async {
                                  isLoading = true;
                                  setState(() {});
                                  bool result = await WallpaperManager
                                      .setWallpaperFromFile(imagePath!,
                                          WallpaperManager.BOTH_SCREEN);
                                  setState(() {
                                    isLoading = false;
                                    Get.back();
                                    if (result) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(successSnackBar);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(failedSnackBar);
                                    }
                                  });
                                },
                                child: Text(
                                  "Home and lock Screens",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: AppColor.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  int selectedColumn = 3;
  void openColumnSelectionBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Consumer<GalleryDataProvider>(
            builder: (context, gallery, child) {
          selectedColumn = gallery.columnCount;

          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                // Default selection

                return Container(
                  height: SizeUtils.verticalBlockSize * 50,
                  decoration: const BoxDecoration(
                      color: AppColor.blackdark,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25))),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 0),
                          height: 3,
                          width: 25,
                          decoration: BoxDecoration(
                              color: AppColor.greyText,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Text("Displayed Columns:",
                            style: TextStyle(
                                color: AppColor.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 15)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.0),
                        child: Divider(
                          thickness: 1,
                          color: AppColor.dividercolor,
                        ),
                      ),
                      RadioListTile(
                        activeColor: AppColor.purpal,
                        title: Text(
                          "Column 1",
                          style: TextStyle(
                              color: selectedColumn == 1
                                  ? AppColor.purpal
                                  : AppColor.greyText),
                        ),
                        value: 1,
                        groupValue: selectedColumn,
                        onChanged: (value) {
                          setState(() {
                            selectedColumn = value ?? 1;
                          });
                        },
                      ),
                      RadioListTile(
                        activeColor: AppColor.purpal,
                        title: Text(
                          "Column 2",
                          style: TextStyle(
                              color: selectedColumn == 2
                                  ? AppColor.purpal
                                  : AppColor.greyText),
                        ),
                        value: 2,
                        groupValue: selectedColumn,
                        onChanged: (value) {
                          setState(() {
                            selectedColumn = value ?? 2;
                          });
                        },
                      ),
                      RadioListTile(
                        activeColor: AppColor.purpal,
                        title: Text(
                          "Column 3",
                          style: TextStyle(
                              color: selectedColumn == 3
                                  ? AppColor.purpal
                                  : AppColor.greyText),
                        ),
                        value: 3,
                        groupValue: selectedColumn,
                        onChanged: (value) {
                          setState(() {
                            selectedColumn = value ?? 3;
                          });
                        },
                      ),
                      RadioListTile(
                        activeColor: AppColor.purpal,
                        title: Text(
                          "Column 4",
                          style: TextStyle(
                              color: selectedColumn == 4
                                  ? AppColor.purpal
                                  : AppColor.greyText),
                        ),
                        value: 4,
                        groupValue: selectedColumn,
                        onChanged: (value) {
                          setState(() {
                            selectedColumn = value ?? 4;
                          });
                        },
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        children: [
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: SizeUtils.verticalBlockSize * 6,
                              width: SizeUtils.horizontalBlockSize * 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: AppColor.graydark),
                              child: Center(
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: AppColor.white),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              // Perform the OK action with the selectedColumn
                              print("Selected Column: ${gallery.columnCount}");
                              gallery.columnCount = selectedColumn;
                              gallery.notifyListeners();
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: SizeUtils.verticalBlockSize * 6,
                              width: SizeUtils.horizontalBlockSize * 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: AppColor.purpal,
                              ),
                              child: Center(
                                child: Text(
                                  "Ok",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: AppColor.white),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        });
      },
    );
  }

  void openFolderSortingBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child:
              Consumer<GalleryDataProvider>(builder: (context, gallery, child) {
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Container(
                    // height: SizeUtils.verticalBlockSize * 70,
                    decoration: const BoxDecoration(
                        color: AppColor.blackdark,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25))),
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 0),
                            height: 3,
                            width: 25,
                            decoration: BoxDecoration(
                                color: AppColor.greyText,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 28.0),
                          child: Text(
                            "Sort By:",
                            style: TextStyle(
                                color: AppColor.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.0),
                          child: Divider(
                            color: AppColor.dividercolor,
                            thickness: 1,
                          ),
                        ),
                        for (SortOption option in SortOption.values)
                          RadioListTile(
                            activeColor: AppColor.purpal,
                            title: Text(
                              gallery.optionToString(option),
                              style: TextStyle(
                                  color: gallery.selectedSortOption == option
                                      ? AppColor.purpal
                                      : AppColor.greyText),
                            ),
                            value: option,
                            groupValue: gallery.selectedSortOption,
                            onChanged: (value) {
                              setState(() {
                                gallery.selectedSortOption = value!;
                              });
                            },
                          ),
                        // const SizedBox(height: 16.0),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.0),
                          child: Divider(
                            color: AppColor.dividercolor,
                            thickness: 1,
                          ),
                        ),
                        // Text("Sort Order:",style: TextStyle(color: AppColor.white),),
                        for (SortOrder order in SortOrder.values)
                          RadioListTile(
                            activeColor: AppColor.purpal,
                            title: Text(
                              gallery.orderToString(order),
                              style: TextStyle(
                                  color: gallery.selectedSortOrder == order
                                      ? AppColor.purpal
                                      : AppColor.greyText),
                            ),
                            value: order,
                            groupValue: gallery.selectedSortOrder,
                            onChanged: (value) {
                              setState(() {
                                gallery.selectedSortOrder = value!;
                              });
                            },
                          ),
                        const SizedBox(height: 16.0),

                        Row(
                          children: [
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: SizeUtils.verticalBlockSize * 6,
                                width: SizeUtils.horizontalBlockSize * 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: AppColor.graydark),
                                child: Center(
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: AppColor.white),
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  gallery.sortList();
                                });
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: SizeUtils.verticalBlockSize * 6,
                                width: SizeUtils.horizontalBlockSize * 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: AppColor.purpal,
                                ),
                                child: Center(
                                  child: Text(
                                    "ok",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: AppColor.white),
                                  ),
                                ),
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
        );
      },
    );
  }

  void openAlbumsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: StatefulBuilder(
            builder: (context, setState) {
              return SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Container(
                  decoration: const BoxDecoration(
                      color: AppColor.blackdark,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30))),
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 0),
                          height: 3,
                          width: 25,
                          decoration: BoxDecoration(
                              color: AppColor.greyText,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "Create New Albums",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: AppColor.white),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: const Divider(
                          color: AppColor.dividercolor,
                          thickness: 1,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: SizeUtils.verticalBlockSize * 8,
                        width: SizeUtils.horizontalBlockSize * 90,
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: AppColor.graydark,
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.only(left: 20, top: 12),
                              hintText: "Enter name",
                              helperStyle: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xffFFFFFF))),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              height: SizeUtils.verticalBlockSize * 6,
                              width: SizeUtils.horizontalBlockSize * 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: AppColor.graydark),
                              child: Center(
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: AppColor.white),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              height: SizeUtils.verticalBlockSize * 6,
                              width: SizeUtils.horizontalBlockSize * 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: AppColor.purpal,
                              ),
                              child: Center(
                                child: Text(
                                  "ok",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: AppColor.white),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  void openRecycleBinBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      context: context,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: StatefulBuilder(
            builder: (context, setState) {
              return SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Container(
                  decoration: const BoxDecoration(
                      color: AppColor.blackdark,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30))),
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "Are you sure?",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                              color: AppColor.white),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "You want restored all images and videos.",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: AppColor.greyText),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Container(
                              height: SizeUtils.verticalBlockSize * 6,
                              width: SizeUtils.horizontalBlockSize * 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: AppColor.graydark),
                              child: Center(
                                child: Text(
                                  "No",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: AppColor.white),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Container(
                              height: SizeUtils.verticalBlockSize * 6,
                              width: SizeUtils.horizontalBlockSize * 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: AppColor.red,
                              ),
                              child: Center(
                                child: Text(
                                  "Yes",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: AppColor.white),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
