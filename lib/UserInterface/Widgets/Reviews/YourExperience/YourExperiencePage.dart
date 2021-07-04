import 'package:getparked/StateManagement/Models/SlotData.dart';
import 'package:getparked/UserInterface/Widgets/FormFieldHeader.dart';
import 'package:flutter/material.dart';
import 'package:getparked/UserInterface/Widgets/Loaders/LoaderPage.dart';
import 'package:getparked/UserInterface/Widgets/Reviews/YourExperience/YourExperience.dart';

class YourExperiencePage extends StatefulWidget {
  SlotData slotData;
  int parkingId;
  int vehicleTypeMasterId;
  YourExperiencePage(
      {@required this.slotData,
      @required this.vehicleTypeMasterId,
      @required this.parkingId});
  @override
  _YourExperiencePageState createState() => _YourExperiencePageState();
}

class _YourExperiencePageState extends State<YourExperiencePage> {
  bool gpLoadStatus = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: (gpLoadStatus)
          ? LoaderPage()
          : YourExperience(
              changeLoadStatus: onLoadStatusChange,
              vehicleTypeMasterId: widget.vehicleTypeMasterId,
              exit: () {
                Navigator.of(context).pop();
              },
              parkingId: widget.parkingId,
              slotData: widget.slotData,
            ),
    );
  }

  onLoadStatusChange(bool loadStatus) {
    setState(() {
      gpLoadStatus = loadStatus;
    });
  }
}
