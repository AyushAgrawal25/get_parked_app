// import 'package:getparked/BussinessLogic/CountryStatesCities.dart';
import 'package:getparked/Utils/GPMapUtils.dart';
import 'package:getparked/StateManagement/Models/AppOverlayStyleData.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/UserInterface/Icons/g_p_icons_icons.dart';
import 'package:getparked/UserInterface/Widgets/ErrorPopUp.dart';
import 'package:provider/provider.dart';
import '../../../Theme/AppOverlayStyle.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/CustomIcon.dart';
import 'package:getparked/UserInterface/Widgets/EdgeLessButton.dart';
import 'package:getparked/UserInterface/Widgets/UnderLineTextFormField.dart';
import 'package:getparked/UserInterface/Widgets/qbFAB.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/mfg_labs_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:getparked/StateManagement/Models/SlotData.dart';

class ParkingAreaDetails extends StatefulWidget {
  SlotData slotData;
  Function(SlotData) onContinuePressed;

  ParkingAreaDetails(
      {@required this.onContinuePressed, @required this.slotData});
  @override
  _ParkingAreaDetailsState createState() => _ParkingAreaDetailsState();
}

class _ParkingAreaDetailsState extends State<ParkingAreaDetails> {
  // Form Data
  String gpLocationISOCode;
  String gpLocationName;
  String gpParkingSlotState;
  String gpParkingSlotCity;
  String gpParkingSlotPincode;
  String gpParkingSlotCountry;

  // Map Controller
  GPMapController gpMapController;
  bool isMarkerSet = false;
  List mapMarkers = [];
  List<Placemark> markerLocationData;

  AppState gpAppState;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gpAppState = Provider.of(context, listen: false);
  }

  onConfirm() async {
    LatLng slotPosition = gpMapController.getCameraPostion().target;
    setState(() {
      isMarkerSet = true;
      mapMarkers.add({
        "slotId": 0,
        "latitude": slotPosition.latitude,
        "longitude": slotPosition.longitude
      });
      gpLocationLong = slotPosition.longitude;
      gpLocationLat = slotPosition.latitude;
      gpMapController.setMarkers(mapMarkers);
    });
    markerLocationData = await Geolocator()
        .placemarkFromCoordinates(slotPosition.latitude, slotPosition.longitude)
        .catchError((err) {
      print(err);
    });
    if (markerLocationData != null) {
      markerLocationData.forEach((element) {
        if (element != null) {
          gpLocationISOCode = element.isoCountryCode;
          gpLocationName = element.name;
          gpParkingSlotCity = element.subAdministrativeArea;
          gpParkingSlotState = element.administrativeArea;
          gpParkingSlotCountry = element.country;
          gpParkingSlotPincode = element.postalCode;
        }
      });
      setState(() {});
    } else {
      print("Getting null man");
      setState(() {
        gpLocationISOCode = "";
        gpLocationName = "";
        gpParkingSlotCity = "";
        gpParkingSlotPincode = "";
        gpParkingSlotCountry = "";
        gpParkingSlotState = "";
        gpLocationLat = null;
        gpLocationLong = null;
      });
    }
  }

  onEdit() {
    setState(() {
      isMarkerSet = false;
      gpLocationISOCode = "";
      gpLocationName = "";
      gpParkingSlotCity = "";
      gpParkingSlotPincode = "";
      gpParkingSlotCountry = "";
      gpParkingSlotState = "";
      gpLocationLat = null;
      gpLocationLong = null;
      gpMapController.setMarkers([]);
    });
  }

  double gpLocationLong;
  double gpLocationLat;
  Widget mapWidget = Container(height: 0, width: 0);
  setMapWidget() {
    mapWidget = Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width * 0.65,
      child: Stack(
        children: [
          // Map
          GPMap(
            getController: (controller) {
              gpMapController = controller;
            },
            initialZoom: 16,
          ),

          // Map Pin
          (!isMarkerSet)
              ? Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Icon(
                      FontAwesome5.map_pin,
                      color: qbAppTextColor,
                      size: 20,
                    ),
                  ),
                )
              : Container(
                  height: 0,
                  width: 0,
                ),

          Positioned(
            bottom: 10,
            right: 15,
            child: QbFAB(
              child: Icon(
                MfgLabs.location,
                size: 20,
                color: Colors.white,
              ),
              color: qbAppPrimaryBlueColor,
              size: 50,
              onPressed: () async {
                gpMapController.setLocation(16);
              },
            ),
          ),

          Positioned(
            bottom: 10,
            left: 15,
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 250),
              child: (isMarkerSet)
                  ? QbFAB(
                      child: Icon(
                        FontAwesome5.pen,
                        size: 16.5,
                        color: Colors.white,
                      ),
                      color: qbAppPrimaryBlueColor,
                      size: 50,
                      onPressed: onEdit)
                  : QbFAB(
                      child: Icon(
                        FontAwesome5.check,
                        size: 20,
                        color: Colors.white,
                      ),
                      color: qbAppPrimaryGreenColor,
                      size: 50,
                      onPressed: onConfirm),
            ),
          )
        ],
      ),
    );
  }

  Widget slotDetailsHeading = Container(height: 0, width: 0);
  setSlotDetailsHeading() {
    slotDetailsHeading = Container(
      child: Text(
        "Slot Details",
        style: GoogleFonts.nunito(
            fontSize: 19,
            fontWeight: FontWeight.w700,
            color: qbDetailDarkColor),
        textScaleFactor: 1.0,
      ),
    );
  }

  String gpSlotAddress;
  String gpSlotLandmark;

  Widget cityAndPincodeWidget = Container(height: 0, width: 0);
  setCityAndPincodeWidget() {
    cityAndPincodeWidget = Container(
      child: Row(
        children: [
          // City
          Expanded(
            child: Container(
                child: UnderLineTextFormField(
              labelText: "City",
              value: gpParkingSlotCity,
              toChangeTextValueOnUpdate: true,
              isReadOnly: true,
            )),
          ),

          // PinCode
          Expanded(
            child: UnderLineTextFormField(
              labelText: "Pincode",
              isReadOnly: true,
              value: gpParkingSlotPincode,
              toChangeTextValueOnUpdate: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget continueBtn = Container(
    height: 0,
    width: 0,
  );
  setContinueBtn() {
    continueBtn = Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(vertical: 1.5, horizontal: 2.5),
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
          color:
              (isFormEntriesValid) ? qbAppPrimaryBlueColor : qbDividerDarkColor,
          width: MediaQuery.of(context).size.width * 0.6,
          padding: EdgeInsets.symmetric(vertical: 8.5),
          onPressed: onContinuePressed,
        ));
  }

  bool isFormEntriesValid = true;
  checkFormValidity() {
    isFormEntriesValid = true;

    if (gpLocationLong == null) {
      isFormEntriesValid = false;
    }

    if (gpLocationLat == null) {
      isFormEntriesValid = false;
    }

    if ((gpLocationISOCode == null) || (gpLocationISOCode == "")) {
      isFormEntriesValid = false;
    }

    if ((gpLocationName == null) || (gpLocationName == "")) {
      isFormEntriesValid = false;
    }

    if ((gpSlotAddress == null) || (gpSlotAddress == "")) {
      isFormEntriesValid = false;
    }

    if ((gpParkingSlotCity == null) || (gpParkingSlotCity == "")) {
      isFormEntriesValid = false;
    }

    if ((gpParkingSlotPincode == null) || (gpParkingSlotPincode == "")) {
      isFormEntriesValid = false;
    }

    if ((gpParkingSlotState == null) || (gpParkingSlotState == "")) {
      isFormEntriesValid = false;
    }

    if ((gpParkingSlotCountry == null) || (gpParkingSlotCountry == "")) {
      isFormEntriesValid = false;
    }

    if ((gpSlotLandmark == null) || (gpSlotLandmark == "")) {
      isFormEntriesValid = false;
    }
  }

  onContinuePressed() {
    if (isFormEntriesValid) {
      SlotData gpSlotData = widget.slotData;
      gpSlotData.latitude = gpLocationLat;
      gpSlotData.longitude = gpLocationLong;
      gpSlotData.countryCode = gpLocationISOCode;
      gpSlotData.locationName = gpLocationName;
      gpSlotData.address = gpSlotAddress;
      gpSlotData.country = gpParkingSlotCountry;
      gpSlotData.state = gpParkingSlotState;
      gpSlotData.city = gpParkingSlotCity;
      gpSlotData.pincode = gpParkingSlotPincode;
      gpSlotData.landmark = gpSlotLandmark;
      widget.onContinuePressed(gpSlotData);
    } else {
      // Show Error PopUp
      if ((gpLocationLat == null) || (gpLocationLong == null)) {
        ErrorPopUp().show("Please confirm your parking area location.", context,
            errorMoreDetails:
                "Your parking area location is helpful for users in finding your parking area.");
      } else {
        ErrorPopUp().show("All fields are required.", context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    checkFormValidity();
    setMapWidget();
    setSlotDetailsHeading();
    setCityAndPincodeWidget();
    setContinueBtn();
    // print(gpLocationISOCode);
    // print(gpLocationName);
    // print(gpParkingSlotCity);
    // print(gpParkingSlotState);
    // print(gpParkingSlotCountry);
    // print(gpParkingSlotPincode);
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Color.fromRGBO(250, 250, 250, 1),
      child: SafeArea(
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
                    "Parking Area Details",
                    style: GoogleFonts.nunito(
                        fontWeight: FontWeight.w600, color: qbAppTextColor),
                    textScaleFactor: 1,
                  ),
                )
              ],
            ),
            iconTheme: IconThemeData(color: qbAppTextColor),
            elevation: 0.0,
            backgroundColor: Colors.transparent,
          ),
          body: Container(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    mapWidget,
                    Expanded(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Parking Slot Details
                            slotDetailsHeading,

                            // Address
                            Container(
                                child: UnderLineTextFormField(
                              labelText: "Address",
                              onChange: (value) {
                                setState(() {
                                  gpSlotAddress = value;
                                });
                              },
                            )),
                            // Address
                            ((gpParkingSlotState != null) &&
                                    (gpParkingSlotState.length > 0))
                                ? Container(
                                    child: UnderLineTextFormField(
                                    labelText: "State",
                                    value: gpParkingSlotState,
                                    isReadOnly: true,
                                    toChangeTextValueOnUpdate: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 7.5, horizontal: 12.5),
                                  ))
                                : Container(),

                            // City And Pincode
                            cityAndPincodeWidget,

                            // Landmark
                            Container(
                                child: UnderLineTextFormField(
                              labelText: "Landmark",
                              onChange: (value) {
                                setState(() {
                                  gpSlotLandmark = value;
                                });
                              },
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 7.5, horizontal: 12.5),
                            )),

                            // Continue Button
                            continueBtn
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
