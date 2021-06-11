import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/EdgeLessButton.dart';
import 'package:getparked/UserInterface/Widgets/UnderLineTextFormField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class PhoneNumberPopUp {
  show(String correctPhNum, String dialCode, String phNumDetail,
      Function onCorrectPhNum, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: PhoneNumberPopUpContent(
            correctPhNum: correctPhNum,
            dialCode: dialCode,
            phNumDetails: phNumDetail,
            onCorrectPhNum: onCorrectPhNum,
          ),
        );
      },
    );
  }
}

bool toShowPhNumIncorrectError(String enteredPhNum, String correctPhNum) {
  if (enteredPhNum.trim() == correctPhNum.trim()) {
    return false;
  } else {
    if (enteredPhNum.trim().length == correctPhNum.trim().length) {
      return true;
    }
    return false;
  }
}

class PhoneNumberPopUpContent extends StatefulWidget {
  String correctPhNum;
  String dialCode;
  String phNumDetails;
  Function onCorrectPhNum;

  PhoneNumberPopUpContent({
    @required this.correctPhNum,
    @required this.dialCode,
    @required this.phNumDetails,
    @required this.onCorrectPhNum,
  });
  @override
  _PhoneNumberPopUpContentState createState() =>
      _PhoneNumberPopUpContentState();
}

class _PhoneNumberPopUpContentState extends State<PhoneNumberPopUpContent> {
  TextEditingController otpController;
  String enteredPhNum;
  bool showError;

  @override
  void initState() {
    super.initState();
    enteredPhNum = "";
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
            height: 15,
          ),
          Container(
            child: Text(
              "Verify",
              style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: qbDetailDarkColor),
              textScaleFactor: 1.0,
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(
            height: 12.5,
          ),

          //Text
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              widget.phNumDetails,
              style: GoogleFonts.roboto(
                  height: 1.5,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: qbAppTextColor),
              textAlign: TextAlign.center,
              textScaleFactor: 1.0,
            ),
          ),

          SizedBox(
            height: 10,
          ),

          // Input Text Field
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    (widget.dialCode != null) ? widget.dialCode : "+91",
                    style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: qbAppTextColor),
                    textScaleFactor: 1.0,
                  ),
                ),
                Expanded(
                  child: UnderLineTextFormField(
                    labelText: "Phone Number",
                    onChange: (String phNum) {
                      setState(() {
                        enteredPhNum = phNum;
                        if ((showError) &&
                            (!toShowPhNumIncorrectError(
                                enteredPhNum, widget.correctPhNum))) {
                          showError = false;
                        }
                      });
                    },
                  ),
                )
              ],
            ),
          ),

          (showError)
              ? Container(
                  padding:
                      EdgeInsets.only(top: 10, bottom: 0, left: 15, right: 15),
                  child: Text(
                    "Entered Phone Number is incorrect.",
                    style: GoogleFonts.roboto(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                        color: qbAppSecondaryRedColor,
                        letterSpacing: 0.75),
                    textAlign: TextAlign.center,
                    textScaleFactor: 1.0,
                  ),
                )
              : Container(height: 0, width: 0),

          SizedBox(
            height: 10,
          ),

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
                if (toShowPhNumIncorrectError(
                    enteredPhNum, widget.correctPhNum)) {
                  setState(() {
                    showError = true;
                  });
                } else {
                  Navigator.of(context).pop();
                  widget.onCorrectPhNum();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
