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
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: SizeUtils.horizontalBlockSize * 5, vertical: SizeUtils.verticalBlockSize * 1.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        height: 3,
                        width: 40,
                        decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: SizeUtils.verticalBlockSize * 1, bottom: SizeUtils.verticalBlockSize * 2),
                      child: const Text(
                        "Set a wallpaper",
                        style: TextStyle(color: AppColor.primaryClr, fontSize: 15),
                      ),
                    ),
                    isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () async {
                                  isLoading = true;
                                  setState(() {});
                                  bool result = await WallpaperManager.setWallpaperFromFile(imagePath!, WallpaperManager.HOME_SCREEN);
                                  setState(() {
                                    isLoading = false;
                                    Get.back();
                                    if (result) {
                                      ScaffoldMessenger.of(context).showSnackBar(successSnackBar);
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(failedSnackBar);
                                    }
                                  });
                                },
                                child: SizedBox(
                                  width: SizeUtils.horizontalBlockSize * 25,
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(color: Colors.blue.shade400, borderRadius: BorderRadius.circular(10)),
                                        child: Icon(
                                          Icons.home_filled,
                                          color: AppColor.white,
                                          size: 30,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text(
                                        "Home Screen",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: AppColor.primaryClr, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  isLoading = true;
                                  setState(() {});
                                  bool result = await WallpaperManager.setWallpaperFromFile(imagePath!, WallpaperManager.LOCK_SCREEN);
                                  setState(() {
                                    isLoading = false;
                                    Get.back();
                                    if (result) {
                                      ScaffoldMessenger.of(context).showSnackBar(successSnackBar);
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(failedSnackBar);
                                    }
                                  });
                                },
                                child: SizedBox(
                                  width: SizeUtils.horizontalBlockSize * 25,
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(color: Colors.blue.shade400, borderRadius: BorderRadius.circular(10)),
                                        child: Icon(
                                          Icons.lock_outline_rounded,
                                          color: AppColor.white,
                                          size: 30,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text(
                                        "Lock Screen",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: AppColor.primaryClr, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  isLoading = true;
                                  setState(() {});
                                  bool result = await WallpaperManager.setWallpaperFromFile(imagePath!, WallpaperManager.BOTH_SCREEN);
                                  setState(() {
                                    isLoading = false;
                                    Get.back();
                                    if (result) {
                                      ScaffoldMessenger.of(context).showSnackBar(successSnackBar);
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(failedSnackBar);
                                    }
                                  });
                                },
                                child: SizedBox(
                                  width: SizeUtils.horizontalBlockSize * 25,
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(color: Colors.blue.shade400, borderRadius: BorderRadius.circular(10)),
                                        child: Icon(
                                          Icons.photo_library,
                                          color: AppColor.white,
                                          size: 30,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text(
                                        "Home and lock Screens",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: AppColor.primaryClr, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
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
      context: context,
      builder: (BuildContext context) {
        return Consumer<GalleryDataProvider>(builder: (context, gallery, child) {
          selectedColumn = gallery.columnCount;

          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              // Default selection

              return Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Displayed Columns:"),
                    RadioListTile(
                      title: const Text("Column 1"),
                      value: 1,
                      groupValue: selectedColumn,
                      onChanged: (value) {
                        setState(() {
                          selectedColumn = value ?? 1;
                        });
                      },
                    ),
                    RadioListTile(
                      title: const Text("Column 2"),
                      value: 2,
                      groupValue: selectedColumn,
                      onChanged: (value) {
                        setState(() {
                          selectedColumn = value ?? 2;
                        });
                      },
                    ),
                    RadioListTile(
                      title: const Text("Column 3"),
                      value: 3,
                      groupValue: selectedColumn,
                      onChanged: (value) {
                        setState(() {
                          selectedColumn = value ?? 3;
                        });
                      },
                    ),
                    RadioListTile(
                      title: const Text("Column 4"),
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
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel"),
                        ),
                        const SizedBox(width: 16.0),
                        ElevatedButton(
                          onPressed: () {
                            // Perform the OK action with the selectedColumn
                            print("Selected Column: ${gallery.columnCount}");
                            gallery.columnCount = selectedColumn;
                            gallery.notifyListeners();
                            Navigator.pop(context);
                          },
                          child: const Text("OK"),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        });
      },
    );
  }

  void openFolderSortingBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Consumer<GalleryDataProvider>(builder: (context, gallery, child) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Container(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Sort By:"),
                      for (SortOption option in SortOption.values)
                        RadioListTile(
                          title: Text(gallery.optionToString(option)),
                          value: option,
                          groupValue: gallery.selectedSortOption,
                          onChanged: (value) {
                            setState(() {
                              gallery.selectedSortOption = value!;
                            });
                          },
                        ),
                      const SizedBox(height: 16.0),
                      const Text("Sort Order:"),
                      for (SortOrder order in SortOrder.values)
                        RadioListTile(
                          title: Text(gallery.orderToString(order)),
                          value: order,
                          groupValue: gallery.selectedSortOrder,
                          onChanged: (value) {
                            setState(() {
                              gallery.selectedSortOrder = value!;
                            });
                          },
                        ),
                      // SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel",style: TextStyle(color: Colors.black),),
                          ),
                          const SizedBox(width: 16.0),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                gallery.sortList();
                              });
                              Navigator.pop(context);
                            },
                            child: const Text("OK"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
      },
    );
  }

  void openAlbumsBottomSheet(BuildContext context){
    showBottomSheet(context: context, builder: (context) {
      return StatefulBuilder(builder: (context, setState) {
        return  SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Container(
            decoration: const BoxDecoration(
                color: AppColor.blackdark,
              borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
            ),
            padding: const EdgeInsets.all(20.0),
            child: Column(mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text("Create New Albums",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15,color: AppColor.white),),
                const SizedBox(height: 10,),
                const Divider(thickness: 1,),
                const SizedBox(height: 30,),

                Container(
                  height: SizeUtils.verticalBlockSize * 8,
                  width: SizeUtils.horizontalBlockSize * 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: AppColor.graydark,
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 20,top: 12),
                      hintText: "Enter name",
                      helperStyle: TextStyle(fontSize: 17,fontWeight: FontWeight.w400,color: Color(0xffFFFFFF))
                    ),
                  ),
                ),
                const SizedBox(height: 30,),
                Row(
                  children: [
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(height: SizeUtils.verticalBlockSize * 6,
                        width: SizeUtils.horizontalBlockSize * 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                            color: AppColor.graydark

                        ),
                        child: Center(child:
                        Text("Cancel",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: AppColor.white),),),
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(height: SizeUtils.verticalBlockSize * 6,
                        width: SizeUtils.horizontalBlockSize * 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: AppColor.purpal,
                        ),
                        child: Center(child:
                        Text("ok",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: AppColor.white),),),
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
      },);
    },);
  }
}
