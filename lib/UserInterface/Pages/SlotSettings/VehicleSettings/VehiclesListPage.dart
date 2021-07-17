import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/StateManagement/Models/VehicleData.dart';
import 'package:getparked/UserInterface/Icons/g_p_icons_icons.dart';
import 'package:getparked/UserInterface/Pages/SlotSettings/VehicleSettings/VehicleSettingCard.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/CustomIcon.dart';
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

    List<Widget> vehicleCards = [];
    appStateListen.parkingLordData.vehicles.forEach((VehicleData vehicleData) {
      vehicleCards.add(VehicleSettingCard(vehicleData: vehicleData));
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
                body: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: ListView(
                    children: vehicleCards,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
