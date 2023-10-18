import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../controller/provider/gallery_data_provider.dart';
import '../../../res/app_colors.dart';
import '../../../res/assets_path.dart';
import '../../../utils/navigation_utils/navigation.dart';
import '../../../utils/navigation_utils/routes.dart';
import '../../../utils/size_utils.dart';
import '../../../widgets/version_popup.dart';

class DrowerScreen extends StatefulWidget {
  const DrowerScreen({super.key});

  @override
  State<DrowerScreen> createState() => _DrowerScreenState();
}

class _DrowerScreenState extends State<DrowerScreen> {

  String? privateSafePin;
  Future<void> checkFirstTimeSetPin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    privateSafePin = prefs.getString('privateSafePin');

    setState(() {});
  }
  @override
  void initState() {
    super.initState();
    // PermissionHandler().getPermission();
    checkFirstTimeSetPin();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<GalleryDataProvider>(builder: (context, gallery, child) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
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
                    image: const DecorationImage(image: AssetImage(AssetsPath.appicon), fit: BoxFit.cover)),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Gallery - Vault, Photo Album",
                style: TextStyle(color: Color(0xffEFDBFF), fontSize: 18, fontWeight: FontWeight.w600),
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
                          style: TextStyle(color: AppColor.white, fontSize: 14),
                        ),
                        Text(
                          "${gallery.allRecentList.length}",
                          style: TextStyle(color: AppColor.greyText, fontSize: 13),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Videos",
                          style: TextStyle(color: AppColor.white),
                        ),
                        Text(
                          "${gallery.allVideoList.length}",
                          style: const TextStyle(color: AppColor.greyText, fontSize: 13),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Albums",
                          style: TextStyle(color: AppColor.white),
                        ),
                        Text(
                          "${gallery.allGalleryFolders.length}",
                          style: TextStyle(color: AppColor.greyText, fontSize: 13),
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
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: InkWell(
                  onTap: () {
                    Navigation.pushNamed(Routes.kSubStitution);
                  },
                  child: Center(
                    child: Image.asset(AssetsPath.premuum),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Wrap(
                children: List.generate(
                    4,
                        (index) => Column(
                      children: [
                        InkWell(
                          onTap: () {
                            if(index==0){
                              Navigation.pushNamed(
                                Routes.kPhotoEdit,
                              ).then((value) {
                                setState(() {});
                              });
                            }
                            else if(index == 1) {
                              Navigation.pushNamed(privateSafePin == null ? Routes.kSecurityScreen : Routes.kConfirmPin2, arg: privateSafePin)
                                  .then((value) {
                                setState(() {});
                              });
                            }
                            else if (index == 2) {
                              Navigation.pushNamed(
                                Routes.kFavoritesScreen,
                              ).then((value) {
                                setState(() {});
                              });
                            }
                            else if(index == 3) {
                              Navigation.pushNamed(
                                Routes.kSettingScreen,
                              ).then((value) {
                                setState(() {});
                              });
                            }
                            else {
                              const SizedBox();
                            }

                          },
                          child: Container(
                            height: SizeUtils.verticalBlockSize * 12,
                            width: SizeUtils.horizontalBlockSize * 28,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: AppColor.blackdark),
                            margin: const EdgeInsets.all(7),
                            child: Center(
                              child: Stack(
                                children: [
                                  Image.asset(
                                    gallery.images2[index],
                                    height: SizeUtils.verticalBlockSize * 6,
                                  ),
                                  Positioned(bottom: 5, child: index == 1 ? Image.asset(AssetsPath.privatesafe2) : const SizedBox()),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Text(
                          gallery.text3[index],
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColor.white),
                        ),
                        SizedBox(height: 10,)
                      ],
                    )),
              ),
              SizedBox(height: SizeUtils.verticalBlockSize * 10,),
              Center(
                child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VersionPopup(),
                          ));
                    },
                    child: const Text(
                      "Version 2.5",
                      style: TextStyle(color: AppColor.blackdark, fontSize: 15, fontWeight: FontWeight.w500),
                    )),
              )
            ],
          ),
        ),
      ),
    );
    });
  }
}
