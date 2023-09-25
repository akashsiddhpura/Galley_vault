import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class GalleryApp extends StatefulWidget {
  @override
  _GalleryAppState createState() => _GalleryAppState();
}

class _GalleryAppState extends State<GalleryApp> {
  File? _selectedImage;
  String? _message;

  Future<void> _pickImage() async {
    try {
      final imagePicker = ImagePicker();
      final XFile? image = await imagePicker.pickImage(
        source: ImageSource.gallery,
      );

      if (image != null) {
        final movedImage = await _moveToPrivateFolder(image);
        setState(() {
          _selectedImage = movedImage;
          _message = 'Image moved to private folder.';
        });
      } else {
        setState(() {
          _message = 'No image selected.';
        });
      }
    } catch (e) {
      setState(() {
        _message = 'Failed to move image: $e';
      });
    }
  }

  Future<File?> _moveToPrivateFolder(XFile image) async {
    final appDir = (await getExternalStorageDirectories())!.first;
    final privateDir = Directory('${appDir.path}/private');
    print(privateDir);
    if (!await privateDir.exists()) {
      await privateDir.create();
    }
    var basNameWithExtension = path.basename(image.path);

    final sourceFile = File(path.join(appDir.path, image.path));
    final destinationFile = File(path.join(appDir.path, "$privateDir/image.jpg"));

    // Check if the source file exists before moving it.
    if (await sourceFile.exists()) {
      // Move the image from the source to the destination.
      final movedImage = await File(image.path).rename(basNameWithExtension);
      print('Image moved successfully.');
      return movedImage;
    } else {
      print('Source image does not exist.');
    }

    return null;
    // final newImagePath = join(privateDir.path, basename(image.path));
    // final movedImage = await File(image.path).rename(newImagePath);
    // Get.to(HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_selectedImage != null)
              Image.file(
                _selectedImage!,
                width: 200,
                height: 200,
              )
            else
              const Text('No Image Selected'),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Pick Image'),
            ),
            if (_message != null) Text(_message!),
          ],
        ),
      ),
    );
  }
}
