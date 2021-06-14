import 'package:getparked/UserInterface/Widgets/ParkingDetailsPage/ParkingDetailsTypeWidgets/SqaureDetailsWidget.dart';
import 'package:flutter/material.dart';

class ParkingHoursWidget extends StatefulWidget {
  int parkingHours;
  ParkingHoursWidget({@required this.parkingHours});
  @override
  _ParkingHoursWidgetState createState() => _ParkingHoursWidgetState();
}

class _ParkingHoursWidgetState extends State<ParkingHoursWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SquareDetailsWidget(
        detailType: "Parking Hours",
        mainText: widget.parkingHours.toString(),
        subText: "Hour" + ((widget.parkingHours > 1) ? "s" : ""),
        mainTextSize: 25,
        subTextSize: 14,
      ),
    );
  }
}
