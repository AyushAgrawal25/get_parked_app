import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';

class QbFAB extends StatefulWidget {
  Widget child;
  Color color = qbAppPrimaryBlueColor;
  final Function onPressed;
  double size;
  bool isElevated;
  BoxBorder border;

  QbFAB(
      {@required this.child,
      @required this.onPressed,
      this.color,
      this.border,
      this.isElevated: true,
      this.size: 55});

  @override
  _QbFABState createState() => _QbFABState();
}

class _QbFABState extends State<QbFAB> {
  @override
  Widget build(BuildContext context) {
    if (widget.color == null) {
      widget.color = qbAppPrimaryBlueColor;
    }

    return GestureDetector(
      child: Container(
        height: widget.size,
        width: widget.size,
        decoration: BoxDecoration(
          border: widget.border,
          boxShadow: (widget.isElevated)
              ? [
                  BoxShadow(
                      blurRadius: 8,
                      spreadRadius: 0.3,
                      offset: Offset(0, 5),
                      color: Color.fromRGBO(0, 0, 0, 0.20)),
                ]
              : [],
          borderRadius: BorderRadius.circular(644464687),
          color: widget.color,
        ),
        child: Center(
          child: widget.child,
        ),
      ),
      onTap: () {
        SystemSound.play(SystemSoundType.click);
        widget.onPressed();
      },
    );
  }
}
