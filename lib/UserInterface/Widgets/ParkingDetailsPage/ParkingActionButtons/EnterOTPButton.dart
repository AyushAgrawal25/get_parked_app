import 'package:getparked/BussinessLogic/SlotsServices.dart';
import 'package:getparked/BussinessLogic/SlotsUtils.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/StateManagement/Models/BookingData.dart';
import 'package:getparked/StateManagement/Models/ParkingLordData.dart';
import 'package:getparked/UserInterface/Widgets/OTPPopUp.dart';
import 'package:getparked/UserInterface/Widgets/SuccessAndFailure/SuccessAndFailurePage.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/EdgeLessButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EnterOTPButton extends StatefulWidget {
  BookingData bookingData;

  Function(bool) changeLoadStatus;

  EnterOTPButton({@required this.bookingData, @required this.changeLoadStatus});

  @override
  _EnterOTPButtonState createState() => _EnterOTPButtonState();
}

class _EnterOTPButtonState extends State<EnterOTPButton> {
  TextEditingController otpController;
  AppState gpAppState;

  @override
  void initState() {
    // TODO: implement initState
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
      color: qbAppPrimaryGreenColor,
      child: Center(
        child: Text(
          "Enter OTP",
          style: GoogleFonts.nunito(
              fontSize: 17.5, fontWeight: FontWeight.w500, color: Colors.white),
          textScaleFactor: 1.0,
          textAlign: TextAlign.center,
        ),
      ),
      onPressed: () {
        showEnterOTPDialog(onCorrectOTPEntered);
      },
    );
  }

  onCorrectOTPEntered() async {
    // Navigator.of(context).pop();
    // Parking

    this.widget.changeLoadStatus(true);

    ParkingStatus parkingStatus = await SlotsServices().parking(
        authToken: gpAppState.authToken, bookingId: widget.bookingData.id);

    // await Future.delayed(Duration(seconds: 2));

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return SuccessAndFailurePage(
          buttonText: "Go Back",
          onButtonPressed: () {
            Navigator.of(context).pop();

            this.widget.changeLoadStatus(false);
          },
          status: (parkingStatus == ParkingStatus.success)
              ? SuccessAndFailureStatus.success
              : SuccessAndFailureStatus.failure,
          // status: (true)
          //     ? SuccessAndFailureStatus.success
          //     : SuccessAndFailureStatus.failure,
          statusText: "Parking",
        );
      },
    )).then((value) {
      this.widget.changeLoadStatus(false);
    });
  }

  showEnterOTPDialog(Function onCorrectOTP) async {
    OTPPopUp().show(
        widget.bookingData.parkingOTP.toString(),
        "Enter OTP recieved from customer for Verification before Parking.",
        onCorrectOTP,
        context);
  }
}
