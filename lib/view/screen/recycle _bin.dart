import 'package:flutter/material.dart';
import 'package:gallery_vault/view/res/app_colors.dart';
import 'package:gallery_vault/view/res/assets_path.dart';
import 'package:gallery_vault/view/utils/navigation_utils/navigation.dart';
import 'package:gallery_vault/view/widgets/bottomsheets.dart';

class Recycle_Bin extends StatefulWidget {
  const Recycle_Bin({super.key});

  @override
  State<Recycle_Bin> createState() => _Recycle_BinState();
}

class _Recycle_BinState extends State<Recycle_Bin> {
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
      appBar: lodding == false
          ? AppBar(
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
                "Recycle Bin",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: AppColor.white),
              ),
              centerTitle: true,
            )
          : AppBar(
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
                "Recycle Bin",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: AppColor.white),
              ),
              actions: [
                Icon(
                  Icons.watch_later_outlined,
                  color: AppColor.white,
                ),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                  onPressed: () {
                    AppBottomSheets().openRecycleBinBottomSheet(context);
                  },
                  icon: Icon(
                    Icons.delete_outline,
                    color: AppColor.white,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
              centerTitle: true,
            ),
      backgroundColor: AppColor.black,
      body: lodding == false
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(AssetsPath.recyclebin),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "This Recycle Bin is Empty",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: AppColor.white),
                )
              ],
            )
          : const Column(
              children: [],
            ),
    );
  }
}
