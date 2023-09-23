import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

// void main() {
//   runApp(MyApp());
// }



class ImageSplitter extends StatefulWidget {
  @override
  _ImageSplitterState createState() => _ImageSplitterState();
}

class _ImageSplitterState extends State<ImageSplitter> {
  File? _selectedImage;
  List<File?> _splitImages = List.generate(9, (index) => null);

  Future<void> _splitImage() async {
    if (_selectedImage == null) return;

    final imageBytes = await _selectedImage!.readAsBytes();
    final image = img.decodeImage(imageBytes);

    if (image == null) {
      // Handle invalid image
      return;
    }

    final width = image.width~/ 3;
    final height = image.height~/ 3;

    for (var i = 0; i < 9; i++) {
      final row = i ~/ 3;
      final col = i % 3;
      final croppedImage = img.copyCrop(
        image,
        x: col * width,
        y: row * height,
        width: width,
        height: height,
      );

      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/split_image_$i.png');
      await tempFile.writeAsBytes(img.encodePng(croppedImage));

      setState(() {
        _splitImages[i] = tempFile;
      });
    }
  }

  Future<void> _saveImagesToGallery() async {
    for (var i = 0; i < 9; i++) {
      if (_splitImages[i] != null) {
        await FlutterImageCompress.compressAndGetFile(
          _splitImages[i]!.path,
          _splitImages[i]!.path,
          quality: 50, // Adjust the quality as needed
        );
        final savedFile = await _splitImages[i]!.copy('your_desired_directory/split_image$i.png');
        // You can now use `savedFile` to reference the saved images.
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Splitter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _selectedImage == null
                ? ElevatedButton(
                    onPressed: () async {
                      XFile? pickedImageFile;
                      ImagePicker picker = ImagePicker();

                      pickedImageFile = await picker.pickImage(source: ImageSource.gallery);
                      setState(() {});
                      // Get.back();
                      if (pickedImageFile != null) {
                        setState(() {
                          _selectedImage = File(pickedImageFile!.path);
                        });
                      }
                    },
                    child: Text('Select an Image'),
                  )
                : Column(
                    children: [
                      ElevatedButton(
                        onPressed: _splitImage,
                        child: Text('Split Image'),
                      ),
                      SizedBox(height: 20),
                      if (_splitImages.every((img) => img != null))
                        ElevatedButton(
                          onPressed: _saveImagesToGallery,
                          child: Text('Save Images to Gallery'),
                        ),
                      SizedBox(height: 20),
                      if (_splitImages.every((img) => img != null))
                        GridView.builder(
                          shrinkWrap: true,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
                          itemCount: 9,
                          itemBuilder: (context, index) {
                            final image = _splitImages[index];
                            return image != null
                                ? Image.file(
                                    image,
                                    fit: BoxFit.cover,
                                  )
                                : Container();
                          },
                        ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
