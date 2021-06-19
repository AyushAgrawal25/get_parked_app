import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';

class TransactionAmountWidget extends StatelessWidget {
  double amount;
  double sizeFactor;
  TransactionAmountWidget({@required this.amount, this.sizeFactor: 1});
  @override
  Widget build(BuildContext context) {
    String amtRs = (this.amount.toStringAsFixed(2).split('.'))[0];
    String amtPaisa = (this.amount.toStringAsFixed(2).split('.'))[1];

    double rupeeSize = 30 * this.sizeFactor;
    double rsSize = 45 * this.sizeFactor;
    double pSize = 27.5 * this.sizeFactor;

    return Container(
      height: 50 * this.sizeFactor,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Rupee
          Container(
            padding: EdgeInsets.only(top: 2.5),
            alignment: Alignment.topCenter,
            child: Text("₹",
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    color: qbDetailDarkColor,
                    fontSize: rupeeSize),
                textScaleFactor: 1.0),
          ),

          SizedBox(
            width: 5,
          ),

          // Amount Rs
          Container(
            child: Text(amtRs + ".",
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    color: qbDetailDarkColor,
                    fontSize: rsSize),
                textScaleFactor: 1.0),
          ),

          // Amount Rs
          Container(
            alignment: Alignment.bottomCenter,
            child: Text(amtPaisa,
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    color: qbDetailDarkColor,
                    fontSize: pSize),
                textScaleFactor: 1.0),
          ),

          // Container(
          //     alignment: Alignment.center,
          //     child:
          //         Icon(Entypo.up_bold, size: 30, color: qbAppPrimaryGreenColor))
        ],
      ),
    );
  }
}
