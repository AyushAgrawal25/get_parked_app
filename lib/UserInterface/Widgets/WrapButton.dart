import 'package:flutter/material.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';

class WrapButton extends StatefulWidget {
  double height;
  double width;
  EdgeInsets padding = EdgeInsets.all(0);
  Color color = qbAppPrimaryBlueColor;
  Widget child;
  Function onPressed;
  BorderRadius borderRadius;

  WrapButton(
      {this.height,
      this.width,
      this.padding,
      @required this.child,
      this.color,
      @required this.onPressed,
      this.borderRadius});

  @override
  _WrapButtonState createState() => _WrapButtonState();
}

class _WrapButtonState extends State<WrapButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 0,
      padding: EdgeInsets.all(0),
      color: Colors.transparent,
      elevation: 0.0,
      height: 10,
      child: Container(
        width: widget.width,
        height: widget.height,
        padding: widget.padding,
        child: widget.child,
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius,
          boxShadow: [
            BoxShadow(
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 0.25,
                color: Color.fromRGBO(0, 0, 0, 0.15))
          ],
          color: widget.color,
        ),
      ),
      onPressed: () {
        widget.onPressed();
      },
    );
  }
}
