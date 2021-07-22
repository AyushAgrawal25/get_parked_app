import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/UserInterface/Icons/g_p_icons_icons.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/CustomIcon.dart';
import 'package:getparked/UserInterface/Widgets/EdgeLessButton.dart';
import 'package:getparked/UserInterface/Widgets/FormFieldHeader.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChangeDimensions extends StatefulWidget {
  @override
  _ChangeDimensionsState createState() => _ChangeDimensionsState();
}

class _ChangeDimensionsState extends State<ChangeDimensions> {
  AppState appState;

  @override
  void initState() {
    super.initState();
    lengthController = TextEditingController();
    breadthController = TextEditingController();
    heightController = TextEditingController();

    appState = Provider.of<AppState>(context, listen: false);

    length = appState.parkingLordData.length.toStringAsFixed(2);
    lengthController.text = length;

    breadth = appState.parkingLordData.breadth.toStringAsFixed(2);
    breadthController.text = breadth;

    height = appState.parkingLordData.height.toStringAsFixed(2);
    heightController.text = height;
  }

  String length;
  TextEditingController lengthController;

  String breadth;
  TextEditingController breadthController;

  String height;
  TextEditingController heightController;

  bool isFormValid = true;
  checkFormValidity() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          // Main Paige
          Container(
            color: qbWhiteBGColor,
            child: SafeArea(
              top: false,
              maintainBottomViewPadding: true,
              child: Scaffold(
                appBar: AppBar(
                    brightness: Brightness.light,
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    iconTheme: IconThemeData(color: qbAppTextColor),
                    title: Row(
                      children: [
                        CustomIcon(
                          icon: FontAwesome5.pencil_ruler,
                          size: 25,
                          color: qbAppTextColor,
                        ),
                        SizedBox(
                          width: 7.5,
                        ),
                        Container(
                          child: Text(
                            "Change Dimensions",
                            style: GoogleFonts.nunito(
                                fontWeight: FontWeight.w600,
                                color: qbAppTextColor),
                            textScaleFactor: 1,
                          ),
                        ),
                      ],
                    )),
                body: Container(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height -
                          MediaQuery.of(context).padding.top -
                          85,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: FormFieldHeader(
                              headerText: "Parking Area Dimensions",
                              fontSize: 22.5,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: FormFieldHeader(
                              headerText: "Length",
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: TextField(
                                controller: lengthController,
                                onChanged: (value) {
                                  setState(() {
                                    length = value;
                                  });
                                },
                                style: GoogleFonts.roboto(
                                    fontSize: 17.5 /
                                        MediaQuery.of(context).textScaleFactor,
                                    fontWeight: FontWeight.w500,
                                    color: qbAppTextColor),
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.phone,
                                readOnly: false,
                                decoration: InputDecoration(
                                  isDense: true,
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 10),
                                )),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: FormFieldHeader(
                              headerText: "Breadth",
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: TextField(
                                controller: breadthController,
                                onChanged: (value) {
                                  setState(() {
                                    breadth = value;
                                  });
                                },
                                style: GoogleFonts.roboto(
                                    fontSize: 17.5 /
                                        MediaQuery.of(context).textScaleFactor,
                                    fontWeight: FontWeight.w500,
                                    color: qbAppTextColor),
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.phone,
                                readOnly: false,
                                decoration: InputDecoration(
                                  isDense: true,
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 10),
                                )),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: FormFieldHeader(
                              headerText: "Height",
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: TextField(
                                controller: heightController,
                                onChanged: (value) {
                                  setState(() {
                                    height = value;
                                  });
                                },
                                style: GoogleFonts.roboto(
                                    fontSize: 17.5 /
                                        MediaQuery.of(context).textScaleFactor,
                                    fontWeight: FontWeight.w500,
                                    color: qbAppTextColor),
                                textAlign: TextAlign.start,
                                keyboardType: TextInputType.phone,
                                readOnly: false,
                                decoration: InputDecoration(
                                  isDense: true,
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 10),
                                )),
                          ),
                          Expanded(
                              child: SizedBox(
                            height: 5,
                          )),
                          Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 2.5),
                              alignment: Alignment.center,
                              child: EdgeLessButton(
                                child: Text(
                                  "Submit",
                                  style: GoogleFonts.nunito(
                                      fontSize: 16.5,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                  textAlign: TextAlign.center,
                                  textScaleFactor: 1.0,
                                ),
                                color: (isFormValid)
                                    ? qbAppPrimaryBlueColor
                                    : qbDividerDarkColor,
                                width: MediaQuery.of(context).size.width * 0.6,
                                padding: EdgeInsets.symmetric(vertical: 8.5),
                                onPressed: () {
                                  onSubmitPressed(context);
                                },
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )

          // Loader
        ],
      ),
    );
  }

  onSubmitPressed(BuildContext buildContext) {}
}
