import 'package:getparked/Utils/DateTimeUtils.dart';
import 'package:getparked/StateManagement/Models/ParkingRequestData.dart';
import 'package:getparked/StateManagement/Models/BookingData.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class ParkingCardTimeAndTransaction extends StatelessWidget {
  ParkingRequestDataType dataType;
  BookingData bookingData;
  ParkingCardTimeAndTransaction(
      {@required this.dataType, @required this.bookingData});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          (this.bookingData.transactionData != null)
              ? Container(
                  padding: EdgeInsets.symmetric(vertical: 2.5),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      (this.bookingData.transactionData.moneyTransferType == 1)
                          ? Container(
                              child: Icon(
                                Entypo.up_bold,
                                size: 13.5,
                                color: qbAppPrimaryGreenColor,
                              ),
                            )
                          : Container(
                              child: Icon(
                                Entypo.down_bold,
                                size: 13.5,
                                color: qbAppPrimaryRedColor,
                              ),
                            ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        child: Text(
                          "₹ ${this.bookingData.transactionData.amount.toStringAsFixed(2)} /-",
                          style: GoogleFonts.roboto(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: qbDetailDarkColor),
                          textScaleFactor: 1.0,
                        ),
                      )
                    ],
                  ))
              : Container(
                  height: 0,
                  width: 0,
                ),
          (this.bookingData.duration != null)
              ? Container(
                  padding: EdgeInsets.symmetric(vertical: 2.5),
                  child: Text(
                    DateTimeUtils.durationInHrAndMinFromatFromMins(
                        this.bookingData.duration),
                    style: GoogleFonts.roboto(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: qbAppTextColor),
                    textScaleFactor: 1.0,
                  ),
                )
              : Container(
                  height: 0,
                  width: 0,
                )
        ],
      ),
    );
  }
}
