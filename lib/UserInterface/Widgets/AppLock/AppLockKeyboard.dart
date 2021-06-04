import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:getparked/UserInterface/Widgets/qbFAB.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';

class AppLockKeyboard extends StatefulWidget {
  Function(AppLockKeyboardController) getController;
  Function(String) onChange;
  Function onDone;
  int length;
  bool showDoneButton;

  AppLockKeyboard(
      {@required this.getController,
      this.onDone,
      @required this.onChange,
      this.length: 4,
      this.showDoneButton: false});

  @override
  _AppLockKeyboardState createState() => _AppLockKeyboardState();
}

class AppLockKeyboardController {
  Function clear;
  Function getText;
  AppLockKeyboardController(clearFun, getTextFun) {
    clear = clearFun;
    getText = getTextFun;
  }
}

class _AppLockKeyboardState extends State<AppLockKeyboard> {
  @override
  void initState() {
    super.initState();
    AppLockKeyboardController appLockKeyboardController =
        AppLockKeyboardController(() {
      setState(() {
        outputText = "";
      });
    }, () {
      return outputText;
    });

    widget.getController(appLockKeyboardController);
  }

  String outputText = "";
  List<Widget> keysRows = [];

  onKeyPressed(String inputChar) {
    if (widget.length > outputText.length) {
      outputText += inputChar;
      widget.onChange(outputText);
    }
  }

  onDeletePressed() {
    if (outputText.length > 0) {
      String newOutputText = "";
      for (int i = 0; i < (outputText.length - 1); i++) {
        newOutputText += outputText[i];
      }
      outputText = newOutputText;
      widget.onChange(outputText);
    }
  }

  onLongDeletePressed() {
    if (outputText.length > 0) {
      outputText = "";
      widget.onChange(outputText);
    }
  }

  setUpKeysRow() {
    keysRows = [];
    List<Widget> kbKeys = [];
    for (int i = 1; i <= 9; i++) {
      kbKeys.add(AppLockKeyboardKey(
          keyText: "$i",
          type: AppLockKeyboardKeyType.key,
          onPressed: () {
            onKeyPressed("$i");
          }));
      if (i % 3 == 0) {
        keysRows.add(Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: kbKeys,
          ),
        ));
        kbKeys = [];
      }
    }

    keysRows.add(Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppLockKeyboardKey(
            keyText: "",
            type: AppLockKeyboardKeyType.delete,
            onPressed: onDeletePressed,
            onLongPressed: onLongDeletePressed,
          ),
          AppLockKeyboardKey(
              keyText: "0",
              type: AppLockKeyboardKeyType.key,
              onPressed: () {
                this.widget.onChange("0");
              }),
          AppLockKeyboardKey(
              keyText: "",
              type: (widget.showDoneButton)
                  ? AppLockKeyboardKeyType.done
                  : AppLockKeyboardKeyType.blank,
              onPressed: () {
                if ((widget.showDoneButton) && (widget.onDone != null)) {
                  widget.onDone();
                }
              }),
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    setUpKeysRow();
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 14),
      height: MediaQuery.of(context).size.width * 2.85 / 4,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Column(children: keysRows),
    );
  }
}

class AppLockKeyboardKey extends StatelessWidget {
  AppLockKeyboardKeyType type;
  String keyText;
  Function onPressed;
  Function onLongPressed;
  AppLockKeyboardKey(
      {@required this.keyText,
      @required this.type,
      @required this.onPressed,
      this.onLongPressed});

  Widget keyWidget = Container(
    height: 0,
    width: 0,
  );
  setKeyWidget(fontSize) {
    switch (type) {
      case AppLockKeyboardKeyType.blank:
        keyWidget = Container(
          height: 0,
          width: 0,
        );
        break;
      case AppLockKeyboardKeyType.delete:
        keyWidget = Container(
          height: 40,
          width: 40,
          decoration:
              BoxDecoration(color: qbAppTextColor, shape: BoxShape.circle),
          padding: EdgeInsets.only(right: 2.5),
          alignment: Alignment.center,
          child: Icon(
            FontAwesome5.caret_left,
            color: Colors.white,
            size: 22.5,
          ),
        );
        break;
      case AppLockKeyboardKeyType.done:
        keyWidget = Container(
          height: 42.5,
          width: 42.5,
          decoration: BoxDecoration(
              color: qbAppPrimaryGreenColor, shape: BoxShape.circle),
          padding: EdgeInsets.only(right: 2.5),
          alignment: Alignment.center,
          child: Icon(
            FontAwesome5.check,
            color: Colors.white,
            size: 17.5,
          ),
        );
        break;
      case AppLockKeyboardKeyType.key:
        keyWidget = Text(
          keyText,
          style: GoogleFonts.openSans(
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
            color: qbAppTextColor,
          ),
          textScaleFactor: 1.0,
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    double fontSize = MediaQuery.of(context).size.width * 0.075;
    // double fontSize = 32;
    setKeyWidget(fontSize);
    return GestureDetector(
      onTap: () {
        SystemSound.play(SystemSoundType.click);
        this.onPressed();
      },
      onLongPress: () {
        if (type == AppLockKeyboardKeyType.delete) {
          SystemSound.play(SystemSoundType.click);
          if (this.onLongPressed != null) {
            this.onLongPressed();
          }
        }
      },
      child: Container(
        color: Colors.transparent,
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.width / 5,
        width: MediaQuery.of(context).size.width / 4,
        child: Container(
            alignment: Alignment.center,
            height: 60,
            width: 60,
            child: keyWidget),
      ),
    );
  }
}

enum AppLockKeyboardKeyType { key, delete, blank, done }
