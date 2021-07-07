import 'dart:math';

import 'package:flutter/material.dart';
import 'package:getparked/StateManagement/Models/VehicleData.dart';
import 'package:getparked/StateManagement/Models/VehicleTypeData.dart';
import 'package:getparked/UserInterface/Icons/g_p_icons_icons.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/CustomIcon.dart';
import 'package:getparked/UserInterface/Widgets/FormFieldHeader.dart';

class VehicleTile extends StatelessWidget {
  final VehicleData vehicleData;
  final double tileSize;
  final double iconSize;
  VehicleTile(
      {@required this.vehicleData,
      @required this.tileSize,
      @required this.iconSize});

  @override
  Widget build(BuildContext context) {
    IconData vehicleIcon = GPIcons.bike_bag;
    String vehicleName = "Bike";
    switch (this.vehicleData.type) {
      case VehicleType.bike:
        vehicleIcon = GPIcons.bike_bag;
        vehicleName = "Bike";
        break;
      case VehicleType.mini:
        vehicleIcon = GPIcons.hatch_back_car;
        vehicleName = "Mini";
        break;
      case VehicleType.sedan:
        vehicleIcon = GPIcons.sedan_car;
        vehicleName = "Sedan";
        break;
      case VehicleType.van:
        vehicleIcon = GPIcons.van;
        vehicleName = "Van";
        break;
      case VehicleType.suv:
        vehicleIcon = GPIcons.suv_car;
        vehicleName = "SUV";
        break;
    }
    return Container(
      child: Container(
        height: this.tileSize,
        width: this.tileSize,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.5),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 0.025,
                  blurRadius: 5,
                  offset: Offset(10, 5),
                  color: Color.fromRGBO(0, 0, 0, 0.04)),
            ],
            // color: qbDividerLightColor
            color: qbWhiteBGColor),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: CustomIcon(
                icon: vehicleIcon,
                size: this.iconSize,
                color: qbAppTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
