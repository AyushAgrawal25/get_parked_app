import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:getparked/BussinessLogic/SlotsServices.dart';
import 'package:getparked/StateManagement/Models/VehicleData.dart';
import 'package:getparked/StateManagement/Models/VehicleTypeData.dart';
import 'package:getparked/UserInterface/Icons/g_p_icons_icons.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/CustomIcon.dart';
import 'package:getparked/UserInterface/Widgets/EdgeLessButton.dart';
import 'package:getparked/UserInterface/Widgets/FormFieldHeader.dart';
import 'package:getparked/UserInterface/Widgets/Loaders/LoaderPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';

class VehicleSettingPage extends StatefulWidget {
  final VehicleData vehicleData;

  VehicleSettingPage({@required this.vehicleData});
  @override
  _VehicleSettingPageState createState() => _VehicleSettingPageState();
}

class _VehicleSettingPageState extends State<VehicleSettingPage> {
  TextEditingController vehicleFairController = TextEditingController();
  String vehicleFair;
  bool isVehicleSelected = true;
  bool isFormValid = true;

  @override
  void initState() {
    super.initState();
    setInitialValues();
  }

  setInitialValues() {
    vehicleFair = widget.vehicleData.fair.toString();
    vehicleFairController.text = vehicleFair;
    isVehicleSelected = true;
  }

  checkFormValidity() {
    isFormValid = true;
    double fair;
    try {
      fair = double.parse(vehicleFair);
    } catch (excp) {
      print(excp);
    }

    print(fair);
    if (fair == null) {
      isFormValid = false;
    }
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    String vehicleName = "Bike";
    IconData vehicleIcon = GPIcons.bike;
    switch (widget.vehicleData.type) {
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

    checkFormValidity();
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
                  backgroundColor: qbWhiteBGColor,
                  elevation: 0.0,
                  iconTheme: IconThemeData(color: qbAppTextColor),
                  brightness: Brightness.light,
                ),
                body: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height -
                          MediaQuery.of(context).padding.top -
                          85,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              children: [
                                CustomIcon(
                                  icon: vehicleIcon,
                                  color: qbAppTextColor,
                                  size: 50,
                                  type: CustomIconType.onHeight,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  child: FormFieldHeader(
                                    headerText:
                                        widget.vehicleData.typeData.name,
                                    fontSize: 20,
                                    color: qbAppTextColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                // Fair title
                                Container(
                                  child: FormFieldHeader(
                                    headerText: "Parking Fair :",
                                    fontSize: 20,
                                    color: qbDetailDarkColor,
                                  ),
                                ),

                                Expanded(
                                  child: SizedBox(
                                    width: 5,
                                  ),
                                ),

                                Container(
                                  child: FormFieldHeader(
                                    headerText: "₹",
                                    fontSize: 20,
                                    color: qbDetailDarkColor,
                                  ),
                                ),

                                SizedBox(
                                  width: 10,
                                ),
                                // Textbox
                                Container(
                                  width: 75,
                                  child: TextField(
                                      controller: vehicleFairController,
                                      onChanged: (value) {
                                        setState(() {
                                          vehicleFair = value;
                                        });
                                      },
                                      style: GoogleFonts.roboto(
                                          fontSize: 15 /
                                              MediaQuery.of(context)
                                                  .textScaleFactor,
                                          fontWeight: FontWeight.w500,
                                          color: qbAppTextColor),
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.phone,
                                      readOnly: false,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 2.5, vertical: 7.5),
                                      )),
                                ),

                                SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Divider(
                            height: 10,
                            color: qbDividerLightColor,
                            thickness: 1.5,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                // Text
                                Expanded(
                                  child: FormFieldHeader(
                                    headerText:
                                        "Do you want allow parking for ${vehicleName.toLowerCase()} in your slot?",
                                    fontSize: 17.5,
                                    color: qbDetailLightColor,
                                  ),
                                ),

                                Container(
                                  child: Checkbox(
                                      onChanged: (value) {
                                        setState(() {
                                          isVehicleSelected = value;
                                        });
                                      },
                                      value: isVehicleSelected,
                                      activeColor: qbAppPrimaryGreenColor),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                              child: SizedBox(
                            height: 5,
                          )),
                          Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 2.5),
                              alignment: Alignment.center,
                              child: EdgeLessButton(
                                child: Text(
                                  "Submit",
                                  style: GoogleFonts.nunito(
                                      fontSize: 16.5,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                  textAlign: TextAlign.center,
                                  textScaleFactor: 1.0,
                                ),
                                color: (isFormValid)
                                    ? qbAppPrimaryBlueColor
                                    : qbDividerDarkColor,
                                width: MediaQuery.of(context).size.width * 0.6,
                                padding: EdgeInsets.symmetric(vertical: 8.5),
                                onPressed: () {
                                  onSubmitPressed(context);
                                },
                              )),
                        ],
                      ),
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

  onSubmitPressed(BuildContext buildContext) async {
    if (!isFormValid) {
      return;
    }

    // TODO: Add Motion Toasts
    setState(() {
      isLoading = true;
    });
    if (isVehicleSelected) {
      double fair = double.parse(vehicleFair);
      if (widget.vehicleData.id == null) {
        if (fair > 0) {
          SlotVehicleAddStatus addStatus = await SlotsServices().addVehicle(
              context: context,
              vehicleType: widget.vehicleData.type,
              fair: fair);
          switch (addStatus) {
            case SlotVehicleAddStatus.success:
              break;
            case SlotVehicleAddStatus.internalServerError:
              break;
            case SlotVehicleAddStatus.failed:
              break;
            case SlotVehicleAddStatus.slotNotFound:
              break;
            case SlotVehicleAddStatus.vehicleAlreadyPresent:
              break;
          }

          // Navigator.of(context).pop();
        }
      } else {
        if (fair != widget.vehicleData.fair) {
          SlotVehicleUpdateStatus updateStatus = await SlotsServices()
              .updateVehicle(
                  context: context,
                  vehicleType: widget.vehicleData.type,
                  fair: double.parse(vehicleFair));

          switch (updateStatus) {
            case SlotVehicleUpdateStatus.success:
              break;
            case SlotVehicleUpdateStatus.cannotBeUpdated:
              break;
            case SlotVehicleUpdateStatus.internalServerError:
              break;
            case SlotVehicleUpdateStatus.failed:
              break;
            case SlotVehicleUpdateStatus.slotNotFound:
              break;
            case SlotVehicleUpdateStatus.vehicleNotFound:
              break;
          }
        }

        Navigator.of(context).pop();
      }
    } else {
      if (widget.vehicleData.id != null) {
        SlotVehicleUnchecktatus uncheckStatus = await SlotsServices()
            .uncheckVehicle(
                context: context, vehicleType: widget.vehicleData.type);

        switch (uncheckStatus) {
          case SlotVehicleUnchecktatus.success:
            break;
          case SlotVehicleUnchecktatus.cannotBeUpdated:
            break;
          case SlotVehicleUnchecktatus.internalServerError:
            break;
          case SlotVehicleUnchecktatus.failed:
            break;
          case SlotVehicleUnchecktatus.slotNotFound:
            break;
          case SlotVehicleUnchecktatus.vehicleNotFound:
            break;
        }

        Navigator.of(context).pop();
      }
    }

    setState(() {
      isLoading = false;
    });
  }
}
