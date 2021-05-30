import 'package:getparked/UserInterface/Widgets/Reviews/ReviewsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';

class ReviewButton extends StatefulWidget {
  int slotId;

  ReviewButton({@required this.slotId});
  @override
  _ReviewButtonState createState() => _ReviewButtonState();
}

class _ReviewButtonState extends State<ReviewButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ReviewsPage(
              slotId: widget.slotId,
            );
          }));
        },
        child: Text(
          "Reviews",
          style: GoogleFonts.roboto(
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
              color: qbAppPrimaryBlueColor),
          textScaleFactor: 1.0,
        ),
      ),
    );
  }
}
