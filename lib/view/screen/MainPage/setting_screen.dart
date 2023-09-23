import 'package:flutter/material.dart';
import 'package:gallery_vault/view/res/app_colors.dart';
import 'package:gallery_vault/view/res/assets_path.dart';
import 'package:gallery_vault/view/utils/navigation_utils/navigation.dart';
import 'package:gallery_vault/view/widgets/bottomsheets.dart';

class Setting_Screen extends StatefulWidget {
  const Setting_Screen({super.key});

  @override
  State<Setting_Screen> createState() => _Setting_ScreenState();
}

class _Setting_ScreenState extends State<Setting_Screen> {
  bool lodding = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      lodding = true;
    });
  }

  @override
  Widget build(BuildContext context) {
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
      body:  const Column(
              children: [],
            ),
    );
  }
}
