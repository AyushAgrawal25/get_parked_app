import 'package:flutter/material.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/StateManagement/Models/ParkingRequestData.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/FormFieldHeader.dart';
import 'package:provider/provider.dart';

class AvailableSpaceWidget extends StatefulWidget {
  @override
  _AvailableSpaceWidgetState createState() => _AvailableSpaceWidgetState();
}

class _AvailableSpaceWidgetState extends State<AvailableSpaceWidget> {
  AppState gpAppState;
  double allottedSpace = 0.0;
  double totalSpace = 0.0;

  calcFunc() {
    totalSpace = 0.0;
    allottedSpace = 0.0;
    gpAppState.slotParkings.forEach((parkingReq) {
      if ((parkingReq.getParkingRequestDataType() ==
              ParkingRequestDataType.booked_BookingGoingON) ||
          (parkingReq.getParkingRequestDataType() ==
              ParkingRequestDataType.booked_ParkingGoingON)) {
        allottedSpace += parkingReq.vehicleData.typeData.area;
      }
    });

    totalSpace =
        gpAppState.parkingLordData.breadth * gpAppState.parkingLordData.length;
  }

  @override
  Widget build(BuildContext context) {
    gpAppState = Provider.of<AppState>(context);
    calcFunc();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            alignment: Alignment.centerLeft,
            child: FormFieldHeader(
              headerText: "Allotted Space",
              fontSize: 20,
              color: qbAppTextColor,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(360),
              child: Stack(
                children: [
                  LinearProgressIndicator(
                    value: allottedSpace / totalSpace,
                    minHeight: 45,
                    backgroundColor: qbDividerLightColor,
                    color: qbAppPrimaryThemeColor,
                  ),
                  Positioned.fill(
                    child: Container(
                      alignment: Alignment.center,
                      child: FormFieldHeader(
                        headerText:
                            "${(allottedSpace / totalSpace).toStringAsFixed(2)} % allotted.",
                        fontSize: 17.5,
                        color: qbAppTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
