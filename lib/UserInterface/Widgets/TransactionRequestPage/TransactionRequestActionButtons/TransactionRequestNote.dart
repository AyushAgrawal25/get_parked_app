import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';

class TransactionRequestNote extends StatelessWidget {
  String note;
  TransactionRequestNote({@required this.note});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          // Note Header
          Container(
            child: Text(
              "Note",
              style: GoogleFonts.nunito(
                  color: qbDividerDarkColor,
                  // color: qbDetailLightColor,
                  fontSize: 15,
                  height: 0.75,
                  fontWeight: FontWeight.w500),
              textScaleFactor: 1.0,
            ),
          ),

          SizedBox(
            height: 5,
          ),

          // Note
          Container(
            child: Text(
              this.note,
              style: GoogleFonts.roboto(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: qbDetailDarkColor),
              textScaleFactor: 1.0,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
