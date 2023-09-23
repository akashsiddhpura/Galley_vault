import 'package:flutter/material.dart';
import 'package:gallery_vault/view/res/app_colors.dart';
import 'package:gallery_vault/view/screen/private_safe/confirm_pin.dart';

import 'package:gallery_vault/view/screen/private_safe/security_screen.dart';


import 'package:gallery_vault/view/utils/navigation_utils/navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Private_Safe extends StatefulWidget {
  const Private_Safe({super.key});

  @override
  State<Private_Safe> createState() => _Private_SafeState();
}

class _Private_SafeState extends State<Private_Safe> with TickerProviderStateMixin {
  String? privateSafePin ;
  @override
  void initState() {
    super.initState();
    checkFirstTimeSetPin();
    // setFirstTimeLoginStatus();
  }

  Future<void> checkFirstTimeSetPin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
     privateSafePin = prefs.getString('privateSafePin')  ;

    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {

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
            "Private Safe",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: AppColor.white),
          ),
          centerTitle: true,
          backgroundColor: AppColor.blackdark,
        ),
        body:privateSafePin==null ? const SecurityScreen():const ConfirmPin() ,
      );

  }
}
