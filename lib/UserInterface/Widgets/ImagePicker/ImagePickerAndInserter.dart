import 'dart:io';
import 'package:getparked/StateManagement/Models/AppOverlayStyleData.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/UserInterface/Widgets/Loaders/LoaderPage.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:fluttericon/entypo_icons.dart';

class ImagePickerAndInserter extends StatefulWidget {
  Function(File) onImageInsert;
  Function onCancel;
  String imgUrl;
  File imgFile;
  double cropRatioX;
  double cropRatioY;

  ImagePickerAndInserter(
      {@required this.onImageInsert,
      this.onCancel,
      this.imgUrl,
      this.imgFile,
      this.cropRatioX: 1,
      this.cropRatioY: 1});
  @override
  _ImagePickerAndInserterState createState() => _ImagePickerAndInserterState();
}

class _ImagePickerAndInserterState extends State<ImagePickerAndInserter> {
  AppState gpAppState;
  bool isLoading = false;

  loadHandler(loadingStatus) {
    setState(() {
      isLoading = loadingStatus;
    });
  }

  @override
  void initState() {
    super.initState();

    gpAppState = Provider.of<AppState>(context, listen: false);
    if (widget.imgFile != null) {
      crpImg = widget.imgFile;
      orgImg = widget.imgFile;
      // isImageSelected = true;
    }
  }

  bool isImageSelected = false;
  Widget imageActionButtons = Container();
  setImageActionButtons() {
    if (isImageSelected) {
      imageActionButtons = Container(
        height: 55,
        child: Row(
          children: [
            Expanded(
              child: TransparentButton(
                child: Text(
                  "Done",
                  style: GoogleFonts.nunito(
                      color: qbWhiteBGColor,
                      fontSize: 17.5,
                      fontWeight: FontWeight.w500),
                  textScaleFactor: 1.0,
                ),
                onPressed: onDoneClick,
              ),
            ),
            Expanded(
              child: TransparentButton(
                child: Text(
                  "Cancel",
                  style: GoogleFonts.nunito(
                      color: qbWhiteBGColor,
                      fontSize: 17.5,
                      fontWeight: FontWeight.w500),
                  textScaleFactor: 1.0,
                ),
                onPressed: onCancelClick,
              ),
            ),
          ],
        ),
      );
    } else {
      imageActionButtons = Container(
        height: 55,
        child: Row(
          children: [
            Expanded(
              child: TransparentButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Typicons.camera_outline,
                      color: qbWhiteBGColor,
                      size: 17.5,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Camera",
                      style: GoogleFonts.nunito(
                          color: qbWhiteBGColor,
                          fontSize: 17.5,
                          fontWeight: FontWeight.w500),
                      textScaleFactor: 1.0,
                    ),
                  ],
                ),
                onPressed: onCameraClick,
              ),
            ),
            Expanded(
              child: TransparentButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Entypo.picture,
                      color: qbWhiteBGColor,
                      size: 17.5,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Gallery",
                      style: GoogleFonts.nunito(
                          color: qbWhiteBGColor,
                          fontSize: 17.5,
                          fontWeight: FontWeight.w500),
                      textScaleFactor: 1.0,
                    ),
                  ],
                ),
                onPressed: onGalleryClick,
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget imageWidget = Container(
    height: 0,
    width: 0,
  );
  setImageWidget() {
    if ((isImageSelected) && (crpImg != null)) {
      // Image Selected
      imageWidget = GestureDetector(
        onTap: () {
          SystemSound.play(SystemSoundType.click);
          onImageClick();
        },
        child: Container(
          child: Image.file(
            crpImg,
            height: MediaQuery.of(context).size.width *
                widget.cropRatioY /
                widget.cropRatioX,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
        ),
      );
    } else {
      if (widget.imgFile != null) {
        // Default Image Provided
        imageWidget = GestureDetector(
          onTap: () {
            SystemSound.play(SystemSoundType.click);
            onImageClick();
          },
          child: Container(
            child: Image.file(
              widget.imgFile,
              height: MediaQuery.of(context).size.width *
                  widget.cropRatioY /
                  widget.cropRatioX,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
        );
      } else if (widget.imgUrl != null) {
        imageWidget = Container(
          child: CachedNetworkImage(
            imageUrl: widget.imgUrl,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
        );
      } else {
        imageWidget = Container(
          height: MediaQuery.of(context).size.width,
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
          alignment: Alignment.center,
          child: Text(
            "No Image For Preview",
            style: GoogleFonts.nunito(
                fontSize: 17.5,
                fontWeight: FontWeight.w500,
                color: qbWhiteBGColor),
            textScaleFactor: 1.0,
          ),
        );
      }
    }
  }

  File orgImg;
  File crpImg;

  _cropImage() async {
    if (orgImg != null) {
      File croppedImg = await ImageCropper.cropImage(
          sourcePath: orgImg.path,
          // cropStyle: CropStyle.circle,
          aspectRatio: CropAspectRatio(
              ratioX: widget.cropRatioX, ratioY: widget.cropRatioY),
          maxHeight: 700,
          maxWidth: 700,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            toolbarColor: Color.fromRGBO(0, 0, 0, 0.9),
            toolbarTitle: "Cropper",
            toolbarWidgetColor: Colors.white,
            statusBarColor: Color.fromRGBO(0, 0, 0, 0.9),
            backgroundColor: Colors.black,
            cropFrameColor: qbWhiteBGColor,
            cropGridColor: qbWhiteBGColor,
            activeControlsWidgetColor: Colors.red,
          ));
      if (croppedImg != null) {
        setState(() {
          isImageSelected = true;
        });
        crpImg = croppedImg;
      }
    }
  }

  _pickImage(ImageSource source) async {
    File pickedImage;
    PickedFile _pickedFile = await ImagePicker().getImage(source: source);

    if (_pickedFile != null) {
      pickedImage = File(_pickedFile.path);
    }
    if (pickedImage != null) {
      orgImg = pickedImage;
      await _cropImage();
    }
  }

  // On Camera Click
  onCameraClick() async {
    setState(() {
      isLoading = true;
    });
    await _pickImage(ImageSource.camera);
    if ((orgImg != null) && (crpImg != null)) {
      isImageSelected = true;
    } else {
      isImageSelected = false;
    }
    setState(() {
      isLoading = false;
    });
  }

  // On Gallery Click
  onGalleryClick() async {
    setState(() {
      isLoading = true;
    });
    await _pickImage(ImageSource.gallery);
    if ((orgImg != null) && (crpImg != null)) {
      isImageSelected = true;
    } else {
      isImageSelected = false;
    }
    setState(() {
      isLoading = false;
    });
  }

  // On Done Click
  onDoneClick() async {
    setState(() {
      isLoading = true;
    });
    await widget.onImageInsert(crpImg);
    setState(() {
      isLoading = true;
    });
    Navigator.of(context).pop();
  }

  // On Cancel Click
  onCancelClick() {
    if (widget.onCancel != null) {
      widget.onCancel();
    }
    Navigator.of(context).pop();
  }

  // On Image Click
  onImageClick() async {
    setState(() {
      isLoading = true;
    });

    await _cropImage();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    setImageActionButtons();
    setImageWidget();
    gpAppState.applySpecificOverlayStyle(AppOverlayStyleType.blackBG);
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Icon(
                  Typicons.picture,
                  size: 17.5,
                  color: qbWhiteBGColor,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Insert Image",
                  style: GoogleFonts.nunito(
                      color: qbWhiteBGColor, fontWeight: FontWeight.w600),
                  textScaleFactor: 1.0,
                ),
              ],
            ),
            backgroundColor: Color.fromRGBO(255, 255, 255, 0.1),
            // elevation: 0.0,
            iconTheme: IconThemeData(color: qbWhiteBGColor),
            brightness: Brightness.dark,
          ),
          backgroundColor: Colors.black,
          body: Container(
            padding: EdgeInsets.only(top: 28),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 78),
                  alignment: Alignment.center,
                  child: InteractiveViewer(child: imageWidget),
                ),

                // Buttons
                Align(
                  alignment: Alignment.bottomCenter,
                  child: imageActionButtons,
                )
              ],
            ),
          ),
        ),
        (isLoading)
            ? Container(
                color: Color.fromRGBO(0, 0, 0, 0.25),
                alignment: Alignment.center,
                child: Container(
                  height: 55,
                  width: 55,
                  child: CircularProgressIndicator(
                    strokeWidth: 10,
                  ),
                ),
              )
            : Container(
                height: 0,
                width: 0,
              ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class TransparentButton extends StatelessWidget {
  Widget child;
  Function onPressed;
  TransparentButton({@required this.child, @required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          SystemSound.play(SystemSoundType.click);
          if (onPressed != null) {
            this.onPressed();
          }
        },
        child: Container(
            color: Color.fromRGBO(255, 255, 255, 0.1),
            alignment: Alignment.center,
            child: this.child),
      ),
    );
  }
}
