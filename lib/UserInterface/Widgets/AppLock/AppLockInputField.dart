import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';

class AppLockInputField extends StatelessWidget {
  String text;
  AppLockInputFieldType type;

  AppLockInputField({@required this.text, @required this.type});

  List<AppLockInputBox> inputBoxes = [];

  setInputBoxes() {
    int textLen = this.text.length;
    if (textLen == 4) {
      for (int i = 0; i < 4; i++) {
        bool isInputActive = false;
        if (i == 3) {
          isInputActive = true;
        }

        inputBoxes.add(AppLockInputBox(
          isActive: isInputActive,
          text: this.text[i],
          type: this.type,
        ));
      }
    } else {
      for (int i = 0; i < 4; i++) {
        bool isInputActive = false;
        String boxText = "";
        if (i < textLen) {
          boxText = this.text[i];
        }
        if (i == textLen) {
          isInputActive = true;
        }

        inputBoxes.add(AppLockInputBox(
          isActive: isInputActive,
          text: boxText,
          type: this.type,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    setInputBoxes();
    return Container(
      child: Row(mainAxisSize: MainAxisSize.min, children: inputBoxes),
    );
  }
}

class AppLockInputBox extends StatelessWidget {
  String text;
  bool isActive;
  AppLockInputFieldType type;
  AppLockInputBox(
      {@required this.isActive, @required this.text, @required this.type});

  Widget inputBox = Container(
    height: 0,
    width: 0,
  );

  @override
  Widget build(BuildContext context) {
    if (this.type == AppLockInputFieldType.password) {
      inputBox = Container(
          height: 30,
          width: 30,
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 40),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60),
              border: Border.all(
                  width: 1.75,
                  color: (isActive)
                      ? qbAppSecondaryGreenColor
                      : qbDividerLightColor)),
          child: ((this.text != null) && (this.text.length > 0))
              ? Container(
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(
                      color: qbAppTextColor, shape: BoxShape.circle),
                )
              : Container(
                  height: 0,
                  width: 0,
                ));
    } else if (this.type == AppLockInputFieldType.normal) {
      inputBox = Container(
        height: 50,
        width: 50,
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 40),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
            border: Border.all(
                width: 1.75,
                color:
                    (isActive) ? qbAppPrimaryThemeColor : qbDividerLightColor)),
        child: Text(
          this.text,
          style: GoogleFonts.openSans(
              color: qbAppTextColor, fontSize: 20, fontWeight: FontWeight.w500),
          textScaleFactor: 1.0,
        ),
      );
    }
    return inputBox;
  }
}

enum AppLockInputFieldType { normal, password }
