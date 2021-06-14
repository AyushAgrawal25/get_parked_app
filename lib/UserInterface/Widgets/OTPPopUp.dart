import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/EdgeLessButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getparked/UserInterface/Widgets/OTPTextField.dart';
import 'package:google_fonts/google_fonts.dart';

class OTPPopUp {
  show(String correctOTP, String otpDetail, Function onCorrectOTP,
      BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
          contentPadding:
              EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 10),
          content: OTPPopUpContent(
            correctOTP: correctOTP,
            otpDetails: otpDetail,
            onCorrectOTP: () {
              Navigator.of(context).pop();
              onCorrectOTP();
            },
          ),
        );
      },
    );
  }
}

bool toShowOTPIncorrectError(String enteredOTP, String correctOTP) {
  if (enteredOTP == correctOTP) {
    return false;
  } else {
    if (enteredOTP.length == correctOTP.length) {
      return true;
    }
    return false;
  }
}

class OTPPopUpContent extends StatefulWidget {
  Function onCorrectOTP;
  String otpDetails;
  String correctOTP;

  OTPPopUpContent(
      {@required this.correctOTP,
      @required this.onCorrectOTP,
      @required this.otpDetails});
  @override
  _OTPPopUpContentState createState() => _OTPPopUpContentState();
}

class _OTPPopUpContentState extends State<OTPPopUpContent> {
  TextEditingController otpController;
  String enteredOTP;
  bool showError;

  @override
  void initState() {
    super.initState();
    enteredOTP = "";
    otpController = TextEditingController();
    showError = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 30,
          ),

          // Title
          Container(
            child: Text(
              "Enter OTP",
              style: GoogleFonts.nunito(
                  fontSize: 17.5,
                  fontWeight: FontWeight.w800,
                  color: qbAppTextColor),
              textAlign: TextAlign.center,
              textScaleFactor: 1.0,
            ),
          ),

          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 15,
          ),

          //Text
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              widget.otpDetails,
              style: GoogleFonts.roboto(
                  height: 1.5,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w500,
                  color: qbAppTextColor),
              textAlign: TextAlign.center,
              textScaleFactor: 1.0,
            ),
          ),

          SizedBox(
            height: 20,
          ),

          // Input Text Field
          Container(
            alignment: Alignment.center,
            child: Container(
              child: OTPTextField(
                onChanged: (String otp) {
                  setState(() {
                    enteredOTP = otp;
                    if ((showError) &&
                        (!toShowOTPIncorrectError(
                            enteredOTP, widget.correctOTP))) {
                      showError = false;
                    }
                  });
                },
              ),
            ),
          ),

          (showError)
              ? Container(
                  padding:
                      EdgeInsets.only(top: 0, bottom: 10, left: 15, right: 15),
                  child: Text(
                    "Entered OTP is incorrect.",
                    style: GoogleFonts.roboto(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                        color: qbAppPrimaryRedColor,
                        letterSpacing: 0.75),
                    textScaleFactor: 1.0,
                  ),
                )
              : Container(height: 0, width: 0),

          // Verify Button
          Container(
            child: EdgeLessButton(
              color: qbAppPrimaryGreenColor,
              padding: EdgeInsets.symmetric(vertical: 7.5, horizontal: 40),
              child: Text(
                "Verfiy",
                style: GoogleFonts.nunito(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
                textScaleFactor: 1.0,
              ),
              onPressed: () {
                if (toShowOTPIncorrectError(enteredOTP, widget.correctOTP)) {
                  setState(() {
                    showError = true;
                  });
                } else {
                  widget.onCorrectOTP();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

// OTPPopUp OTPPopUp = OTPPopUp();
// OTPPopUp.show("5478", () {
//   print("Correct OTP Entered !");
// }, context);
