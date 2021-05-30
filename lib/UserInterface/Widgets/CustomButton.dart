import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';

class CustomButton extends StatefulWidget {
  Widget child;
  Color color;
  BorderRadius borderRadius;
  EdgeInsets padding;
  EdgeInsets margin;
  double width;
  double height;
  Function onPressed;
  Border border;

  CustomButton(
      {this.child,
      this.color: Colors.blue,
      this.borderRadius,
      this.border,
      this.height,
      this.margin,
      this.padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      this.width,
      @required this.onPressed});

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.margin,
      child: GestureDetector(
        onTap: () {
          SystemSound.play(SystemSoundType.click);
          widget.onPressed();
        },
        child: Container(
          padding: widget.padding,
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
              color: widget.color,
              borderRadius: widget.borderRadius,
              border: widget.border,
              boxShadow: [
                BoxShadow(
                    blurRadius: 5,
                    color: Color.fromRGBO(0, 0, 0, 0.1),
                    spreadRadius: 0.25,
                    offset: Offset(2, 4))
              ]),
          child: widget.child,
        ),
      ),
    );
  }
}
