import 'package:flutter/material.dart';
import 'package:getparked/StateManagement/Models/ParkingRatingReviewData.dart';
import 'package:getparked/StateManagement/Models/SlotData.dart';
import 'package:getparked/StateManagement/Models/VehicleData.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/EdgeLessButton.dart';
import 'package:getparked/UserInterface/Widgets/ParkingCard/ParkingCard.dart';
import 'package:getparked/UserInterface/Widgets/Rating/RatingWidget.dart';
import 'package:getparked/UserInterface/Widgets/Reviews/YourExperience/YourExperiencePage.dart';
import 'package:google_fonts/google_fonts.dart';

class RatingReviewWidget extends StatefulWidget {
  final ParkingRatingReviewData ratingReviewData;
  final SlotData slotData;
  final VehicleType vehicleType;
  final int parkingId;
  final ParkingDetailsAccType accType;
  // final AccT
  RatingReviewWidget(
      {this.ratingReviewData,
      @required this.parkingId,
      @required this.accType,
      @required this.slotData,
      @required this.vehicleType});
  @override
  _RatingReviewWidgetState createState() => _RatingReviewWidgetState();
}

class _RatingReviewWidgetState extends State<RatingReviewWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.ratingReviewData != null) {
      return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 25),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.5),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 0.025,
                  blurRadius: 5,
                  offset: Offset(10, 5),
                  color: Color.fromRGBO(0, 0, 0, 0.04)),
            ],
            color: qbWhiteBGColor),
        padding: EdgeInsets.only(left: 20, top: 15, right: 20, bottom: 10),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title
              Container(
                child: Text(
                  (widget.accType == ParkingDetailsAccType.slot)
                      ? "User opinion"
                      : "Your opinion",
                  style: GoogleFonts.nunito(
                      color: qbDetailLightColor,
                      fontSize: 17.5,
                      fontWeight: FontWeight.w500),
                  textScaleFactor: 1.0,
                ),
              ),

              SizedBox(
                height: 15,
              ),

              Container(
                alignment: Alignment.center,
                child: RatingWidget(
                  ratingValue: widget.ratingReviewData.ratingValue.toDouble(),
                  iconSize: 25,
                  fontSize: 25,
                  toShowRatingText: false,
                ),
              ),

              (widget.ratingReviewData.review != null)
                  ? Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        (widget.accType == ParkingDetailsAccType.slot)
                            ? "User review"
                            : "Your review",
                        style: GoogleFonts.nunito(
                            color: qbDetailLightColor,
                            fontSize: 13.5,
                            fontWeight: FontWeight.w500),
                        textScaleFactor: 1.0,
                      ),
                    )
                  : Container(
                      height: 12.5,
                    ),

              (widget.ratingReviewData.review != null)
                  ? Container(
                      padding: EdgeInsets.only(bottom: 15, top: 5),
                      child: Text(
                        widget.ratingReviewData.review,
                        style: GoogleFonts.roboto(
                            color: qbDetailDarkColor,
                            fontSize: 13.5,
                            fontWeight: FontWeight.w400),
                        textScaleFactor: 1.0,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      );
    }

    if (widget.accType == ParkingDetailsAccType.slot) {
      return Container();
    }

    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 25),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      decoration: BoxDecoration(
          border: Border.all(
            width: 1.5,
            color: qbDividerLightColor,
          ),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          SizedBox(
            height: 12.5,
          ),

          // Title
          Container(
            child: Text(
              "Your opinion matters",
              style: GoogleFonts.nunito(
                  color: qbDetailLightColor,
                  fontSize: 17.5,
                  fontWeight: FontWeight.w500),
              textScaleFactor: 1.0,
            ),
          ),

          SizedBox(
            height: 5,
          ),

          // Button
          Container(
            child: EdgeLessButton(
              color: qbAppPrimaryThemeColor,
              child: Container(
                height: 35,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Text(
                  "Rate the slot",
                  style: GoogleFonts.nunito(
                      color: qbWhiteBGColor,
                      fontSize: 17.5,
                      fontWeight: FontWeight.w500),
                  textScaleFactor: 1.0,
                ),
              ),
              onPressed: onRateSlotPressed,
            ),
          ),
        ],
      ),
    );
  }

  onRateSlotPressed() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return YourExperiencePage(
          slotData: widget.slotData,
          vehicleType: widget.vehicleType,
          parkingId: widget.parkingId);
    }));
  }
}
