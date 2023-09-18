import 'package:flutter/material.dart';
import 'package:gallery_vault/view/res/app_colors.dart';
import 'package:gallery_vault/view/screen/recent_gallery_list.dart';
import 'package:gallery_vault/view/utils/navigation_utils/navigation.dart';

import 'album_list_screeen.dart';

class Private_Safe extends StatefulWidget {
  const Private_Safe({super.key});

  @override
  State<Private_Safe> createState() => _Private_SafeState();
}

class _Private_SafeState extends State<Private_Safe> with TickerProviderStateMixin {
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

    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigation.pop();

          },
          icon: Icon(Icons.arrow_back_ios_new,color: AppColor.white,),
        ),
        title: Text(
          "Private Safe",
          style:TextStyle(fontWeight: FontWeight.w600,fontSize: 18,color: AppColor.white),
        ),

        centerTitle: true,
        backgroundColor: AppColor.blackdark,
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
              text: "Photo",
            ),

          ],
        ),
      ),

      backgroundColor: AppColor.black,
      body: TabBarView(
        controller: tabController,
        children: _children,
      ),
    );
  }
}
