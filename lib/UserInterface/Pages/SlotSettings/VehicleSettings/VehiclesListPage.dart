import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/StateManagement/Models/VehicleData.dart';
import 'package:getparked/StateManagement/Models/VehicleTypeData.dart';
import 'package:getparked/UserInterface/Icons/g_p_icons_icons.dart';
import 'package:getparked/UserInterface/Pages/SlotSettings/VehicleSettings/VehicleSettingCard.dart';
import 'package:getparked/UserInterface/Pages/SlotSettings/VehicleSettings/VehicleSettingPage.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/CustomIcon.dart';
import 'package:getparked/UserInterface/Widgets/qbFAB.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class VehiclesListPage extends StatefulWidget {
  @override
  _VehiclesListPageState createState() => _VehiclesListPageState();
}

class _VehiclesListPageState extends State<VehiclesListPage> {
  AppState appState;
  @override
  void initState() {
    super.initState();

    appState = Provider.of<AppState>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    AppState appStateListen = Provider.of<AppState>(context, listen: true);

    Map<VehicleType, bool> isVehiclePres = {};

    List<Widget> vehicleCards = [];
    appStateListen.parkingLordData.vehicles.forEach((VehicleData vehicleData) {
      vehicleCards.add(VehicleSettingCard(vehicleData: vehicleData));
      isVehiclePres[vehicleData.type] = true;
    });

    List<VehicleData> nonPresVehicles = [];
    appState.vehiclesTypeData.forEach((vehicleTypeData) {
      if (isVehiclePres[vehicleTypeData.type] != true) {
        double slotArea =
            appState.parkingLordData.length * appState.parkingLordData.breadth;
        if ((slotArea >= vehicleTypeData.area) &&
            (vehicleTypeData.height <= appState.parkingLordData.height)) {
          nonPresVehicles.add(VehicleData(
              fair: 0.0,
              slotId: appState.parkingLordData.id,
              status: 1,
              type: vehicleTypeData.type,
              typeData: vehicleTypeData));
        }
      }
    });

    return Container(
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: qbWhiteBGColor,
            child: SafeArea(
              top: false,
              maintainBottomViewPadding: true,
              child: Scaffold(
                appBar: AppBar(
                  title: Row(
                    children: [
                      CustomIcon(
                        icon: FontAwesome5.car,
                        size: 25,
                        color: qbAppTextColor,
                      ),
                      SizedBox(
                        width: 7.5,
                      ),
                      Container(
                        child: Text(
                          "Vehicle Settings",
                          style: GoogleFonts.nunito(
                              fontWeight: FontWeight.w600,
                              color: qbAppTextColor),
                          textScaleFactor: 1,
                        ),
                      ),
                    ],
                  ),
                  brightness: Brightness.light,
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  iconTheme: IconThemeData(color: qbAppTextColor),
                ),
                body: Stack(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      child: ListView(
                        children: vehicleCards,
                      ),
                    ),
                    (nonPresVehicles.length > 0)
                        ? Positioned(
                            bottom: 25,
                            right: 20,
                            child: Container(
                              child: PopupMenuButton<VehicleType>(
                                child: Container(
                                  height: 55,
                                  width: 55,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(360),
                                      color: qbAppPrimaryThemeColor,
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 8,
                                            spreadRadius: 0.3,
                                            offset: Offset(0, 5),
                                            color:
                                                Color.fromRGBO(0, 0, 0, 0.20)),
                                      ]),
                                  child: Icon(
                                    FontAwesome5.plus,
                                    size: 20,
                                    color: qbWhiteBGColor,
                                  ),
                                ),
                                itemBuilder: (context) {
                                  List<PopupMenuItem<VehicleType>> items = [];
                                  nonPresVehicles
                                      .forEach((VehicleData vehicleData) {
                                    items.add(PopupMenuItem(
                                      value: vehicleData.type,
                                      child: Container(
                                        child: Text(
                                          vehicleData.typeData.name,
                                          style: GoogleFonts.roboto(
                                              color: qbDetailDarkColor),
                                          textScaleFactor: 1.0,
                                        ),
                                      ),
                                    ));
                                  });
                                  return items;
                                },
                                onSelected: (value) {
                                  VehicleData vehicleData;
                                  nonPresVehicles.forEach((element) {
                                    if (element.type == value) {
                                      vehicleData = element;
                                    }
                                  });

                                  if (vehicleData != null) {
                                    onAddVehiclePressed(vehicleData);
                                  }
                                },
                              ),
                            ),
                          )
                        : Container()
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  onAddVehiclePressed(VehicleData vehicleData) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return VehicleSettingPage(vehicleData: vehicleData);
      },
    ));
  }
}
