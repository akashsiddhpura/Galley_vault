import 'dart:developer';
import 'dart:math';

import 'package:ads_sdk/Ads_helper/ads/custom_banner_ad.dart';
import 'package:gallery_vault/view/utils/size_utils.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:applovin_max/applovin_max.dart';
import 'package:shimmer/shimmer.dart';

import '../../helper/debug_print.dart';
import '../ad_constant.dart';

class BannerAds extends StatefulWidget {
  static bool isLoaded = false;

  const BannerAds({Key? key}) : super(key: key);

  @override
  _BannerAdsState createState() => _BannerAdsState();
}

class _BannerAdsState extends State<BannerAds> {
  BannerAd? _ad;
  FacebookNativeAd? _fbAd;
  bool isAdError = false;
  int bannerCount = 0;
  int fbBannerCount = 0;
  List<String>? alternatePlatforms;
  bool adLoaded = false;
  Random random = Random();
  String? admobBanner, fbBanner, applovinBanner;
  Widget? _maxAdView;

  @override
  void initState() {
    super.initState();
    adLoaded = false;
    setRandomAdId();
    apiBannerAds();
    setState(() {});
  }

  void setRandomAdId() {
    int admobId = random.nextInt(AdConstants.adsModel.admob?.admobBanner?.length ?? 1);
    admobBanner = "${AdConstants.adsModel.admob?.admobBanner![admobId]}";
    debugLog(admobBanner);

    int fbId = random.nextInt(AdConstants.adsModel.facebook?.fbNative?.length ?? 1);
    fbBanner = "${AdConstants.adsModel.facebook?.fbNative![fbId]}";

    int applovin = random.nextInt(AdConstants.adsModel.appLovin?.lovinBanner?.length ?? 1);
    applovinBanner = "${AdConstants.adsModel.appLovin?.lovinBanner![applovin]}";
  }

  void adsFunction({bool? alterNative}) {
    _ad = BannerAd(
      size: AdSize.fullBanner,
      adUnitId: "$admobBanner",
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          setState(() {
            BannerAds.isLoaded = true;
            adLoaded = true;
          });
          debugLog("banner loaded");
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          debugLog('banner $BannerAd failedToLoad: $error');
        },
        onAdOpened: (Ad ad) => debugLog('$BannerAd onAdOpened.'),
        onAdClosed: (Ad ad) => debugLog('$BannerAd onAdClosed.'),
      ),
      request: const AdRequest(),
    );
    _ad!.load();
  }

  void fbAdFunction() {
    setState(() {
      BannerAds.isLoaded = true;
      adLoaded = true;
    });
    _fbAd = FacebookNativeAd(
      placementId: "$fbBanner",
      adType: NativeAdType.NATIVE_BANNER_AD,
      height: 100,
      // bannerAdSize: AdConstants.adsModel.nativeSize == "medium" ? NativeBannerAdSize.HEIGHT_120 : NativeBannerAdSize.HEIGHT_120,
      width: double.infinity,
      listener: (result, value) {
        debugLog("Native Native Ad: $result --> $value");
        switch (result) {
          case NativeAdResult.ERROR:
            debugLog("Facebook Native Ad Error: $value");
            fbBannerCount++;
            setState(() {
              isAdError = true;
            });
            break;
          case NativeAdResult.LOADED:
            debugLog("Facebook Native Ad Loaded: $value");
            setState(() {
              BannerAds.isLoaded = true;
              adLoaded = true;
              // isLoaded = AdConstants.isShowNativeAds ;
            });
            break;
          case NativeAdResult.CLICKED:
            break;
          case NativeAdResult.LOGGING_IMPRESSION:
            break;
          case NativeAdResult.MEDIA_DOWNLOADED:
            // TODO: Handle this case.
            break;
        }
      },
      keepExpandedWhileLoading: true,
      expandAnimationDuraion: 1000,
    );
  }

  void appLovinAdFunction() {
    setState(() {
      BannerAds.isLoaded = true;
      adLoaded = true;
    });
    _maxAdView = MaxAdView(
      adUnitId: "$applovinBanner",
      adFormat: AdFormat.banner,
      listener: AdViewAdListener(
        onAdLoadedCallback: (ad) {
          debugLog(ad);
        },
        onAdLoadFailedCallback: (adUnitId, error) {
          debugLog(error);
          setState(() {
            BannerAds.isLoaded = true;
            adLoaded = true;
          });
        },
        onAdClickedCallback: (ad) {
          debugLog(ad);
        },
        onAdExpandedCallback: (ad) {
          debugLog(ad);
        },
        onAdCollapsedCallback: (ad) {
          debugLog(ad);
        },
      ),
    );
    setState(() {});
  }

  void apiBannerAds() {
    if (AdConstants.adsModel.adStatus == true) {
      if (admobBanner!.isNotEmpty) {
        adsFunction();
      } else if (fbBanner!.isNotEmpty) {
        fbAdFunction();
      } else if (applovinBanner!.isNotEmpty) {
        appLovinAdFunction();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (AdConstants.adsModel.adStatus == true) {
      if (AdConstants.adsModel.showCustomAd == true) {
        return CustomBannerAd();
      } else {
        if (adLoaded == true) {
          return admobBanner!.isNotEmpty
              ? Container(
                  width: _ad!.size.width.toDouble(),
                  height: _ad!.size.height.toDouble(),
                  alignment: Alignment.center,
                  child: AdWidget(
                    ad: _ad!,
                  ),
                )
              : fbBanner!.isNotEmpty
                  ? Container(
                      height: _fbAd!.height,
                      width: _fbAd!.width,
                      alignment: Alignment.center,
                      child: _fbAd,
                    )
                  : applovinBanner!.isNotEmpty
                      ? Container(
                          height: SizeUtils.verticalBlockSize * 9,
                          alignment: Alignment.center,
                          child: _maxAdView,
                        )
                      : const SizedBox();
        } else {
          return Container(
            width: double.infinity,
            height: 75,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  enabled: true,
                  child: Container(
                    color: Colors.white,
                    height: 65,
                    width: 65,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(padding: EdgeInsets.all(2), height: 20, color: Colors.grey.shade300, child: Text("AD", style: TextStyle(color: Colors.white))),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              enabled: true,
                              child: Container(
                                color: Colors.white,
                                height: 20,
                                width: double.infinity,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          color: Colors.white,
                          height: 25,
                          width: double.infinity,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      }
    } else {
      return const SizedBox();
    }
  }
}
