import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionStatusWidget extends StatelessWidget {
  String text;
  Color color;
  IconData icon;

  TransactionStatusWidget({
    @required this.color,
    @required this.icon,
    @required this.text,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Icon(
                this.icon,
                color: this.color,
                size: 40,
              ),
            ),
            SizedBox(
              width: 10,
            ),

            // Status Text
            Container(
              child: Text(
                this.text,
                style: GoogleFonts.nunito(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: this.color),
                textScaleFactor: 1.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
