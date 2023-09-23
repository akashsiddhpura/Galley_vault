import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:lottie/lottie.dart';

import '../res/assets_path.dart';

class AppLoader {
  static sw(BuildContext context) {
    return Loader.show(
      context,
      overlayColor: Colors.black26,
      progressIndicator: Lottie.asset(AssetsPath.loader),
    );
  }

  static hd() {
    return Loader.hide();
  }
}
