import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';

class RadioButton extends StatefulWidget {
  Color color;
  double innerRadius;
  double outterRadius;
  String value;
  String groupValue;
  Function onChanged;
  double height;
  double width;

  RadioButton(
      {this.color: Colors.blue,
      this.innerRadius: 4.5,
      this.outterRadius: 9,
      @required this.value,
      @required this.groupValue,
      @required this.onChanged,
      this.height: 35,
      this.width: 35});

  @override
  _RadioButtonState createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  Color centerColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    if (widget.groupValue == widget.value) {
      centerColor = widget.color;
    } else {
      centerColor = Colors.white;
    }

    return GestureDetector(
      onTap: () {
        SystemSound.play(SystemSoundType.click);
        widget.onChanged(widget.value);
      },
      child: Container(
        height: widget.height,
        width: widget.width,
        alignment: Alignment.center,
        child: Container(
          height: widget.outterRadius * 2,
          width: widget.outterRadius * 2,
          decoration: BoxDecoration(
              color: widget.color, borderRadius: BorderRadius.circular(360)),
          alignment: Alignment.center,
          child: Container(
            height: (widget.outterRadius * 2) - 4,
            width: (widget.outterRadius * 2) - 4,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(360)),
            alignment: Alignment.center,
            child: Container(
              height: (widget.innerRadius * 2),
              width: (widget.innerRadius * 2),
              decoration: BoxDecoration(
                  color: centerColor, borderRadius: BorderRadius.circular(360)),
            ),
          ),
        ),
      ),
    );
  }
}
