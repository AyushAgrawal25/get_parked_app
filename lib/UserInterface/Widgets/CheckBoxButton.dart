import 'package:flutter/material.dart';
import 'package:fluttericon/web_symbols_icons.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';

class CheckBoxButton extends StatefulWidget {
  @override
  _CheckBoxButtonState createState() => _CheckBoxButtonState();
}

class _CheckBoxButtonState extends State<CheckBoxButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      child: Stack(
        children: [
          //Bg Box
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.5),
                  border: Border.all(width: 2, color: Colors.black54)),
            ),
          ),

          Align(
            alignment: Alignment.center,
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  // border: Border.all(
                  //   color: qbAppPrimaryBlueColor
                  // )
                  ),
              child: Icon(
                WebSymbols.ok,
                size: 20,
                color: qbAppPrimaryBlueColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
