import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:saf/saf.dart';

import '../../view/widgets/toast_helper.dart';

class HideImage {
  Future<void> hideImage(String originalPath) async {
    try {
      Saf saf = Saf(originalPath);

      bool? isGranted = await saf.getDirectoryPermission(isDynamic: true, grantWritePermission: true);

      if (isGranted != null && isGranted) {
        final appDir = await getApplicationDocumentsDirectory();
        final hiddenDir = Directory('/storage/emulated/0/.galleryVaultHide');
        if (!await hiddenDir.exists()) {
          await hiddenDir.create();
        }

        final fileName = originalPath.split('/').last;
        final hiddenFilePath = '${hiddenDir.path}/$fileName';

        final File originalFile = File(originalPath);
        if (await originalFile.exists()) {
          await originalFile.rename(hiddenFilePath);
          AppToast.toastMessage("Hidden Successfully");
        }
      } else {
        // failed to get the permission
        AppToast.toastMessage("Please allow folder permission");
      }
    } catch (e) {
      print('Error hiding image: $e');
    }
  }

  Future<List<FileSystemEntity>> getMediaFromHideFolder() async {
    final Directory folder = Directory("/storage/emulated/0/.galleryVaultHide");

    // Check if the folder exists
    if (!await folder.exists()) {
      return [];
    }

    final List<FileSystemEntity> mediaFiles = [];

    // List all files in the folder
    final List<FileSystemEntity> entities = folder.listSync();

    for (final FileSystemEntity entity in entities) {
      if (entity is File) {
        // Filter out image and video files based on their extensions
        final String extension = entity.path.split('.').last.toLowerCase();
        if (extension == 'jpg' ||
            extension == 'png' ||
            extension == 'jpeg' ||
            extension == 'gif' ||
            extension == 'mp4' ||
            extension == 'mov' ||
            extension == 'avi') {
          mediaFiles.add(entity);
        }
      }
    }

    return mediaFiles;
  }

}
