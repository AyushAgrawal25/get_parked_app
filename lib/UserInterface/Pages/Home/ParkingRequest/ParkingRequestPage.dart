import 'package:getparked/BussinessLogic/SlotsServices.dart';
import 'package:getparked/Utils/FlushBarUtils.dart';
import 'package:getparked/BussinessLogic/SlotsUtils.dart';
import 'package:getparked/Utils/DomainUtils.dart';
import 'package:getparked/StateManagement/Models/AppOverlayStyleData.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/StateManagement/Models/SlotData.dart';
import 'package:getparked/StateManagement/Models/UserDetails.dart';
import 'package:getparked/StateManagement/Models/VehicleData.dart';
import 'package:getparked/UserInterface/Icons/g_p_icons_icons.dart';
import 'package:getparked/UserInterface/Widgets/Reviews/ReviewButton.dart';
import 'package:getparked/UserInterface/Widgets/Loaders/LoaderPage.dart';
import 'package:getparked/UserInterface/Widgets/SuccessAndFailure/SuccessAndFailurePage.dart';
import 'package:getparked/UserInterface/Widgets/SlotNameWidget.dart';
import 'package:flushbar/flushbar.dart';
import '../../../Theme/AppOverlayStyle.dart';
import 'package:getparked/UserInterface/Widgets/CustomIcon.dart';
import 'package:getparked/UserInterface/Widgets/DisplayPicture.dart';
import 'package:getparked/UserInterface/Widgets/EdgeLessButton.dart';
import 'package:getparked/UserInterface/Widgets/RadioTileButton.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:provider/provider.dart';
import '../../../Widgets/MoreDetailsAcc.dart';
import '../../../Widgets/Rating/RatingWidget.dart';
import '../../../Theme/AppTheme.dart';
import 'package:google_fonts/google_fonts.dart';

class ParkingRequestForm extends StatefulWidget {
  VehicleType vehicleType;
  SlotData slotData;

  Function(bool) onParkingRequestSent;

  ParkingRequestForm(
      {@required this.vehicleType,
      @required this.slotData,
      this.onParkingRequestSent});

  @override
  _ParkingRequestFormState createState() => _ParkingRequestFormState();
}

class _ParkingRequestFormState extends State<ParkingRequestForm> {
  //Form Fields
  String parkingHour;

  // Vehicle Data
  VehicleData gpSelectedVehicleData;
  IconData vehicleIcon = GPIcons.bike_bag;

  //Widgets
  List<DropdownMenuItem<String>> parkingHourList = [];

  // Carousel Images
  List carouselImages = [
    Container(
      color: qbDetailLightColor,
      child: Center(
        child: Text(
          "No Image For Preview",
          textScaleFactor: 1.0,
        ),
      ),
    )
  ];

  // Profile Picture
  Widget profilePic = Container();

  // Loading
  bool isLoading = false;

  AppState gpAppState;
  @override
  void initState() {
    super.initState();

    gpAppState = Provider.of<AppState>(context, listen: false);
    initiateParkingHoursList();
  }

  @override
  Widget build(BuildContext context) {
    // AppState Listenable
    AppState gpAppStateListen = Provider.of<AppState>(context);

    // Carousel Images
    carouselImages = [];
    if (widget.slotData.mainImageUrl != null) {
      carouselImages.add(DisplayPicture(
          imgUrl: formatImgUrl(widget.slotData.mainImageUrl),
          height: MediaQuery.of(context).size.height * 0.266,
          width: MediaQuery.of(context).size.width,
          isDeletable: false,
          isEditable: false));
    } else {
      carouselImages.add(Container(
        color: qbDetailLightColor,
        child: Center(
          child: Text(
            "No Image For Preview",
            textScaleFactor: 1.0,
          ),
        ),
      ));
    }
    widget.slotData.imageUrls.forEach((slotImage) {
      carouselImages.add(DisplayPicture(
        imgUrl: formatImgUrl(slotImage),
        height: MediaQuery.of(context).size.height * 0.266,
        width: MediaQuery.of(context).size.width,
        isDeletable: false,
        isEditable: false,
      ));
    });

    // Vehicles
    widget.slotData.vehicles.forEach((slotVehicle) {
      if (slotVehicle.type == widget.vehicleType) {
        gpSelectedVehicleData = slotVehicle;
      }
    });

    switch (gpSelectedVehicleData.type) {
      case VehicleType.bike:
        vehicleIcon = GPIcons.bike_bag;
        break;
      case VehicleType.mini:
        vehicleIcon = GPIcons.hatch_back_car;
        break;
      case VehicleType.sedan:
        vehicleIcon = GPIcons.sedan_car;
        break;
      case VehicleType.van:
        vehicleIcon = GPIcons.van;
        break;
      case VehicleType.suv:
        vehicleIcon = GPIcons.suv_car;
        break;
    }

    if (widget.slotData.userDetails != null) {
      UserGender userGender = UserDetailsUtils.setGenderTypeFromString(
          widget.slotData.userDetails.gender);
      profilePic = DisplayPicture(
        imgUrl:
            formatImgUrl(widget.slotData.userDetails.profilePicThumbnailUrl),
        height: 45,
        width: 45,
        isEditable: false,
        isDeletable: false,
        type: (userGender == UserGender.female)
            ? DisplayPictureType.profilePictureFemale
            : DisplayPictureType.profilePictureMale,
      );
    }

    if (isLoading) {
      return Container(
        child: LoaderPage(),
      );
    } else {
      return Container(
        color: qbWhiteBGColor,
        child: SafeArea(
          maintainBottomViewPadding: true,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                "Parking Request",
                style: GoogleFonts.nunito(
                    fontSize: 20,
                    color: qbAppTextColor,
                    fontWeight: FontWeight.w600),
                textScaleFactor: 1.0,
              ),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              iconTheme: IconThemeData(color: qbAppTextColor),
            ),
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //ImageCarousel
                      Container(
                        height: MediaQuery.of(context).size.height * 0.2666,
                        width: MediaQuery.of(context).size.width,
                        child: Carousel(
                          boxFit: BoxFit.cover,
                          images: carouselImages,
                          autoplay: false,
                          animationCurve: Curves.fastLinearToSlowEaseIn,
                          animationDuration: Duration(milliseconds: 250),
                          dotSize: 4.0,
                          indicatorBgPadding: 6.0,
                        ),
                      ),

                      //Rest All Details
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Slot Details
                            Container(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //SlotName
                                  SlotNameWidget(
                                      slotName: (widget.slotData != null)
                                          ? widget.slotData.name
                                          : "Slot Name Loading..."),

                                  //Slot User Details
                                  Container(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            child: Row(
                                              children: [
                                                //Profile Picture
                                                Container(
                                                  height: 45,
                                                  width: 45,
                                                  decoration: BoxDecoration(
                                                      color: qbDetailLightColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              360)),
                                                  child: profilePic,
                                                ),

                                                SizedBox(
                                                  width: 15,
                                                ),

                                                //User Name
                                                Container(
                                                  child: Text(
                                                    (widget.slotData != null)
                                                        ? widget
                                                                .slotData
                                                                .userDetails
                                                                .firstName
                                                                .trim() +
                                                            " " +
                                                            widget
                                                                .slotData
                                                                .userDetails
                                                                .lastName
                                                                .trim()
                                                        : "No Username",
                                                    style: GoogleFonts.roboto(
                                                        fontSize: 17.5,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: qbAppTextColor),
                                                    textScaleFactor: 1.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        ReviewButton(slotId: widget.slotData.id)
                                      ],
                                    ),
                                  ),

                                  //Rating
                                  Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 2.5),
                                      child: RatingWidget(
                                        fontSize: 12.5,
                                        // Add Rating Value
                                        ratingValue: (widget.slotData != null)
                                            ? widget.slotData.rating
                                            : null,
                                        iconSize: 13,
                                      )),

                                  //More Details
                                  Container(
                                    child: MoreDetailsAcc(
                                      address: widget.slotData.address,
                                      landmark: widget.slotData.landmark,
                                      state: widget.slotData.state,
                                      city: widget.slotData.city,
                                    ),
                                  )
                                ],
                              ),
                            ),

                            //Vehicle Type
                            Container(
                              height: 47.5,
                              alignment: Alignment.center,
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 7.5),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: qbAppPrimaryGreenColor,
                                  borderRadius: BorderRadius.circular(360),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Text(
                                        "Vehicle Type : ",
                                        style: GoogleFonts.roboto(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white),
                                        textScaleFactor: 1.0,
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        gpSelectedVehicleData.typeData.name,
                                        style: GoogleFonts.nunito(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                        textScaleFactor: 1.0,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      child: CustomIcon(
                                        icon: vehicleIcon,
                                        size: 16.5,
                                        type: CustomIconType.onHeight,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),

                            //Parking Type
                            Container(
                              height: 47.5,
                              alignment: Alignment.center,
                              child: Row(
                                children: [
                                  //Title
                                  Container(
                                    child: Text(
                                      "Parking Type : ",
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
                                              : "Unavailable"),
                                      style: GoogleFonts.roboto(
                                          fontSize: 17.5,
                                          fontWeight: FontWeight.w500,
                                          color: qbDetailDarkColor),
                                      textScaleFactor: 1.0,
                                    ),
                                  )
                                ],
                              ),
                            ),

                            //Security Deposit
                            Container(
                              height: 47.5,
                              alignment: Alignment.center,
                              child: Row(
                                children: [
                                  //Title
                                  Container(
                                    child: Text(
                                      "Security Deposit : ",
                                      style: GoogleFonts.roboto(
                                          fontSize: 17.5,
                                          fontWeight: FontWeight.w500,
                                          color: qbAppTextColor),
                                      textScaleFactor: 1.0,
                                    ),
                                  ),

                                  Container(
                                    child: Text(
                                      "${widget.slotData.securityDepositTime} Hours",
                                      style: GoogleFonts.roboto(
                                          fontSize: 17.5,
                                          fontWeight: FontWeight.w500,
                                          color: qbDetailDarkColor),
                                      textScaleFactor: 1.0,
                                    ),
                                  )
                                ],
                              ),
                            ),

                            //Parking Hours
                            Container(
                              height: 47.5,
                              alignment: Alignment.center,
                              child: Row(
                                children: [
                                  //Title
                                  Container(
                                    child: Text(
                                      "Parking Hours :",
                                      style: GoogleFonts.roboto(
                                          fontSize: 17.5,
                                          fontWeight: FontWeight.w500,
                                          color: qbAppTextColor),
                                      textScaleFactor: 1.0,
                                    ),
                                  ),

                                  SizedBox(
                                    width: 10,
                                  ),

                                  Container(
                                    child: DropdownButton(
                                      value: parkingHour,
                                      items: parkingHourList,
                                      onChanged: (value) {
                                        if (value != null) {
                                          setState(() {
                                            parkingHour = value;
                                          });
                                        }

                                        print(parkingHour);
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),

                            //Parking Charges
                            Container(
                              height: 55,
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  Container(
                                    child: Divider(
                                      height: 10,
                                      color: Color.fromRGBO(225, 225, 225, 1),
                                      thickness: 1,
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: Text(
                                            "Parking Charges Per Hour : ",
                                            style: GoogleFonts.roboto(
                                              fontSize: 17.5,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            textScaleFactor: 1.0,
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            "Rs ${gpSelectedVehicleData.fair} /-",
                                            style: GoogleFonts.mukta(
                                                fontSize: 17.5,
                                                fontWeight: FontWeight.w500,
                                                color: qbAppTextColor),
                                            textScaleFactor: 1.0,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Divider(
                                      height: 10,
                                      color: Color.fromRGBO(225, 225, 225, 1),
                                      thickness: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            //Send Button
                            Container(
                              padding: EdgeInsets.only(
                                top: 7.5,
                                bottom: 15,
                              ),
                              child: EdgeLessButton(
                                height: 45,
                                padding: EdgeInsets.symmetric(vertical: 10),
                                onPressed: sendParkingRequest,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Send Parking Request",
                                      style: GoogleFonts.nunito(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 17.5,
                                          color: Colors.white),
                                      textScaleFactor: 1.0,
                                    ),
                                    Icon(
                                      FontAwesome.paper_plane_empty,
                                      size: 15,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
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
  }

  initiateParkingHoursList() {
    parkingHourList = [];
    parkingHourList.add(DropdownMenuItem(
      value: null,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          "Hours",
          style: GoogleFonts.roboto(
              fontSize: 14, fontWeight: FontWeight.w400, color: qbAppTextColor),
          textScaleFactor: 1.0,
        ),
      ),
    ));

    for (var i = 1; i <= 24; i++) {
      parkingHourList.add(DropdownMenuItem(
        value: i.toString(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            i.toString() + " hr",
            style: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: qbAppTextColor),
            textScaleFactor: 1.0,
          ),
        ),
      ));
    }
  }

  sendParkingRequest() async {
    //Code For Form Validation
    bool isFormValid = true;

    if (gpAppState.userData.id == null) {
      isFormValid = false;
    }
    if (gpAppState.authToken == null) {
      isFormValid = false;
    }
    if (widget.slotData.id == null) {
      isFormValid = false;
    }
    if (widget.slotData.userDetails.id == null) {
      isFormValid = false;
    }
    if (gpSelectedVehicleData.id == null) {
      isFormValid = false;
    }
    if (parkingHour == null) {
      isFormValid = false;
    }

    if (isFormValid) {
      setState(() {
        isLoading = true;
      });

      bool parkingRequestSendStatus = false;
      ParkingRequestStatus requestStatus = await SlotsServices()
          .sendParkingRequest(
              authToken: gpAppState.authToken,
              parkingHours: int.parse(parkingHour),
              slotId: widget.slotData.id,
              spaceType: widget.slotData.spaceType,
              vehicleId: gpSelectedVehicleData.id);
      if (requestStatus == ParkingRequestStatus.success) {
        parkingRequestSendStatus = true;
      }

      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return SuccessAndFailurePage(
            status: (parkingRequestSendStatus)
                ? SuccessAndFailureStatus.success
                : SuccessAndFailureStatus.failure,
            statusText: "Parking Request",
            onButtonPressed: () {
              Navigator.of(context).pop();
              if (widget.onParkingRequestSent != null) {
                widget.onParkingRequestSent(parkingRequestSendStatus);
              }
            },
          );
        },
      )).then((value) {
        setState(() {
          isLoading = false;
        });
      });
    } else {
      FlushBarUtils.showTextResponsive(context, "Select Parking Hours",
          "Parking Hours must be Selected Before Proccessing");
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
