import 'dart:io';

import 'package:getparked/BussinessLogic/ParkingLordServices.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/StateManagement/Models/ParkingLordData.dart';
import 'package:getparked/StateManagement/Models/SlotImageData.dart';
import 'package:getparked/UserInterface/Widgets/ImagePicker/ImagePickerAndInserter.dart';
import 'package:getparked/UserInterface/Pages/ParkingLord/ParkingLord.dart';
import 'package:getparked/UserInterface/Pages/ParkingLord/ParkingLordEdit/UIComponents/SlotImgGallery.dart';
import 'package:getparked/UserInterface/Pages/ParkingLord/ParkingLordEdit/UIComponents/SlotImgWidget.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/DisplayPicture.dart';
import 'package:getparked/UserInterface/Widgets/FormFieldHeader.dart';
import 'package:getparked/UserInterface/Widgets/UnderLineTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:getparked/Utils/DomainUtils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ParkingLordEdit extends StatefulWidget {
  Function(bool) changeLoadStatus;
  ParkingLordEdit({this.changeLoadStatus});
  @override
  _ParkingLordEditState createState() => _ParkingLordEditState();
}

class _ParkingLordEditState extends State<ParkingLordEdit> {
  AppState gpAppState;
  @override
  void initState() {
    super.initState();

    gpAppState = Provider.of(context, listen: false);
    gpSlotName = gpAppState.parkingLordData.name;
  }

  double horiPadding = 25;

  Widget slotImgWidget = Container(
    height: 0,
    width: 0,
  );
  setSlotImgWidget() {
    String slotImgUrl =
        formatImgUrl(gpAppState.parkingLordData.mainImage.imageUrl);
    slotImgWidget = Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: MediaQuery.of(context).size.width * 0.35 + 25,
      width: (MediaQuery.of(context).size.width * 0.35 * 6 / 5) + 35,
      child: DisplayPicture(
        imgUrl: slotImgUrl,
        iconButtonSize: 40,
        height: MediaQuery.of(context).size.width * 0.35,
        width: MediaQuery.of(context).size.width * 0.35 * 6 / 5,
        type: DisplayPictureType.slotMainImage,
        onEditPressed: onSlotMainImgEdit,
      ),
    );
  }

  String gpSlotName = "";
  Widget slotNameWidget = Container();
  setSlotNameWidget() {
    slotNameWidget = Container(
      padding: EdgeInsets.symmetric(horizontal: horiPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Icon
          Container(
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(360),
                    border: Border.all(width: 1.5, color: qbAppTextColor)),
                child: Icon(FontAwesome5.home,
                    color: qbAppPrimaryBlueColor, size: 17.5)),
          ),

          SizedBox(
            width: 12.5,
          ),

          // TextField
          Expanded(
            child: Container(
              child: UnderLineTextFormField(
                labelText: "Slot Name",
                value: gpSlotName,
                onChange: (value) {
                  setState(() {
                    gpSlotName = value;
                  });
                },
                showClearButton: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget slotImagesWidget = Container(
    height: 0,
    width: 0,
  );
  setSlotImagesWidget() {
    List<Widget> slotImgWidgets = [];
    double picMargin = 10;
    double contWidth =
        MediaQuery.of(context).size.width - 2 * (horiPadding - picMargin);
    int imgIn = 0;
    gpAppState.parkingLordData.images.forEach((slotImgData) {
      slotImgWidgets.add(SlotImgWidget(
        slotImageData: slotImgData,
        height: contWidth / 3,
        width: contWidth / 3,
        imgIndex: imgIn,
        horizontalMargin: picMargin,
        verticalMargin: picMargin,
        onPressed: onSlotImgTap,
      ));
      imgIn++;
    });

    // slotImgWidgets = [...slotImgWidgets, ...slotImgWidgets, ...slotImgWidgets];

    slotImgWidgets.add(GestureDetector(
      onTap: onAddImgTap,
      child: Container(
        height: contWidth / 3 - (2 * picMargin),
        width: contWidth / 3 - (2 * picMargin),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: qbDividerLightColor),
        margin:
            EdgeInsets.symmetric(vertical: picMargin, horizontal: picMargin),
        child: Icon(
          Icons.add,
          size: contWidth * 0.15,
          color: qbDividerDarkColor,
        ),
      ),
    ));

    slotImagesWidget = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: horiPadding - picMargin),
      alignment: Alignment.center,
      child: Container(
        width: contWidth,
        child: Wrap(
          alignment: WrapAlignment.start,
          direction: Axis.horizontal,
          crossAxisAlignment: WrapCrossAlignment.center,
          runAlignment: WrapAlignment.spaceBetween,
          children: slotImgWidgets,
        ),
      ),
    );
  }

  bool isFormValid = true;
  checkFormValidity() {
    isFormValid = true;
    if ((gpSlotName == null) || (gpSlotName == "")) {
      isFormValid = false;
    }

    bool isChangesMade = false;
    if (gpSlotName != gpAppState.parkingLordData.name) {
      isChangesMade = true;
    }

    if (!isChangesMade) {
      isFormValid = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    AppState gpAppStateListen = Provider.of<AppState>(context);
    checkFormValidity();
    setSlotImgWidget();
    setSlotNameWidget();
    setSlotImagesWidget();
    return Container(
      child: SafeArea(
        top: false,
        maintainBottomViewPadding: true,
        child: Container(
          child: Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  Icon(
                    FontAwesome.edit,
                    size: 20,
                    color: qbAppTextColor,
                  ),
                  SizedBox(
                    width: 12.5,
                  ),
                  Text(
                    "Edit",
                    style: GoogleFonts.nunito(
                        color: qbAppTextColor, fontWeight: FontWeight.w600),
                    textScaleFactor: 1.0,
                  ),
                ],
              ),
              actions: [
                GestureDetector(
                  onTap: onSavePressed,
                  child: Container(
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Save",
                      style: GoogleFonts.nunito(
                          fontSize: 17.5,
                          fontWeight: FontWeight.w500,
                          color: (isFormValid)
                              ? qbAppPrimaryBlueColor
                              : qbDividerDarkColor),
                      textScaleFactor: 1.0,
                    ),
                  ),
                ),
              ],
              backgroundColor: qbWhiteBGColor,
              elevation: 0.0,
              iconTheme: IconThemeData(color: qbAppTextColor),
              brightness: Brightness.light,
            ),
            body: Container(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      slotImgWidget,
                      SizedBox(
                        height: 10,
                      ),
                      slotNameWidget,
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: qbDividerLightColor,
                        thickness: 1.5,
                        height: 20,
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: horiPadding, vertical: 10),
                          alignment: Alignment.centerLeft,
                          child: FormFieldHeader(headerText: "Slot Images")),
                      slotImagesWidget
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  onSavePressed() async {
    SystemSound.play(SystemSoundType.click);
    if (isFormValid) {
      widget.changeLoadStatus(true);
      await ParkingLordServices().updateDetails(
          authToken: gpAppState.authToken,
          name: gpSlotName,
          appState: gpAppState);
      widget.changeLoadStatus(false);
      Navigator.of(context).pop();
    }
  }

  onSlotMainImgEdit() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return ImagePickerAndInserter(
          imgUrl: formatImgUrl(gpAppState.parkingLordData.mainImage.imageUrl),
          onImageInsert: onNewMainImgInsert,
          cropRatioX: 4,
          cropRatioY: 3,
        );
      },
    ));
  }

  onNewMainImgInsert(File newImgFile) async {
    if (newImgFile != null) {
      SlotImageUpdateStatus imageUpdateStatus = await ParkingLordServices()
          .updateSlotImage(
              type: SlotImageType.main,
              imgFile: newImgFile,
              slotImageId: gpAppState.parkingLordData.mainImage.id,
              authToken: gpAppState.authToken);
      if (imageUpdateStatus == SlotImageUpdateStatus.successful) {
        // TODO: solve this cache image issues.
        ParkingLordServices().getParkingLord(context: context);
      }
    }
  }

  onSlotImgTap(SlotImageData slotImageData, int index) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return SlotImgGallery(
        focusIndex: index,
      );
    }));
  }

  onAddImgTap() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return ImagePickerAndInserter(
          onImageInsert: onNewImgInsert,
          cropRatioX: 4,
          cropRatioY: 3,
        );
      },
    ));
  }

  onNewImgInsert(File imgFile) async {
    SlotImageUploadStatus imageUploadStatus = await ParkingLordServices()
        .uploadSlotImage(
            type: SlotImageType.other,
            imgFile: imgFile,
            authToken: gpAppState.authToken);
    if (imageUploadStatus == SlotImageUploadStatus.successful) {
      ParkingLordServices().getParkingLord(context: context);
    }
  }
}
