import 'package:flutter/material.dart';
import 'package:getparked/UserInterface/Pages/LiveSlot/LiveSlot.dart';

class LiveSlotPage extends StatefulWidget {
  @override
  _LiveSlotPageState createState() => _LiveSlotPageState();
}

class _LiveSlotPageState extends State<LiveSlotPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: LiveSlot(),
    );
  }
}
