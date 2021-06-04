import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class FlushBarUtils {
  static showTextResponsive(
      BuildContext buildContext, String title, String message) {
    Flushbar(
      isDismissible: true,
      titleText: Container(
        child: Text(
          title,
          style: GoogleFonts.roboto(
              fontSize: 19, fontWeight: FontWeight.w500, color: qbWhiteBGColor),
          textScaleFactor: 1.0,
        ),
      ),
      messageText: Container(
        child: Text(
          message,
          style: GoogleFonts.roboto(
              fontSize: 15, fontWeight: FontWeight.w400, color: qbWhiteBGColor),
          textScaleFactor: 1.0,
        ),
      ),
      flushbarStyle: FlushbarStyle.FLOATING,
      duration: Duration(seconds: 2),
    )..show(buildContext);
  }
}
