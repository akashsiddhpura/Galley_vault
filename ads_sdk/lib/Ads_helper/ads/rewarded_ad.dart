import 'dart:math';

import 'package:applovin_max/applovin_max.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../helper/loader.dart';
import '../ad_constant.dart';

var notificationRewardCollected = ValueNotifier<bool>(false);

class RewardedAdController extends GetxController {
  RewardedAd? _rewardedAd;
  String? admobReward;
  String? fbReward;
  String? appLovinReward;
  bool rewardCollected = false;
  bool adLoaded = false;
  Random random = Random();

  Future<void> showLoader() async {
    if (AdConstants.adsModel.adProgressDialog == true) {
      Loader.sw();
      await Future.delayed(Duration(milliseconds: AdConstants.adsModel.dialogTimer ?? 1000), () {
        Loader.hd();
      });
    }
  }

  void setRandomAdId() {
    int admobId = random.nextInt(AdConstants.adsModel.admob?.admobReward?.length ?? 1);
    admobReward = "${AdConstants.adsModel.admob?.admobReward![admobId]}";

    int fbId = random.nextInt(AdConstants.adsModel.facebook?.fbReward?.length ?? 1);
    fbReward = "${AdConstants.adsModel.facebook?.fbReward![fbId]}";

    int applovin = random.nextInt(AdConstants.adsModel.appLovin?.lovinReward?.length ?? 1);
    appLovinReward = "${AdConstants.adsModel.appLovin?.lovinReward![applovin]}";
    update();
  }

  Future<void> loadRewardedAds() async {
    setRandomAdId();
    if (AdConstants.adsModel.adStatus == true) {
      if (admobReward!.isNotEmpty) {
        loadAdmobReward();
      } else if (fbReward!.isNotEmpty) {
        loadFBReward();
      } else if (appLovinReward!.isNotEmpty) {
        loadAppLovinReward();
      }
    }
  }

  /// Loads a rewarded ad.
  void loadAdmobReward() {
    RewardedAd.load(
        adUnitId: "$admobReward",
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) {
            adLoaded = true;

            ad.fullScreenContentCallback = FullScreenContentCallback(
                onAdShowedFullScreenContent: (ad) {},
                onAdImpression: (ad) {},
                onAdFailedToShowFullScreenContent: (ad, err) {
                  ad.dispose();
                  loadAdmobReward();
                  adLoaded = false;
                },
                onAdDismissedFullScreenContent: (ad) {
                  ad.dispose();
                  loadAdmobReward();
                  adLoaded = false;
                },
                onAdClicked: (ad) {});

            _rewardedAd = ad;
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            adLoaded = false;
            debugPrint('RewardedAd failed to load: $error');
          },
        ));
  }

  void loadFBReward() {
    FacebookRewardedVideoAd.loadRewardedVideoAd(
      placementId: '$fbReward',
      listener: (result, value) {
        if (result == RewardedVideoAdResult.VIDEO_COMPLETE) {
          rewardCollected = true;
          notificationRewardCollected.value = true;
          adLoaded = false;
          update();
          loadFBReward();
        }
        if (result == RewardedVideoAdResult.ERROR) {
          loadFBReward();
          adLoaded = false;
        }
        if (result == RewardedVideoAdResult.LOADED) {
          adLoaded = true;
        }
        if (result == RewardedVideoAdResult.VIDEO_CLOSED) {
          adLoaded = false;
        }
      },
    );
  }

  void loadAppLovinReward() {
    AppLovinMAX.setRewardedAdListener(
      RewardedAdListener(
        onAdLoadedCallback: (ad) {
          adLoaded = true;

          print('Rewarded ad loaded from ' + ad.networkName);
        },
        onAdLoadFailedCallback: (adUnitId, error) {
          adLoaded = false;

          Future.delayed(Duration(seconds: 5), () {
            AppLovinMAX.loadRewardedAd("$appLovinReward");
          });
        },
        onAdDisplayedCallback: (ad) {},
        onAdDisplayFailedCallback: (ad, error) {},
        onAdClickedCallback: (ad) {},
        onAdHiddenCallback: (ad) {
          adLoaded = false;

          loadAppLovinReward();
        },
        onAdReceivedRewardCallback: (ad, reward) {
          loadAppLovinReward();
        },
      ),
    );
  }

  /// show reward ad
  Future<bool> showRewardAd() async {
    rewardCollected = false;
    notificationRewardCollected.value = false;

    if (AdConstants.adsModel.adStatus == true) {
      if (admobReward!.isNotEmpty && _rewardedAd != null && adLoaded) {
        await showLoader();

        await _rewardedAd?.show(onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
          rewardCollected = true;
          notificationRewardCollected.value = true;

          update();
        });
        return rewardCollected;
      } else if (fbReward!.isNotEmpty && adLoaded) {
        await showLoader();

        await FacebookRewardedVideoAd.showRewardedVideoAd();
        return rewardCollected;
      } else if (appLovinReward!.isNotEmpty && adLoaded) {
        bool isReady = (await AppLovinMAX.isRewardedAdReady("$appLovinReward"))!;

        if (isReady) {
          await showLoader();

          AppLovinMAX.showRewardedAd("$appLovinReward");
          return rewardCollected;
        } else {
          await showLoader();

          loadAppLovinReward();
          Future.delayed(
            const Duration(milliseconds: 200),
            () => AppLovinMAX.showRewardedAd("$appLovinReward"),
          );
          return rewardCollected;
        }
      }
    }
    return rewardCollected;
  }

  @override
  void onInit() {
    loadRewardedAds();
    super.onInit();
  }
}
