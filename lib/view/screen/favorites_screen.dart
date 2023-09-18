import 'package:flutter/material.dart';
import 'package:gallery_vault/view/res/app_colors.dart';

import '../utils/navigation_utils/navigation.dart';

class Favorites_Screen extends StatelessWidget {
  const Favorites_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
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
        title: Text("Favorites",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18,color: AppColor.white),),
        centerTitle: true,
      ),

      body: Column(
        children: [

        ],
      ),
    );
  }
}
