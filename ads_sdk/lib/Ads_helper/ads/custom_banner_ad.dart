import 'package:flutter/material.dart';

import '../../helper/qureka_ad_widget.dart';
import '../../helper/size_utils.dart';
import '../ad_constant.dart';

class CustomBannerAd extends StatelessWidget {
  const CustomBannerAd({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeUtils.verticalBlockSize * 9,
      child: Card(
        color: Colors.blueGrey.shade50,
        elevation: 0,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                "${AdConstants.adsModel.customAdData?.logo}",
                width: 50,
                height: 50,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        margin: const EdgeInsets.only(right: 5),
                        decoration: const BoxDecoration(color: Colors.black87),
                        child: const Text(
                          "AD",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                            maxWidth: SizeUtils.horizontalBlockSize * 48),
                        child: FittedBox(
                          child: Text(
                            "${AdConstants.adsModel.customAdData?.appName}",
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: SizeUtils.horizontalBlockSize * 55),
                    child: Text(
                      "${AdConstants.adsModel.customAdData?.shortDesc}",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 14, overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primaryClr,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      textStyle: TextStyle(fontWeight: FontWeight.bold)),
                  onPressed: () {
                    MyURLLauncher.launchURL(
                        "${AdConstants.adsModel.customAdData?.packageName}");
                  },
                  child: Text(
                    "${AdConstants.adsModel.customAdData?.buttonName}",
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
