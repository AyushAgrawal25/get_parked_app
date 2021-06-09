import 'dart:io';

// import 'package:getparked/BussinessLogic/ParkingLordUtils.dart';
import 'package:getparked/BussinessLogic/ParkingLordServices.dart';
import 'package:getparked/BussinessLogic/SlotsServices.dart';
import 'package:getparked/BussinessLogic/UserServices.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/StateManagement/Models/ParkingLordData.dart';
import 'package:getparked/StateManagement/Models/SlotData.dart';
import 'package:getparked/UserInterface/Pages/RentOutSpace/RentOutSpaceForms/ParkingAreaDetails.dart';
import 'package:getparked/UserInterface/Pages/RentOutSpace/RentOutSpaceForms/ParkingSlotSpecs.dart';
import 'package:getparked/UserInterface/Pages/RentOutSpace/RentOutSpaceForms/TermsAndConditions.dart';
import 'package:getparked/UserInterface/Pages/RentOutSpace/RentOutSpaceForms/VehiclesSelect.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class RentOutSpaceForms extends StatefulWidget {
  @override
  _RentOutSpaceFormsState createState() => _RentOutSpaceFormsState();
}

class _RentOutSpaceFormsState extends State<RentOutSpaceForms> {
  AppState gpAppState;
  @override
  void initState() {
    super.initState();
    gpAppState = Provider.of(context, listen: false);
  }

  File gpMainImgFile;
  SlotData gpSlotData = SlotData();

  int gpFormPosition = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          ParkingSlotSpecs(
            onContinuePressed: (imgFile, slotData) {
              gpMainImgFile = imgFile;
              gpSlotData = slotData;
              openVehicleSelectPage();
            },
          )
        ],
      ),
    );
  }

  // For Vehicle Select Page
  openVehicleSelectPage() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return VehicleSelect(
          slotData: gpSlotData,
          onContinuePressed: (SlotData slotData) {
            gpSlotData = slotData;
            print(gpSlotData.name);
            openParkingAreaDetailsPage();
          },
        );
      },
    ));
  }

  // For Parking Slot Details Page
  openParkingAreaDetailsPage() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return ParkingAreaDetails(
          slotData: gpSlotData,
          onContinuePressed: (SlotData slotData) {
            gpSlotData = slotData;
            openRentOutSpaceTermsAndConditions();
          },
        );
      },
    ));
  }

  // For Terms And Conditions
  openRentOutSpaceTermsAndConditions() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return RentOutSpaceTermsAndConditions(
          slotData: gpSlotData,
          onAgree: (SlotData slotData) async {
            gpSlotData = slotData;
            bool uploadStatus = await postingDataFinal();
            return uploadStatus;
          },
        );
      },
    ));
  }

  // Final Posting Data using API
  postingDataFinal() async {
    // Write The Main Code Here
    // bool postStatus = await ParkingLordUtils().becomeParkingLord(gpSlotData,
    //     gpAppState.userData.id, gpAppState.userData.accessToken, gpMainImgFile);
    // if (postStatus) {
    //   // Fetching Parking Lord Data
    //   ParkingLordData gpParkingLordData = await ParkingLordUtils()
    //       .init(gpAppState.userData.id, gpAppState.userData.accessToken);
    //   if (gpParkingLordData != null) {
    //     gpAppState.setParkingLordData(gpParkingLordData);

    //     bool uploadImgStatus = await ParkingLordUtils().uploadSlotMainImg(
    //         gpMainImgFile, gpParkingLordData.id, gpParkingLordData.token);
    //     if (uploadImgStatus) {
    //       gpParkingLordData = await ParkingLordUtils()
    //           .init(gpAppState.userData.id, gpAppState.userData.accessToken);
    //       if (gpParkingLordData != null) {
    //         gpAppState.setParkingLordData(gpParkingLordData);
    //       }
    //     }
    //   } else {
    //     print("Data is NULL.");
    //   }
    // }

    // return postStatus;

    AppState appState = Provider.of<AppState>(context, listen: false);
    ParkingLordCreateStatus parkingLordCreateStatus =
        await ParkingLordServices()
            .createSlot(authToken: gpAppState.authToken, slotData: gpSlotData);
    if (parkingLordCreateStatus == ParkingLordCreateStatus.successful) {
      UserServices().getUser(authToken: appState.authToken, context: context);
      return true;
    }
    return false;
  }
}
