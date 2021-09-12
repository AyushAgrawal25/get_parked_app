import 'package:getparked/BussinessLogic/SlotsServices.dart';
import 'package:getparked/StateManagement/Models/VehicleData.dart';
import 'package:getparked/StateManagement/Models/VehicleTypeData.dart';
import 'package:getparked/Utils/DomainUtils.dart';
import 'package:getparked/Utils/FlushBarUtils.dart';
import 'package:getparked/BussinessLogic/SlotsUtils.dart';
import 'package:getparked/StateManagement/Models/AppOverlayStyleData.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/StateManagement/Models/SlotData.dart';
import 'package:getparked/StateManagement/Models/UserDetails.dart';
import 'package:getparked/UserInterface/Icons/g_p_icons_icons.dart';
import 'package:getparked/UserInterface/Pages/Home/ParkingRequest/ParkingRequestPage.dart';
import 'package:flushbar/flushbar.dart';
import 'package:getparked/UserInterface/Widgets/CustomIcon.dart';
import 'package:getparked/UserInterface/Widgets/DisplayPicture.dart';
import 'package:getparked/UserInterface/Widgets/EdgeLessButton.dart';
import 'package:getparked/UserInterface/Widgets/Rating/RatingWidget.dart';
import 'package:getparked/UserInterface/Widgets/qbFAB.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:provider/provider.dart';
import './../../../Theme/AppTheme.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class QRScannerPage extends StatefulWidget {
  String qrCode;
  Function onScanAgain;
  QRScannerPage({@required this.qrCode, @required this.onScanAgain});

  @override
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  Widget pageBody = Container(
    child: Center(child: CircularProgressIndicator()),
  );
  bool isLoading = true;

  SlotData gpSlotData;
  Map slotData;
  Map slotDetails;
  String mainImgUrl = "";
  AppState gpAppState;

  // Area
  double totalArea = 0;
  double allottedArea = 0;

  @override
  void initState() {
    super.initState();
    gpAppState = Provider.of(context, listen: false);
    initializeSlotData();
  }

  initializeSlotData() async {
    gpSlotData = await SlotsServices()
        .getSlotDetailsFromQRCode(widget.qrCode, gpAppState.authToken);
    setState(() {
      isLoading = false;
    });
  }

  settingUpParkingLordDetailsWidget() {
    if (!isLoading) {
      if (gpSlotData != null) {
        // Calculating Area
        totalArea = gpSlotData.breadth * gpSlotData.length;
        allottedArea = totalArea - gpSlotData.availableSpace;

        // Page Body
        pageBody = ParkingLordDetailsWidget(
            availableArea: (totalArea - allottedArea),
            slotData: gpSlotData,
            onScanAgain: widget.onScanAgain);
      } else {
        // When No Information was Found..
        pageBody = Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  height: MediaQuery.of(context).size.width * 0.75,
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: Stack(
                    children: [
                      Container(
                          child: Image.asset(
                        "assets/images/QRCodeError.png",
                        color: Color.fromRGBO(150, 150, 150, 1),
                      )),
                      Align(
                        alignment: Alignment(-0.085, -0.055),
                        child: Text(
                          "Error !",
                          style: GoogleFonts.raleway(
                              color: qbAppTextColor,
                              fontSize: 32.5,
                              fontWeight: FontWeight.w900),
                          textScaleFactor: 1.0,
                        ),
                      )
                    ],
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  "Oops\nNo Information Found...",
                  style: GoogleFonts.nunito(
                      fontSize: 17.5, color: qbDetailLightColor),
                  textAlign: TextAlign.center,
                  textScaleFactor: 1.0,
                ),
              ),
              Container(
                child: Text(
                  "# May be Due to Internet Connection.",
                  style: GoogleFonts.nunito(
                      fontSize: 17.5, color: qbDetailLightColor),
                  textAlign: TextAlign.center,
                  textScaleFactor: 1.0,
                ),
              ),
              Container(
                child: Text(
                  "# May be Scanned QR Code is Invalid.",
                  style: GoogleFonts.nunito(
                      fontSize: 17.5, color: qbDetailLightColor),
                  textAlign: TextAlign.center,
                  textScaleFactor: 1.0,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: EdgeLessButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        MdiIcons.qrcodeScan,
                        size: 15,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 7.5,
                      ),
                      Text(
                        "Scan Again",
                        style: GoogleFonts.nunito(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                        textScaleFactor: 1.0,
                      )
                    ],
                  ),
                  width: 150,
                  padding: EdgeInsets.symmetric(
                    vertical: 9,
                  ),
                  color: qbAppPrimaryBlueColor,
                  onPressed: () {
                    Navigator.pop(context);
                    widget.onScanAgain();
                  },
                ),
              )
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    settingUpParkingLordDetailsWidget();

    return Container(
      color: Color.fromRGBO(250, 250, 250, 1),
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  Icon(
                    MdiIcons.qrcodeScan,
                    size: 20,
                    color: qbAppTextColor,
                  ),
                  SizedBox(
                    width: 12.5,
                  ),
                  Text(
                    "QR Scanner",
                    style: GoogleFonts.nunito(
                        fontWeight: FontWeight.w600, color: qbAppTextColor),
                    textScaleFactor: 1.0,
                  )
                ],
              ),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              iconTheme: IconThemeData(color: qbAppTextColor),
            ),
            body: pageBody),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class ParkingLordDetailsWidget extends StatefulWidget {
  Function onScanAgain;

  // dimensions
  double availableArea;

  // Slot Data
  SlotData slotData;

  ParkingLordDetailsWidget(
      {@required this.availableArea,
      @required this.slotData,
      @required this.onScanAgain});
  @override
  _ParkingLordDetailsWidgetState createState() =>
      _ParkingLordDetailsWidgetState();
}

class _ParkingLordDetailsWidgetState extends State<ParkingLordDetailsWidget> {
  String parkingTime = "";
  List<Widget> vehicleButtons = [];
  @override
  Widget build(BuildContext context) {
    parkingTime = SlotDataUtils()
        .convertToShowTime(widget.slotData.startTime, widget.slotData.endTime);
    settingUpVehicles();
    Color parkHereButtonColor;
    if (gpSelectedVehicleType == null) {
      parkHereButtonColor = qbDetailLightColor;
    } else {
      parkHereButtonColor = qbAppPrimaryGreenColor;
    }
    return Container(
      child: Column(
        children: [
          Expanded(
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 7.5),
                alignment: Alignment.topCenter,
                child: DisplayPicture(
                  imgUrl: formatImgUrl(widget.slotData.mainImageUrl),
                  isEditable: false,
                  height: MediaQuery.of(context).size.width * 0.6,
                  width: MediaQuery.of(context).size.width,
                )),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 0, horizontal: 25),
            child: Text(
              widget.slotData.name,
              style: GoogleFonts.mukta(
                  fontWeight: FontWeight.w600,
                  fontSize: 22.5,
                  color: qbAppTextColor),
              textAlign: TextAlign.start,
              textScaleFactor: 1.0,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
            child: Row(
              children: [
                // Profile Picture
                Container(
                  child: DisplayPicture(
                    imgUrl: formatImgUrl(
                        widget.slotData.userDetails.profilePicThumbnailUrl),
                    height: 45,
                    width: 45,
                    type: (widget.slotData.userDetails.getGenderType() ==
                            UserGender.male)
                        ? DisplayPictureType.profilePictureMale
                        : DisplayPictureType.profilePictureFemale,
                    isEditable: false,
                  ),
                ),
                SizedBox(
                  width: 12.5,
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.slotData.userDetails.firstName.trim() +
                              " " +
                              widget.slotData.userDetails.lastName.trim(),
                          style: GoogleFonts.roboto(
                              fontSize: 17.5,
                              fontWeight: FontWeight.w500,
                              color: qbAppTextColor),
                          textAlign: TextAlign.start,
                          textScaleFactor: 1.0,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 2.5,
                        ),
                        Container(
                          child: RatingWidget(
                              ratingValue: (widget.slotData != null)
                                  ? widget.slotData.rating
                                  : null,
                              fontSize: 12.5,
                              iconSize: 12.5),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              padding: EdgeInsets.symmetric(vertical: 12.5, horizontal: 17.5),
              decoration: BoxDecoration(
                border: Border.all(
                  color: qbDividerLightColor,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Parking Time
                  Container(
                    child: Row(
                      children: [
                        Container(
                          child: Text(
                            "Parking Time : ",
                            style: GoogleFonts.roboto(
                                fontSize: 17.5,
                                fontWeight: FontWeight.w500,
                                color: qbAppTextColor),
                            textScaleFactor: 1.0,
                          ),
                        ),
                        Container(
                          child: Text(
                            parkingTime,
                            style: GoogleFonts.roboto(
                                fontSize: 17.5,
                                fontWeight: FontWeight.w500,
                                color: qbDetailDarkColor),
                            textScaleFactor: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Parking Area
                  Container(
                    child: Row(
                      children: [
                        Container(
                          child: Text(
                            "Space Type : ",
                            style: GoogleFonts.roboto(
                                fontSize: 17.5,
                                fontWeight: FontWeight.w500,
                                color: qbAppTextColor),
                            textScaleFactor: 1.0,
                          ),
                        ),
                        Container(
                          child: Text(
                            "Shed " +
                                ((widget.slotData.spaceType ==
                                        SlotSpaceType.sheded)
                                    ? "Available"
                                    : "unavailable"),
                            style: GoogleFonts.roboto(
                                fontSize: 17.5,
                                fontWeight: FontWeight.w500,
                                color: qbDetailDarkColor),
                            textScaleFactor: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Vehicle Availability
                  Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            "Select Vehicle : ",
                            style: GoogleFonts.roboto(
                                fontSize: 17.5,
                                fontWeight: FontWeight.w500,
                                color: qbAppTextColor),
                            textScaleFactor: 1.0,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: vehicleButtons,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 7.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Scan Again
                EdgeLessButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        MdiIcons.qrcodeScan,
                        size: 15,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 7.5,
                      ),
                      Text(
                        "Scan Again",
                        style: GoogleFonts.nunito(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                        textScaleFactor: 1.0,
                      )
                    ],
                  ),
                  width: 150,
                  padding: EdgeInsets.symmetric(
                    vertical: 9,
                  ),
                  color: qbAppPrimaryBlueColor,
                  onPressed: () {
                    Navigator.pop(context);
                    widget.onScanAgain();
                  },
                ),

                // Park Here
                EdgeLessButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        FontAwesome5.car,
                        size: 17.5,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 7.5,
                      ),
                      Text(
                        "Park Here !",
                        style: GoogleFonts.nunito(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                        textScaleFactor: 1.0,
                      )
                    ],
                  ),
                  width: 150,
                  padding: EdgeInsets.symmetric(
                    vertical: 9,
                  ),
                  color: parkHereButtonColor,
                  onPressed: onParkHerePressed,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  VehicleType gpSelectedVehicleType;

  settingUpVehicles() {
    vehicleButtons = [];
    widget.slotData.vehicles.forEach((vehicle) {
      bool isAvailable = false;
      if (vehicle.status == 1) {
        double vehicleArea = vehicle.typeData.breadth * vehicle.typeData.length;
        if ((widget.slotData.height >= vehicle.typeData.height) &&
            (vehicleArea <= widget.availableArea)) {
          isAvailable = true;
        }
      }

      bool isVehicleSelected = false;
      if (vehicle.type == gpSelectedVehicleType) {
        isVehicleSelected = true;
      }
      vehicleButtons.add(VehicleAndNameButton(
        isAvailable: isAvailable,
        type: vehicle.type,
        isSelected: isVehicleSelected,
        onSelect: onVehicleSelect,
      ));
    });
  }

  onVehicleSelect(vehicleType) {
    setState(() {
      gpSelectedVehicleType = vehicleType;
    });
  }

  onParkHerePressed() {
    if (gpSelectedVehicleType == null) {
      FlushBarUtils.showTextResponsive(context, "Select Vehicle Type",
          "Vehicle Must be Selected Before Proccessing");
    } else {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return ParkingRequestForm(
              vehicleType: gpSelectedVehicleType, slotData: widget.slotData);
        },
      ));
    }
  }
}

class VehicleAndNameButton extends StatefulWidget {
  VehicleType type;
  bool isAvailable;
  bool isSelected;
  Function(VehicleType) onSelect;

  VehicleAndNameButton(
      {@required this.isAvailable,
      @required this.type,
      @required this.isSelected,
      this.onSelect});
  @override
  _VehicleAndNameButtonState createState() => _VehicleAndNameButtonState();
}

class _VehicleAndNameButtonState extends State<VehicleAndNameButton> {
  String name = "";
  IconData icon = GPIcons.bike;
  double size = 30;
  Color iconColor = qbAppTextColor;
  Color iconBGColor = qbLightGreyBGColor;
  @override
  Widget build(BuildContext context) {
    if (widget.isAvailable) {
      if (widget.isSelected) {
        iconColor = qbWhiteBGColor;
        iconBGColor = qbAppPrimaryGreenColor;
      } else {
        iconColor = qbAppTextColor;
        iconBGColor = qbWhiteBGColor;
      }
    } else {
      iconColor = qbAppTextColor;
      iconBGColor = qbLightGreyBGColor;
    }
    switch (widget.type) {
      case VehicleType.bike:
        name = "Bike";
        size = 30;
        if ((!widget.isAvailable) || (widget.isSelected)) {
          icon = GPIcons.bike_bag;
        } else if ((!widget.isSelected) && (widget.isAvailable)) {
          icon = GPIcons.bike_bag_outlined;
        }
        break;
      case VehicleType.mini:
        name = "Mini";
        size = 32.5;
        if ((!widget.isAvailable) || (widget.isSelected)) {
          icon = GPIcons.hatch_back_car;
        } else if ((!widget.isSelected) && (widget.isAvailable)) {
          icon = GPIcons.hatch_back_car_outlined;
        }
        break;
      case VehicleType.sedan:
        name = "Sedan";
        size = 37.5;
        if ((!widget.isAvailable) || (widget.isSelected)) {
          icon = GPIcons.sedan_car;
        } else if ((!widget.isSelected) && (widget.isAvailable)) {
          icon = GPIcons.sedan_car_outlined;
        }
        break;
      case VehicleType.suv:
        name = "SUV";
        size = 35;
        if ((!widget.isAvailable) || (widget.isSelected)) {
          icon = GPIcons.suv_car;
        } else if ((!widget.isSelected) && (widget.isAvailable)) {
          icon = GPIcons.suv_car_outlined;
        }
        break;
      case VehicleType.van:
        name = "Van";
        size = 32.5;
        if ((!widget.isAvailable) || (widget.isSelected)) {
          icon = GPIcons.van;
        } else if ((!widget.isSelected) && (widget.isAvailable)) {
          icon = GPIcons.van_outlined;
        }
        break;
    }
    return Container(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QbFAB(
              size: 50,
              color: iconBGColor,
              child: Container(
                child: CustomIcon(
                  icon: icon,
                  color: iconColor,
                  size: size,
                ),
              ),
              onPressed: () {
                if (widget.isAvailable) {
                  widget.onSelect(widget.type);
                }
              },
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              child: Text(
                name,
                style: GoogleFonts.nunito(
                    fontSize: 14,
                    fontWeight:
                        (widget.isSelected) ? FontWeight.w700 : FontWeight.w600,
                    color: qbAppTextColor),
                textScaleFactor: 1.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
