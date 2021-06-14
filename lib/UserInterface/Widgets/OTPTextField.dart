import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';

class OTPTextField extends StatefulWidget {
  final Function(String) onChanged;
  OTPTextField({@required this.onChanged});
  @override
  _OTPTextFieldState createState() => _OTPTextFieldState();
}

class _OTPTextFieldState extends State<OTPTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: PinPut(
        onChanged: widget.onChanged,
        withCursor: true,
        fieldsCount: 4,
        mainAxisSize: MainAxisSize.max,
        fieldsAlignment: MainAxisAlignment.spaceEvenly,
        eachFieldHeight: 40,
        eachFieldWidth: 40,
        eachFieldMargin: EdgeInsets.symmetric(horizontal: 2.5),
        keyboardType: TextInputType.phone,
        selectedFieldDecoration: BoxDecoration(
          border: Border.all(color: Colors.deepPurpleAccent, width: 1.5),
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
    );
  }
}
