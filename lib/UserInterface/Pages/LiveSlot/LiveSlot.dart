import 'package:flutter/material.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/StateManagement/Models/ParkingRequestData.dart';
import 'package:getparked/UserInterface/Pages/LiveSlot/AvailableSpaceWidget.dart';
import 'package:getparked/UserInterface/Pages/LiveSlot/AvailableVehiclesWidget/AvailableVehiclesWidget.dart';
import 'package:getparked/UserInterface/Pages/LiveSlot/BookingCard.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/FormFieldHeader.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LiveSlot extends StatefulWidget {
  @override
  _LiveSlotState createState() => _LiveSlotState();
}

class _LiveSlotState extends State<LiveSlot> {
  bool isLoading = false;
  List<Widget> mainWidgets = [];
  AppState gpAppState;

  setBookingsCards() {
    List<Widget> bookingCards = [];
    gpAppState.slotParkings.forEach((parkingReq) {
      if ((parkingReq.getParkingRequestDataType() ==
              ParkingRequestDataType.booked_BookingGoingON) ||
          (parkingReq.getParkingRequestDataType() ==
              ParkingRequestDataType.booked_ParkingGoingON)) {
        bookingCards.add(BookingCard(parkingRequestData: parkingReq));
      }
    });

    if (bookingCards.length == 0) {
      mainWidgets.add(Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 25),
        child: Text(
          "No Bookings or Parkings",
          style: GoogleFonts.roboto(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: qbDetailLightColor),
          textScaleFactor: 1.0,
        ),
      ));
    } else {
      mainWidgets = [...mainWidgets, ...bookingCards];
    }
  }

  @override
  Widget build(BuildContext context) {
    gpAppState = Provider.of<AppState>(context);
    mainWidgets = [];
    mainWidgets.add(AvailableSpaceWidget());
    mainWidgets.add(AvailableVehiclesWidget());
    mainWidgets.add(Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: FormFieldHeader(
        headerText: "Bookings",
        color: qbAppTextColor,
      ),
    ));
    mainWidgets.add(
      Divider(
        thickness: 1.5,
        color: qbDividerLightColor,
        height: 5,
      ),
    );

    setBookingsCards();

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
                        Icon(Elusive.video, size: 20),
                        SizedBox(
                          width: 12.5,
                        ),
                        Text(
                          "Live Slot",
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
                    child: ListView.builder(
                      itemCount: mainWidgets.length,
                      itemBuilder: (context, index) {
                        return mainWidgets[index];
                      },
                    ),
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
