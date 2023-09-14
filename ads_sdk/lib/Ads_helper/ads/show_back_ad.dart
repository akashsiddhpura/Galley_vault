import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ad_constant.dart';
import 'custom_interstitial.dart';
import 'interstitialAd.dart';

class AdWillPopScope extends StatefulWidget {
  final Widget child;

  AdWillPopScope({required this.child});

  @override
  _AdWillPopScopeState createState() => _AdWillPopScopeState();
}

class _AdWillPopScopeState extends State<AdWillPopScope> {
  bool _isBackPressed = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _showAdAndBack() async {
    if (AdConstants.adsModel.adStatus == true) {
      if (AdConstants.adsModel.backAd == true) {
        if (AdConstants.adsModel.showCustomAd == true) {
          CustomInter().showInter();
        } else {
          InterstitialAdClass().showInterstitialAds().then((value) => Future.delayed(const Duration(milliseconds: 800), () {
                Get.back();
              }));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (!_isBackPressed && AdConstants.adsModel.adStatus == true && AdConstants.adsModel.backAd == true) {
          _isBackPressed = true;
          _showAdAndBack();
          return false;
        } else {
          return Future.value(true);
        }
      },
      child: widget.child,
    );
  }
}
