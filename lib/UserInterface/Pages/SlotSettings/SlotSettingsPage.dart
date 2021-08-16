import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getparked/BussinessLogic/AuthProvider.dart';
import 'package:getparked/BussinessLogic/ParkingLordServices.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/StateManagement/Models/ParkingLordData.dart';
import 'package:getparked/UserInterface/Icons/g_p_icons_icons.dart';
import 'package:getparked/UserInterface/Pages/SlotSettings/ChangeDimensions/ChangeDimensions.dart';
import 'package:getparked/UserInterface/Pages/SlotSettings/VehicleSettings/VehiclesListPage.dart';
import 'package:getparked/UserInterface/Pages/SplashScreen/SplashScreenPage.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/Loaders/LoaderPage.dart';
import 'package:getparked/UserInterface/Widgets/SettingCard.dart';
import 'package:getparked/Utils/ToastUtils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
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
                        ),
                        SettingCard(
                          child: Text(
                            "Vehicle Settings",
                            style: GoogleFonts.roboto(
                                color: qbAppTextColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 17.5),
                            textScaleFactor: 1.0,
                          ),
                          icon: FontAwesome5.car,
                          onPressed: onVehicleSettingsPressed,
                        ),
                        SettingCard(
                          child: Text(
                            "Change Dimensios",
                            style: GoogleFonts.roboto(
                                color: qbAppTextColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 17.5),
                            textScaleFactor: 1.0,
                          ),
                          icon: FontAwesome5.pencil_ruler,
                          onPressed: onChangeDimensionsPressed,
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

  onChangeActivation(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    if (appState.parkingLordData.status == 1) {
      await onSlotDeactivate(context);
    } else {
      await onSlotActivate(context);
    }
    setState(() {
      isLoading = false;
    });
  }

  onSlotActivate(BuildContext context) async {
    SlotActivateStatus activateStatus =
        await ParkingLordServices().activateSlot(authToken: appState.authToken);

    switch (activateStatus) {
      case SlotActivateStatus.success:
        MotionToast.success(
          description: "Activation Successful",
          title: "Activated",
          titleStyle: GoogleFonts.nunito(
            fontSize: 13.5 / MediaQuery.of(context).textScaleFactor,
            fontWeight: FontWeight.w600,
          ),
          descriptionStyle: GoogleFonts.nunito(
            fontSize: 11.5 / MediaQuery.of(context).textScaleFactor,
            fontWeight: FontWeight.w600,
          ),
        ).show(context);

        ParkingLordData parkingLordData = appState.parkingLordData;
        parkingLordData.status = 1;
        appState.setParkingLordData(parkingLordData);
        break;
      case SlotActivateStatus.notFound:
        MotionToast.error(
          description: "Slot Not Found",
          title: "Error",
          titleStyle: GoogleFonts.nunito(
            fontSize: 13.5 / MediaQuery.of(context).textScaleFactor,
            fontWeight: FontWeight.w600,
          ),
          descriptionStyle: GoogleFonts.nunito(
            fontSize: 11.5 / MediaQuery.of(context).textScaleFactor,
            fontWeight: FontWeight.w600,
          ),
        ).show(context);
        break;
      case SlotActivateStatus.internalServerError:
        MotionToast.error(
          description: "Internal Server Error",
          title: "Error",
          titleStyle: GoogleFonts.nunito(
            fontSize: 13.5 / MediaQuery.of(context).textScaleFactor,
            fontWeight: FontWeight.w600,
          ),
          descriptionStyle: GoogleFonts.nunito(
            fontSize: 11.5 / MediaQuery.of(context).textScaleFactor,
            fontWeight: FontWeight.w600,
          ),
        ).show(context);
        break;
      case SlotActivateStatus.alreadyActive:
        MotionToast.error(
          description: "Already Active.",
          title: "Error",
          titleStyle: GoogleFonts.nunito(
            fontSize: 13.5 / MediaQuery.of(context).textScaleFactor,
            fontWeight: FontWeight.w600,
          ),
          descriptionStyle: GoogleFonts.nunito(
            fontSize: 11.5 / MediaQuery.of(context).textScaleFactor,
            fontWeight: FontWeight.w600,
          ),
        ).show(context);
        break;
      case SlotActivateStatus.failed:
        MotionToast.error(
          description: "Activation Failed.",
          title: "Failed",
          titleStyle: GoogleFonts.nunito(
            fontSize: 13.5 / MediaQuery.of(context).textScaleFactor,
            fontWeight: FontWeight.w600,
          ),
          descriptionStyle: GoogleFonts.nunito(
            fontSize: 11.5 / MediaQuery.of(context).textScaleFactor,
            fontWeight: FontWeight.w600,
          ),
        ).show(context);
        break;
    }
  }

  onSlotDeactivate(BuildContext context) async {
    SlotDeactivateStatus deactivateStatus = await ParkingLordServices()
        .deactivateSlot(authToken: appState.authToken);

    switch (deactivateStatus) {
      case SlotDeactivateStatus.success:
        MotionToast.success(
          description: "Deactivation Successful",
          title: "Deactivated",
          titleStyle: GoogleFonts.nunito(
            fontSize: 13.5 / MediaQuery.of(context).textScaleFactor,
            fontWeight: FontWeight.w600,
          ),
          descriptionStyle: GoogleFonts.nunito(
            fontSize: 11.5 / MediaQuery.of(context).textScaleFactor,
            fontWeight: FontWeight.w600,
          ),
        ).show(context);

        ParkingLordData parkingLordData = appState.parkingLordData;
        parkingLordData.status = 0;
        appState.setParkingLordData(parkingLordData);
        break;
      case SlotDeactivateStatus.notFound:
        MotionToast.error(
          description: "Slot Not Found",
          title: "Error",
          titleStyle: GoogleFonts.nunito(
            fontSize: 13.5 / MediaQuery.of(context).textScaleFactor,
            fontWeight: FontWeight.w600,
          ),
          descriptionStyle: GoogleFonts.nunito(
            fontSize: 11.5 / MediaQuery.of(context).textScaleFactor,
            fontWeight: FontWeight.w600,
          ),
        ).show(context);
        break;
      case SlotDeactivateStatus.alreadyDeactive:
        MotionToast.error(
          description: "Already Deactive.",
          title: "Error",
          titleStyle: GoogleFonts.nunito(
            fontSize: 13.5 / MediaQuery.of(context).textScaleFactor,
            fontWeight: FontWeight.w600,
          ),
          descriptionStyle: GoogleFonts.nunito(
            fontSize: 11.5 / MediaQuery.of(context).textScaleFactor,
            fontWeight: FontWeight.w600,
          ),
        ).show(context);
        break;
      case SlotDeactivateStatus.cannotBeDeactivated:
        MotionToast.error(
          description: "Cannot be deactivated.",
          title: "Failed",
          titleStyle: GoogleFonts.nunito(
            fontSize: 13.5 / MediaQuery.of(context).textScaleFactor,
            fontWeight: FontWeight.w600,
          ),
          descriptionStyle: GoogleFonts.nunito(
            fontSize: 11.5 / MediaQuery.of(context).textScaleFactor,
            fontWeight: FontWeight.w600,
          ),
        ).show(context);
        break;
        break;
      case SlotDeactivateStatus.internalServerError:
        MotionToast.error(
          description: "Internal Server Error",
          title: "Error",
          titleStyle: GoogleFonts.nunito(
            fontSize: 13.5 / MediaQuery.of(context).textScaleFactor,
            fontWeight: FontWeight.w600,
          ),
          descriptionStyle: GoogleFonts.nunito(
            fontSize: 11.5 / MediaQuery.of(context).textScaleFactor,
            fontWeight: FontWeight.w600,
          ),
        ).show(context);
        break;
      case SlotDeactivateStatus.failed:
        MotionToast.error(
          description: "Deactivation Failed.",
          title: "Failed",
          titleStyle: GoogleFonts.nunito(
            fontSize: 13.5 / MediaQuery.of(context).textScaleFactor,
            fontWeight: FontWeight.w600,
          ),
          descriptionStyle: GoogleFonts.nunito(
            fontSize: 11.5 / MediaQuery.of(context).textScaleFactor,
            fontWeight: FontWeight.w600,
          ),
        ).show(context);
        break;
    }
  }

  onVehicleSettingsPressed(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return VehiclesListPage();
      },
    ));
  }

  onChangeDimensionsPressed(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return ChangeDimensions();
      },
    ));
  }
}
