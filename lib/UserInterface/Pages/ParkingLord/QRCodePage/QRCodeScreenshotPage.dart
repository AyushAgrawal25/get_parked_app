import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/EdgeLessButton.dart';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:getparked/UserInterface/Widgets/Loaders/LoaderPage.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart' as PathProvider;
import 'package:folder_file_saver/folder_file_saver.dart';

class QRCodeScreenShotPage extends StatefulWidget {
  RenderRepaintBoundary boundary;
  QRCodeScreenShotPage({@required this.boundary});
  @override
  _QRCodeScreenShotPageState createState() => _QRCodeScreenShotPageState();
}

class _QRCodeScreenShotPageState extends State<QRCodeScreenShotPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imgSize = 20;
    takeScreenshot();
  }

  double imgSize;

  File capturedImgFile;
  takeScreenshot() async {
    loadHandler(true);
    ui.Image image = await widget.boundary.toImage(pixelRatio: 5);
    final directory =
        (await PathProvider.getExternalStorageDirectories())[0].path;
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    capturedImgFile = new File('$directory/screenshot.png');
    capturedImgFile.writeAsBytes(pngBytes);

    try {
      await FolderFileSaver.requestPermission().then((permissionStatus) async {
        if (permissionStatus == 0) {
          String newFilePath = await FolderFileSaver.saveImage(
              pathImage: '$directory/screenshot.png');
        }
      });
    } catch (exp) {
      print(exp);
    }
    loadHandler(false);
    setState(() {
      imgSize = MediaQuery.of(context).size.width * 0.5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Scaffold(
            body: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  AnimatedContainer(
                    duration: Duration(microseconds: 1500),
                    child: Text(
                      "Captured !",
                      style: GoogleFonts.nunito(
                          color: qbDetailDarkColor,
                          fontSize: 30,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                      textScaleFactor: 1.0,
                    ),
                  ),
                  SizedBox(
                    height: imgSize * 0.15,
                  ),
                  // Picture
                  AnimatedContainer(
                      duration: Duration(milliseconds: 1500),
                      curve: Curves.bounceOut,
                      width: imgSize,
                      child: (capturedImgFile == null)
                          ? Container(child: CircularProgressIndicator())
                          : Image.file(
                              capturedImgFile,
                              width: imgSize,
                              fit: BoxFit.cover,
                            )),

                  SizedBox(
                    height: imgSize * 0.25,
                  ),

                  Container(
                    child: EdgeLessButton(
                      color: qbAppPrimaryBlueColor,
                      padding: EdgeInsets.symmetric(vertical: 7.5),
                      width: MediaQuery.of(context).size.width * 0.65,
                      child: Text(
                        "Continue",
                        style: GoogleFonts.nunito(
                            fontSize: 17.5,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                        textScaleFactor: 1.0,
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          (isLoading)
              ? LoaderPage()
              : Container(
                  height: 0,
                  width: 0,
                )
        ],
      ),
    );
  }

  bool isLoading = false;
  loadHandler(status) {
    setState(() {
      isLoading = status;
    });
  }
}
