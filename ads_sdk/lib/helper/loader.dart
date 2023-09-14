import 'package:gallery_vault/view/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:loader_overlay/loader_overlay.dart';
// GlobalKey<NavigatorState> navigatorKey = GlobalKey(debugLabel: "Main Navigator");

class Loader {
  void configLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.yellow
      ..backgroundColor = Colors.green
      ..indicatorColor = Colors.yellow
      ..textColor = Colors.yellow
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false;
  }

  static sw() async {
    return await EasyLoading.show(
      status: 'loading...',
      maskType: EasyLoadingMaskType.black,
    );
  }

  static hd() async {
    return await EasyLoading.dismiss();
  }
}

class MyLoader extends StatelessWidget {
  EdgeInsetsGeometry? margin;
  MyLoader({this.margin});
  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        margin: margin ?? EdgeInsets.symmetric(vertical: SizeUtils.verticalBlockSize * 40, horizontal: SizeUtils.horizontalBlockSize * 20),
        decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: primaryClr),
            SizedBox(
              width: 20,
            ),
            Text(
              "Ad Loading...",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            )
          ],
        ),
      );
}
