import 'package:flutter/material.dart';
import 'package:gallery_vault/controller/provider/gallery_data_provider.dart';
import 'package:gallery_vault/view/res/app_colors.dart';
import 'package:gallery_vault/view/res/assets_path.dart';
import 'package:gallery_vault/view/screen/recent_gallery_list.dart';
import 'package:gallery_vault/view/utils/navigation_utils/navigation.dart';
import 'package:gallery_vault/view/utils/navigation_utils/routes.dart';
import 'package:gallery_vault/view/utils/size_utils.dart';
import 'package:gallery_vault/view/widgets/bottomsheets.dart';
import 'package:gallery_vault/view/widgets/common_textstyle.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../widgets/version_popup.dart';
import 'album_list_screeen.dart';
import 'explore_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  Future<void> openCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      // Handle the selected image, e.g., display it or process it.
      // pickedFile.path contains the path to the selected image file.
    } else {
      // User canceled the image selection.
    }
  }

  Future<void> openGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Handle the selected image, e.g., display it or process it.
      // pickedFile.path contains the path to the selected image file.
    } else {
      // User canceled the image selection.
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
      const RecentGalleryList(),
      const Explore_Screen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GalleryDataProvider>(builder: (context, gallery, child) {
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
                  } else if (value == 2) {
                    openGallery();
                  }
                },
                icon: Icon(
                  Icons.camera_alt_outlined,
                  color: AppColor.white,
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 1,
                    child: Text(
                      "Camera",
                      style: TextStyle(
                          color: AppColor.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                    ),
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: Text(
                      "Gallery",
                      style: TextStyle(
                          color: AppColor.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                    ),
                  ),
                ],
              ),
            if (tabController!.index == 0)
              PopupMenuButton<int>(
                  itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 1,
                          child: Text(
                            "Sort By",
                            style: TextStyle(
                                color: AppColor.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                        ),
                        PopupMenuItem(
                          value: 2,
                          child: Text(
                            "Column Count",
                            style: TextStyle(
                                color: AppColor.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                        ),
                      ],
                  onSelected: (value) async {
                    if (value == 1) {
                      AppBottomSheets().openFolderSortingBottomSheet(context);
                    } else if (value == 2) {
                      AppBottomSheets().openColumnSelectionBottomSheet(context);
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
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: InkWell(
                        onTap: () {
                          Navigation.pop();
                        },
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              color: AppColor.white,
                            ))),
                  ),
                  Container(
                    height: SizeUtils.verticalBlockSize * 10,
                    width: SizeUtils.horizontalBlockSize * 20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColor.blackdark,
                        image: const DecorationImage(
                            image: AssetImage(AssetsPath.appicon),
                            fit: BoxFit.cover)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Gallery - Vault, Photo Album",
                    style: TextStyle(
                        color: Color(0xffEFDBFF),
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Photos",
                              style: TextStyle(
                                  color: AppColor.white, fontSize: 14),
                            ),
                            const Text(
                              "895",
                              style: TextStyle(
                                  color: AppColor.greyText, fontSize: 13),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Videos",
                              style: TextStyle(color: AppColor.white),
                            ),
                            const Text(
                              "256",
                              style: TextStyle(
                                  color: AppColor.greyText, fontSize: 13),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Albums",
                              style: TextStyle(color: AppColor.white),
                            ),
                            const Text(
                              "25",
                              style: TextStyle(
                                  color: AppColor.greyText, fontSize: 13),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    color: Color(0xff35383F),
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Center(
                      child: Image.asset(AssetsPath.premuum),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Wrap(
                    children: List.generate(
                        7,
                        (index) => Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    index == 1
                                        ? Navigation.pushNamed(
                                            Routes.kPrivateSafe,
                                          ).then((value) {
                                            setState(() {});
                                          })
                                        : index == 2
                                            ? Navigation.pushNamed(
                                                Routes.kFavoritesScreen,
                                              ).then((value) {
                                                setState(() {});
                                              })
                                            : index == 3
                                                ? Navigation.pushNamed(
                                                    Routes.kRecycleBin,
                                                  ).then((value) {
                                                    setState(() {});
                                                  })
                                                : const SizedBox();
                                  },
                                  child: Container(
                                    height: SizeUtils.verticalBlockSize * 12,
                                    width: SizeUtils.horizontalBlockSize * 28,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: AppColor.blackdark),
                                    margin: const EdgeInsets.all(7),
                                    child: Center(
                                      child: Stack(
                                        children: [
                                          Image.asset(
                                            gallery.images2[index],
                                            height:
                                                SizeUtils.verticalBlockSize * 6,
                                          ),
                                          Positioned(
                                              bottom: 5,
                                              child: index == 1
                                                  ? Image.asset(
                                                      AssetsPath.privatesafe2)
                                                  : const SizedBox()),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  gallery.text3[index],
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.white),
                                ),
                              ],
                            )),
                  ),
                  Center(
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VersionPopup(),
                              ));
                        },
                        child: Text(
                          "Version 2.5",
                          style: TextStyle(
                              color: AppColor.blackdark,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          controller: tabController,
          children: _children,
        ),
      );
    });
  }
}

// import 'package:flutter/material.dart';
// import 'package:photo_manager/photo_manager.dart';
// import 'package:provider/provider.dart';
//
// import '../../controller/functions/global_variables.dart';
// import '../../controller/provider/gallery_data_provider.dart';
// import '../../controller/provider/video_data_provider.dart';
// import '../utils/navigation_utils/navigation.dart';
// import '../utils/navigation_utils/routes.dart';
// import '../utils/permission_handler.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   bool isLoading = false;
//   @override
//   void initState() {
//     super.initState();
//     // PermissionHandler().getPermission();
//     _loadData();
//   }
//
//   void _loadData() async {
//     await Provider.of<GalleryDataProvider>(context, listen: false).fetchGalleryData();
//     Navigation.replaceAll(Routes.kMainScreen);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Stack(
//           children: [
//             Positioned(
//               bottom: MediaQuery.of(context).size.height * .08,
//               right: MediaQuery.of(context).size.width * .05,
//               child: Text(
//                 'Gallery',
//                 style: TextStyle(fontFamily: "Inter", fontSize: MediaQuery.of(context).size.height * 0.023, color: Colors.black),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
