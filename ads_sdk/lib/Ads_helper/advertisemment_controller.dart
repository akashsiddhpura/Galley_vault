import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:gallery_vault/view/utils/size_utils.dart';
import 'package:android_play_install_referrer/android_play_install_referrer.dart';
import 'package:app_settings/app_settings.dart';
import 'package:check_vpn_connection/check_vpn_connection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_fgbg/flutter_fgbg.dart';
import 'package:get/get.dart';

import '../helper/debug_print.dart';
import 'Ad_modal.dart';
import 'ad_constant.dart';
import 'ads/custom_open_ad.dart';
import 'ads/interstitialAd.dart';
import 'ads/open_app_ads.dart';
import 'location_data.dart';

void printWrapped(String text) {
  final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

class AdsSdk {
  AdsSdk._adSdk();

  static final AdsSdk instance = AdsSdk._adSdk();
  String? get collectionName => _collectionName1;
  String? _collectionName1 = '';

  Future<void> initialize({String? apiName = ''}) async {
    _collectionName1 = apiName;
  }
}

class AdvertisementController extends GetxController {
  String? collectionName;
  late StreamSubscription<FGBGType> subscription;
  AppOpenAdManager appOpenAdManager = AppOpenAdManager();

  AdsModel? adsModel;
  LocationData? locationData;
  Object? data;

  Future<bool> advertisementData({bool showAd = true}) async {
    Loader().configLoading();
    bool developerMode = await FlutterJailbreakDetection.developerMode;
    String? collectionName = AdsSdk.instance.collectionName;
    // 'ads_data_model'

    if (await CheckVpnConnection.isVpnActive()) {
      Dialogs().showVpnOptionDialog();
      return false;
    }
    // else if (developerMode) {
    //   Dialogs().showDeveloperOptionDialog();
    //   return false;
    // }

    else {
      // CollectionReference users = FirebaseFirestore.instance.collection(collectionName ?? "");
      // QuerySnapshot querySnapshot = await users.get();

      var url =
          Uri.parse("http://plumtech.online/flutterJson/$collectionName.txt");

      var response = await http.get(url);
      // print(jsonDecode(response.body));
      var object = json.decode(response.body);
      adsModel = AdsModel.fromJson(object);
      AdConstants.adsModel = adsModel!;
      AdConstants.adsModel.version = adsModel?.version;
      if (adsModel?.bot == true) {
        var response = await http.get(Uri.parse("${adsModel?.botUrl}"));
        var object = json.decode(response.body);
        locationData = LocationData.fromJson(object);
        debugLog(locationData);

        checkLocationData();
      } else {
        checkTrackData();
      }
      if (showAd) {
        if (adsModel?.adStatus == true) {
          AdConstants.adsModel = adsModel!;

          await InterstitialAdClass().loadInterstitialAds();
          if (AdConstants.adsModel.splashAd == true) {
            if (AdConstants.adsModel.splashAdType == "Interstitial") {
              InterstitialAdClass().showInterstitialAds();
            } else {
              appInForGroundOrBackGround();
            }
          }
          return true;
        }
        return true;
      } else {
        return true;
      }

      //
      // if (querySnapshot.docs.isNotEmpty) {
      //   querySnapshot.docs.forEach(
      //     (doc) async {
      //       // Access the document data
      //       data = doc.data();
      //       printWrapped(jsonEncode(data));
      //       var object = json.decode(jsonEncode(data));
      //
      //       adsModel = AdsModel.fromJson(object);
      //
      //       update();
      //     },
      //   );
      //   AdConstants.adsModel.version = adsModel?.version;
      //   if (adsModel?.adStatus == true) {
      //     AdConstants.adsModel = adsModel!;
      //     if (adsModel?.bot == true) {
      //       var response = await http.get(Uri.parse("${adsModel?.botUrl}"));
      //       var object = json.decode(response.body);
      //       locationData = LocationData.fromJson(object);
      //       debugLog(locationData);
      //
      //       checkLocationData();
      //     }
      //     await InterstitialAdClass().loadInterstitialAds();
      //     if (AdConstants.adsModel.splashAd == true) {
      //       if (AdConstants.adsModel.splashAdType == "Interstitial") {
      //         InterstitialAdClass().showInterstitialAds();
      //       } else {
      //         appInForGroundOrBackGround();
      //       }
      //     }
      //     return true;
      //   } else {
      //     return true;
      //   }
      //   return false;
      // } else {
      //   debugLog('No documents found.');
      //   return true;
      // }
    }
  }

  static bool getInterstitialType(String? interstitialTypeName) {
    bool isFacebookAds = false;
    if (interstitialTypeName != null) {
      isFacebookAds = interstitialTypeName == 'facebook' ? true : false;
    }
    return isFacebookAds;
  }

  Future<void> appInForGroundOrBackGround() async {
    int admobId =
        Random().nextInt(AdConstants.adsModel.admob?.admobInter?.length ?? 0);
    int appLovinId = Random()
        .nextInt(AdConstants.adsModel.appLovin?.lovinAppopen?.length ?? 0);
    String admobAppOpen =
        "${AdConstants.adsModel.admob?.admobAppopen![admobId]}";
    String appLovinAppOpen =
        "${AdConstants.adsModel.appLovin?.lovinAppopen![appLovinId]}";
    if (AdConstants.adsModel.adStatus == true) {
      if (admobAppOpen.isNotEmpty) {
        appOpenAdManager.loadSplashAds(id: admobAppOpen);
      } else if (appLovinAppOpen.isNotEmpty) {
        await appOpenAdManager.loadAppLovinOpenAd(id: appLovinAppOpen);
        Future.delayed(
          Duration(seconds: 1),
          () async {
            await appOpenAdManager.showAppLovinAdIfReady(id: appLovinAppOpen);
          },
        );
      }
      if (AdConstants.adsModel.showCustomAd == true) {
        Future.delayed(Duration(seconds: 4), () {
          CustomOpenAd().showOpenAd();
        });
      }

      if (AdConstants.adsModel.onResumeAd == true) {
        subscription = FGBGEvents.stream.listen((event) async {
          admobId = Random()
              .nextInt(AdConstants.adsModel.admob?.admobInter?.length ?? 0);
          appLovinId = Random().nextInt(
              AdConstants.adsModel.appLovin?.lovinAppopen?.length ?? 0);
          debugLog(event);
          // appOpenAdManager.loadAdmobOpenAd(id: admobAppOpen);

          if (event == FGBGType.foreground) {
            if (AdConstants.adsModel.showCustomAd == true) {
              Future.delayed(Duration(milliseconds: 300), () {
                CustomOpenAd().showOpenAd();
              });
            } else {
              if (admobAppOpen.isNotEmpty) {
                appOpenAdManager.showAdIfAvailable(
                    id: admobAppOpen, adType: "admob");
              } else if (appLovinAppOpen.isNotEmpty) {
                appOpenAdManager.showAdIfAvailable(
                    id: appLovinAppOpen, adType: "applovin");
              }
            }
          }
          if (event == FGBGType.background) {
            if (admobAppOpen.isNotEmpty) {
              appOpenAdManager.loadAdmobOpenAd(id: admobAppOpen);
            } else if (appLovinAppOpen.isNotEmpty) {
              appOpenAdManager.loadAppLovinOpenAd(id: appLovinAppOpen);
            }
          }
        });
      }
    }
  }

  void checkLocationData() {
    print(adsModel!.targetCountry!.contains(locationData?.country));
    if (adsModel!.targetCountry!.contains(locationData?.country)) {
      if (adsModel?.targetState?.isEmpty == true) {
        setBotData();
      } else if (adsModel!.targetState!.contains(locationData?.regionName)) {
        if (adsModel?.targetCity?.isEmpty == true) {
          setBotData();
        } else if (adsModel!.targetCity!.contains(locationData?.city)) {
          setBotData();
        }
      }
    }
  }

  void setBotData() {
    if (adsModel?.targetArea == true) {
      AdConstants.adsModel.adStatus = adsModel?.extraData?.adStatus;
      AdConstants.adsModel.installTrack = adsModel?.extraData?.installTrack;
      AdConstants.adsModel.trackUrl = adsModel?.extraData?.trackUrl;
      AdConstants.adsModel.trackType = adsModel?.extraData?.trackType;
      AdConstants.adsModel.smartOrNative = adsModel?.extraData?.smartOrNative;
      AdConstants.adsModel.adStatus = adsModel?.extraData?.adStatus;
      AdConstants.adsModel.adProgressDialog =
          adsModel?.extraData?.adProgressDialog;
      AdConstants.adsModel.splashAd = adsModel?.extraData?.splashAd;
      AdConstants.adsModel.splashAdType = adsModel?.extraData?.splashAdType;
      AdConstants.adsModel.backAd = adsModel?.extraData?.backAd;
      AdConstants.adsModel.game = adsModel?.extraData?.game;
      AdConstants.adsModel.gameUrl = adsModel?.extraData?.gameUrl;
      AdConstants.adsModel.nativeSize = adsModel?.extraData?.nativeSize;
      AdConstants.adsModel.clickCount = adsModel?.extraData?.clickCount;
      AdConstants.adsModel.admob = adsModel?.extraData?.admob;
      AdConstants.adsModel.appLovin = adsModel?.extraData?.appLovin;
      AdConstants.adsModel.facebook = adsModel?.extraData?.facebook;
      AdConstants.adsModel.extraScreen = adsModel?.extraData?.extraScreen;
      AdConstants.adsModel.multiNative = adsModel?.extraData?.multiNative;
      AdConstants.adsModel.onResumeAd = adsModel?.extraData?.onResumeAd;
      AdConstants.adsModel.gameNative = adsModel?.extraData?.gameNative;
      AdConstants.adsModel.gameNativeUrl = adsModel?.extraData?.gameNativeUrl;
      AdConstants.adsModel.gameNativeSize = adsModel?.extraData?.gameNativeSize;
      AdConstants.adsModel.showStep = adsModel?.extraData?.showStep;
      AdConstants.adsModel.showScreen = adsModel?.extraData?.showScreen;
      debugLog("extra data set");
      checkTrackData();
      update();
    }
  }

  Future<void> checkTrackData() async {
    if (adsModel?.installTrack == true) {
      String? referrerDetailsString;
      // Platform messages may fail, so we use a try/catch PlatformException.
      try {
        ReferrerDetails referrerDetails =
            await AndroidPlayInstallReferrer.installReferrer;

        referrerDetailsString = referrerDetails.installReferrer;
        print("referrer Url ---> ${referrerDetails.installReferrer}");
      } catch (e) {
        referrerDetailsString = 'Failed to get referrer details: $e';
      }

      // ReferrerDetails { installReferrer: utm_source=google-play&utm_medium=organic, referrerClickTimestampSeconds: 0, installBeginTimestampSeconds: 0, googlePlayInstantParam: false }

      update();
      if (adsModel!.matchTrackUrl == true &&
          adsModel!.trackUrl!.contains(referrerDetailsString)) {
        setTrackData();
      } else if (adsModel!.matchTrackUrl == false &&
          !adsModel!.trackUrl!.contains(referrerDetailsString)) {
        setTrackData();
      }
    }
  }

  void setTrackData() {
    AdConstants.adsModel.adStatus = adsModel?.trackData?.adStatus;
    AdConstants.adsModel.adStatus = adsModel?.trackData?.adStatus;
    AdConstants.adsModel.adProgressDialog =
        adsModel?.trackData?.adProgressDialog;
    AdConstants.adsModel.splashAd = adsModel?.trackData?.splashAd;
    AdConstants.adsModel.splashAdType = adsModel?.trackData?.splashAdType;
    AdConstants.adsModel.smartOrNative = adsModel?.trackData?.smartOrNative;
    AdConstants.adsModel.backAd = adsModel?.trackData?.backAd;
    AdConstants.adsModel.game = adsModel?.trackData?.game;
    AdConstants.adsModel.gameUrl = adsModel?.trackData?.gameUrl;
    AdConstants.adsModel.nativeSize = adsModel?.trackData?.nativeSize;
    AdConstants.adsModel.clickCount = adsModel?.trackData?.clickCount;
    AdConstants.adsModel.admob = adsModel?.trackData?.admob;
    AdConstants.adsModel.appLovin = adsModel?.trackData?.appLovin;
    AdConstants.adsModel.facebook = adsModel?.trackData?.facebook;
    AdConstants.adsModel.extraScreen = adsModel?.trackData?.extraScreen;
    AdConstants.adsModel.multiNative = adsModel?.trackData?.multiNative;
    AdConstants.adsModel.onResumeAd = adsModel?.trackData?.onResumeAd;
    AdConstants.adsModel.gameNative = adsModel?.trackData?.gameNative;
    AdConstants.adsModel.gameNativeUrl = adsModel?.trackData?.gameNativeUrl;
    AdConstants.adsModel.gameNativeSize = adsModel?.trackData?.gameNativeSize;
    AdConstants.adsModel.showStep = adsModel?.trackData?.showStep;
    AdConstants.adsModel.showScreen = adsModel?.trackData?.showScreen;
    debugLog("track data set");
    update();
  }
}

class Dialogs {
  showDeveloperOptionDialog() {
    Get.defaultDialog(
      onWillPop: () async => false,
      title: "Developer Option ON",
      middleText: "Sorry! Try After Developer option off",
      titleStyle: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
      middleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      // content: getContent(),
      barrierDismissible: false,
      radius: 10.0,
      confirm: ElevatedButton(
        onPressed: () async {
          bool developerMode = await FlutterJailbreakDetection.developerMode;
          if (!developerMode) {
            Get.back();
            AdvertisementController().advertisementData();
          }
        },
        child: Text(
          "Recheck",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.green),
        ),
      ),
      cancel: ElevatedButton(
        onPressed: () {
          AppSettings.openAppSettings(
              asAnotherTask: true, type: AppSettingsType.developer);
        },
        child: Text(
          "Turn Off",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.red),
        ),
      ),
    );
  }

  showVpnOptionDialog() {
    Get.defaultDialog(
      onWillPop: () async => false,
      title: "Your VPN is ON",
      middleText: "Sorry! Try After VPN off",
      titleStyle: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
      middleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      // content: getContent(),
      barrierDismissible: false,
      radius: 10.0,
      confirm: ElevatedButton(
        onPressed: () async {
          if (await CheckVpnConnection.isVpnActive() == false) {
            Get.back();
            AdvertisementController().advertisementData();
          }
        },
        child: Text(
          "Recheck",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.green),
        ),
      ),
      cancel: ElevatedButton(
        onPressed: () {
          print("sample callback function called");
          AppSettings.openAppSettings(
              asAnotherTask: true, type: AppSettingsType.vpn);
        },
        child: Text(
          "Turn Off",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.red),
        ),
      ),
    );
  }
}
