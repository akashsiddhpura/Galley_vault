import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:gallery_vault/controller/provider/gallery_data_provider.dart';
import 'package:gallery_vault/view/res/app_colors.dart';
import 'package:gallery_vault/view/res/assets_path.dart';

import 'package:gallery_vault/view/utils/size_utils.dart';
import 'package:gallery_vault/view/widgets/bottomsheets.dart';
import 'package:gallery_vault/view/widgets/common_textstyle.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../controller/provider/preview_page_provider.dart';
import 'Albums/album_list_screeen.dart';
import 'All Media/recent_gallery_list.dart';
import 'Drower/drower_screen.dart';
import 'Explore/explore_screen.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  Future<void> openCamera() async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      GallerySaver.saveImage(pickedFile.path, albumName: "Camera").then((value) {});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Photo saved to gallery')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('sorry you have not selected photo')),
      );
    }
  }

  TabController? tabController;
  late List<Widget> _children;
  @override
  void initState() {
    super.initState();
    // PermissionHandler().getPermission();
    tabController = TabController(length: 3, vsync: this);
    tabController!.addListener(() {
      setState(() {});
    });
    _children = [
      const AlbumListScreen(),
      RecentGalleryList(),
      const Explore_Screen(),
    ];

    // checkFirstTimeSetPin();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GalleryDataProvider>(builder: (context, gallery, child) {
      return Consumer<PreviewPageProvider>(builder: (context, preview, child)
      {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Gallery",
              style: CommonTextStyle.title,
            ),
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: Image.asset(
                    AssetsPath.drawer,
                    height: 25,
                  ), // Replace with your custom icon
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
            centerTitle: true,
            backgroundColor: AppColor.blackdark,
            actions: [
              if (tabController!.index == 0)
                PopupMenuButton(
                  color: AppColor.blackdark,
                  onSelected: (value) async {
                    if (value == 1) {
                      openCamera();
                    }
                  },
                  icon:preview.camera==false? Icon(
                    Icons.camera_alt_outlined,
                    color: AppColor.white,
                  ):const SizedBox(),
                  itemBuilder: (context) =>
                  [
                    PopupMenuItem(
                      value: 1,
                      child: Text(
                        "Camera",
                        style: TextStyle(color: AppColor.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                    ),
                  ],
                ),
              if (tabController!.index == 0)
                PopupMenuButton<int>(
                    itemBuilder: (context) =>
                    [
                      PopupMenuItem(
                        value: 1,
                        child: Text(
                          "Sort By",
                          style: TextStyle(color: AppColor.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
                        ),
                      ),
                      PopupMenuItem(
                        value: 2,
                        child: Text(
                          "Column Count",
                          style: TextStyle(color: AppColor.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
                        ),
                      ),
                    ],
                    onSelected: (value) async {
                      if (value == 1) {
                        AppBottomSheets().openFolderSortingBottomSheet(context);
                      } else if (value == 2) {
                        AppBottomSheets().openColumnSelectionBottomSheet(
                            context);
                      }
                    },
                    offset: const Offset(10, 30),
                    color: AppColor.blackdark,
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.more_vert_rounded,
                        color: AppColor.white,
                      ),
                    )),
            ],
            bottom: TabBar(
              controller: tabController,
              labelColor: AppColor.purpal,
              dividerColor: AppColor.black,
              indicatorColor: AppColor.purpal,
              tabs: const [
                Tab(
                  text: "Albums",
                ),
                Tab(
                  text: "All Media",
                ),
                Tab(
                  text: "Explore",
                ),
              ],
            ),
          ),
          drawer: Drawer(
            width: SizeUtils.screenWidth,
            backgroundColor: AppColor.black,
            child: const DrowerScreen(),
          ),
          body: TabBarView(
            controller: tabController,
            children: _children,
          ),
        );
      });
    });
  }
}

