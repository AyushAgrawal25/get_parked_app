import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getparked/BussinessLogic/AuthProvider.dart';
import 'package:getparked/BussinessLogic/ParkingLordServices.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/StateManagement/Models/ParkingLordData.dart';
import 'package:getparked/UserInterface/Pages/SplashScreen/SplashScreenPage.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/Loaders/LoaderPage.dart';
import 'package:getparked/UserInterface/Widgets/SettingCard.dart';
import 'package:getparked/Utils/ToastUtils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SlotSettingsPage extends StatefulWidget {
  @override
  _SlotSettingsPageState createState() => _SlotSettingsPageState();
}

class _SlotSettingsPageState extends State<SlotSettingsPage> {
  bool isLoading = false;
  AppState appState;

  @override
  void initState() {
    super.initState();

    appState = Provider.of<AppState>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    AppState appStateListen = Provider.of<AppState>(context, listen: true);
    return Container(
      child: Stack(
        children: [
          Container(
            child: SafeArea(
              top: false,
              maintainBottomViewPadding: true,
              child: Container(
                child: Scaffold(
                  appBar: AppBar(
                    title: Row(
                      children: [
                        Icon(FontAwesomeIcons.slidersH, size: 20),
                        SizedBox(
                          width: 12.5,
                        ),
                        Text(
                          "Settings",
                          style:
                              GoogleFonts.nunito(fontWeight: FontWeight.w500),
                          textScaleFactor: 1.0,
                        ),
                      ],
                    ),
                    brightness: Brightness.dark,
                    elevation: 0.0,
                    backgroundColor: qbAppPrimaryThemeColor,
                  ),
                  body: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    child: Column(
                      children: [
                        SettingCard(
                          child: Text(
                            (appState.parkingLordData.status == 1)
                                ? "Deactivate Slot"
                                : "Activate Slot",
                            style: GoogleFonts.roboto(
                                color: qbAppTextColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 17.5),
                            textScaleFactor: 1.0,
                          ),
                          icon: FontAwesomeIcons.powerOff,
                          onPressed: onChangeActivation,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          (isLoading) ? LoaderPage() : Container()
        ],
      ),
    );
  }

  onChangeActivation() async {
    setState(() {
      isLoading = true;
    });
    if (appState.parkingLordData.status == 1) {
      await onSlotDeactivate();
    } else {
      await onSlotActivate();
    }
    setState(() {
      isLoading = false;
    });
  }

  onSlotActivate() async {
    SlotActivateStatus activateStatus =
        await ParkingLordServices().activateSlot(authToken: appState.authToken);

    switch (activateStatus) {
      case SlotActivateStatus.success:
        ToastUtils.showMessage("Slot Activated...");
        ParkingLordData parkingLordData = appState.parkingLordData;
        parkingLordData.status = 1;
        appState.setParkingLordData(parkingLordData);
        break;
      case SlotActivateStatus.notFound:
        ToastUtils.showMessage("Slot Not Found");
        break;
      case SlotActivateStatus.internalServerError:
        ToastUtils.showMessage("Internal Server Error");
        break;
      case SlotActivateStatus.alreadyActive:
        ToastUtils.showMessage("Already Active");
        break;
      case SlotActivateStatus.failed:
        ToastUtils.showMessage("Failed");
        break;
    }
  }

  onSlotDeactivate() async {
    SlotDeactivateStatus deactivateStatus = await ParkingLordServices()
        .deactivateSlot(authToken: appState.authToken);

    switch (deactivateStatus) {
      case SlotDeactivateStatus.success:
        ToastUtils.showMessage("Slot Deactivated...");
        ParkingLordData parkingLordData = appState.parkingLordData;
        parkingLordData.status = 0;
        appState.setParkingLordData(parkingLordData);
        break;
      case SlotDeactivateStatus.notFound:
        ToastUtils.showMessage("Slot Not Found");
        break;
      case SlotDeactivateStatus.alreadyDeactive:
        ToastUtils.showMessage("Already Deactive");
        break;
      case SlotDeactivateStatus.cannotBeDeactivated:
        ToastUtils.showMessage("Cannot be deactivated.");
        break;
      case SlotDeactivateStatus.internalServerError:
        ToastUtils.showMessage("Internal Server Error");
        break;
      case SlotDeactivateStatus.failed:
        ToastUtils.showMessage("Failed");
        break;
    }
  }
}
