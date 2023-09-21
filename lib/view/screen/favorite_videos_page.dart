import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gallery_vault/view/res/app_colors.dart';
import 'package:gallery_vault/view/screen/preview_page.dart';
import 'package:gallery_vault/view/screen/video_player_page.dart';
import 'package:gallery_vault/view/utils/navigation_utils/routes.dart';
import 'package:gallery_vault/view/utils/size_utils.dart';

import 'package:photo_manager/photo_manager.dart';

import '../../controller/functions/favoritedb.dart';
import '../utils/navigation_utils/navigation.dart';

class FavouriteScreen extends StatefulWidget {
  FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: FavoriteDb.favoriteVideos,
        builder: (BuildContext ctx, List<AssetEntity> favoriteData, Widget? child) {
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
                  "Favorite",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: AppColor.white),
                ),
                centerTitle: true,
                backgroundColor: AppColor.blackdark,
              ),
              backgroundColor: AppColor.black,
              body: SafeArea(
                  child:
                      // ValueListenableBuilder(
                      //     valueListenable: FavoriteDb.favoriteVideos,
                      //     builder: (BuildContext ctx, List<AssetEntity> favoriteData, Widget? child) {
                      // if (favoriteData.isEmpty) {
                      //   return const Padding(
                      //     padding: EdgeInsets.only(top: 70, left: 10),
                      //     child: Align(
                      //       alignment: Alignment.center,
                      //       child: Text(
                      //         'No Favorite Videos',
                      //         style: TextStyle(color: Colors.white),
                      //       ),
                      //     ),
                      //   );
                      // } else {
                      //   return
                      Padding(
                padding: const EdgeInsets.only(top: 18.0, left: 10, right: 10),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: ((context, index) {
                    return InkWell(
                      onTap: () {
                        Navigation.pushNamed(Routes.kPriviewPage2, arg: index);
                      },
                      child: FutureBuilder<Uint8List?>(
                        future: favoriteData[index].thumbnailData,
                        builder: (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
                          if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                            return Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Container(
                                      child: Center(
                                    child: Image.memory(
                                      snapshot.data!,
                                      height: 116,
                                      width: 200,
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                                ),
                                Positioned(
                                  top: -10,
                                  right: -10,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.favorite,
                                      color: AppColor.red,
                                    ),
                                    onPressed: () {
                                      FavoriteDb.favoriteVideos.notifyListeners();
                                      FavoriteDb.delete(favoriteData[index].id);
                                      const snackbar = SnackBar(
                                        content: Text(
                                          'Video Removed From  Favourites',
                                        ),
                                        duration: Duration(seconds: 1),
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                                    },
                                  ),
                                )
                              ],
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
                                    )));
                          }
                        },
                      ),
                    );
                  }),
                  itemCount: favoriteData.length,
                ),
              )
                  // ;
                  // }
                  // }),
                  ));
        });
  }
}
