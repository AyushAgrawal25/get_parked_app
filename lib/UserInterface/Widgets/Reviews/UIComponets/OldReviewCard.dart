import 'package:getparked/Utils/DateTimeUtils.dart';
import 'package:getparked/BussinessLogic/domainDetails.dart';
import 'package:getparked/StateManagement/Models/ReviewData.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/DisplayPicture.dart';
import 'package:getparked/UserInterface/Widgets/Rating/RatingWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewCard extends StatelessWidget {
  ReviewData reviewData;

  ReviewCard({@required this.reviewData});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Upper Row
          Container(
              child: Row(
            children: [
              // User Profile Picture
              Container(
                child: DisplayPicture(
                  imgUrl: formatImgUrl(
                      this.reviewData.userDetails.profilePicThumbnailUrl),
                  height: 40,
                  width: 40,
                  type: DisplayPictureType.profilePictureMale,
                  isEditable: false,
                ),
              ),

              SizedBox(
                width: 12.5,
              ),

              // User Name
              Column(
                children: [
                  Container(
                    child: Text(
                      this.reviewData.userDetails.firstName.trim() +
                          " " +
                          this.reviewData.userDetails.lastName,
                      style: GoogleFonts.yantramanav(
                          fontSize: 17.5,
                          fontWeight: FontWeight.w500,
                          color: qbAppTextColor),
                      textScaleFactor: 1.0,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  RatingWidget(
                      ratingValue: this.reviewData.rating.toDouble(),
                      fontSize: 11,
                      iconSize: 12)
                ],
              )
            ],
          )),

          SizedBox(
            height: 10,
          ),

          // Review Text
          Container(
            child: Text(
              this.reviewData.text,
              style:
                  GoogleFonts.roboto(fontSize: 15, color: qbDetailLightColor),
              textAlign: TextAlign.start,
              textScaleFactor: 1.0,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          SizedBox(
            height: 10,
          ),

          // Date Row
          Container(
            child: Text(
              DateTimeUtils.dateIn12MonthsFormat(this.reviewData.time),
              style: GoogleFonts.roboto(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w500,
                  color: qbAppTextColor),
              textScaleFactor: 1.0,
            ),
          ),

          // Divider
          Divider(
            height: 30,
            thickness: 1,
            color: qbAppTextColor,
          )
        ],
      ),
    );
  }
}
