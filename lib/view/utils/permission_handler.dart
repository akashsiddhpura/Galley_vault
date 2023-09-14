import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../widgets/dialogs.dart';

class PermissionHandler {
  Future<void> getPermission() async {
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    var androidSdk = androidInfo.version.sdkInt;

    PermissionStatus? status;
    if (androidSdk >= 30) {
      status = await Permission.manageExternalStorage.status;
    } else {
      status = await Permission.storage.status;
    }
    if (androidSdk >= 30) {
      if (!await Permission.manageExternalStorage.status.isGranted) {
        AppDialogs().permissionDialog(Get.context!, onPressed: () async {
          status = await Permission.manageExternalStorage.request();

          if (status!.isGranted) {
            Get.back();
          }
        }, displayText: "Allow Thread Video Downloader to access photo, media and files on your device?");
      }
    } else {
      if (!await Permission.manageExternalStorage.status.isGranted) {
        AppDialogs().permissionDialog(Get.context!, onPressed: () async {
          status = await Permission.storage.request();

          if (status!.isGranted) {
            Get.back();
          }
        }, displayText: "Allow Thread Video Downloader to access photo, media and files on your device?");
      }
    }
  }
}
