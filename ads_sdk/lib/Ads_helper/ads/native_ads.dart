import 'dart:math';

import 'package:applovin_max/applovin_max.dart' as applovin;
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shimmer/shimmer.dart';

import '../../helper/debug_print.dart';
import '../../helper/size_utils.dart';
import '../ad_constant.dart';
import 'custom_native_ad.dart';

class NativeAds extends StatefulWidget {
  NativeAds({
    Key? key,
  }) : super(key: key);

  @override
  State<NativeAds> createState() => _NativeAdsState();
}

class _NativeAdsState extends State<NativeAds> {
  NativeAd? _ad;
  FacebookNativeAd? _fbAd;
  bool isAdError = false;
  int admobNativeCount = 0;
  int fbNativeCount = 0;
  List<String>? alternatePlatforms;
  bool isLoaded = false;
  Random random = Random();
  String? admobNative, fbNative, applovinNative;

  static const double _kMediaViewAspectRatio = 16 / 9;

  String _statusText = "";

  double _mediaViewAspectRatio = _kMediaViewAspectRatio;

  final applovin.MaxNativeAdViewController _nativeAdViewController = applovin.MaxNativeAdViewController();

  void logStatus(String status) {
    /// ignore: avoid_print
    print(status);

    setState(() {
      _statusText = '$_statusText\n$status';
    });
  }

  @override
  void initState() {
    super.initState();
    setRandomAdId();
    isLoaded = false;
    apiNativeAds();
    _ad?.load();
  }

  void setRandomAdId() {
    int admobId = random.nextInt(AdConstants.adsModel.admob?.admobNative?.length ?? 1);
    admobNative = "${AdConstants.adsModel.admob?.admobNative![admobId]}";

    int fbId = random.nextInt(AdConstants.adsModel.facebook?.fbNative?.length ?? 1);
    fbNative = "${AdConstants.adsModel.facebook?.fbNative![fbId]}";

    int applovin = random.nextInt(AdConstants.adsModel.appLovin?.lovinNative?.length ?? 1);
    applovinNative = "${AdConstants.adsModel.appLovin?.lovinNative![applovin]}";
  }

  void loadAdmobNativeAd({bool? alterNative}) {
    debugLog('NativeAd onAdLoaded----: ${"$admobNative"}');

    _ad = NativeAd(
      request: const AdRequest(),
      adUnitId: "$admobNative",
      // adUnitId: "ca-app-pub-3940256099942544/2247696110",
      factoryId: "listTileMedium",
      nativeAdOptions: NativeAdOptions(
          videoOptions: VideoOptions(
        clickToExpandRequested: true,
      )),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          debugLog('NativeAd onAdLoaded----: load');

          setState(() {
            isLoaded = true;
            // isLoaded = AdConstants.isShowNativeAds ;
          });
        },
        onAdFailedToLoad: (ad, error) {
          admobNativeCount++;
          debugLog('failed to load the ad ${error.message}, ${error.code}');
          debugLog('NativeAd onAdLoaded----: error');
        },
      ),
      // nativeTemplateStyle: NativeTemplateStyle(templateType: TemplateType.medium,)
    );
    _ad?.load();
  }

  void loadFbNativeAd({bool? alterNative}) {
    setState(() {
      isLoaded = true;
      // isLoaded = AdConstants.isShowNativeAds ;
    });

    _fbAd = FacebookNativeAd(
      placementId: "$fbNative",
      adType: NativeAdType.NATIVE_AD_HORIZONTAL,
      height: 300,
      buttonColor: primaryClr,
      // bannerAdSize: AdConstants.adsModel.nativeSize == "medium" ? NativeBannerAdSize.HEIGHT_120 : NativeBannerAdSize.HEIGHT_120,
      width: double.infinity,
      listener: (result, value) {
        debugLog("Native Native Ad: $result --> $value");
        switch (result) {
          case NativeAdResult.ERROR:
            debugLog("Facebook Native Ad Error: $value");
            fbNativeCount++;
            setState(() {
              isAdError = true;
            });
            break;
          case NativeAdResult.LOADED:
            debugLog("Facebook Native Ad Loaded: $value");
            setState(() {
              isLoaded = true;
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

  bool adLoaded = false;

  void apiNativeAds() {
    if (AdConstants.adsModel.adStatus == true) {
      if (admobNative!.isNotEmpty) {
        loadAdmobNativeAd(alterNative: false);
      } else if (fbNative!.isNotEmpty) {
        loadFbNativeAd(alterNative: true);
      } else if (applovinNative!.isNotEmpty) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    if (AdConstants.adsModel.adStatus == true) {
      if (AdConstants.adsModel.showCustomAd == true) {
        return CustomNativeAd();
      } else {
        if (isLoaded) {
          debugLog(" NativeAds.isLoaded -----${isLoaded}");
          return admobNative!.isNotEmpty
              ? Container(
                  alignment: Alignment.center,
                  height: _ad != null ? SizeUtils.verticalBlockSize * (AdConstants.adsModel.nativeSize ?? 30) : 0,
                  child: AdWidget(
                    ad: _ad!,
                  ),
                )
              : fbNative!.isNotEmpty
                  ? Container(
                      height: _fbAd!.height,
                      width: _fbAd!.width,
                      alignment: const Alignment(0.5, 1),
                      child: _fbAd,
                    )
                  : applovinNative!.isNotEmpty
                      ? Container(
                          margin: const EdgeInsets.all(8.0),
                          height: 300,
                          child: applovin.MaxNativeAdView(
                            adUnitId: admobNative ?? "",
                            controller: _nativeAdViewController,
                            listener: applovin.NativeAdListener(onAdLoadedCallback: (ad) {
                              logStatus('Native ad loaded from ${ad.networkName}');
                              setState(() {
                                _mediaViewAspectRatio = ad.nativeAd?.mediaContentAspectRatio ?? _kMediaViewAspectRatio;
                              });
                            }, onAdLoadFailedCallback: (adUnitId, error) {
                              logStatus('Native ad failed to load with error code ${error.code} and message: ${error.message}');
                            }, onAdClickedCallback: (ad) {
                              logStatus('Native ad clicked');
                            }, onAdRevenuePaidCallback: (ad) {
                              logStatus('Native ad revenue paid: ${ad.revenue}');
                            }),
                            child: Container(
                              color: const Color(0xffefefef),
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(4.0),
                                        child: const applovin.MaxNativeAdIconView(
                                          width: 48,
                                          height: 48,
                                        ),
                                      ),
                                      const Flexible(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            applovin.MaxNativeAdTitleView(
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                              maxLines: 1,
                                              overflow: TextOverflow.visible,
                                            ),
                                            applovin.MaxNativeAdAdvertiserView(
                                              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 10),
                                              maxLines: 1,
                                              overflow: TextOverflow.fade,
                                            ),
                                            applovin.MaxNativeAdStarRatingView(
                                              size: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const applovin.MaxNativeAdOptionsView(
                                        width: 20,
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: applovin.MaxNativeAdBodyView(
                                          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Expanded(
                                    child: AspectRatio(
                                      aspectRatio: _mediaViewAspectRatio,
                                      child: const applovin.MaxNativeAdMediaView(),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: double.infinity,
                                    child: applovin.MaxNativeAdCallToActionView(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStatePropertyAll(Color(0xff2d545e)),
                                        textStyle: MaterialStatePropertyAll(TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : SizedBox();
        }
        else {
          return Container(
            width: double.infinity,
            height: 250,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  enabled: true,
                  child: Container(
                    color: Colors.white,
                    height: 110,
                    width: double.infinity,
                  ),
                ),
                Row(
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        color: Colors.white,
                        height: 50,
                        width: 50,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            enabled: true,
                            child: Container(
                              color: Colors.white,
                              height: 20,
                              width: double.infinity,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  enabled: true,
                  child: Container(
                    color: Colors.white,
                    height: 50,
                    width: double.infinity,
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
