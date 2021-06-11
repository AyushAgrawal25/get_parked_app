import 'package:getparked/StateManagement/Models/VehicleTypeData.dart';
import 'package:getparked/Utils/VehiclesUtils.dart';
import 'package:getparked/StateManagement/Models/AppOverlayStyleData.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/StateManagement/Models/SlotData.dart';
import 'package:getparked/StateManagement/Models/VehicleData.dart';
import 'package:getparked/UserInterface/Icons/g_p_icons_icons.dart';
import 'package:getparked/UserInterface/Widgets/ErrorPopUp.dart';
import 'package:provider/provider.dart';
import '../../../Theme/AppOverlayStyle.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/CustomIcon.dart';
import 'package:getparked/UserInterface/Widgets/EdgeLessButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class VehicleSelect extends StatefulWidget {
  SlotData slotData;
  Function(SlotData) onContinuePressed;

  VehicleSelect({@required this.onContinuePressed, @required this.slotData});
  @override
  _VehicleSelectState createState() => _VehicleSelectState();
}

class _VehicleSelectState extends State<VehicleSelect> {
  AppState gpAppState;
  @override
  void initState() {
    super.initState();
    gpAppState = Provider.of(context, listen: false);
  }

  List<VehicleInfoBoxController> infoBoxControllers = [];

  bool isFormEntriesValid = true;
  checkFormValidity() {
    isFormEntriesValid = true;
    infoBoxControllers.forEach((infoBoxController) {
      if (infoBoxController.isSelected()) {
        if (!infoBoxController.isFairProvided()) {
          isFormEntriesValid = false;
        }
      }
    });
  }

  onContinuePressed() {
    if (isFormEntriesValid) {
      List<VehicleData> vehicles = [];
      infoBoxControllers.forEach((infoBoxController) {
        if (infoBoxController.isSelected()) {
          VehicleData vehicleData = infoBoxController.getVehicleData();
          vehicles.add(vehicleData);
        }
      });

      SlotData gpSlotData = widget.slotData;
      gpSlotData.vehicles = vehicles;
      widget.onContinuePressed(gpSlotData);
    } else {
      // Error Pop Up
      ErrorPopUp().show(
          "Please Enter per Hour Charges for all the selected Vehicles.",
          context);
    }
  }

  @override
  Widget build(BuildContext context) {
    checkFormValidity();
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Color.fromRGBO(250, 250, 250, 1),
      child: SafeArea(
        maintainBottomViewPadding: false,
        child: Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  CustomIcon(
                    icon: GPIcons.rent_out_space,
                    size: 25,
                    color: qbAppTextColor,
                  ),
                  SizedBox(
                    width: 7.5,
                  ),
                  Container(
                    child: Text(
                      "Select Vehicles",
                      style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w600, color: qbAppTextColor),
                      textScaleFactor: 1,
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              iconTheme: IconThemeData(color: qbAppTextColor),
            ),
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: (MediaQuery.of(context).viewInsets.bottom > 40)
                        ? MediaQuery.of(context).size.height -
                            56 -
                            MediaQuery.of(context).padding.top
                        : MediaQuery.of(context).size.height -
                            56 -
                            MediaQuery.of(context).padding.top -
                            MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //Two Wheelers
                        Container(
                          child: Stack(
                            children: [
                              Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: 12.5,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 17.5, horizontal: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Color.fromRGBO(225, 225, 225, 1),
                                      width: 0.75,
                                    ),
                                  ),
                                  child: VehicleInfoBox(
                                    getController: (controller) {
                                      infoBoxControllers.add(controller);
                                    },
                                    onChange: () {
                                      setState(() {});
                                    },
                                    typeData: gpAppState.vehiclesTypeData[0],
                                    length: widget.slotData.length,
                                    breadth: widget.slotData.breadth,
                                    height: widget.slotData.height,
                                  )),
                              Positioned(
                                left: 25,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  color: Color.fromRGBO(250, 250, 250, 1),
                                  child: Text(
                                    "Two wheeler",
                                    style: GoogleFonts.nunito(
                                        color: qbAppTextColor,
                                        fontSize: 17.5,
                                        fontWeight: FontWeight.w600),
                                    textScaleFactor: 1.0,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),

                        //Four Wheelers
                        Container(
                          child: Stack(
                            children: [
                              Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: 12.5,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 17.5, horizontal: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Color.fromRGBO(225, 225, 225, 1),
                                      width: 0.75,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      VehicleInfoBox(
                                        getController: (controller) {
                                          infoBoxControllers.add(controller);
                                        },
                                        onChange: () {
                                          setState(() {});
                                        },
                                        typeData:
                                            gpAppState.vehiclesTypeData[1],
                                        length: widget.slotData.length,
                                        breadth: widget.slotData.breadth,
                                        height: widget.slotData.height,
                                      ),
                                      VehicleInfoBox(
                                        getController: (controller) {
                                          infoBoxControllers.add(controller);
                                        },
                                        onChange: () {
                                          setState(() {});
                                        },
                                        typeData:
                                            gpAppState.vehiclesTypeData[2],
                                        length: widget.slotData.length,
                                        breadth: widget.slotData.breadth,
                                        height: widget.slotData.height,
                                      ),
                                      VehicleInfoBox(
                                        getController: (controller) {
                                          infoBoxControllers.add(controller);
                                        },
                                        onChange: () {
                                          setState(() {});
                                        },
                                        typeData:
                                            gpAppState.vehiclesTypeData[3],
                                        length: widget.slotData.length,
                                        breadth: widget.slotData.breadth,
                                        height: widget.slotData.height,
                                      ),
                                      VehicleInfoBox(
                                        getController: (controller) {
                                          infoBoxControllers.add(controller);
                                        },
                                        onChange: () {
                                          setState(() {});
                                        },
                                        typeData:
                                            gpAppState.vehiclesTypeData[4],
                                        length: widget.slotData.length,
                                        breadth: widget.slotData.breadth,
                                        height: widget.slotData.height,
                                      ),
                                    ],
                                  )),
                              Positioned(
                                left: 25,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  color: Color.fromRGBO(250, 250, 250, 1),
                                  child: Text(
                                    "Four wheeler",
                                    style: GoogleFonts.nunito(
                                        color: qbAppTextColor,
                                        fontSize: 17.5,
                                        fontWeight: FontWeight.w600),
                                    textScaleFactor: 1.0,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),

                        Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 1.5, horizontal: 2.5),
                            child: EdgeLessButton(
                              child: Text(
                                "Continue",
                                style: GoogleFonts.nunito(
                                    fontSize: 16.5,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                                textScaleFactor: 1.0,
                              ),
                              color: (isFormEntriesValid)
                                  ? qbAppPrimaryBlueColor
                                  : qbDividerDarkColor,
                              width: MediaQuery.of(context).size.width * 0.6,
                              padding: EdgeInsets.symmetric(vertical: 8.5),
                              onPressed: onContinuePressed,
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class VehicleInfoBox extends StatefulWidget {
  VehicleTypeData typeData;
  Function(VehicleInfoBoxController) getController;
  Function onChange;
  double length;
  double breadth;
  double height;

  VehicleInfoBox({
    @required this.typeData,
    @required this.getController,
    @required this.breadth,
    @required this.onChange,
    @required this.height,
    @required this.length,
  });
  @override
  _VehicleInfoBoxState createState() => _VehicleInfoBoxState();
}

class VehicleInfoBoxController {
  Function isSelected;
  Function isFairProvided;
  Function getVehicleData;
}

class _VehicleInfoBoxState extends State<VehicleInfoBox> {
  IconData vehicleIcon;
  String vehicleName;
  double iconSize;
  String vehicleFair;
  TextEditingController vehicleFairController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isSelectable = VehiclesUtils().isVehicleParkable(
        widget.typeData, widget.length, widget.height, widget.breadth);
    if (isSelectable) {
      VehicleInfoBoxController infoBoxController = VehicleInfoBoxController();
      infoBoxController.isSelected = () {
        return isVehicleSelected;
      };

      infoBoxController.isFairProvided = () {
        if ((vehicleFair != null) && (vehicleFair != "")) {
          return true;
        }
        return false;
      };

      infoBoxController.getVehicleData = () {
        print(widget.typeData.toString() +
            " " +
            widget.typeData.name +
            " " +
            widget.typeData.height.toString());
        VehicleData vehicleData = VehicleData(
          breadth: widget.typeData.breadth,
          fair: double.parse(vehicleFair),
          height: widget.typeData.height,
          length: widget.typeData.length,
          status: 1,
          type: widget.typeData.type,
        );

        return vehicleData;
      };

      widget.getController(infoBoxController);
    }
  }

  bool isVehicleSelected = true;
  bool isSelectable;

  @override
  Widget build(BuildContext context) {
    VehicleType vehicleType = widget.typeData.type;
    if (vehicleType == VehicleType.bike) {
      vehicleIcon = GPIcons.bike_bag;
      vehicleName = "Bike";
      iconSize = 28;
    }
    if (vehicleType == VehicleType.mini) {
      vehicleIcon = GPIcons.hatch_back_car;
      vehicleName = "Mini";
      iconSize = 32.5;
    }
    if (vehicleType == VehicleType.sedan) {
      vehicleIcon = GPIcons.sedan_car;
      vehicleName = "Sedan";
      iconSize = 40;
    }
    if (vehicleType == VehicleType.suv) {
      vehicleIcon = GPIcons.suv_car;
      vehicleName = "SUV";
      iconSize = 34;
    }
    if (vehicleType == VehicleType.van) {
      vehicleIcon = GPIcons.van;
      vehicleName = "Van";
      iconSize = 28;
    }
    return Container(
      height: 60,
      margin: EdgeInsets.symmetric(vertical: 7.5),
      padding: EdgeInsets.only(left: 20, right: 5),
      decoration: BoxDecoration(
          color: (isSelectable) ? qbWhiteBGColor : qbDividerLightColor,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                blurRadius: 1,
                color: Color.fromRGBO(0, 0, 0, 0.15),
                offset: Offset(2.5, 2.5),
                spreadRadius: 0.25)
          ]),
      child: Row(
        children: [
          CustomIcon(
            icon: vehicleIcon,
            color: (isSelectable) ? qbDetailDarkColor : qbDetailLightColor,
            size: iconSize,
          ),
          SizedBox(
            width: 7.5,
          ),
          Container(
            child: Text(
              vehicleName,
              style: GoogleFonts.roboto(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w500,
                  color: qbAppTextColor),
              textScaleFactor: 1.0,
            ),
          ),
          (isSelectable && isVehicleSelected)
              ? Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          child: Text(
                            "Charges : ₹ ",
                            style: GoogleFonts.roboto(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w400,
                                color: qbAppTextColor),
                            textScaleFactor: 1.0,
                          ),
                        ),
                        Container(
                          width: 40,
                          child: TextField(
                              controller: vehicleFairController,
                              onChanged: (value) {
                                String validChars = "0123456789.";
                                if (value != null) {
                                  String fairVal = "";
                                  for (int i = 0; i < value.length; i++) {
                                    if (validChars.contains(value[i])) {
                                      fairVal += value[i];
                                    }
                                  }
                                  vehicleFair = fairVal;
                                  widget.onChange();
                                }
                              },
                              style: GoogleFonts.roboto(
                                  fontSize: 13.5 /
                                      MediaQuery.of(context).textScaleFactor,
                                  fontWeight: FontWeight.w500,
                                  color: qbAppTextColor),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.phone,
                              readOnly: false,
                              decoration: InputDecoration(
                                isDense: true,
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 2.5, vertical: 5),
                              )),
                        ),
                      ],
                    ),
                  ),
                )
              : Expanded(
                  child: SizedBox(
                    height: 10,
                  ),
                ),
          Container(
            child: Checkbox(
                onChanged: (value) {
                  isVehicleSelected = value;
                  widget.onChange();
                },
                value: (isSelectable) ? isVehicleSelected : false,
                activeColor: qbAppPrimaryGreenColor),
          )
        ],
      ),
    );
  }
}
