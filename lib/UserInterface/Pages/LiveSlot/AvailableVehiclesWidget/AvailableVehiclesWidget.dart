import 'package:flutter/material.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/UserInterface/Pages/LiveSlot/AvailableVehiclesWidget/VehicleTile.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/FormFieldHeader.dart';
import 'package:provider/provider.dart';

class AvailableVehiclesWidget extends StatefulWidget {
  @override
  _AvailableVehiclesWidgetState createState() =>
      _AvailableVehiclesWidgetState();
}

class _AvailableVehiclesWidgetState extends State<AvailableVehiclesWidget> {
  @override
  Widget build(BuildContext context) {
    AppState gpAppState = Provider.of<AppState>(context);
    List<Widget> vehicleTiles = [];
    gpAppState.parkingLordData.vehicles.forEach((vehicle) {
      vehicleTiles.add(VehicleTile(vehicleData: vehicle));
    });

    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerLeft,
              child: FormFieldHeader(
                headerText: "Available vehicles",
                color: qbDetailLightColor,
              ),
            ),

            SizedBox(
              height: 10,
            ),

            Divider(
              thickness: 1.5,
              color: qbDividerLightColor,
              height: 5,
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: vehicleTiles,
              ),
            ),

            Divider(
              thickness: 1.5,
              color: qbDividerLightColor,
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
