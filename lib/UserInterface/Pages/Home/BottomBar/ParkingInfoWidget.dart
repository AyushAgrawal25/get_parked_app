import 'package:getparked/Utils/DomainUtils.dart';
import 'package:getparked/StateManagement/Models/SlotData.dart';
import 'package:getparked/UserInterface/Widgets/DisplayPicture.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import './../../../Widgets/EdgeLessButton.dart';
import '../../../Widgets/Rating/RatingWidget.dart';
import './../../../Theme/AppTheme.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class ParkingInfoWidget extends StatefulWidget {
  Function(int) onParkHerePressed;
  SlotData slotData;

  ParkingInfoWidget({this.onParkHerePressed, @required this.slotData});

  @override
  _ParkingInfoWidgetState createState() => _ParkingInfoWidgetState();
}

class _ParkingInfoWidgetState extends State<ParkingInfoWidget> {
  String parkingTiming = "";
  String parkingTypeText;

  @override
  Widget build(BuildContext context) {
    if (widget.slotData != null) {
      parkingTiming = SlotDataUtils().convertToShowTime(
          widget.slotData.startTime, widget.slotData.endTime);

      switch (widget.slotData.spaceType) {
        case 1:
          parkingTypeText = "Shed Available";
          break;
        case 2:
          parkingTypeText = "Shed Unavailable";
          break;
        default:
          parkingTypeText = "";
      }
    }

    return Container(
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      decoration: BoxDecoration(color: qbWhiteBGColorShade248, boxShadow: [
        BoxShadow(
            blurRadius: 2.5,
            color: Color.fromRGBO(0, 0, 0, 0.05),
            offset: Offset(0, -2),
            spreadRadius: 0.05)
      ]),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Text(
              (widget.slotData != null)
                  ? widget.slotData.name
                  : "Slot Name Loading..",
              style: GoogleFonts.roboto(
                  fontSize: 17.5,
                  color: qbDetailDarkColor,
                  fontWeight: FontWeight.w500),
              textScaleFactor: 1.0,
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                //Slot Picture
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 15, 5),
                  alignment: Alignment.center,
                  child: Container(
                    height: 110,
                    width: 110,
                    child: DisplayPicture(
                      imgUrl: (widget.slotData != null)
                          ? formatImgUrl(widget.slotData.thumbnailUrl)
                          : "https://cdn.wallpapersafari.com/81/18/iUOFkP.jpg",
                      height: 110,
                      width: 110,
                      isEditable: false,
                      type: DisplayPictureType.slotMainImage,
                    ),
                  ),
                ),

                //Slot Details
                Expanded(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        //Rating
                        Container(
                            alignment: Alignment.centerLeft,
                            child: RatingWidget(
                                fontSize: 12,
                                iconSize: 13,
                                // Add Ratings As Soon As Possible
                                ratingValue: (widget.slotData != null)
                                    ? widget.slotData.rating
                                    : null)),

                        SizedBox(
                          height: 10,
                        ),

                        //Timing
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Timing : ",
                                style: GoogleFonts.roboto(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: qbDetailLightColor),
                                textScaleFactor: 1.0,
                              ),
                              Text(
                                (parkingTiming != null)
                                    ? parkingTiming
                                    : "6 am to 7 am",
                                style: GoogleFonts.roboto(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: qbDetailDarkColor),
                                textScaleFactor: 1.0,
                              )
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),

                        //Parking Type
                        Container(
                          child: Row(
                            children: <Widget>[
                              //Parking
                              Text(
                                "Parking Type : ",
                                style: GoogleFonts.roboto(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: qbDetailLightColor),
                                textScaleFactor: 1.0,
                              ),

                              //Parking
                              Text(
                                (parkingTypeText != null)
                                    ? parkingTypeText
                                    : "Inside",
                                style: GoogleFonts.roboto(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: qbDetailDarkColor),
                                textScaleFactor: 1.0,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 5,
                        ),

                        //Park Here
                        Container(
                          child: EdgeLessButton(
                            color: qbAppPrimaryGreenColor,
                            padding: EdgeInsets.fromLTRB(30, 7.5, 27.5, 7.5),
                            child: IntrinsicWidth(
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "Park Here",
                                    style: GoogleFonts.nunito(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                    textScaleFactor: 1.0,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 1.5),
                                    child: Icon(
                                      FontAwesomeIcons.car,
                                      size: 15,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            onPressed: () {
                              if (widget.onParkHerePressed != null) {
                                widget.onParkHerePressed(widget.slotData.id);
                              }
                            },
                          ),
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
    );
  }
}
