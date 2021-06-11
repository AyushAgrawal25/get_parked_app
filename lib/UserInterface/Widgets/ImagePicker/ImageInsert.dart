import 'dart:io';
import 'package:getparked/StateManagement/Models/AppOverlayStyleData.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/UserInterface/Widgets/Loaders/LoaderPage.dart';
import 'package:provider/provider.dart';
import '../../Theme/AppOverlayStyle.dart';

import 'package:getparked/Utils/DomainUtils.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/entypo_icons.dart';
import './../../Widgets/EdgeLessButton.dart';
import './../../Theme/AppTheme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

enum ImageInsertType { profilePic, slotMainImage, slotImages }

class ImageInsertPage extends StatefulWidget {
  ImageInsertType imageInsertType;
  Function(File) onImageInsert;

  ImageInsertPage({this.imageInsertType, @required this.onImageInsert});

  @override
  _ImageInsertPageState createState() => _ImageInsertPageState();
}

class _ImageInsertPageState extends State<ImageInsertPage> {
  Widget imageWidget = Container(
      color: Color.fromRGBO(250, 250, 250, 1),
      height: 280,
      width: 280,
      child: Image.asset('assets/images/female.png'));

  File profilePicture;
  File originalPicture;

  Future _getImage(ImageSource source) async {
    //Start Loading
    setState(() {
      isLoading = true;
    });

    File image;
    PickedFile _pickedFile = await ImagePicker().getImage(source: source);
    if (_pickedFile != null) {
      image = File(_pickedFile.path);
    }

    //Stop Loading
    setState(() {
      isLoading = false;
    });

    if (image != null) {
      //Start Loading
      setState(() {
        isLoading = true;
      });

      File croppedImage = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          maxHeight: 700,
          maxWidth: 700,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            toolbarColor: qbAppPrimaryThemeColor,
            toolbarTitle: "Image Cropper",
            toolbarWidgetColor: Colors.white,
            statusBarColor: qbAppPrimaryThemeColor,
            backgroundColor: Colors.white,
            activeControlsWidgetColor: Colors.white,
          ));

      //Setting Image And Stop Loading
      setState(() {
        originalPicture = image;
        profilePicture = croppedImage;
        isLoading = false;
      });
    }
  }

  Future _cropImage() async {
    SystemSound.play(SystemSoundType.click);
    if (originalPicture != null) {
      //Start Loading
      setState(() {
        isLoading = true;
      });

      File croppedImage = await ImageCropper.cropImage(
          sourcePath: originalPicture.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          maxHeight: 700,
          maxWidth: 700,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            toolbarColor: qbAppPrimaryThemeColor,
            toolbarTitle: "Image Cropper",
            toolbarWidgetColor: Colors.white,
            statusBarColor: qbAppPrimaryThemeColor,
            backgroundColor: Colors.white,
            activeControlsWidgetColor: Colors.white,
          ));

      //Set Profile Picture And Stop Loading
      setState(() {
        profilePicture = croppedImage;
        isLoading = false;
      });
    }
  }

  bool isLoading = false;

  AppState gpAppState;
  @override
  void initState() {
    super.initState();

    gpAppState = Provider.of(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    if (profilePicture != null) {
      imageWidget = GestureDetector(
        child: Image.file(
          profilePicture,
          height: 280,
          width: 280,
          fit: BoxFit.cover,
        ),
        onTap: () {
          _cropImage();
        },
      );
    }

    //Template
    if (isLoading) {
      return LoaderPage();
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Insert Image",
            style: GoogleFonts.nunito(
                fontSize: 20,
                color: qbAppTextColor,
                fontWeight: FontWeight.w600),
            textScaleFactor: 1.0,
          ),
          iconTheme: IconThemeData(color: qbAppTextColor),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        backgroundColor: Colors.white,
        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                  child: Center(
                child: IntrinsicHeight(
                  child: Column(
                    children: <Widget>[
                      //Image Container
                      Container(
                        child: imageWidget,
                      ),

                      //Buttons
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            //Camaera Button
                            EdgeLessButton(
                              color: qbAppPrimaryThemeColor,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(right: 5),
                                      child: Icon(
                                        Icons.camera,
                                        size: 17.5,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "Camera",
                                        style: GoogleFonts.nunito(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                        textScaleFactor: 1.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onPressed: () {
                                _getImage(ImageSource.camera);
                              },
                            ),

                            //Gallery Button
                            EdgeLessButton(
                              color: qbAppPrimaryThemeColor,
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(right: 10),
                                        child: Icon(
                                          Entypo.picture,
                                          size: 17.5,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(right: 5),
                                        child: Text(
                                          "Gallery",
                                          style: GoogleFonts.nunito(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                          textScaleFactor: 1.0,
                                        ),
                                      ),
                                    ],
                                  )),
                              onPressed: () {
                                _getImage(ImageSource.gallery);
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
                child: EdgeLessButton(
                  color: qbAppPrimaryBlueColor,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: IntrinsicWidth(
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Icon(
                              Entypo.picture,
                              size: 22.5,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            child: Text(
                              "Insert Image",
                              style: GoogleFonts.nunito(
                                  fontSize: 17.5,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                              textScaleFactor: 1.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onPressed: () async {
                    if (profilePicture != null) {
                      widget.onImageInsert(profilePicture);
                      Navigator.pop(context);
                    } else {
                      print("Insert Image..");
                    }
                  },
                ),
              )
            ],
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
