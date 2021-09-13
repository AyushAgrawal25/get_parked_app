import 'package:flutter/material.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:google_fonts/google_fonts.dart';

class TermDisplayWidget extends StatelessWidget {
  String term;
  bool addHashtag;
  bool addMargin;
  double fontSize;
  TermDisplayWidget(
      {@required this.term,
      this.addHashtag: true,
      this.addMargin: true,
      this.fontSize: 12.5});
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = GoogleFonts.roboto(
        letterSpacing: 0.15,
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        color: qbDetailLightColor);

    return Container(
        margin:
            (addMargin) ? EdgeInsets.symmetric(vertical: 5) : EdgeInsets.all(0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (addHashtag)
                ? Container(
                    padding: EdgeInsets.only(right: 5),
                    alignment: Alignment.topCenter,
                    child: Text(
                      "#",
                      style: textStyle,
                      textScaleFactor: 1.0,
                    ),
                  )
                : Container(
                    height: 0,
                    width: 0,
                  ),
            Expanded(
              child: Container(
                child: Text(
                  this.term,
                  style: textStyle,
                  textScaleFactor: 1.0,
                ),
              ),
            ),
          ],
        ));
  }
}
