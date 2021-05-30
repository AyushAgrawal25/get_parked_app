import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class SlotDetailWidget extends StatefulWidget {
  final IconData iconName;
  final String detail;
  bool isEditable;
  SlotDetailWidget({this.iconName, this.detail, this.isEditable = false});
  @override
  _SlotDetailWidgetState createState() => _SlotDetailWidgetState();
}

class _SlotDetailWidgetState extends State<SlotDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 5, 0, 5),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
            child: Icon(
              widget.iconName,
              color: qbAppTextColor,
              size: 25,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.centerLeft,
              child: Text(
                widget.detail,
                style: GoogleFonts.roboto(
                    fontSize: 15, fontWeight: FontWeight.w500),
                textScaleFactor: 1,
              ),
            ),
          ),
          widget.isEditable
              ? Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 30, 10),
                  child: Icon(
                    FontAwesomeIcons.pen,
                    size: 20,
                    color: qbAppTextColor,
                  ),
                )
              : Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                )
        ],
      ),
    );
  }
}
