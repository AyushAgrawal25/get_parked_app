import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SquareDetailsWidget extends StatefulWidget {
  String detailType;
  String mainText;
  double mainTextSize;
  String subText;
  double subTextSize;

  SquareDetailsWidget(
      {@required this.detailType,
      @required this.mainText,
      this.mainTextSize: 25.0,
      @required this.subText,
      this.subTextSize: 14.0});
  @override
  _SquareDetailsWidgetState createState() => _SquareDetailsWidgetState();
}

class _SquareDetailsWidgetState extends State<SquareDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              border: Border.all(color: qbAppPrimaryThemeColor, width: 2.5),
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 12.5,
                ),
                Container(
                  child: Text(
                    widget.mainText,
                    style: GoogleFonts.nunito(
                        fontSize: widget.mainTextSize,
                        color: qbAppPrimaryThemeColor,
                        height: 0.6,
                        fontWeight: FontWeight.w800),
                    textScaleFactor: 1.0,
                  ),
                ),
                Container(
                  child: Text(
                    widget.subText,
                    style: GoogleFonts.nunito(
                        fontSize: widget.subTextSize,
                        color: qbAppPrimaryThemeColor,
                        fontWeight: FontWeight.w700),
                    textScaleFactor: 1.0,
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          child: Text(
            widget.detailType,
            style: GoogleFonts.nunito(
                color: qbDetailLightColor,
                fontSize: 13.5,
                fontWeight: FontWeight.w700),
            textScaleFactor: 1.0,
          ),
        )
      ],
    ));
  }
}
