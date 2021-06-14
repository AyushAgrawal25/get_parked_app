import 'package:getparked/UserInterface/Widgets/ParkingDetailsPage/ParkingDetailsTypeWidgets/SqaureDetailsWidget.dart';
import 'package:flutter/material.dart';

class ParkingChargesWidget extends StatefulWidget {
  double charges;
  ParkingChargesWidget({@required this.charges});
  @override
  _ParkingChargesWidgetState createState() => _ParkingChargesWidgetState();
}

class _ParkingChargesWidgetState extends State<ParkingChargesWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SquareDetailsWidget(
        detailType: "Charges",
        mainText: widget.charges.toInt().toString(),
        subText: "₹/Hr",
        mainTextSize: 22.5,
        subTextSize: 14,
      ),
    );
  }
}
