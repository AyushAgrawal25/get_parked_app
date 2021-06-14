import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/FormFieldHeader.dart';
import 'package:getparked/UserInterface/Widgets/ParkingCard/ParkingCard.dart';

class ParkingOTPWidget extends StatelessWidget {
  ParkingOTPType type;
  String otp;
  ParkingDetailsAccType accType;

  ParkingOTPWidget(
      {this.type: ParkingOTPType.parking,
      @required this.otp,
      this.accType: ParkingDetailsAccType.user});
  @override
  Widget build(BuildContext context) {
    String otpNote = "";
    if (this.accType == ParkingDetailsAccType.user) {
      if (type == ParkingOTPType.parking) {
        otpNote = "Share this OTP with Parking Lord to initiate your Parking.";
      } else {
        otpNote = "Share this OTP with Parking Lord to complete your Parking.";
      }
    } else {
      if (type == ParkingOTPType.parking) {
        otpNote =
            "OTP is generated and sent to customer, you need to collect it from customer to initiate parking.";
      } else {
        otpNote =
            "OTP is generated and sent to customer, you need to collect it from customer to complete of parking.";
      }
    }
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 10,
          ),
          // Text
          Container(
            child: Text("OTP",
                style: GoogleFonts.nunito(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: qbAppPrimaryBlueColor),
                textScaleFactor: 1.0),
          ),

          // OTP
          (this.accType == ParkingDetailsAccType.user)
              ? Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 12.5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ParkingOTPBox(
                        otpDigit: this.otp[0].toString(),
                      ),
                      ParkingOTPBox(
                        otpDigit: this.otp[1].toString(),
                      ),
                      ParkingOTPBox(
                        otpDigit: this.otp[2].toString(),
                      ),
                      ParkingOTPBox(
                        otpDigit: this.otp[3].toString(),
                      ),
                    ],
                  ),
                )
              : Container(
                  height: 0,
                  width: 0,
                ),

          // OTP Header
          Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: FormFieldHeader(
              headerText: (this.type == ParkingOTPType.parking)
                  ? "Initiate Parking"
                  : "Withdraw Parking",
            ),
          ),

          // Note
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Text(otpNote,
                style: GoogleFonts.roboto(
                    letterSpacing: 0.15,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: qbDetailLightColor),
                textAlign: TextAlign.center,
                textScaleFactor: 1.0),
          ),
        ],
      ),
    );
  }
}

class ParkingOTPBox extends StatelessWidget {
  String otpDigit;
  ParkingOTPBox({@required this.otpDigit});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      // padding: EdgeInsets.symmetric(horizontal: 7.5),
      child: Container(
        height: 35,
        width: 35,

        // height: 30,
        // width: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: qbDetailLightColor, width: 1),
          // borderRadius: BorderRadius.circular(3.5),
          borderRadius: BorderRadius.circular(360),
        ),
        child: Text(otpDigit,
            style: GoogleFonts.notoSans(
                fontSize: 17.5,
                fontWeight: FontWeight.w600,
                color: qbDetailDarkColor),
            textScaleFactor: 1.0),
      ),
    );
  }
}

enum ParkingOTPType { parking, withdraw }
