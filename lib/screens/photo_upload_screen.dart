import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class PhotoUploadScreen extends StatefulWidget {
  @override
  _PhotoUploadScreenState createState() => _PhotoUploadScreenState();
}

class _PhotoUploadScreenState extends State<PhotoUploadScreen> {
  late String _imagePath;

  Future<void> _pickImage() async {
    final permissionStatus = await Permission.photos.request();
    if (permissionStatus.isGranted) {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _imagePath = pickedFile.path;
        });
      }
    } else {
      // Kullanıcı izin vermeyi reddetti
      // Burada uygun bir işlem yapılabilir, örneğin bir mesaj gösterilebilir
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Photo'),
      ),
      body: Center(
        child: _imagePath != null
            ? Image.file(
                File(_imagePath),
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              )
            : Text('No image selected'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImage,
        child: Icon(Icons.add_photo_alternate),
      ),
    );
  }
}
