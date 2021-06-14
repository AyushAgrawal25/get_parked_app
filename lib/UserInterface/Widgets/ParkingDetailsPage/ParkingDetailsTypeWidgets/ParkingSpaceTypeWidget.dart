import 'package:getparked/UserInterface/Widgets/ParkingDetailsPage/ParkingDetailsTypeWidgets/SqaureDetailsWidget.dart';
import 'package:flutter/material.dart';

class ParkingSpaceTypeWidget extends StatefulWidget {
  int spaceType;
  ParkingSpaceTypeWidget({@required this.spaceType});
  @override
  _ParkingSpaceTypeWidgetState createState() => _ParkingSpaceTypeWidgetState();
}

class _ParkingSpaceTypeWidgetState extends State<ParkingSpaceTypeWidget> {
  @override
  Widget build(BuildContext context) {
    String mainText = "";
    String subText = "";
    if (widget.spaceType == 1) {
      mainText = "I";
      subText = "Shed";
    } else {
      mainText = "O";
      subText = "Open";
    }
    return Container(
      child: SquareDetailsWidget(
        detailType: "Space Type",
        mainText: mainText,
        subText: subText,
        mainTextSize: 25,
        subTextSize: 14,
      ),
    );
  }
}
