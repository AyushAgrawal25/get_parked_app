import 'package:getparked/StateManagement/Models/SlotData.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/ParkingDetailsPage/ParkingDetailsWidgets/ParkingDetailsTheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ParkingDetailsWidget extends StatelessWidget {
  int parkingHours;
  SlotSpaceType spaceType;
  double charges;

  ParkingDetailsWidget({
    @required this.charges,
    @required this.parkingHours,
    @required this.spaceType,
  });

  @override
  Widget build(BuildContext context) {
    String pHrs = this.parkingHours.toString();
    if (this.parkingHours > 1) {
      pHrs += " hours";
    } else {
      pHrs += " hour";
    }

    String pChs = "₹ " + this.charges.toStringAsFixed(2);

    String spType = "";
    if (this.spaceType == SlotSpaceType.sheded) {
      spType = "Sheded";
    } else {
      spType = "Open";
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Divider(
            height: 5,
            color: qbDividerLightColor,
            thickness: 1,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 17.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ParkingDetailKeyValue(keyText: "Hours ", valueText: pHrs),
                ParkingDetailKeyValue(keyText: "Charges ", valueText: pChs),
                ParkingDetailKeyValue(keyText: "Space ", valueText: spType)
              ],
            ),
          ),
          Divider(
            height: 5,
            color: qbDividerLightColor,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}

class ParkingDetailKeyValue extends StatelessWidget {
  String keyText;
  String valueText;
  ParkingDetailKeyValue({@required this.keyText, @required this.valueText});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              child: Text(
            this.keyText,
            style: GoogleFonts.poppins(
                fontSize: 10, fontWeight: FontWeight.w500, color: qbHeadColor),
            textAlign: TextAlign.left,
            textScaleFactor: 1.0,
          )),
          SizedBox(
            height: 2.5,
          ),
          Container(
              child: Text(
            this.valueText,
            style: GoogleFonts.notoSans(
                fontSize: 17.5,
                fontWeight: FontWeight.w600,
                color: qbBodyColor),
            textAlign: TextAlign.left,
            textScaleFactor: 1.0,
          ))
        ],
      ),
    );
  }
}
