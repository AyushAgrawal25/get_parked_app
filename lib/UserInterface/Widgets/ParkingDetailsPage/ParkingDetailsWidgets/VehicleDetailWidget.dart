import 'package:getparked/StateManagement/Models/VehicleTypeData.dart';
import 'package:getparked/Utils/VehiclesUtils.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/StateManagement/Models/VehicleData.dart';
import 'package:getparked/UserInterface/Icons/g_p_icons_icons.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/CustomIcon.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:getparked/UserInterface/Widgets/ParkingDetailsPage/ParkingDetailsWidgets/ParkingDetailsTheme.dart';

class VehicleDetailWidget extends StatelessWidget {
  VehicleData vehicleData;
  VehicleDetailWidgetType widgetType;
  VehicleDetailWidget(
      {@required this.vehicleData,
      this.widgetType: VehicleDetailWidgetType.borderLess});
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

    Color paintColor = qbDetailLightColor;
    double fontSize = 15;
    double iconSize = 16.5;
    FontWeight fontWeight = FontWeight.w400;
    FontWeight nameFontWeight = FontWeight.w500;
    BoxDecoration boxDeco;
    switch (this.widgetType) {
      case VehicleDetailWidgetType.borderLess:
        paintColor = qbAppTextColor;
        boxDeco = BoxDecoration();
        fontSize = 16.5;
        iconSize = 16.5;
        fontWeight = FontWeight.w500;
        nameFontWeight = FontWeight.w600;
        break;
      case VehicleDetailWidgetType.filled:
        paintColor = qbWhiteBGColor;
        boxDeco = BoxDecoration(
          color: qbAppPrimaryThemeColor,
          borderRadius: BorderRadius.circular(360),
        );
        fontWeight = FontWeight.w400;
        nameFontWeight = FontWeight.w500;
        break;
      case VehicleDetailWidgetType.outlined:
        paintColor = qbAppTextColor;
        boxDeco = BoxDecoration(
          border: Border.all(color: qbDividerLightColor, width: 1.5),
          borderRadius: BorderRadius.circular(360),
        );
        fontWeight = FontWeight.w500;
        nameFontWeight = FontWeight.w600;
        break;
    }

    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 47.5,
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 0),
        width: MediaQuery.of(context).size.width,
        decoration: boxDeco,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(
                "Vehicle Type : ",
                style: GoogleFonts.poppins(
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                    color: qbHeadColor),
                textScaleFactor: 1.0,
              ),
            ),
            Container(
              child: Text(
                vehicleName,
                style: GoogleFonts.notoSans(
                    fontSize: fontSize,
                    fontWeight: nameFontWeight,
                    color: qbBodyColor),
                textScaleFactor: 1.0,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              child: CustomIcon(
                icon: vehicleIcon,
                size: iconSize,
                type: CustomIconType.onHeight,
                color: qbBodyColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}

enum VehicleDetailWidgetType { filled, outlined, borderLess }
