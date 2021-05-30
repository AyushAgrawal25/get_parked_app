import 'dart:math';

import 'package:getparked/Utils/DateTimeUtils.dart';
import 'package:getparked/StateManagement/Models/BookingData.dart';
import 'package:getparked/StateManagement/Models/NotificationData.dart';
import 'package:getparked/StateManagement/Models/ParkingData.dart';
import 'package:getparked/StateManagement/Models/ParkingRequestData.dart';
import 'package:getparked/StateManagement/Models/TransactionData.dart';
import 'package:getparked/StateManagement/Models/TransactionRequestData.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionStatusAndTime extends StatefulWidget {
  final int transactionStatus;
  final String transactionTime;

  TransactionStatusAndTime({
    @required this.transactionStatus,
    @required this.transactionTime,
  });
  @override
  _TransactionStatusAndTimeState createState() =>
      _TransactionStatusAndTimeState();
}

class _TransactionStatusAndTimeState extends State<TransactionStatusAndTime> {
  @override
  Widget build(BuildContext context) {
    // Time And Date
    String timeForDisplay = (widget.transactionTime != null)
        ? DateTimeUtils.timeForDisplayRelative(widget.transactionTime)
        : "";
    String dateForDisplay = (widget.transactionTime != null)
        ? DateTimeUtils.dateForDisplayRelative(widget.transactionTime)
        : "";

    // Setting Up Status
    IconData statusIcon = FontAwesome5.exclamation_triangle;
    Color statusColor = qbAppSecondaryGreenColor;
    String statusText = "Successful";

    // Deciding Status
    switch (widget.transactionStatus) {
      case 0:
        statusText = "Pending";
        statusIcon = FontAwesome5.hourglass_half;
        statusColor = qbAppSecondaryBlueColor;
        break;

      case 1:
        statusText = "Successful";
        statusIcon = FontAwesome5.check_circle;
        statusColor = qbAppSecondaryGreenColor;
        break;

      case 2:
        statusText = "Failed";
        statusIcon = FontAwesome5.exclamation_circle;
        statusColor = qbAppPrimaryRedColor;
        break;

      default:
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 3.5),
      child: Row(
        children: [
          // Time And Date
          Container(
            child: Text(
              timeForDisplay,
              style: GoogleFonts.roboto(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w500,
                  color: qbDetailLightColor),
              textScaleFactor: 1.0,
            ),
          ),
          Container(
            child: Text(
              dateForDisplay,
              style: GoogleFonts.roboto(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w500,
                  color: qbDetailLightColor),
              textScaleFactor: 1.0,
            ),
          ),

          Expanded(
              child: SizedBox(
            height: 10,
          )),

          // Status Text And Icon,
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
    );
  }
}
