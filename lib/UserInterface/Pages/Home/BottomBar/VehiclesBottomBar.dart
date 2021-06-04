import 'package:getparked/StateManagement/Models/VehicleData.dart';
import 'package:getparked/Utils/VehiclesUtils.dart';
import 'package:getparked/UserInterface/Icons/g_p_icons_icons.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class VehicleBottomBar extends StatefulWidget {
  Function(VehicleType) onChanged;

  VehicleBottomBar({@required this.onChanged});

  @override
  _VehicleBottomBarState createState() => _VehicleBottomBarState();
}

class _VehicleBottomBarState extends State<VehicleBottomBar> {
  VehicleType activeVehicleType;
  vehicleOnTap(VehicleType vehicleType) {
    setState(() {
      activeVehicleType = vehicleType;
    });
    widget.onChanged(vehicleType);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: qbWhiteBGColor),
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.025),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          VehicleButton(
              type: VehicleType.bike,
              activeType: activeVehicleType,
              onTap: vehicleOnTap),
          VehicleButton(
              type: VehicleType.mini,
              activeType: activeVehicleType,
              onTap: vehicleOnTap),
          VehicleButton(
              type: VehicleType.sedan,
              activeType: activeVehicleType,
              onTap: vehicleOnTap),
          VehicleButton(
              type: VehicleType.van,
              activeType: activeVehicleType,
              onTap: vehicleOnTap),
          VehicleButton(
              type: VehicleType.suv,
              activeType: activeVehicleType,
              onTap: vehicleOnTap),
        ],
      ),
    );
  }
}

class VehicleButton extends StatefulWidget {
  VehicleType type;
  Function(VehicleType) onTap;
  VehicleType activeType;

  VehicleButton(
      {@required this.type, @required this.onTap, @required this.activeType});

  @override
  _VehicleButtonState createState() => _VehicleButtonState();
}

class _VehicleButtonState extends State<VehicleButton> {
  String name = "Bike";
  IconData inactiveIcon = GPIcons.bike_bag_outlined;
  IconData activeIcon = GPIcons.bike_bag;
  double iconSize = 17.5;
  EdgeInsets iconPadding = EdgeInsets.only(right: 15);

  @override
  Widget build(BuildContext context) {
    if (widget.type == VehicleType.bike) {
      name = "Bike";
      inactiveIcon = GPIcons.bike_bag_outlined;
      activeIcon = GPIcons.bike_bag;
      iconSize = 17.5;
      iconPadding = EdgeInsets.only(right: 15);
    } else if (widget.type == VehicleType.mini) {
      name = "Mini";
      inactiveIcon = GPIcons.hatch_back_car_outlined;
      activeIcon = GPIcons.hatch_back_car;
      iconSize = 15;
      iconPadding = EdgeInsets.only(right: 25);
    } else if (widget.type == VehicleType.sedan) {
      name = "Sedan";
      inactiveIcon = GPIcons.sedan_car_outlined;
      activeIcon = GPIcons.sedan_car;
      iconSize = 14.5;
      iconPadding = EdgeInsets.only(right: 30);
    } else if (widget.type == VehicleType.van) {
      name = "Van";
      inactiveIcon = GPIcons.van_outlined;
      activeIcon = GPIcons.van;
      iconSize = 16.5;
      iconPadding = EdgeInsets.only(right: 17.5);
    } else if (widget.type == VehicleType.suv) {
      name = "SUV";
      inactiveIcon = GPIcons.suv_car_outlined;
      activeIcon = GPIcons.suv_car;
      iconSize = 14;
      iconPadding = EdgeInsets.only(right: 25);
    }

    return GestureDetector(
      onTap: () {
        SystemSound.play(SystemSoundType.click);
        widget.onTap(widget.type);
      },
      child: Container(
        height: 56,
        color: Color.fromRGBO(250, 250, 250, 1),
        width: MediaQuery.of(context).size.width * 0.19,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 25,
              alignment: Alignment.bottomCenter,
              padding: iconPadding,
              child: Icon(
                (widget.activeType == widget.type) ? activeIcon : inactiveIcon,
                size: iconSize,
                color: (widget.activeType == widget.type)
                    ? qbAppPrimaryThemeColor
                    : qbAppTextColor,
              ),
            ),
            Container(
              child: Text(
                name,
                style: GoogleFonts.nunito(
                  fontWeight: (widget.activeType == widget.type)
                      ? FontWeight.w900
                      : FontWeight.w600,
                  fontSize: 10,
                  color: (widget.activeType == widget.type)
                      ? qbAppPrimaryThemeColor
                      : qbAppTextColor,
                ),
                textScaleFactor: 1,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
