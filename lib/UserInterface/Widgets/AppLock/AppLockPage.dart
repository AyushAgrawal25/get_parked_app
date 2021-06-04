import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/UserInterface/Widgets/AppLock/AppLockKeyboard.dart';
import 'package:getparked/UserInterface/Widgets/AppLock/AppLockInputField.dart';
import 'package:getparked/UserInterface/Widgets/Loaders/LoaderPage.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/OTPPopUp.dart';
import 'package:getparked/UserInterface/Widgets/PhoneNumberPopUp.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AppLockPage extends StatefulWidget {
  String pin;
  AppLockPage({@required this.pin});
  @override
  _AppLockPageState createState() => _AppLockPageState();
}

class _AppLockPageState extends State<AppLockPage> {
  AppState gpAppState;
  AppLockKeyboardController kbController;
  @override
  void initState() {
    super.initState();
    gpAppState = Provider.of<AppState>(context, listen: false);
  }

  String encodePhNum(String phNum) {
    String enPhNum = "";
    for (int i = 0; i < phNum.length; i++) {
      if (i < phNum.length - 3) {
        enPhNum += "x";
      } else {
        enPhNum += phNum[i];
      }
    }

    return enPhNum;
  }

  String pinText = "";
  onChange(String text) {
    print(text);
    setState(() {
      pinText = text;
    });

    if (widget.pin == pinText) {
      print("Correct Pin Entered..");
    }
  }

  bool isLoading = false;
  loadHandler(bool status) {
    setState(() {
      isLoading = status;
    });
  }

  onForgotPin() async {
    loadHandler(true);
    // await Future.delayed(Duration(seconds: 3));
    PhoneNumberPopUp().show(
        gpAppState.userDetails.phoneNumber,
        gpAppState.userDetails.dialCode,
        "Please type the registered phone number\n${gpAppState.userDetails.dialCode} " +
            encodePhNum(gpAppState.userDetails.phoneNumber),
        onCorrectPhNumEntered,
        context);
    loadHandler(false);
  }

  onCorrectPhNumEntered() {
    print("Correct Phone Number Entered");
    loadHandler(true);
    // Call API For OTP
    String otpForChange = "7894";
    OTPPopUp().show(
        otpForChange,
        "Please type 4-digit code sent to\n${gpAppState.userDetails.dialCode} ${gpAppState.userDetails.phoneNumber}",
        onCorrectOTPEntered,
        context);
    loadHandler(false);
  }

  onCorrectOTPEntered() {
    print("Correct OTP");
  }

  Widget forgotAndChangePin = Container();
  setForgotAndChangePin() {
    forgotAndChangePin = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Forgot Pin
          Container(
            child: FlatButton(
              child: Text(
                "Forgot Pin",
                style: GoogleFonts.nunito(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                    color: qbAppPrimaryBlueColor),
                textScaleFactor: 1.0,
              ),
              onPressed: onForgotPin,
            ),
          ),

          // Change Pin
          Container(
            child: FlatButton(
              child: Text(
                "Change Pin",
                style: GoogleFonts.nunito(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                    color: qbAppPrimaryBlueColor),
                textScaleFactor: 1.0,
              ),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    setForgotAndChangePin();
    return Container(
        child: Stack(
      children: [
        // Main Page
        Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: qbAppTextColor,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            brightness: Brightness.light,
          ),
          body: Container(
            child: Column(
              children: [
                // Main Info Aur Rest Other THings
                Expanded(
                  child: Container(),
                ),

                Container(
                  child: AppLockInputField(
                    text: pinText,
                    type: AppLockInputFieldType.password,
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                // Forgot And Change Pin
                forgotAndChangePin,

                // Key Board
                AppLockKeyboard(
                  onChange: onChange,
                  getController: (controller) {
                    kbController = controller;
                  },
                )
              ],
            ),
          ),
        ),

        (isLoading)
            ? Container(
                child: LoaderPage(),
              )
            : Container(
                height: 0,
                width: 0,
              )
      ],
    ));
  }
}
