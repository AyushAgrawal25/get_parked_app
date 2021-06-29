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

class NotificationStatusAndTime extends StatefulWidget {
  NotificationData notificationData;

  NotificationStatusAndTime({
    @required this.notificationData,
  });
  @override
  _NotificationStatusAndTimeState createState() =>
      _NotificationStatusAndTimeState();
}

class _NotificationStatusAndTimeState extends State<NotificationStatusAndTime> {
  @override
  Widget build(BuildContext context) {
    // Time And Date
    String timeForDisplay = (widget.notificationData.time != null)
        ? DateTimeUtils.timeForDisplayRelative(widget.notificationData.time)
        : "";
    String dateForDisplay = (widget.notificationData.time != null)
        ? DateTimeUtils.dateForDisplayRelative(widget.notificationData.time)
        : "";
    // Setting Up Status
    IconData statusIcon = FontAwesome5.exclamation_triangle;
    Color statusColor = qbAppSecondaryGreenColor;
    String statusText = "Successful";

    // Deciding Status
    switch (widget.notificationData.notificationType) {
      case NotificationDataType.parkingRequest:
      case NotificationDataType.parkingRequestResponse:
        {
          switch (widget.notificationData.parkingRequestData
              .getParkingRequestDataType()) {
            case ParkingRequestDataType.pending:
              {
                statusIcon = FontAwesome5.hourglass_half;
                statusColor = qbAppSecondaryBlueColor;
                statusText = "Pending";
                break;
              }
            case ParkingRequestDataType.pendingButExpired:
              {
                statusIcon = FontAwesome5.exclamation_triangle;
                statusColor = qbAppPrimaryRedColor;
                statusText = "Expired";
                break;
              }
            case ParkingRequestDataType.accepted_BookingPending:
              {
                statusIcon = FontAwesome5.hourglass_half;
                statusColor = qbAppSecondaryBlueColor;
                statusText = "Booking Pending";
                break;
              }
            case ParkingRequestDataType.accepted_BookingExpired:
              {
                statusIcon = FontAwesome5.exclamation_triangle;
                statusColor = qbAppPrimaryRedColor;
                statusText = "Booking Expired";
                break;
              }
            case ParkingRequestDataType.rejected:
              {
                statusIcon = FontAwesome.cancel_circled;
                statusColor = qbAppPrimaryRedColor;
                statusText = "Rejected";
                break;
              }
            case ParkingRequestDataType.booked:
              {
                statusIcon = Octicons.checklist;
                statusColor = qbAppSecondaryGreenColor;
                statusText = "Booked";
                break;
              }
            case ParkingRequestDataType.booked_ParkedAndWithdrawn:
            case ParkingRequestDataType.booked_ParkingGoingON:
            case ParkingRequestDataType.booked_BookingGoingON:
            case ParkingRequestDataType.booked_BookingCancelled:
            case ParkingRequestDataType.booked_BookingFailed:
            case ParkingRequestDataType.accepted:
              {
                statusIcon = FontAwesome5.check_circle;
                statusColor = qbAppSecondaryGreenColor;
                statusText = "Accepted";
                break;
              }
          }
          break;
        }
      case NotificationDataType.booking_ForSlot:
      case NotificationDataType.booking_ForUser:
      case NotificationDataType.bookingCancellation_ForSlot:
      case NotificationDataType.bookingCancellation_ForUser:
        {
          switch (widget.notificationData.bookingData.getBookingDataType()) {
            case BookingDataType.failed:
              {
                statusIcon = FontAwesome5.exclamation_triangle;
                statusColor = qbAppPrimaryRedColor;
                statusText = "Failed";
                break;
              }
            case BookingDataType.bookingGoingON:
              {
                statusIcon = Octicons.checklist;
                statusColor = qbAppSecondaryBlueColor;
                statusText = "Booked";
                break;
              }
            case BookingDataType.cancelled:
              {
                statusIcon = FontAwesome.cancel_circled;
                statusColor = qbAppPrimaryRedColor;
                statusText = "Cancelled";
                break;
              }
            case BookingDataType.parkingGoingON:
              {
                statusIcon = FontAwesome5.car;
                statusColor = qbAppSecondaryBlueColor;
                statusText = "Parked";
                break;
              }
            case BookingDataType.parkedAndWithdrawn:
              {
                statusIcon = FontAwesome5.check_circle;
                statusColor = qbAppSecondaryGreenColor;
                statusText = "Withdrawn";
                break;
              }
          }
          break;
        }
      case NotificationDataType.parking_ForSlot:
      case NotificationDataType.parking_ForUser:
      case NotificationDataType.parkingWithdraw_ForSlot:
      case NotificationDataType.parkingWithdraw_ForUser:
        {
          switch (widget.notificationData.parkingData.getParkingDataType()) {
            case ParkingDataType.completed:
              {
                statusIcon = FontAwesome5.check_circle;
                statusColor = qbAppSecondaryGreenColor;
                statusText = "Withdrawn";
                break;
              }
            case ParkingDataType.goingON:
              {
                statusIcon = FontAwesome5.car;
                statusColor = qbAppSecondaryBlueColor;
                statusText = "Parked";
                break;
              }
          }
          break;
        }
      case NotificationDataType.transaction:
        {
          switch (
              widget.notificationData.transactionData.getTransactionStatus()) {
            case TransactionStatus.failed:
              {
                statusIcon = FontAwesome5.exclamation_triangle;
                statusColor = qbAppPrimaryRedColor;
                statusText = "Failed";
                break;
              }
            case TransactionStatus.pending:
              {
                statusIcon = FontAwesome5.hourglass_half;
                statusColor = qbAppSecondaryBlueColor;
                statusText = "Pending";
                break;
              }
            case TransactionStatus.successful:
              {
                statusIcon = FontAwesome5.check_circle;
                statusColor = qbAppSecondaryGreenColor;
                statusText = "Successful";
                break;
              }
          }
          break;
        }
      case NotificationDataType.transactionRequest:
      case NotificationDataType.transactionRequestResponse:
        {
          switch (widget.notificationData.transactionRequestData
              .getTransactionRequestDataType()) {
            case TransactionRequestDataType.accepted:
              {
                statusIcon = FontAwesome5.check_circle;
                statusColor = qbAppSecondaryGreenColor;
                statusText = "Paid";
                break;
              }
            case TransactionRequestDataType.pending:
              {
                statusIcon = FontAwesome5.hourglass_half;
                statusColor = qbAppSecondaryBlueColor;
                statusText = "Pending";
                break;
              }

            case TransactionRequestDataType.rejected:
              {
                statusIcon = FontAwesome.cancel_circled;
                statusColor = qbAppPrimaryRedColor;
                statusText = "Rejected";
                break;
              }
          }
          break;
        }
    }

    double angleForIcon;
    if (statusIcon == FontAwesome5.ticket_alt) {
      angleForIcon = pi * (10 / 9);
    } else {
      angleForIcon = 0;
    }

    return Container(
      child: Row(
        children: [
          // Time And Date
          Container(
            child: Text(
              timeForDisplay,
              style: GoogleFonts.roboto(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w500,
                  color: qbDetailLightColor),
              textScaleFactor: 1.0,
            ),
          ),
          Container(
            child: Text(
              dateForDisplay,
              style: GoogleFonts.roboto(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w500,
                  color: qbDetailLightColor),
              textScaleFactor: 1.0,
            ),
          ),

          // Status Text And Icon,
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  child: Icon(
                    statusIcon,
                    size: 13.5,
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
                        fontSize: 13.5,
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
}
