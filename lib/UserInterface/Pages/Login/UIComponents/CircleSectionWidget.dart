import 'dart:math';

import 'package:flutter/material.dart';

class CircleSectionWidget extends StatelessWidget {
  double width;
  Color color;
  double topMargin;
  List<BoxShadow> boxShadow;
  CircleSectionWidget(
      {@required this.width,
      this.color: Colors.white,
      this.topMargin: 5,
      this.boxShadow});
  @override
  Widget build(BuildContext context) {
    double rad = this.width;
    double height = rad * (1 - (1.732 / 2));

    return Container(
      child: ClipRect(
        child: Align(
          alignment: Alignment.topCenter,
          heightFactor: (height + topMargin) / rad,
          child: Container(
            height: rad,
            width: rad,
            child: FractionallySizedBox(
              heightFactor: 2,
              widthFactor: 2,
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: topMargin),
                decoration: BoxDecoration(
                    boxShadow: (this.boxShadow != null) ? this.boxShadow : [],
                    color: this.color,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(rad),
                      topRight: Radius.circular(rad),
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
