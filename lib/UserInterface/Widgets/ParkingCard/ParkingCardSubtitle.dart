import 'package:getparked/StateManagement/Models/ParkingRequestData.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ParkingCardSubtitle extends StatelessWidget {
  ParkingRequestDataType dataType;
  ParkingCardSubtitle({@required this.dataType});
  @override
  Widget build(BuildContext context) {
    String subtitle = "";
    switch (this.dataType) {
      case ParkingRequestDataType.pending:
      case ParkingRequestDataType.pendingButExpired:
      case ParkingRequestDataType.accepted_BookingExpired:
        subtitle = "Parking Request Sent";
        break;
      case ParkingRequestDataType.accepted_BookingPending:
        subtitle = "Booking";
        break;
      case ParkingRequestDataType.booked_BookingFailed:
        subtitle = "Booking Failed";
        break;
      case ParkingRequestDataType.booked_BookingGoingON:
      case ParkingRequestDataType.booked:
      case ParkingRequestDataType.booked_BookingCancelled:
        subtitle = "Booked";
        break;
      case ParkingRequestDataType.booked_ParkingGoingON:
      case ParkingRequestDataType.booked_ParkedAndWithdrawn:
        subtitle = "Parked";
        break;
      case ParkingRequestDataType.rejected:
        subtitle = "Parking Request Rejected";
        break;
      case ParkingRequestDataType.accepted:
        subtitle = "Parking Request Accepted";
        break;
    }
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        subtitle,
        style: GoogleFonts.yantramanav(
            fontWeight: FontWeight.w500,
            fontSize: 11.5,
            color: qbDetailLightColor),
        textScaleFactor: 1,
        maxLines: 1,
      ),
    );
  }
}
