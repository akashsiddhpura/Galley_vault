import 'package:flutter/material.dart';
import 'package:gallery_vault/view/res/app_colors.dart';
import 'package:gallery_vault/view/res/assets_path.dart';
import 'package:gallery_vault/view/utils/navigation_utils/navigation.dart';
import 'package:gallery_vault/view/utils/navigation_utils/routes.dart';
import 'package:gallery_vault/view/utils/size_utils.dart';
import 'package:gallery_vault/view/widgets/bottomsheets.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../controller/provider/preview_page_provider.dart';
import '../../../res/strings_utils.dart';

class Setting_Screen extends StatefulWidget {
  const Setting_Screen({super.key});

  @override
  State<Setting_Screen> createState() => _Setting_ScreenState();
}

class _Setting_ScreenState extends State<Setting_Screen> {

  String? privateSafePin1;
  Map<String , String> parms = {
    "select": "true"
  };
  Future<void> checkFirstTimeSetPin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    privateSafePin1 = prefs.getString('privateSafePin');

    setState(() {});
  }
  @override
  void initState() {
    super.initState();
    // PermissionHandler().getPermission();
    checkFirstTimeSetPin();
  }
  bool select = true;
  List name = [
    'Send Feedback',
    'Share App',
    'Privacy Policy'
  ];
  launchPrivacyPolicyURL() async {
    const privacyPolicyURL = 'https://www.pacegallery.com/privacy/';
    if (await canLaunch(privacyPolicyURL)) {
      await launch(privacyPolicyURL);
    } else {
      throw 'Could not launch $privacyPolicyURL';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<PreviewPageProvider>(builder: (context, preview, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.blackdark,
          leading: InkWell(
            onTap: () {
              Navigation.pop();
            },
            child: Icon(
              Icons.arrow_back_ios_new,
              color: AppColor.white,
            ),
          ),
          title: Text(
            "Setting",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: AppColor.white),
          ),
          centerTitle: true,
        ),
        backgroundColor: AppColor.black,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeUtils.horizontalBlockSize * 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: SizeUtils.verticalBlockSize * 3,
                  ),
                  const Text(
                    "General",
                    style: TextStyle(
                        color: AppColor.purpal,
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                  ),
                  SizedBox(
                    height: SizeUtils.verticalBlockSize * 1,
                  ),
                  Container(
                    height: SizeUtils.verticalBlockSize * 10,
                    width: SizeUtils.horizontalBlockSize * 90,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColor.blackdark),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeUtils.horizontalBlockSize * 5,
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigation.pushNamed(Routes.kInstructionsScreen);
                        },
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Instructions',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      color: AppColor.white),
                                ),
                                const Text(
                                  'Find some frequently asked questions',
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.greyText),
                                )
                              ],
                            ),
                            const Spacer(),
                         Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: AppColor.white,
                               ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeUtils.verticalBlockSize * 3,
                  ),
                  const Text(
                    "Private Safe",
                    style: TextStyle(
                        color: AppColor.purpal,
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                  ),
                  SizedBox(
                    height: SizeUtils.verticalBlockSize * 1,
                  ),
                  Container(
                    height: SizeUtils.verticalBlockSize * 18,
                    width: SizeUtils.horizontalBlockSize * 90,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColor.blackdark),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeUtils.horizontalBlockSize * 5,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigation.pushNamed(privateSafePin1 == null ? Routes.kSecurityScreen : Routes.kConfirmPin2, arg: privateSafePin1,params: parms);
                            },
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Change Password',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: AppColor.white),
                                    ),
                                    const Text(
                                      'Set or Change password for security',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color: AppColor.greyText),
                                    )
                                  ],
                                ),
                                const Spacer(),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: AppColor.white,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: SizeUtils.verticalBlockSize * 1,
                          ),
                          const Divider(
                              thickness: 1, color: AppColor.dividercolor),
                          SizedBox(
                            height: SizeUtils.verticalBlockSize * 1,
                          ),
                          InkWell(
                            onTap: () {
                              AppBottomSheets()
                                  .openPrivateSafeBinBottomSheet(context);
                            },
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Security Questions',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: AppColor.white),
                                    ),
                                    const Text(
                                      'Set or Change security question for data',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color: AppColor.greyText),
                                    )
                                  ],
                                ),
                                const Spacer(),
                            Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: AppColor.white,
                                    ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeUtils.verticalBlockSize * 3,
                  ),
                  const Text(
                    "Visibility",
                    style: TextStyle(
                        color: AppColor.purpal,
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                  ),
                  SizedBox(
                    height: SizeUtils.verticalBlockSize * 1,
                  ),
                  Container(
                    height: SizeUtils.verticalBlockSize * 25,
                    width: SizeUtils.horizontalBlockSize * 90,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColor.blackdark),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeUtils.horizontalBlockSize * 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Hide Privacy Tab',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: AppColor.white),
                              ),
                              const Spacer(),
                              Switch(
                                inactiveTrackColor: AppColor.greyText,
                                activeTrackColor: AppColor.greenAsset,
                                activeColor: AppColor.white,
                                inactiveThumbColor: AppColor.white,
                                value: preview.isPrivacyScreenVisible,
                                onChanged: (index) {
                                  setState(() {
                                    preview.togglePrivacyScreen();
                                  });
                                },
                              ),
                            ],
                          ),
                          const Divider(
                              thickness: 1, color: AppColor.dividercolor),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Exclude Camera ',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: AppColor.white),
                                  ),
                                  const Text(
                                    'Exclude camera from Home',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400,
                                        color: AppColor.greyText),
                                  )
                                ],
                              ),
                              const Spacer(),
                              Switch(
                                inactiveTrackColor: AppColor.greyText,
                                activeTrackColor: AppColor.greenAsset,
                                activeColor: AppColor.white,
                                inactiveThumbColor: AppColor.white,
                                value: preview.camera,
                                onChanged: (index) {
                                  setState(() {
                                    preview.cameraHide();
                                  });
                                },
                              ),
                            ],
                          ),
                          const Divider(
                              thickness: 1, color: AppColor.dividercolor),
                          InkWell(
                            onTap: () {
                              AppBottomSheets()
                                  .openTrashEmptyTimeIntervalBottomSheet(
                                  context);
                            },
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Trash empty time interval ',
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: AppColor.white),
                                    ),
                                    const Text(
                                      'Set the interval time to empty trask',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color: AppColor.greyText),
                                    )
                                  ],
                                ),
                                const Spacer(),
                             Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: AppColor.white,
                                    ),
                                SizedBox(width: SizeUtils.horizontalBlockSize * 2,)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeUtils.verticalBlockSize * 3,
                  ),
                  const Text(
                    "App Settings",
                    style: TextStyle(
                        color: AppColor.purpal,
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                  ),
                  SizedBox(
                    height: SizeUtils.verticalBlockSize * 1,
                  ),
                  Container(
                    height: SizeUtils.verticalBlockSize * 25,
                    width: SizeUtils.horizontalBlockSize * 90,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColor.blackdark),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: SizeUtils.horizontalBlockSize * 5,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                         Column(
                           children: List.generate(3, (index) =>  Column(
                             children: [
                               InkWell(
                                 onTap: ()async {
                                   if(index==1) {
                                        Navigation.pushNamed(
                                            Routes.kSendFeedbackScreen);
                                      }
                                   else if (index ==1) {
                                     await Share.share(
                                         "https://play.google.com/store/apps/details?id=${AppString.kPackageName}");
                                   }
                                   else if (index == 2) {
                                     launchPrivacyPolicyURL();
                                   }
                                    },
                                 child: Row(
                                   children: [
                                     Text(
                                       name[index],
                                       style: TextStyle(
                                           fontSize: 14,
                                           fontWeight: FontWeight.w700,
                                           color: AppColor.white),
                                     ),
                                     const Spacer(),
                                     Icon(
                                       Icons.arrow_forward_ios_rounded,
                                       color: AppColor.white,
                                     ),
                                     SizedBox(width: SizeUtils.horizontalBlockSize * 2,),
                                   ],
                                 ),
                               ),
                               SizedBox(height: SizeUtils.verticalBlockSize *1,),
                               index !=2?  const Divider(
                                 thickness: 1,
                                 color: AppColor.dividercolor,
                               ):const SizedBox(),
                               index !=2? SizedBox(height: SizeUtils.verticalBlockSize *1,):const SizedBox(),

                             ],
                           ),),
                         ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
