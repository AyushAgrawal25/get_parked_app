import 'package:getparked/UserInterface/Widgets/EdgeLessButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/CustomButton.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:getparked/UserInterface/Widgets/qbFAB.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:pinput/pin_put/pin_put.dart';

class PhoneNumberOTPPopUp {
  show(BuildContext context,
      {String correctOtp,
      String phoneNumber,
      String dialCode,
      Function onChangePhNum,
      Function onCorrentOTPEntered}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            contentPadding:
                EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 10),
            content: PhoneNumberOTPPopUpContent(
              correctOTP: correctOtp,
              dialCode: dialCode,
              phNum: phoneNumber,
              onChangePhNum: onChangePhNum,
              onCorrectOTPEntered: () {
                onCorrentOTPEntered();
                Navigator.of(context).pop();
              },
            ));
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

class PhoneNumberOTPPopUpContent extends StatefulWidget {
  String phNum;
  String dialCode;
  String correctOTP;
  Function onChangePhNum;
  Function onCorrectOTPEntered;
  PhoneNumberOTPPopUpContent(
      {this.phNum,
      this.dialCode,
      this.correctOTP,
      this.onCorrectOTPEntered,
      this.onChangePhNum});
  @override
  _PhoneNumberOTPPopUpContentState createState() =>
      _PhoneNumberOTPPopUpContentState();
}

class _PhoneNumberOTPPopUpContentState
    extends State<PhoneNumberOTPPopUpContent> {
  String gpUserEnteredOTP = "";
  bool showError = false;
  onValidate() {
    if (toShowOTPIncorrectError(gpUserEnteredOTP, widget.correctOTP)) {
      setState(() {
        showError = true;
      });
    } else {
      if (gpUserEnteredOTP == widget.correctOTP) {
        widget.onCorrectOTPEntered();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
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

            Container(
              child: Text(
                "Enter The OTP sent to Phone Number.",
                style: GoogleFonts.roboto(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w500,
                  color: qbDetailLightColor,
                  // letterSpacing: 0.75
                ),
                textAlign: TextAlign.center,
                textScaleFactor: 1.0,
              ),
            ),

            SizedBox(
              height: 20,
            ),

            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Phone Number
                  Container(
                    child: Text(
                      "${widget.dialCode} ${widget.phNum}",
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: qbDetailDarkColor,
                      ),
                      textScaleFactor: 1.0,
                    ),
                  ),

                  SizedBox(
                    width: 20,
                  ),

                  Container(
                    child: QbFAB(
                      size: 35,
                      color: qbAppPrimaryBlueColor,
                      child: Icon(
                        FontAwesome.pencil,
                        size: 15,
                        color: qbWhiteBGColor,
                      ),
                      onPressed: () {
                        widget.onChangePhNum();
                        Navigator.of(context).pop();
                      },
                    ),
                  )
                ],
              ),
            ),

            SizedBox(
              height: 5,
            ),

            // Change Phone Number Button
            // Container(
            //   alignment: Alignment.centerRight,
            //   child: CustomButton(
            //     child: Text(
            //       "Change",
            //       style: GoogleFonts.roboto(
            //         fontSize: 13.5,
            //         fontWeight: FontWeight.w500,
            //         color: Colors.white,
            //       ),
            //       textScaleFactor: 1.0,
            //     ),
            //     borderRadius: BorderRadius.circular(5),
            //     padding: EdgeInsets.symmetric(vertical: 7.5, horizontal: 15),
            //     onPressed: () {
            //       Navigator.of(context).pop();
            //     },
            //   ),
            // ),

            // SizedBox(height: 12.5),
            // OTP Field
            // Container(
            //   padding: EdgeInsets.only(top: 13.5, left: 20, right: 20),
            //   child: PinCodeTextField(
            //     onTextChanged: (String otp) {
            //       print(otp + " Entered Value...");
            //       setState(() {
            //         gpUserEnteredOTP = otp;
            //         if ((showError) &&
            //             (!toShowOTPIncorrectError(
            //                 gpUserEnteredOTP, widget.correctOTP))) {
            //           showError = false;
            //         }
            //       });
            //     },
            //     autofocus: true,
            //     highlight: true,
            //     keyboardType: TextInputType.phone,
            //     highlightColor: qbAppSecondaryBlueColor,
            //     pinBoxColor: qbAppTextColor,
            //     pinBoxHeight: 20,
            //     pinBoxWidth: 20,
            //     pinBoxDecoration:
            //         ProvidedPinBoxDecoration.underlinedPinBoxDecoration,
            //     wrapAlignment: WrapAlignment.spaceAround,
            //     pinTextStyle: GoogleFonts.roboto(
            //         fontSize: 15 / MediaQuery.of(context).textScaleFactor,
            //         fontWeight: FontWeight.w500,
            //         color: Colors.black),
            //   ),
            // ),

            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 13.5, left: 20, right: 20),
              child: PinPut(
                withCursor: true,
                fieldsCount: 4,
                onChanged: (String otp) {
                  // print(otp + " Entered Value...");
                  setState(() {
                    gpUserEnteredOTP = otp;
                    if ((showError) &&
                        (!toShowOTPIncorrectError(
                            gpUserEnteredOTP, widget.correctOTP))) {
                      showError = false;
                    }
                  });
                },
                fieldsAlignment: MainAxisAlignment.spaceEvenly,
                eachFieldHeight: 40,
                eachFieldWidth: 40,
                eachFieldMargin: EdgeInsets.symmetric(horizontal: 2.5),
                keyboardType: TextInputType.phone,
                selectedFieldDecoration: BoxDecoration(
                  border:
                      Border.all(color: Colors.deepPurpleAccent, width: 1.5),
                  borderRadius: BorderRadius.circular(360),
                ),
                followingFieldDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(
                    width: 1.5,
                    color: Colors.deepPurpleAccent.withOpacity(.5),
                  ),
                ),
              ),
            ),

            (showError)
                ? Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top: 5, bottom: 15),
                    child: Text(
                      "Incorrect.",
                      style: GoogleFonts.roboto(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w400,
                          color: qbAppPrimaryRedColor,
                          letterSpacing: 0.75),
                      textScaleFactor: 1.0,
                    ),
                  )
                : Container(height: 0, width: 0),

            SizedBox(
              height: 5,
            ),

            //Confirm
            Container(
              child: EdgeLessButton(
                color: qbAppPrimaryBlueColor,
                padding: EdgeInsets.symmetric(vertical: 7.5, horizontal: 25),
                onPressed: onValidate,
                child: Text(
                  "Validate",
                  style: GoogleFonts.nunito(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                  textScaleFactor: 1.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
