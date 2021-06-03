import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerTest extends StatefulWidget {
  @override
  _ImagePickerTestState createState() => _ImagePickerTestState();
}

class _ImagePickerTestState extends State<ImagePickerTest> {
  File _image;

  Future _getImage() async {
    File image;
    PickedFile _pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (_pickedFile != null) {
      image = File(_pickedFile.path);
    }

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: FloatingActionButton(
            child: Text(
              "Add",
              textScaleFactor: 1.0,
            ),
            onPressed: () {
              _getImage();
            },
          ),
        ),
      ),
    );
  }
}
