import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SlotNameWidget extends StatelessWidget {
  String slotName;
  double fontSize;
  SlotNameWidget({@required this.slotName, this.fontSize: 22.5});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        slotName,
        style: GoogleFonts.mukta(
            fontSize: this.fontSize,
            fontWeight: FontWeight.w500,
            color: qbAppTextColor),
        textScaleFactor: 1.0,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
