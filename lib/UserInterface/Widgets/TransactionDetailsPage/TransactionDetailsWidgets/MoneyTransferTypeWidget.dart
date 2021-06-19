import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:getparked/StateManagement/Models/TransactionData.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';

class MoneyTransferTypeWidget extends StatelessWidget {
  MoneyTransferType moneyTransferType;
  bool status;
  MoneyTransferTypeWidget(
      {@required this.moneyTransferType, this.status: true});
  @override
  Widget build(BuildContext context) {
    String typeText = "Nothing";
    Color textColor = qbAppTextColor;
    IconData transferIcon = FontAwesome.anchor;
    if (this.moneyTransferType == MoneyTransferType.remove) {
      typeText = "Debit";
      textColor = qbAppPrimaryRedColor;
      transferIcon = Entypo.down_bold;
    } else {
      typeText = "Credit";
      textColor = qbAppPrimaryGreenColor;
      transferIcon = Entypo.up_bold;
    }

    if (this.status) {
      typeText += "ed";
    }

    return Container(
      height: 25,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Text
          Container(
            child: Text(typeText,
                style: GoogleFonts.hind(
                    fontWeight: FontWeight.w500,
                    color: textColor,
                    fontSize: 20),
                textScaleFactor: 1.0),
          ),

          // Icon
          Container(
              alignment: Alignment.bottomCenter,
              child: Icon(transferIcon, size: 20, color: textColor))
        ],
      ),
    );
  }
}
