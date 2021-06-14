import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/ParkingCard/ParkingCard.dart';
import 'package:getparked/UserInterface/Icons/g_p_icons_icons.dart';
import 'package:getparked/UserInterface/Widgets/CustomIcon.dart';
import 'package:getparked/UserInterface/Widgets/ParkingDetailsPage/ParkingDetailsWidgets/ParkingDetailsTheme.dart';

class ParkingTotalProfitWidget extends StatelessWidget {
  double amount;
  ParkingDetailsAccType accType;
  ParkingTotalProfitWidget({this.amount: 0, @required this.accType});
  @override
  Widget build(BuildContext context) {
    double calcAmount = this.amount;
    if (this.accType == ParkingDetailsAccType.slot) {
      calcAmount = this.amount * 0.7;
    }
    return Container(
      child: Row(
        children: [
          // Rupee Card
          Container(
            child: Container(
              height: 24 * 1.4,
              width: 36 * 1.4,
              // decoration: BoxDecoration(
              //     color: qbDetailDarkColor,
              //     borderRadius: BorderRadius.circular(2.5)),
              child: CustomIcon(
                icon: GPIcons.transaction_slip,
                size: 35,
                color: qbBodyColor,
              ),
            ),
          ),

          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Container(
              child: Text(
                  (this.accType == ParkingDetailsAccType.slot)
                      ? "Total Profit"
                      : "Total Charges",
                  style: GoogleFonts.nunito(
                      fontSize: 17.5,
                      fontWeight: FontWeight.w600,
                      color: qbHeadColor),
                  textScaleFactor: 1.0),
            ),
          ),

          Container(
            child: Text("₹" + calcAmount.toStringAsFixed(2),
                style: GoogleFonts.notoSans(
                    fontSize: 17.5,
                    fontWeight: FontWeight.w600,
                    color: qbBodyColor),
                textScaleFactor: 1.0),
          )
        ],
      ),
    );
  }
}
