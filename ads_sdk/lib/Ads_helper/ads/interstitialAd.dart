import 'dart:math';

import 'package:applovin_max/applovin_max.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../helper/debug_print.dart';
import '../../helper/loader.dart';
import '../../helper/qureka_ad_widget.dart';
import '../ad_constant.dart';

const int maxFailedLoadAttempts = 3;
String? admobInter;
String? fbInter;
String? applovinInter;

class InterstitialAdClass extends GetxController {
  static InterstitialAd? adMobInterstitialAd;
  static const AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );

  static bool isFacebookInterstitialAdLoaded = false;
  static bool isAppLovinInterstitialAdLoaded = false;
  static bool isReadyToShowAd = true;

// static bool firstAdShowDelayed = true;
  static int _numInterstitialLoadAttempts = 0;
  static int interstitialAdShow = 0;
  static bool isAdIsRewarded = false;
  static late RewardedAd rewardAd;
  Random random = Random();

  Future<void> showLoader() async {
    if (AdConstants.adsModel.adProgressDialog == true) {
      Loader.sw();
      await Future.delayed(Duration(milliseconds: AdConstants.adsModel.dialogTimer ?? 1000), () {
        Loader.hd();
      });
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    setRandomAdId();
    super.onInit();
  }

  void setRandomAdId() {
    int admobId = random.nextInt(AdConstants.adsModel.admob?.admobInter?.length ?? 1);
    admobInter = "${AdConstants.adsModel.admob?.admobInter![admobId]}";

    int fbId = random.nextInt(AdConstants.adsModel.facebook?.fbInter?.length ?? 1);
    fbInter = "${AdConstants.adsModel.facebook?.fbInter![fbId]}";

    int applovin = random.nextInt(AdConstants.adsModel.appLovin?.lovinInter?.length ?? 1);
    applovinInter = "${AdConstants.adsModel.appLovin?.lovinInter![applovin]}";
    update();
  }

  Future<void> loadInterstitialAds() async {
    setRandomAdId();
    if (AdConstants.adsModel.adStatus == true) {
      if (admobInter!.isNotEmpty) {
        await loadAdMobAd("AdMobInterstitialAds", alterNative: false);
      } else if (fbInter!.isNotEmpty) {
        await loadFacebookAd("FacebookInterstitialAds", alterNative: true);
      } else if (applovinInter!.isNotEmpty) {
        await loadAppLovinAd();
      }
    }
  }

  Future<void> loadFacebookAd(String adsType, {bool alterNative = false}) async {
    await FacebookInterstitialAd.loadInterstitialAd(
      placementId: "$fbInter",
      // placementId: "IMG_16_9_APP_INSTALL#YOUR_PLACEMENT_ID",
      listener: (result, value) {
        debugLog(result);
        debugLog(value);
        switch (result) {
          case InterstitialAdResult.LOADED:
            isFacebookInterstitialAdLoaded = true;
            update();
            debugLog('LOADED ads');
            break;
          case InterstitialAdResult.DISMISSED:
            isFacebookInterstitialAdLoaded = false;
            debugLog('DISMISSED ads');
            MyURLLauncher().launchGameUrl();
            loadInterstitialAds();
            break;
          case InterstitialAdResult.ERROR:
            break;
          default:
        }
      },
    );
    update();
  }

  Future<void> loadAdMobAd(String adsType, {bool alterNative = false}) async {
    await InterstitialAd.load(
      adUnitId: "$admobInter",
      request: request,
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          adMobInterstitialAd = ad;
          _numInterstitialLoadAttempts = 0;
          update();
        },
        onAdFailedToLoad: (LoadAdError error) {
          if (alterNative == true) {
            if (adsType != "FacebookInterstitialAds") {
              loadFacebookAd("AdMobInterstitialAds");
            }
          }
          _numInterstitialLoadAttempts += 1;
          adMobInterstitialAd = null;
          if (_numInterstitialLoadAttempts <= maxFailedLoadAttempts) {
            loadInterstitialAds();
          }
        },
      ),
    );
  }

  var _interstitialRetryAttempt = 0;

  Future<void> loadAppLovinAd() async {
    AppLovinMAX.setInterstitialListener(InterstitialListener(
      onAdLoadedCallback: (ad) {
        isAppLovinInterstitialAdLoaded = true;
        print('Interstitial ad loaded from ' + ad.networkName);

        // Reset retry attempt
        _interstitialRetryAttempt = 0;
      },
      onAdLoadFailedCallback: (adUnitId, error) {
        _interstitialRetryAttempt = _interstitialRetryAttempt + 1;
        int retryDelay = pow(2, min(6, _interstitialRetryAttempt)).toInt();

        print('Interstitial ad failed to load with code ' + error.code.toString() + ' - retrying in ' + retryDelay.toString() + 's');

        Future.delayed(Duration(milliseconds: retryDelay * 1000), () {
          AppLovinMAX.loadInterstitial("$applovinInter");
        });
      },
      onAdDisplayedCallback: (ad) {
        update();
        Loader.hd();
      },
      onAdDisplayFailedCallback: (ad, error) {
        MyURLLauncher().launchGameUrl();
      },
      onAdClickedCallback: (ad) {},
      onAdHiddenCallback: (ad) {
        MyURLLauncher().launchGameUrl();
        loadInterstitialAds();
      },
    ));

    // Load the first interstitial
    AppLovinMAX.loadInterstitial("$applovinInter");
  }

  Future<bool?> showInterstitialAds() async {
    if (interstitialAdShow == 0) {
      if (isReadyToShowAd && adMobInterstitialAd != null) {
        await showLoader();
        adMobInterstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
          onAdShowedFullScreenContent: (InterstitialAd ad) {
            update();
            debugLog('ad onAdShowedFullScreenContent.');
          },
          onAdDismissedFullScreenContent: (InterstitialAd ad) {
            ad.dispose();
            loadInterstitialAds();
            MyURLLauncher().launchGameUrl();
          },
          onAdWillDismissFullScreenContent: (InterstitialAd ad) {
            ad.dispose();
            MyURLLauncher().launchGameUrl();
            loadInterstitialAds();
          },
          onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
            debugLog('$ad onAdFailedToShowFullScreenContent: $error');
            ad.dispose();
            MyURLLauncher().launchGameUrl();
            loadInterstitialAds();
          },
        );
        await adMobInterstitialAd?.show();
        adMobInterstitialAd = null;
        isReadyToShowAd = true;
      } else if (isFacebookInterstitialAdLoaded) {
        await showLoader();
        await FacebookInterstitialAd.showInterstitialAd();
        update();
        isReadyToShowAd = true;
      } else if (isReadyToShowAd && isAppLovinInterstitialAdLoaded) {
        isAppLovinInterstitialAdLoaded = await AppLovinMAX.isInterstitialReady("$applovinInter") ?? false;
        if (isAppLovinInterstitialAdLoaded) {
          await showLoader();
          AppLovinMAX.showInterstitial("$applovinInter");
        } else {
          AppLovinMAX.loadInterstitial("$applovinInter");
          await showLoader();
          Future.delayed(
            const Duration(milliseconds: 200),
            () => AppLovinMAX.showInterstitial("$applovinInter"),
          );
        }
      } else {
        MyURLLauncher().launchGameUrl();
      }
      return true;
    }
    int clickCounter = AdConstants.adsModel.clickCount ?? 0;
    if (interstitialAdShow >= clickCounter) {
      interstitialAdShow = 0;
      update();
      return false;
    } else {
      interstitialAdShow++;
      update();
      return false;
    }
  }
}
