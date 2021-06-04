import 'package:getparked/UserInterface/Widgets/AppLock/AppLockInputField.dart';
import 'package:getparked/UserInterface/Widgets/AppLock/AppLockKeyboard.dart';
import 'package:getparked/UserInterface/Widgets/Loaders/LoaderPage.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppLockPinChangePage extends StatefulWidget {
  @override
  _AppLockPinChangePageState createState() => _AppLockPinChangePageState();
}

class _AppLockPinChangePageState extends State<AppLockPinChangePage> {
  AppLockKeyboardController kbController;
  bool isLoading = false;
  loadHandler(bool status) {
    setState(() {
      isLoading = status;
    });
  }

  String pinText = "";
  onChange(String text) {
    print(text);
    setState(() {
      pinText = text;
    });
  }

  String confirmPin = "";
  bool isPinFirstTimeEntered = false;
  onDone() {
    if (pinText.length == 4) {
      if (isPinFirstTimeEntered == false) {
        // When Pin Entered For First Time.
        setState(() {
          confirmPin = pinText;
          pinText = "";
          kbController.clear();
          isPinFirstTimeEntered = true;
        });
      } else {
        // When Pin Re-Entered.
        if (confirmPin == pinText) {
          changePin();
        }
      }
    }
  }

  changePin() async {
    loadHandler(true);
    await Future.delayed(Duration(seconds: 1));
    print("Changing Pin");
    print("API Calling For THIS..");
    print("Head Back To App Lock Page Push Replacement");
    loadHandler(false);
  }

  @override
  Widget build(BuildContext context) {
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

                // Title
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    (isPinFirstTimeEntered) ? "Re-enter Pin" : "Enter New Pin",
                    style: GoogleFonts.nunito(
                        fontSize: 17.5,
                        fontWeight: FontWeight.w600,
                        color: qbAppTextColor),
                    textScaleFactor: 1.0,
                  ),
                ),

                Container(
                  child: AppLockInputField(
                    text: pinText,
                    type: AppLockInputFieldType.password,
                  ),
                ),

                SizedBox(
                  height: 15,
                ),

                // Key Board
                AppLockKeyboard(
                  getController: (controller) {
                    kbController = controller;
                  },
                  onDone: onDone,
                  onChange: onChange,
                  showDoneButton: true,
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
