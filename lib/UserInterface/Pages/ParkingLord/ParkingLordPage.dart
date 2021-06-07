import 'package:flutter/material.dart';
import 'package:getparked/UserInterface/Pages/ParkingLord/ParkingLord.dart';

class ParkingLordPage extends StatefulWidget {
  @override
  _ParkingLordPageState createState() => _ParkingLordPageState();
}

class _ParkingLordPageState extends State<ParkingLordPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ParkingLord(),
    );
  }
}
