import 'package:getparked/StateManagement/Models/AppOverlayStyleData.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/StateManagement/Models/SlotData.dart';
import 'package:getparked/UserInterface/Icons/g_p_icons_icons.dart';
import 'package:getparked/UserInterface/Widgets/ErrorPopUp.dart';
import 'package:getparked/UserInterface/Widgets/FormFieldHeader.dart';
import 'package:provider/provider.dart';
import '../../../Theme/AppOverlayStyle.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/CustomIcon.dart';
import 'package:getparked/UserInterface/Widgets/EdgeLessButton.dart';
import 'package:getparked/UserInterface/Widgets/RadioTileButton.dart';
import 'package:getparked/UserInterface/Widgets/UnderLineTextFormField.dart';
import 'package:getparked/UserInterface/Widgets/qbFAB.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/linearicons_free_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'dart:io';
import 'package:getparked/UserInterface/Widgets/ImagePicker/ImagePickerAndInserter.dart';

class ParkingSlotSpecs extends StatefulWidget {
  Function(File, SlotData) onContinuePressed;

  ParkingSlotSpecs({this.onContinuePressed});
  @override
  _ParkingSlotSpecsState createState() => _ParkingSlotSpecsState();
}

class _ParkingSlotSpecsState extends State<ParkingSlotSpecs> {
  List<DropdownMenuItem<String>> startTimeList = [];
  String startTimeVal;

  List<DropdownMenuItem<String>> endTimeList = [];
  String endTimeVal;

  AppState gpAppState;

  @override
  void initState() {
    super.initState();
    gpAppState = Provider.of(context, listen: false);

    initTimeDropDown();
  }

  bool isFormEntriesValid = true;

  File gpMainSlotImgFile;
  Widget mainSlotImageWidget = Container(
    height: 0,
    width: 0,
  );
  setMainSlotImageWidgt() {
    mainSlotImageWidget = Container(
      height: 150,
      width: 175,
      child: Stack(
        children: [
          //SlotPic
          Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 140,
                width: 140,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(220, 220, 220, 1)),
              )),
          (gpMainSlotImgFile != null)
              ? Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        gpMainSlotImgFile,
                        fit: BoxFit.cover,
                        height: 140,
                        width: 140,
                      ),
                    ),
                  ),
                )
              : Container(
                  height: 0,
                  width: 0,
                ),

          Positioned(
            right: 0,
            bottom: 0,
            child: QbFAB(
              child: Icon(
                MdiIcons.cameraPlus,
                color: Colors.white,
                size: 25,
              ),
              size: 50,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return ImagePickerAndInserter(
                        cropRatioX: 4,
                        cropRatioY: 3,
                        imgUrl: null,
                        imgFile: gpMainSlotImgFile,
                        onImageInsert: onMainSlotImgInsert);
                  },
                ));
              },
            ),
          ),
        ],
      ),
    );
  }

  onMainSlotImgInsert(File imgFile) {
    setState(() {
      gpMainSlotImgFile = imgFile;
    });
  }

  String gpSlotName;
  Widget slotNameInputField = Container(
    height: 0,
    width: 0,
  );

  setSlotNameInputField() {
    slotNameInputField = Container(
      margin: EdgeInsets.only(bottom: 12.5),
      child: TextFormField(
        minLines: 1,
        maxLines: 1,
        onChanged: (value) {
          setState(() {
            gpSlotName = value;
          });
        },
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(width: 1, color: qbAppTextColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    BorderSide(width: 1.5, color: qbAppSecondaryBlueColor)),
            labelText: "Enter your Slot Name",
            labelStyle: GoogleFonts.roboto(
              fontSize: 15,
              color: qbAppTextColor,
              fontWeight: FontWeight.w500,
            ),
            contentPadding:
                EdgeInsets.only(left: 25, right: 25, top: 12.5, bottom: 12.5),
            alignLabelWithHint: false,
            isDense: true),
      ),
    );
  }

  int gpStartTime;
  int gpEndTime;
  Widget activeParkingTimeWidget = Container(
    height: 0,
    width: 0,
  );
  setActiveParkingTimeWidget() {
    activeParkingTimeWidget = Container(
      margin: EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //Title
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "Active Parking Time",
              style: GoogleFonts.nunito(
                  fontSize: 17.5,
                  fontWeight: FontWeight.w700,
                  color: qbAppTextColor),
              textScaleFactor: 1,
            ),
          ),

          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 100,
                  height: 45,
                  child: DropdownButton(
                    value: startTimeVal,
                    items: startTimeList,
                    onChanged: (value) {
                      print(value);
                      gpStartTime = int.parse(value);
                      setState(() {
                        startTimeVal = value;
                      });

                      setEndTimeList(value);
                    },
                  ),
                ),
                Container(
                  child: Text(
                    "To",
                    style: GoogleFonts.nunito(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: qbAppTextColor),
                    textScaleFactor: 1,
                  ),
                ),
                Container(
                  width: 100,
                  child: DropdownButton(
                    value: endTimeVal,
                    items: endTimeList,
                    onChanged: (value) {
                      gpEndTime = int.parse(value);
                      setState(() {
                        endTimeVal = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  int gpParkingSpaceType;
  Widget parkingSpaceTypeWidget = Container(
    height: 0,
    width: 0,
  );
  setParkingSpaceTypeWidget() {
    parkingSpaceTypeWidget = Container(
      margin: EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //Title
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Text("Parking Space Types",
                style: GoogleFonts.nunito(
                    fontSize: 17.5,
                    fontWeight: FontWeight.w700,
                    color: qbAppTextColor),
                textScaleFactor: 1),
          ),

          Container(
            child: Row(
              children: [
                Container(
                  child: RadioTileButton(
                    value: "1",
                    groupValue: gpParkingSpaceType.toString(),
                    onChanged: (String value) {
                      setState(() {
                        gpParkingSpaceType = int.parse(value);
                      });
                    },
                    title: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      child: Text("Sheded",
                          style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: qbAppTextColor),
                          textScaleFactor: 1),
                    ),
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
                Container(
                  child: RadioTileButton(
                    value: "2",
                    groupValue: gpParkingSpaceType.toString(),
                    onChanged: (String value) {
                      setState(() {
                        gpParkingSpaceType = int.parse(value);
                      });
                    },
                    title: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      child: Text("Open",
                          style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: qbAppTextColor),
                          textScaleFactor: 1),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  double gpSpaceHeight;
  double gpSpaceBreadth;
  double gpSpaceLength;
  Widget parkingDimensionsWidget = Container(
    height: 0,
    width: 0,
  );
  setParkingDimensionsWidget() {
    parkingDimensionsWidget = Container(
      margin: EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //Title
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            alignment: Alignment.centerLeft,
            child: FormFieldHeader(
              headerText: "Parking Area Dimensions",
              fontSize: 17.5,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            alignment: Alignment.centerLeft,
            child: FormFieldHeader(
              headerText: "Fill Length, Breadth and Height of your space.",
              fontSize: 12.5,
              color: qbDetailLightColor,
            ),
          ),

          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: UnderLineTextFormField(
                    labelText: "Length",
                    keyboardType: TextInputType.number,
                    contentPadding:
                        EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                    onChange: (value) {
                      setState(() {
                        if ((value != null) && (value != "")) {
                          gpSpaceLength = double.parse(value);
                        } else {
                          gpSpaceLength = 0.0;
                        }
                      });
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: Icon(
                    LineariconsFree.cross,
                    size: 17.5,
                    color: qbAppTextColor,
                  ),
                ),
                Expanded(
                  child: UnderLineTextFormField(
                      labelText: "Breadth",
                      keyboardType: TextInputType.number,
                      onChange: (value) {
                        setState(() {
                          if ((value != null) && (value != "")) {
                            gpSpaceBreadth = double.parse(value);
                          } else {
                            gpSpaceBreadth = 0.0;
                          }
                        });
                      },
                      contentPadding: EdgeInsets.only(
                          left: 5, right: 5, top: 5, bottom: 5)),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: Icon(
                    LineariconsFree.cross,
                    size: 17.5,
                    color: qbAppTextColor,
                  ),
                ),
                Expanded(
                  child: UnderLineTextFormField(
                      labelText: "Height",
                      keyboardType: TextInputType.number,
                      onChange: (value) {
                        setState(() {
                          if ((value != null) && (value != "")) {
                            gpSpaceHeight = double.parse(value);
                          } else {
                            gpSpaceHeight = 0.0;
                          }
                        });
                      },
                      contentPadding: EdgeInsets.only(
                          left: 5, right: 5, top: 5, bottom: 5)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget continueBtn = Container(
    height: 0,
    width: 0,
  );
  setContinueBtn() {
    continueBtn = Container(
        margin: EdgeInsets.symmetric(vertical: 1.5, horizontal: 2.5),
        child: EdgeLessButton(
            child: Text(
              "Continue",
              style: GoogleFonts.nunito(
                  fontSize: 16.5,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
              textAlign: TextAlign.center,
              textScaleFactor: 1.0,
            ),
            color: (isFormEntriesValid)
                ? qbAppPrimaryBlueColor
                : qbDividerDarkColor,
            width: MediaQuery.of(context).size.width * 0.6,
            padding: EdgeInsets.symmetric(vertical: 8.5),
            onPressed: onContinuePressed));
  }

  checkFormEntries() {
    isFormEntriesValid = true;

    // Check Img File
    if (gpMainSlotImgFile == null) {
      isFormEntriesValid = false;
    }

    // Check For Name
    if ((gpSlotName == null) && (gpSlotName == "")) {
      isFormEntriesValid = false;
    }

    // Check Parking Time
    if ((gpStartTime == null) && (gpEndTime == null)) {
      isFormEntriesValid = false;
    }

    // Parking Space Types
    if ((gpParkingSpaceType != 1) && (gpParkingSpaceType != 2)) {
      isFormEntriesValid = false;
    }

    // Parking Dimensions
    if ((gpSpaceBreadth == null) ||
        (gpSpaceHeight == null) ||
        (gpSpaceLength == null) ||
        (gpSpaceBreadth == 0.0) ||
        (gpSpaceHeight == 0.0) ||
        (gpSpaceLength == 0.0)) {
      isFormEntriesValid = false;
    }
  }

  onContinuePressed() {
    if (isFormEntriesValid) {
      SlotData gpSlotData = SlotData();
      gpSlotData.name = gpSlotName;
      gpSlotData.startTime = gpStartTime;
      gpSlotData.endTime = gpEndTime;
      gpSlotData.spaceType =
          (gpParkingSpaceType == 1) ? SlotSpaceType.sheded : SlotSpaceType.open;
      gpSlotData.length = gpSpaceLength;
      gpSlotData.breadth = gpSpaceBreadth;
      gpSlotData.height = gpSpaceHeight;

      widget.onContinuePressed(gpMainSlotImgFile, gpSlotData);
    } else {
      if (gpMainSlotImgFile == null) {
        // Error Pop Up For Image
        ErrorPopUp().show(
            "You need to add image of your parking area.", context,
            errorMoreDetails:
                "This is image will be helpful for identifying parking area.");
      } else {
        ErrorPopUp().show("All input fields are required.", context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    setMainSlotImageWidgt();
    setSlotNameInputField();
    setActiveParkingTimeWidget();
    setParkingSpaceTypeWidget();
    setParkingDimensionsWidget();
    checkFormEntries();
    setContinueBtn();
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: qbWhiteBGColor,
      child: SafeArea(
        top: false,
        maintainBottomViewPadding: true,
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                CustomIcon(
                  icon: GPIcons.rent_out_space,
                  size: 25,
                  color: qbAppTextColor,
                ),
                SizedBox(
                  width: 7.5,
                ),
                Container(
                  child: Text(
                    "Rent Out your Space",
                    style: GoogleFonts.nunito(
                        fontWeight: FontWeight.w600, color: qbAppTextColor),
                    textScaleFactor: 1,
                  ),
                ),
              ],
            ),
            brightness: Brightness.light,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            iconTheme: IconThemeData(color: qbAppTextColor),
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: (MediaQuery.of(context).viewInsets.bottom > 40)
                      ? MediaQuery.of(context).size.height -
                          56 -
                          MediaQuery.of(context).padding.top
                      : MediaQuery.of(context).size.height -
                          56 -
                          MediaQuery.of(context).padding.top -
                          MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //Slot Main Image
                    mainSlotImageWidget,

                    //Slot Name Input Field
                    slotNameInputField,

                    //Active Parking Time Text
                    activeParkingTimeWidget,

                    //Parking Space Types
                    parkingSpaceTypeWidget,

                    //Parking Dimensions
                    parkingDimensionsWidget,

                    // Continue Button
                    continueBtn
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //Functions

  //Start Time Drop Down
  initTimeDropDown() {
    startTimeList.add(DropdownMenuItem(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          "Time",
          style: GoogleFonts.roboto(
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
              color: qbAppTextColor),
          textScaleFactor: 1,
        ),
      ),
    ));

    endTimeList.add(DropdownMenuItem(
      value: null,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          "Time",
          style: GoogleFonts.roboto(
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
              color: qbAppTextColor),
          textScaleFactor: 1,
        ),
      ),
    ));

    var timeType = "pm";
    for (var i = 0; i < 24; i++) {
      var timeVal = (i % 12).toString();
      if (i % 12 == 0) {
        if (timeType == "am") {
          timeType = "pm";
        } else {
          timeType = "am";
        }

        timeVal = "12";
      }

      //print(timeVal+" "+timeType);

      startTimeList.add(DropdownMenuItem(
        value: i.toString(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            timeVal + " " + timeType,
            style: GoogleFonts.roboto(
                fontSize: 12.5,
                fontWeight: FontWeight.w400,
                color: qbAppTextColor),
            textScaleFactor: 1,
          ),
        ),
      ));
    }
  }

  //End Time Drop Down
  setEndTimeList(startTimeString) {
    setState(() {
      endTimeVal = null;
    });

    endTimeList = [];
    endTimeList.add(DropdownMenuItem(
      value: null,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          "Time",
          style: GoogleFonts.roboto(
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
              color: qbAppTextColor),
          textScaleFactor: 1,
        ),
      ),
    ));

    int startTimeInt = int.parse(startTimeString) + 1;

    var timeType;
    if (startTimeInt > 12) {
      timeType = "pm";
    } else {
      timeType = "am";
    }

    for (var i = startTimeInt; i < 24; i++) {
      var timeVal = (i % 12).toString();
      if (i % 12 == 0) {
        if (timeType == "am") {
          timeType = "pm";
        } else {
          timeType = "am";
        }

        timeVal = "12";
      }

      //print(timeVal+" "+timeType);

      endTimeList.add(DropdownMenuItem(
        value: i.toString(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            timeVal + " " + timeType,
            style: GoogleFonts.roboto(
                fontSize: 12.5,
                fontWeight: FontWeight.w400,
                color: qbAppTextColor),
            textScaleFactor: 1,
          ),
        ),
      ));
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
