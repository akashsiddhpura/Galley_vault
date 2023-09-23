// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
//
// class ImageMoveScreen2 extends StatefulWidget {
//   @override
//   _ImageMoveScreen2State createState() => _ImageMoveScreen2State();
// }
//
// class _ImageMoveScreen2State extends State<ImageMoveScreen2> {
//   File? _pickedImage;
//
//   Future<void> pickAndMoveImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedFile != null) {
//       final sourceFile = File(pickedFile.path);
//       // final destinationDir = Directory('path_to_destination_folder');
//       final tempDir = await getTemporaryDirectory();
//       final destinationDir = Directory('${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}_.png');
//
//
//       if (!await destinationDir.exists()) {
//         await destinationDir.create(recursive: true);
//       }
//
//       final destinationPath = '${destinationDir.path}/your_image.png';
//
//       await sourceFile.rename(destinationPath);
//
//       if (await File(destinationPath).exists()) {
//         setState(() {
//           _pickedImage = File(destinationPath);
//         });
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: Text('Move Image Example'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             if (_pickedImage != null)
//               Image.file(
//                 _pickedImage!,
//                 width: 200,
//                 height: 200,
//               ),
//             ElevatedButton(
//               onPressed: pickAndMoveImage,
//               child: const Text('Pick and Move Image'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// void main() {
//   runApp(MaterialApp(
//     home: ImageMoveScreen2(),
//   ));
// }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';


class SourceScreen extends StatefulWidget {
  @override
  _SourceScreenState createState() => _SourceScreenState();
}

class _SourceScreenState extends State<SourceScreen> {
  List<XFile>? _selectedPhotos = [];

  Future<void> _pickPhotos() async {
    final picker = ImagePicker();
    final selectedImages = await picker.pickMultiImage();

    if (selectedImages.isNotEmpty) {
      setState(() {
        _selectedPhotos = selectedImages;
      });
    }
  }

  void _navigateToDestinationScreen() {
    if (_selectedPhotos != null && _selectedPhotos!.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DestinationScreen(selectedPhotos: _selectedPhotos!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Manager - Source Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_selectedPhotos != null && _selectedPhotos!.isNotEmpty)
              Column(
                children: _selectedPhotos!.map((photo) {
                  return Image.file(File(photo.path));
                }).toList(),
              ),
            ElevatedButton(
              onPressed: _pickPhotos,
              child: Text('Select Photos'),
            ),
            ElevatedButton(
              onPressed: _navigateToDestinationScreen,
              child: Text('Go to Destination Screen'),
            ),
          ],
        ),
      ),
    );
  }
}

class DestinationScreen extends StatelessWidget {
  final List<XFile> selectedPhotos;


  DestinationScreen({required this.selectedPhotos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Manager - Destination Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: selectedPhotos.map((photo) {
                return Image.file(File(photo.path));
              }).toList(),
            ),
            ElevatedButton(
              onPressed: () async {
                await GallerySaver.saveImage(selectedPhotos.first.path);
                // await GallerySaver.saveImage().then((value) {});

                // Implement logic to save or use the selected photos as needed
              },
              child: Text('Save Photos'),
            ),
          ],
        ),
      ),
    );
  }
}
