import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class ErrorPopUp {
  show(String errorDetails, BuildContext context, {String errorMoreDetails}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
          contentPadding:
              EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 10),
          content: ErrorPopUpContent(
            errorDetails: errorDetails,
            errorMoreDetails: errorMoreDetails,
          ),
        );
      },
    );
  }
}

class ErrorPopUpContent extends StatelessWidget {
  final String errorDetails;
  final String errorMoreDetails;
  ErrorPopUpContent({@required this.errorDetails, this.errorMoreDetails});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
          ),
          Container(
            child: Icon(
              FontAwesome5.exclamation_triangle,
              color: qbAppPrimaryRedColor,
              size: 60,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Text(
              "Error",
              style: GoogleFonts.nunito(
                  fontSize: 17.5,
                  fontWeight: FontWeight.w800,
                  color: qbAppTextColor),
              textScaleFactor: 1.0,
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(
            height: 10,
          ),

          //Text
          Container(
            child: Text(
              this.errorDetails,
              style: GoogleFonts.roboto(
                  height: 1.25,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w500,
                  color: qbDetailDarkColor),
              textAlign: TextAlign.center,
              textScaleFactor: 1.0,
            ),
          ),

          ((this.errorMoreDetails != null) && (this.errorMoreDetails != ""))
              ? Container(
                  padding: EdgeInsets.only(top: 12.5, right: 15, left: 15),
                  child: Text(
                    this.errorMoreDetails,
                    style: GoogleFonts.roboto(
                        height: 1.5,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w400,
                        color: qbDetailLightColor),
                    textAlign: TextAlign.center,
                    textScaleFactor: 1.0,
                  ),
                )
              : Container(
                  height: 0,
                  width: 0,
                ),

          SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }
}
