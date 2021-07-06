import 'package:getparked/StateManagement/Models/VehicleTypeData.dart';
import 'package:getparked/UserInterface/Icons/g_p_icons_icons.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/CustomIcon.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TabHeader extends StatelessWidget {
  final VehicleType vehicleType;
  TabHeader({@required this.vehicleType});
  @override
  Widget build(BuildContext context) {
    IconData icon = GPIcons.bike_bag;
    String name = "Bike";

    switch (this.vehicleType) {
      case VehicleType.bike:
        icon = GPIcons.bike_bag;
        name = "Bike";
        break;
      case VehicleType.mini:
        icon = GPIcons.hatch_back_car;
        name = "Mini";
        break;
      case VehicleType.sedan:
        icon = GPIcons.sedan_car;
        name = "Sedan";
        break;
      case VehicleType.van:
        icon = GPIcons.van;
        name = "Van";
        break;
      case VehicleType.suv:
        icon = GPIcons.suv_car;
        name = "SUV";
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomIcon(
            size: 14.5,
            type: CustomIconType.onHeight,
            icon: icon,
            color: qbAppTextColor,
          ),
          SizedBox(
            height: 2.5,
          ),
          Text(
            name,
            style: GoogleFonts.nunito(
                fontSize: 11,
                color: qbAppTextColor,
                fontWeight: FontWeight.w600),
            textScaleFactor: 1.0,
          )
        ],
      ),
    );
  }
}
