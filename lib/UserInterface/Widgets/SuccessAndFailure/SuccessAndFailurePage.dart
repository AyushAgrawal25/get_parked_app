import 'package:getparked/StateManagement/Models/AppOverlayStyleData.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:provider/provider.dart';

import '../../Theme/AppOverlayStyle.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/EdgeLessButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class SuccessAndFailurePage extends StatefulWidget {
  Function onButtonPressed;
  SuccessAndFailureStatus status;
  String statusText;
  String buttonText;
  Color buttonColor;

  SuccessAndFailurePage(
      {this.buttonColor,
      this.buttonText: "Continue",
      this.onButtonPressed,
      this.status: SuccessAndFailureStatus.success,
      this.statusText: "Transaction"});

  @override
  _SuccessAndFailurePageState createState() => _SuccessAndFailurePageState();
}

class _SuccessAndFailurePageState extends State<SuccessAndFailurePage> {
  AppState gpAppState;

  @override
  void initState() {
    super.initState();
    gpAppState = Provider.of(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Icon(
                (widget.status == SuccessAndFailureStatus.success)
                    ? FontAwesome5.check
                    : FontAwesome5.exclamation_circle,
                color: (widget.status == SuccessAndFailureStatus.success)
                    ? Colors.green.shade600
                    : Colors.red.shade600,
                size: (widget.status == SuccessAndFailureStatus.success)
                    ? 80
                    : 90,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              child: Text(
                widget.statusText,
                style: GoogleFonts.nunito(
                    fontSize: 22.5,
                    fontWeight: FontWeight.w700,
                    color: qbAppTextColor),
                textScaleFactor: 1.0,
              ),
            ),
            Container(
              child: Text(
                (widget.status == SuccessAndFailureStatus.success)
                    ? "Successful"
                    : "Failed",
                style: GoogleFonts.nunito(
                    fontSize: 22.5,
                    fontWeight: FontWeight.w700,
                    color: qbAppTextColor),
                textScaleFactor: 1.0,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            EdgeLessButton(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 55),
              color: (widget.buttonColor != null)
                  ? widget.buttonColor
                  : qbAppPrimaryBlueColor,
              child: Container(
                child: Text(
                  widget.buttonText,
                  style: GoogleFonts.nunito(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                  textScaleFactor: 1,
                ),
              ),
              onPressed: () {
                widget.onButtonPressed();
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

enum SuccessAndFailureStatus { success, failure }
