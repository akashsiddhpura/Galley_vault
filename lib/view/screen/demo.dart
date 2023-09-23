import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class ImageMoveScreen extends StatelessWidget {
  Future<void> moveImage() async {
    // Source and destination paths
    final tempDir = await getTemporaryDirectory();
    final String sourcePath = '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}_.png';
    const String destinationPath = 'path_to_destination_folder/your_image.png';

    try {
      // Create a File object for the source image
      final File sourceFile = File(sourcePath);

      // Check if the source file exists
      if (await sourceFile.exists()) {
        // Create a Directory object for the destination folder
        final Directory destinationDir = Directory('path_to_destination_folder');

        // Ensure that the destination folder exists, create it if necessary
        if (!await destinationDir.exists()) {
          await destinationDir.create(recursive: true);
        }

        // Move the image to the destination folder
        await sourceFile.rename(destinationPath);

        // Check if the image was successfully moved
        final File movedFile = File(destinationPath);
        if (await movedFile.exists()) {
          print('Image moved successfully');
        } else {
          print('Image move failed');
        }
      } else {
        print('Source image does not exist');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Move Image Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: moveImage,
          child: Text('Move Image 2'),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ImageMoveScreen(),
  ));
}

