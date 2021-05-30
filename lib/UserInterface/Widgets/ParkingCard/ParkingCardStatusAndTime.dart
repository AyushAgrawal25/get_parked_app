import 'dart:async';

import 'package:getparked/Utils/DateTimeUtils.dart';
import 'package:getparked/StateManagement/Models/ParkingRequestData.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class ParkingCardStatusAndTime extends StatefulWidget {
  ParkingRequestData parkingRequestData;
  ParkingCardStatusAndTime({@required this.parkingRequestData});

  @override
  _ParkingCardStatusAndTimeState createState() =>
      _ParkingCardStatusAndTimeState();
}

class _ParkingCardStatusAndTimeState extends State<ParkingCardStatusAndTime> {
  Timer timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (gpTimer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // Setting Up Time And Date
    String time =
        DateTimeUtils.timeForDisplayRelative(widget.parkingRequestData.time);
    String date =
        DateTimeUtils.dateForDisplayRelative(widget.parkingRequestData.time);

    // Setting Up Status
    IconData statusIcon = FontAwesome5.exclamation_triangle;
    Color statusColor = qbAppSecondaryGreenColor;
    String statusText = "Successful";
    switch (this.widget.parkingRequestData.getParkingRequestDataType()) {
      case ParkingRequestDataType.pending:
        statusIcon = FontAwesome5.clock;
        statusColor = qbAppSecondaryBlueColor;
        statusText = "Pending";
        break;
      case ParkingRequestDataType.pendingButExpired:
        statusIcon = FontAwesome5.exclamation_triangle;
        statusColor = qbAppPrimaryRedColor;
        statusText = "Expired";
        break;
      case ParkingRequestDataType.accepted_BookingPending:
        statusIcon = FontAwesome5.clock;
        statusColor = qbAppSecondaryBlueColor;
        statusText = "Pending";
        break;
      case ParkingRequestDataType.accepted_BookingExpired:
        statusIcon = FontAwesome5.exclamation_triangle;
        statusColor = qbAppPrimaryRedColor;
        statusText = "Expired";
        break;
      case ParkingRequestDataType.booked_BookingFailed:
        statusIcon = FontAwesome5.exclamation_triangle;
        statusColor = qbAppPrimaryRedColor;
        statusText = "Failed";
        break;
      case ParkingRequestDataType.booked_BookingGoingON:
        statusIcon = FontAwesome5.check_circle;
        statusColor = qbAppSecondaryGreenColor;
        statusText = "Booked";
        break;
      case ParkingRequestDataType.booked_BookingCancelled:
        statusIcon = FontAwesome5.exclamation_triangle;
        statusColor = qbAppPrimaryRedColor;
        statusText = "Cancelled";
        break;
      case ParkingRequestDataType.booked_ParkingGoingON:
        statusIcon = FontAwesome5.check_circle;
        statusColor = qbAppSecondaryGreenColor;
        statusText = "Parked";
        break;
      case ParkingRequestDataType.booked_ParkedAndWithdrawn:
        statusIcon = FontAwesome5.check_circle;
        statusColor = qbAppSecondaryGreenColor;
        statusText = "Withdrawn";
        break;
      case ParkingRequestDataType.rejected:
        statusIcon = FontAwesome5.exclamation_triangle;
        statusColor = qbAppPrimaryRedColor;
        statusText = "Rejected";
        break;
      case ParkingRequestDataType.accepted:
        statusIcon = FontAwesome5.check_circle;
        statusColor = qbAppSecondaryGreenColor;
        statusText = "Accepted";
        break;
      case ParkingRequestDataType.booked:
        statusIcon = FontAwesome5.check_circle;
        statusColor = qbAppSecondaryGreenColor;
        statusText = "Booked";
        break;
    }
    return Container(
      padding: EdgeInsets.symmetric(vertical: 3.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Text(
              time,
              style: GoogleFonts.roboto(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w500,
                  color: qbDetailLightColor),
              textScaleFactor: 1.0,
            ),
          ),
          Container(
            child: Text(
              date,
              style: GoogleFonts.roboto(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w500,
                  color: qbDetailLightColor),
              textScaleFactor: 1.0,
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  child: Icon(
                    statusIcon,
                    size: 12.5,
                    color: statusColor,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  child: Text(
                    statusText,
                    style: GoogleFonts.roboto(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                        color: statusColor),
                    textScaleFactor: 1.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
