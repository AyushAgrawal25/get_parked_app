import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';

class ExtraDetailKey extends StatelessWidget {
  String keyText;
  ExtraDetailKey({@required this.keyText});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 27.5,
      alignment: Alignment.center,
      child: Text(keyText,
          style: GoogleFonts.roboto(
              fontSize: 15,
              color: qbDetailLightColor,
              fontWeight: FontWeight.w400),
          textScaleFactor: 1.0),
    );
  }
}

class ExtraDetailValue extends StatelessWidget {
  String valueText;
  ExtraDetailValue({@required this.valueText});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 27.5,
      alignment: Alignment.center,
      child: Text(valueText,
          style: GoogleFonts.roboto(
              fontSize: 15,
              color: qbDetailDarkColor,
              fontWeight: FontWeight.w400),
          textScaleFactor: 1.0),
    );
  }
}
