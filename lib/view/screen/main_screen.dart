import 'package:flutter/material.dart';
import 'package:gallery_vault/view/res/app_colors.dart';
import 'package:gallery_vault/view/screen/recent_gallery_list.dart';
import 'package:gallery_vault/view/widgets/custom_appbar.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/bottomsheets.dart';
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
    return Scaffold(
      appBar: customAppBar(
          title: "Gallery",
          appBarHeight: 12,
          bgClr: AppColor.black,
          leadingIcon:  Icon(
            Icons.menu,
            color: AppColor.white,
          ),
          action: [
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
              icon: Icon(Icons.camera_alt_outlined,color: AppColor.white,),
               itemBuilder: (context) =>

               [
                PopupMenuItem(
                 value: 1,
                 child: Text(
                   "Camera",
                   style: TextStyle(color: AppColor.white,fontWeight: FontWeight.w500, fontSize: 15),
                 ),
               ),
                PopupMenuItem(
                 value: 2,
                 child: Text(
                   "Gallery",
                   style: TextStyle(color: AppColor.white,fontWeight: FontWeight.w500, fontSize: 15),
                 ),
               ),
               ] ,

     ),
            if (tabController!.index == 0)
              PopupMenuButton<int>(
                  itemBuilder: (context) => [
                         PopupMenuItem(
                          value: 1,
                          child: Text(
                            "Sort By",
                            style: TextStyle(color: AppColor.white,fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                        ),
                         PopupMenuItem(
                          value: 2,
                          child: Text(
                            "Column Count",
                            style: TextStyle(color: AppColor.white,fontWeight: FontWeight.w500, fontSize: 15),
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
                  offset: const Offset(0, 30),
                  color: AppColor.blackdark,
                  elevation: 2,
                  child:  Padding(
                    padding: EdgeInsets.all(8.0),
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
          showLeading: true),
      body: TabBarView(
        controller: tabController,
        children: _children,
      ),
    );
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

