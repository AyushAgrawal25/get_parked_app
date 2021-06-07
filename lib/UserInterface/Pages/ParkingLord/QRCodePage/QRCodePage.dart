import 'dart:convert';

import 'package:getparked/Utils/EncryptionUtils.dart';
import 'package:getparked/Utils/DomainUtils.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/StateManagement/Models/UserDetails.dart';
import 'package:getparked/UserInterface/Icons/g_p_icons_icons.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/CustomIcon.dart';
import 'package:getparked/UserInterface/Widgets/DisplayPicture.dart';
import 'package:getparked/UserInterface/Widgets/EdgeLessButton.dart';
import 'package:getparked/UserInterface/Widgets/Rating/RatingWidget.dart';
import 'package:getparked/UserInterface/Widgets/SlotNameWidget.dart';
import 'package:getparked/UserInterface/Widgets/qbFAB.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart' as PathProvider;
import 'package:folder_file_saver/folder_file_saver.dart';
import 'package:getparked/UserInterface/Pages/ParkingLord/QRCodePage/QRCodeScreenshotPage.dart';

class QRCodePage extends StatefulWidget {
  @override
  _QRCodePageState createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {
  static GlobalKey previewContainer = new GlobalKey();

  AppState gpAppState;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gpAppState = Provider.of<AppState>(context, listen: false);
  }

  Widget lordUserDetailsWidget = Container();
  setLordUserDetailsWidget() {
    lordUserDetailsWidget = Container(
      child: Row(
        children: [
          Container(
            child: DisplayPicture(
              imgUrl:
                  formatImgUrl(gpAppState.userDetails.profilePicThumbnailUrl),
              type:
                  (gpAppState.userDetails.getGenderType() == UserGender.female)
                      ? DisplayPictureType.profilePictureFemale
                      : DisplayPictureType.profilePictureMale,
              height: 40,
              width: 40,
              isEditable: false,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    child: Text(
                      gpAppState.userDetails.firstName.trim() +
                          " " +
                          gpAppState.userDetails.lastName.trim(),
                      style: GoogleFonts.roboto(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: qbAppTextColor),
                      overflow: TextOverflow.ellipsis,
                      textScaleFactor: 1.0,
                    ),
                  ),
                  SizedBox(
                    height: 1.5,
                  ),
                  Container(
                      child: RatingWidget(
                          fontSize: 12.5,
                          iconSize: 13,
                          ratingValue: gpAppState.parkingLordData.rating))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget appLogoName = Container();
  setAppLogoName() {
    appLogoName = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: CustomIcon(
              icon: GPIcons.get_parked_logo,
              color: qbWhiteBGColor,
              size: 37.5,
            ),
          ),
          SizedBox(
            width: 7.5,
          ),
          Container(
            padding: EdgeInsets.only(top: 5),
            child: Text(
              appName,
              style: GoogleFonts.josefinSans(
                  fontSize: 37.5,
                  fontWeight: FontWeight.w600,
                  color: qbWhiteBGColor),
              textScaleFactor: 1.0,
            ),
          ),
          SizedBox(
            width: 7.5,
          ),
        ],
      ),
    );
  }

  Widget edgelessScreenshotButton = Container();
  setEdgeLessScreenshotButton() {
    edgelessScreenshotButton = Container(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: EdgeLessButton(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 7.5),
          width: MediaQuery.of(context).size.width * 0.65,
          alignment: Alignment.center,
          child: Text(
            "Screenshot",
            style: GoogleFonts.nunito(
                fontWeight: FontWeight.w500,
                color: qbWhiteBGColor,
                fontSize: 17.5),
            textScaleFactor: 1.0,
          ),
        ),
        border: Border.all(color: qbWhiteBGColor, width: 2),
        color: qbAppPrimaryGreenColor,
        onPressed: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    setLordUserDetailsWidget();
    setAppLogoName();
    double posterWidth = MediaQuery.of(context).size.width * 0.8;
    double slotImgSize = posterWidth * 0.4;
    AppState gpAppStateListen = Provider.of<AppState>(context);
    Map<String, dynamic> slotDataForEnc = {
      "slotId": gpAppState.parkingLordData.id,
      "slotUserId": gpAppState.parkingLordData.userId
    };
    String encryptedSlotToken =
        EncryptionUtils.aesEncryption(json.encode(slotDataForEnc));
    return Container(
      child: Stack(
        children: [
          Container(
            child: SafeArea(
              top: false,
              maintainBottomViewPadding: true,
              child: Container(
                child: Scaffold(
                  appBar: AppBar(
                    title: Row(
                      children: [
                        Icon(
                          MdiIcons.qrcode,
                          size: 20,
                        ),
                        SizedBox(
                          width: 12.5,
                        ),
                        Text(
                          "QR Code",
                          style:
                              GoogleFonts.nunito(fontWeight: FontWeight.w500),
                          textScaleFactor: 1.0,
                        )
                      ],
                    ),
                    brightness: Brightness.dark,
                    backgroundColor: qbAppPrimaryThemeColor,
                    elevation: 0.0,
                  ),
                  backgroundColor: qbAppPrimaryThemeColor,
                  body: SingleChildScrollView(
                    child: RepaintBoundary(
                      key: previewContainer,
                      child: Container(
                        alignment: Alignment.center,
                        color: qbAppPrimaryThemeColor,
                        padding: EdgeInsets.symmetric(vertical: 30),
                        child: Container(
                          width: posterWidth,
                          child: Column(
                            children: [
                              appLogoName,
                              SizedBox(
                                height: 12.5,
                              ),
                              Container(
                                child: Stack(
                                  children: [
                                    // BG
                                    Positioned.fill(
                                      child: Container(
                                        width: posterWidth,
                                        margin: EdgeInsets.only(
                                            top: slotImgSize * 0.5),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: qbWhiteBGColor,
                                            boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 10,
                                                  spreadRadius: 1,
                                                  offset: Offset(2, 4),
                                                  color: Color.fromRGBO(
                                                      0, 0, 0, 0.1))
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                      ),
                                    ),

                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 25),
                                      child: Column(
                                        children: [
                                          Container(
                                            alignment: Alignment.topCenter,
                                            child: DisplayPicture(
                                              imgUrl: formatImgUrl(gpAppState
                                                  .parkingLordData
                                                  .mainImage
                                                  .imageUrl),
                                              height: slotImgSize,
                                              width: slotImgSize * 1.1,
                                              isEditable: false,
                                              isElevated: true,
                                              type: DisplayPictureType
                                                  .slotMainImage,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 12.5,
                                          ),
                                          Container(
                                            child: Text(
                                              gpAppState.parkingLordData.name,
                                              style: GoogleFonts.mukta(
                                                  fontSize: 20,
                                                  height: 1.25,
                                                  letterSpacing: 0.75,
                                                  fontWeight: FontWeight.w500,
                                                  color: qbDetailDarkColor),
                                              textScaleFactor: 1.0,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Text(
                                              gpAppState
                                                  .parkingLordData.address,
                                              style: GoogleFonts.roboto(
                                                  fontSize: 12.5,
                                                  letterSpacing: 0.75,
                                                  fontWeight: FontWeight.w500,
                                                  color: qbDetailLightColor),
                                              textScaleFactor: 1.0,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 10),
                                            height: posterWidth * 0.675,
                                            width: posterWidth * 0.675,
                                            child: QrImage(
                                              data: encryptedSlotToken,
                                            ),
                                          ),
                                          Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: lordUserDetailsWidget),
                                          SizedBox(
                                            height: 30,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
              alignment: Alignment(0, 0.95),
              child: EdgeLessButton(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 40),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Capture",
                        style: GoogleFonts.nunito(
                            color: qbWhiteBGColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                        textScaleFactor: 1.0,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        height: 25,
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            Icon(
                              MdiIcons.cropFree,
                              size: 20,
                              color: qbWhiteBGColor,
                            ),
                            Positioned.fill(
                              child: Container(
                                child: Icon(
                                  MdiIcons.imageOutline,
                                  size: 12.5,
                                  color: qbWhiteBGColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                color: qbAppPrimaryBlueColor,
                onPressed: takeScreenshot,
              )),
        ],
      ),
    );
  }

  bool isLoading = false;
  loadHandler(bool status) {
    setState(() {
      isLoading = status;
    });
  }

  takeScreenshot() async {
    RenderRepaintBoundary boundary =
        previewContainer.currentContext.findRenderObject();
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return QRCodeScreenShotPage(
          boundary: boundary,
        );
      },
    ));
  }
}
