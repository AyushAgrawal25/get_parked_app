import 'package:flutter/material.dart';

class DesignButton extends StatefulWidget {
  double height;
  var padding=EdgeInsets.all(0);
  Widget child;
  BoxDecoration decoration;
  final Function onPressed;
  DesignButton({this.height, this.padding, @required this.child, @required this.onPressed, this.decoration});

  @override
  _DesignButtonState createState() => _DesignButtonState();
}

class _DesignButtonState extends State<DesignButton> {
  @override
  Widget build(BuildContext context) {
    
    return MaterialButton(
      minWidth: 0,
      padding: EdgeInsets.all(0),
      color: Colors.transparent,
      elevation: 0.0,
      height: 10,
      child: Container(
        decoration: widget.decoration,
        height: widget.height,
        padding: widget.padding,
        child: widget.child,
      ),
      onPressed: (){
        widget.onPressed();
      },
    );
  }
}