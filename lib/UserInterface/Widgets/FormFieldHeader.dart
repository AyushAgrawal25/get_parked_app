import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormFieldHeader extends StatelessWidget {
  String headerText;
  double fontSize;
  Color color;

  FormFieldHeader({@required this.headerText, this.fontSize: 17.5, this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        this.headerText,
        style: GoogleFonts.nunito(
            fontSize: this.fontSize,
            fontWeight: FontWeight.w600,
            color: (this.color == null) ? qbDetailDarkColor : this.color),
        textScaleFactor: 1.0,
      ),
    );
  }
}
