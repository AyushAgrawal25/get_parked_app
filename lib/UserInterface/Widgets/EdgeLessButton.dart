import 'package:flutter/material.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';

class EdgeLessButton extends StatefulWidget {
  double height;
  double width;
  EdgeInsets padding;
  EdgeInsets margin;
  Color color;
  Function onPressed;
  Widget child;
  BoxBorder border;

  EdgeLessButton(
      {this.height,
      this.width,
      this.padding,
      this.margin,
      this.border,
      this.color: Colors.blue,
      @required this.onPressed,
      @required this.child});

  @override
  _EdgeLessButtonState createState() => _EdgeLessButtonState();
}

class _EdgeLessButtonState extends State<EdgeLessButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 0,
      height: 0,
      padding: EdgeInsets.all(0),
      child: Container(
          width: widget.width,
          height: widget.height,
          padding: widget.padding,
          margin: widget.margin,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    spreadRadius: 0.25,
                    blurRadius: 5,
                    offset: Offset(2, 4),
                    color: Color.fromRGBO(0, 0, 0, 0.15))
              ],
              border: widget.border,
              borderRadius: BorderRadius.circular(454546),
              color: widget.color),
          child: widget.child),
      onPressed: () {
        widget.onPressed();
      },
    );
  }
}
