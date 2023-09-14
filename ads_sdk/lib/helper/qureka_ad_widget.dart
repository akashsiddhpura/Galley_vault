import 'dart:math';

import 'package:gallery_vault/view/utils/size_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart' as urlLaunch;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';

import '../Ads_helper/ad_constant.dart';

class MyURLLauncher {
  static Future<void> launchURL(String url) async {
    // if (await canLaunch(url)) {
    await launch(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }

  void launchGameUrl() {
    if (AdConstants.adsModel.adStatus == true && AdConstants.adsModel.game == true) {
      int gameUrl = Random().nextInt(AdConstants.adsModel.gameUrl?.length ?? 0);
      String? gameLaunchUrl = AdConstants.adsModel.gameUrl![gameUrl];
      if (gameLaunchUrl.isNotEmpty) {
        // Get.to(CustomWebView(url: gameLaunchUrl), transition: Transition.fadeIn);

        launchTabURL(Get.context!, gameLaunchUrl);
      }
    }
  }

  Future<void> launchTabURL(BuildContext context, String url) async {
    final theme = Theme.of(context);
    try {
      await launch(
        url,
        customTabsOption: CustomTabsOption(
          toolbarColor: primaryClr,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          animation: CustomTabsSystemAnimation.fade(),
          extraCustomTabs: const <String>[
            'org.mozilla.firefox',
            'com.microsoft.emmx',
          ],
        ),
        safariVCOption: SafariViewControllerOption(
          preferredBarTintColor: primaryClr,
          preferredControlTintColor: Colors.white,
          barCollapsingEnabled: true,
          entersReaderIfAvailable: false,
          dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
        ),
      );
    } catch (e) {
      // An exception is thrown if browser app is not installed on Android device.
      debugPrint(e.toString());
    }
  }
}

class QurekaAdWidget extends StatelessWidget {
  final String asset;
  const QurekaAdWidget({Key? key, required this.asset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdConstants.adsModel.game == true
        ? InkWell(
            onTap: MyURLLauncher().launchGameUrl,
            child: Image.asset(asset),
          )
        : const SizedBox();
  }
}

class GameNativeWidget extends StatefulWidget {
  const GameNativeWidget({Key? key}) : super(key: key);

  @override
  State<GameNativeWidget> createState() => _GameNativeWidgetState();
}

class _GameNativeWidgetState extends State<GameNativeWidget> {
  String? gameNativeUrl;
  @override
  void initState() {
    int gameUrl = Random().nextInt(AdConstants.adsModel.gameNativeUrl?.length ?? 0);
    gameNativeUrl = AdConstants.adsModel.gameNativeUrl![gameUrl];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AdConstants.adsModel.adStatus == true && AdConstants.adsModel.gameNative == true
        ? CustomWebView(
            url: gameNativeUrl,
            nativeAdSize: AdConstants.adsModel.gameNativeSize,
          )
        : SizedBox();
  }
}

class CustomWebView extends StatefulWidget {
  String? url;
  int? nativeAdSize = 20;
  CustomWebView({Key? key, this.url, this.nativeAdSize}) : super(key: key);
  @override
  State<CustomWebView> createState() => _CustomWebViewState();
}

class _CustomWebViewState extends State<CustomWebView> {
  late final WebViewController controller;
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onUrlChange: (url) async {
          if (url.url!.startsWith("intent")) {
            if (await urlLaunch.canLaunch("${url.url}")) {
              await urlLaunch.launch("${url.url}");
            } else {
              throw 'Could not launch $url';
            }
          }
          if (mounted) setState(() {});
        },
        onPageStarted: (url) {
          if (mounted) {
            setState(() {
              loadingPercentage = 0;
            });
          }
        },
        onProgress: (progress) {
          if (mounted) {
            setState(() {
              loadingPercentage = progress;
            });
          }
        },
        onPageFinished: (url) {
          if (mounted) {
            setState(() {
              loadingPercentage = 100;
            });
          }
        },
      ))
      ..loadRequest(
        Uri.parse(widget.url ?? "google.com"),
      );
  }

  var loadingPercentage = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (_) {},
      onHorizontalDragUpdate: (_) {},
      child: SizedBox(
        height: SizeUtils.verticalBlockSize * (widget.nativeAdSize ?? 20),
        width: double.infinity,
        child: WebViewWidget(
          gestureRecognizers: Set()
            ..add(
              Factory<OneSequenceGestureRecognizer>(
                () => EagerGestureRecognizer(),
              ), // or null
            ),
          controller: controller,
        ),
      ),
    );
  }
}
