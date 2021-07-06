import 'package:getparked/StateManagement/Models/SlotData.dart';
import 'package:getparked/StateManagement/Models/VehicleData.dart';
import 'package:getparked/StateManagement/Models/VehicleTypeData.dart';
import 'package:getparked/UserInterface/Widgets/FormFieldHeader.dart';
import 'package:flutter/material.dart';
import 'package:getparked/UserInterface/Widgets/Loaders/LoaderPage.dart';
import 'package:getparked/UserInterface/Widgets/Reviews/YourExperience/YourExperience.dart';

class YourExperiencePage extends StatefulWidget {
  final SlotData slotData;
  final int parkingId;
  final VehicleType vehicleType;
  YourExperiencePage(
      {@required this.slotData,
      @required this.vehicleType,
      @required this.parkingId});
  @override
  _YourExperiencePageState createState() => _YourExperiencePageState();
}

class _YourExperiencePageState extends State<YourExperiencePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: YourExperience(
        vehicleType: widget.vehicleType,
        parkingId: widget.parkingId,
        slotData: widget.slotData,
      ),
    );
  }
}
