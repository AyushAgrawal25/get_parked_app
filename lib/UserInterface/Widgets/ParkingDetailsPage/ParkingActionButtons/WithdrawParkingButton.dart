import 'package:getparked/BussinessLogic/SlotsServices.dart';
import 'package:getparked/BussinessLogic/SlotsUtils.dart';
// import 'package:getparked/BussinessLogic/TransactionUtils.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/StateManagement/Models/BookingData.dart';
import 'package:getparked/StateManagement/Models/ParkingData.dart';
import 'package:getparked/StateManagement/Models/ParkingLordData.dart';
import 'package:getparked/StateManagement/Models/ParkingRequestData.dart';
import 'package:getparked/UserInterface/Widgets/OTPPopUp.dart';
import 'package:getparked/UserInterface/Widgets/SuccessAndFailure/SuccessAndFailurePage.dart';
// import 'package:getparked/UserInterface/Pages/Wallet/RequestMoney/SelectContact/SelectContact.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/EdgeLessButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class WithdrawParkingButton extends StatefulWidget {
  BookingData bookingData;
  // Notification Comes With booking Data Inside parking Data
  // So create a new Booking Data which consists of parking Data.
  // Make User in Case of Parking Notification Only

  Function(bool) changeLoadStatus;

  WithdrawParkingButton(
      {@required this.bookingData, @required this.changeLoadStatus});

  @override
  _WithdrawParkingButtonState createState() => _WithdrawParkingButtonState();
}

class _WithdrawParkingButtonState extends State<WithdrawParkingButton> {
  TextEditingController otpController;
  AppState gpAppState;

  @override
  void initState() {
    super.initState();

    otpController = TextEditingController();
    gpAppState = Provider.of<AppState>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return EdgeLessButton(
      height: 35,
      width: MediaQuery.of(context).size.width * 0.6,
      margin: EdgeInsets.only(top: 1.5, bottom: 5),
      color: qbAppPrimaryBlueColor,
      child: Center(
        child: Text(
          "Withdraw Parking",
          style: GoogleFonts.nunito(
              fontSize: 17.5, fontWeight: FontWeight.w500, color: Colors.white),
          textScaleFactor: 1.0,
          textAlign: TextAlign.center,
        ),
      ),
      onPressed: () {
        OTPPopUp().show(
            widget.bookingData.parkingData.withdrawOTP,
            "Enter OTP recieved from customer for Verification before Parking Completion.",
            onCorrectOTPEntered,
            context);
      },
    );
  }

  onCorrectOTPEntered() async {
    int duration = DateTime.now()
        .toLocal()
        .difference(DateTime.parse(widget.bookingData.time).toLocal())
        .inMinutes;
    int exceedDuration = 0;
    int endTime = gpAppState.parkingLordData.endTime;

    if (DateTime.now().toLocal().hour > endTime) {
      // Setting Up Date
      String day = "";
      if (DateTime.now().toLocal().day > 9) {
        day = DateTime.parse(widget.bookingData.time).toLocal().day.toString();
      } else {
        day = "0" +
            DateTime.parse(widget.bookingData.time).toLocal().day.toString();
      }

      String month = "";
      if (DateTime.now().toLocal().month > 9) {
        month =
            DateTime.parse(widget.bookingData.time).toLocal().month.toString();
      } else {
        month = "0" +
            DateTime.parse(widget.bookingData.time).toLocal().month.toString();
      }

      String year =
          DateTime.parse(widget.bookingData.time).toLocal().year.toString();

      String hour = "";
      if (endTime > 9) {
        hour = endTime.toString();
      } else {
        hour = "0" + endTime.toString();
      }

      exceedDuration = DateTime.now()
          .toLocal()
          .difference(DateTime.parse("$year-$month-$day $hour:00:00").toLocal())
          .inMinutes;
    }

    this.widget.changeLoadStatus(true);

    if (exceedDuration > duration) {
      exceedDuration = duration;
    }
    ParkingWithdrawStatus withdrawStatus = await SlotsServices()
        .parkingWithdraw(
            authToken: gpAppState.authToken,
            parkingId: widget.bookingData.parkingData.id,
            duration: duration,
            exceedDuration: exceedDuration);

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return SuccessAndFailurePage(
          buttonText: "Continue",
          onButtonPressed: () {
            Navigator.of(context).pop();
            this.widget.changeLoadStatus(false);
          },
          status: (withdrawStatus == ParkingWithdrawStatus.success)
              ? SuccessAndFailureStatus.success
              : SuccessAndFailureStatus.failure,
          statusText: "Parking Completion",
        );
      },
    )).then((value) {
      this.widget.changeLoadStatus(false);
    });
  }
}
