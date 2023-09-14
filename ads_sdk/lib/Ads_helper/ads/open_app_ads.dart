import 'package:applovin_max/applovin_max.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../helper/debug_print.dart';

class AppOpenAdManager {
  AppOpenAd? _appOpenAd;
  static bool isShowingAd = false;

  // Datum adsModel = Datum();

  /// Load an AppOpenAd.
  Future<void> loadAdmobOpenAd({required String id}) async {
    await AppOpenAd.load(
      adUnitId: id,
      orientation: AppOpenAd.orientationPortrait,
      request: AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenAd = ad;
          // _appOpenAd!.show();
        },
        onAdFailedToLoad: (error) {
          debugLog('AppOpenAd failed to load: $error');
          // Handle the error.
        },
      ),
    );
  }

  Future<void> loadSplashAds({required String id}) async {
    return AppOpenAd.load(
      adUnitId: id,
      orientation: AppOpenAd.orientationPortrait,
      request: AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenAd = ad;
          _appOpenAd!.show();
        },
        onAdFailedToLoad: (error) {
          debugLog('AppOpenAd failed to load: $error');
          // Handle the error.
        },
      ),
    );
  }

  Future<void> loadAppLovinOpenAd({required String id}) async {
    AppLovinMAX.setAppOpenAdListener(AppOpenAdListener(
      onAdLoadedCallback: (ad) {
        debugLog(ad);
      },
      onAdLoadFailedCallback: (adUnitId, error) {
        debugLog(error.message);
      },
      onAdDisplayedCallback: (ad) {
        debugLog(ad);
      },
      onAdDisplayFailedCallback: (ad, error) {
        debugLog(ad);
        debugLog(error.message);

        AppLovinMAX.loadAppOpenAd(id);
      },
      onAdClickedCallback: (ad) {},
      onAdHiddenCallback: (ad) {
        AppLovinMAX.loadAppOpenAd(id);
      },
      onAdRevenuePaidCallback: (ad) {},
    ));

    AppLovinMAX.loadAppOpenAd(id);
  }

  void showAdIfAvailable({required String id, required String adType}) {
    if (adType == "admob") {
      if (!isAdAvailable) {
        loadAdmobOpenAd(id: "$id");
        return;
      } else {
        _appOpenAd!.show();
      }
      if (isShowingAd) {
        return;
      }
      // Set the fullScreenContentCallback and show the ad.
      _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (ad) {
          isShowingAd = true;
          debugLog('$ad onAdShowedFullScreenContent');
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          debugLog('$ad onAdFailedToShowFullScreenContent: $error');
          isShowingAd = false;
          ad.dispose();
          _appOpenAd = null;
        },
        onAdDismissedFullScreenContent: (ad) {
          debugLog('$ad onAdDismissedFullScreenContent');
          isShowingAd = false;
          ad.dispose();
          _appOpenAd = null;
          loadAdmobOpenAd(id: id);
        },
      );
    } else {
      showAppLovinAdIfReady(id: id);
    }
  }

  Future<void> showAppLovinAdIfReady({required String id}) async {
    bool isReady = await AppLovinMAX.isAppOpenAdReady(id) ?? false;
    if (isReady) {
      AppLovinMAX.showAppOpenAd(id);
    } else {
      AppLovinMAX.loadAppOpenAd(id);

      Future.delayed(
        const Duration(milliseconds: 300),
        () => AppLovinMAX.showAppOpenAd(id),
      );
    }
  }

  /// Whether an ad is available to be shown.
  bool get isAdAvailable {
    return _appOpenAd != null;
  }
}
