import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<File> selectedPhotos = [];

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        selectedPhotos.add(File(pickedFile.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hide Photos Example'),
      ),
      body: Column(
        children: <Widget>[
          ElevatedButton(
            onPressed: pickImage,
            child: Text('Pick a Photo from Gallery'),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: selectedPhotos.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                final photo = selectedPhotos[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PhotoDetailScreen(photo: photo),
                      ),
                    );
                  },
                  child: Image.file(
                    photo,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PhotoDetailScreen extends StatelessWidget {
  final File photo;

  PhotoDetailScreen({required this.photo});

  Future<void> movePhotoToPrivateDirectory(BuildContext context) async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final privateDirectory = await getApplicationSupportDirectory();
    final destinationFile = File('${privateDirectory.path}/${photo.path.split('/').last}');

    try {
      await photo.copy(destinationFile.path);
      // await photo.delete();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Photo moved to private directory.'),
        ),
      );
    } catch (e) {
      print('Error moving photo: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Detail'),
      ),
      body: Column(
        children: <Widget>[
          Image.file(photo),
          ElevatedButton(
            onPressed: () {
              movePhotoToPrivateDirectory(context);
              // Navigator.pop(context);
            },
            child: Text('Move to Private Screen'),
          ),

        ],
      ),
    );
  }
}


