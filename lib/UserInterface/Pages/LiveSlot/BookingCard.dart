import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:getparked/StateManagement/Models/ParkingRequestData.dart';
import 'package:getparked/StateManagement/Models/UserDetails.dart';
import 'package:getparked/UserInterface/Icons/g_p_icons_icons.dart';
import 'package:getparked/UserInterface/Pages/LiveSlot/AvailableVehiclesWidget/VehicleTile.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/DisplayPicture.dart';
import 'package:getparked/UserInterface/Widgets/ParkingCard/ParkingCard.dart';
import 'package:getparked/UserInterface/Widgets/ParkingDetailsPage/ParkingDetailsPage.dart';
import 'package:getparked/UserInterface/Widgets/ParkingDetailsPage/ParkingDetailsWidgets/ParkingDetailsTheme.dart';
import 'package:getparked/Utils/DomainUtils.dart';
import 'package:google_fonts/google_fonts.dart';

class BookingCard extends StatefulWidget {
  final ParkingRequestData parkingRequestData;
  BookingCard({@required this.parkingRequestData});

  @override
  _BookingCardState createState() => _BookingCardState();
}

class _BookingCardState extends State<BookingCard> {
  @override
  Widget build(BuildContext context) {
    String displayImgUrl = formatImgUrl(
        widget.parkingRequestData.userDetails.profilePicThumbnailUrl);
    String displayName =
        widget.parkingRequestData.userDetails.firstName.trim() +
            " " +
            widget.parkingRequestData.userDetails.lastName;
    DisplayPictureType pictureType;
    double senderImgSize = 40;
    if (widget.parkingRequestData.userDetails.getGenderType() ==
        UserGender.female) {
      pictureType = DisplayPictureType.profilePictureFemale;
    } else {
      pictureType = DisplayPictureType.profilePictureMale;
    }
    int diffInMin = DateTime.now()
        .toLocal()
        .difference(DateTime.parse(widget.parkingRequestData.bookingData.time)
            .toLocal())
        .inMinutes;
    EdgeInsets textPadding = EdgeInsets.symmetric(horizontal: 1.5);

    IconData statusIcon = FontAwesome5.exclamation_triangle;
    Color statusColor = qbAppSecondaryGreenColor;
    String statusText = "Successful";
    switch (this.widget.parkingRequestData.getParkingRequestDataType()) {
      case ParkingRequestDataType.pending:
        statusIcon = FontAwesome5.clock;
        statusColor = qbAppSecondaryBlueColor;
        statusText = "Pending";
        break;
      case ParkingRequestDataType.pendingButExpired:
        statusIcon = FontAwesome5.exclamation_triangle;
        statusColor = qbAppPrimaryRedColor;
        statusText = "Expired";
        break;
      case ParkingRequestDataType.accepted_BookingPending:
        statusIcon = FontAwesome5.clock;
        statusColor = qbAppSecondaryBlueColor;
        statusText = "Pending";
        break;
      case ParkingRequestDataType.accepted_BookingExpired:
        statusIcon = FontAwesome5.exclamation_triangle;
        statusColor = qbAppPrimaryRedColor;
        statusText = "Expired";
        break;
      case ParkingRequestDataType.booked_BookingFailed:
        statusIcon = FontAwesome5.exclamation_triangle;
        statusColor = qbAppPrimaryRedColor;
        statusText = "Failed";
        break;
      case ParkingRequestDataType.booked_BookingGoingON:
        statusIcon = FontAwesome5.check_circle;
        statusColor = qbAppSecondaryGreenColor;
        statusText = "Booked";
        break;
      case ParkingRequestDataType.booked_BookingCancelled:
        statusIcon = FontAwesome5.exclamation_triangle;
        statusColor = qbAppPrimaryRedColor;
        statusText = "Cancelled";
        break;
      case ParkingRequestDataType.booked_ParkingGoingON:
        statusIcon = FontAwesome5.check_circle;
        statusColor = qbAppSecondaryGreenColor;
        statusText = "Parked";
        break;
      case ParkingRequestDataType.booked_ParkedAndWithdrawn:
        statusIcon = FontAwesome5.check_circle;
        statusColor = qbAppSecondaryGreenColor;
        statusText = "Withdrawn";
        break;
      case ParkingRequestDataType.rejected:
        statusIcon = FontAwesome5.exclamation_triangle;
        statusColor = qbAppPrimaryRedColor;
        statusText = "Rejected";
        break;
      case ParkingRequestDataType.accepted:
        statusIcon = FontAwesome5.check_circle;
        statusColor = qbAppSecondaryGreenColor;
        statusText = "Accepted";
        break;
      case ParkingRequestDataType.booked:
        statusIcon = FontAwesome5.check_circle;
        statusColor = qbAppSecondaryGreenColor;
        statusText = "Booked";
        break;
    }
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return ParkingDetailsPage(
                accType: ParkingDetailsAccType.slot,
                parkingRequest: widget.parkingRequestData);
          },
        ));
      },
      child: Container(
        padding: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 0.025,
                  blurRadius: 5,
                  offset: Offset(10, 5),
                  color: Color.fromRGBO(0, 0, 0, 0.04)),
            ],
            // color: qbDividerLightColor
            color: qbWhiteBGColor),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // User Details Row.
            Container(
              child: Row(
                children: [
                  Container(
                    child: DisplayPicture(
                      imgUrl: displayImgUrl,
                      height: senderImgSize,
                      width: senderImgSize,
                      type: pictureType,
                      isEditable: false,
                      isDeletable: false,
                    ),
                  ),

                  SizedBox(
                    width: 12.5,
                  ),

                  // Name
                  Expanded(
                      child: Container(
                    child: Text(
                      displayName,
                      style: GoogleFonts.yantramanav(
                          fontWeight: FontWeight.w500,
                          fontSize: 15.5,
                          color: qbDetailDarkColor),
                      textAlign: TextAlign.start,
                      textScaleFactor: 1,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )),
                ],
              ),
            ),

            SizedBox(
              height: 10,
            ),

            // Parking Details Row.
            Container(
              child: Row(
                children: [
                  // Vehicle Tile
                  VehicleTile(
                    vehicleData: widget.parkingRequestData.vehicleData,
                    tileSize: 60,
                    iconSize: 45,
                  ),

                  SizedBox(
                    width: 15,
                  ),

                  // Time and status
                  Expanded(
                      child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Time
                        Container(
                          child: Row(
                            children: [
                              Container(
                                child: Icon(
                                  GPIcons.stopwatch_outlined,
                                  color: qbBodyColor,
                                  size: 20,
                                ),
                              ),

                              SizedBox(
                                width: 5,
                              ),

                              // Hours
                              Container(
                                  padding: textPadding,
                                  child: Text(
                                    "${(diffInMin ~/ 60).toInt()}",
                                    style: GoogleFonts.cabin(
                                        fontSize: 17.5,
                                        fontWeight: FontWeight.w600,
                                        color: qbBodyColor),
                                    textScaleFactor: 1.0,
                                  )),
                              Container(
                                padding: textPadding,
                                child: Text("hours",
                                    style: GoogleFonts.cabin(
                                        fontSize: 11.5,
                                        height: 2,
                                        fontWeight: FontWeight.w600,
                                        color: qbBodyColor),
                                    textScaleFactor: 1.0),
                              ),

                              SizedBox(
                                width: 2.5,
                              ),

                              // Minutes
                              Container(
                                  padding: textPadding,
                                  child: Text("${(diffInMin % 60).toInt()}",
                                      style: GoogleFonts.cabin(
                                          fontSize: 17.5,
                                          fontWeight: FontWeight.w600,
                                          color: qbBodyColor),
                                      textScaleFactor: 1.0)),
                              Container(
                                padding: textPadding,
                                child: Text("minutes",
                                    style: GoogleFonts.cabin(
                                        fontSize: 11.5,
                                        height: 2,
                                        fontWeight: FontWeight.w600,
                                        color: qbBodyColor),
                                    textScaleFactor: 1.0),
                              )
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 7.5,
                        ),

                        // Status
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                "Status : ",
                                style: GoogleFonts.roboto(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: qbDetailLightColor),
                                textScaleFactor: 1.0,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              child: Text(
                                statusText,
                                style: GoogleFonts.roboto(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: statusColor),
                                textScaleFactor: 1.0,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              child: Icon(
                                statusIcon,
                                size: 15,
                                color: statusColor,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
