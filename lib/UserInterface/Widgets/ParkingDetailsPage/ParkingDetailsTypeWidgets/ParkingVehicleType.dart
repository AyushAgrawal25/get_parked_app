import 'package:getparked/StateManagement/Models/VehicleData.dart';
import 'package:getparked/StateManagement/Models/VehicleTypeData.dart';
import 'package:getparked/UserInterface/Icons/g_p_icons_icons.dart';
import 'package:getparked/UserInterface/Widgets/CustomIcon.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';

class ParkingVehicleType extends StatefulWidget {
  VehicleType type;
  ParkingVehicleType({@required this.type});
  @override
  _ParkingVehicleTypeState createState() => _ParkingVehicleTypeState();
}

class _ParkingVehicleTypeState extends State<ParkingVehicleType> {
  @override
  Widget build(BuildContext context) {
    IconData vehicleIcon = GPIcons.bike_bag;
    String vehicleName = "Bike";
    switch (widget.type) {
      case VehicleType.bike:
        vehicleName = "Bike";
        vehicleIcon = GPIcons.bike_bag;
        break;
      case VehicleType.mini:
        vehicleName = "Mini";
        vehicleIcon = GPIcons.hatch_back_car;
        break;
      case VehicleType.sedan:
        vehicleName = "Sedan";
        vehicleIcon = GPIcons.sedan_car;
        break;
      case VehicleType.suv:
        vehicleName = "SUV";
        vehicleIcon = GPIcons.suv_car;
        break;
      case VehicleType.van:
        vehicleName = "Van";
        vehicleIcon = GPIcons.van;
        break;
    }
    return Container(
      height: 47.5,
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 7.5),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: qbAppPrimaryThemeColor,
            borderRadius: BorderRadius.circular(360),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 0.25,
                  blurRadius: 5,
                  offset: Offset(2, 4),
                  color: Color.fromRGBO(0, 0, 0, 0.15))
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(
                "Vehicle Type : ",
                style: GoogleFonts.roboto(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
                textScaleFactor: 1.0,
              ),
            ),
            Container(
              child: Text(
                vehicleName,
                style: GoogleFonts.nunito(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
                textScaleFactor: 1.0,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              child: CustomIcon(
                icon: vehicleIcon,
                size: 16.5,
                type: CustomIconType.onHeight,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
