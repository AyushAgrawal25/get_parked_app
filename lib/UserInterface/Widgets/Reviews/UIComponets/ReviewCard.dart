import 'package:getparked/Utils/DateTimeUtils.dart';
import 'package:getparked/BussinessLogic/domainDetails.dart';
import 'package:getparked/StateManagement/Models/ReviewData.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/DisplayPicture.dart';
import 'package:getparked/UserInterface/Widgets/Rating/RatingWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:getparked/StateManagement/Models/UserDetails.dart';

class ReviewCard extends StatelessWidget {
  final ReviewData reviewData;
  ReviewCard({@required this.reviewData});
  @override
  Widget build(BuildContext context) {
    double profSize = 40;
    String date = DateTimeUtils.dateForDisplayRelative(this.reviewData.time);
    String time = DateTimeUtils.timeForDisplayRelative(this.reviewData.time);
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Pic
                Container(
                  child: DisplayPicture(
                    imgUrl: formatImgUrl(
                        this.reviewData.userDetails.profilePicThumbnailUrl),
                    isEditable: false,
                    type: (this.reviewData.userDetails.getGenderType() ==
                            UserGender.female)
                        ? DisplayPictureType.profilePictureFemale
                        : DisplayPictureType.profilePictureMale,
                    height: profSize,
                    width: profSize,
                    isElevated: true,
                  ),
                ),

                SizedBox(
                  width: 15,
                ),

                // Data
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Name And Rating
                      Container(
                        alignment: Alignment.center,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Name
                            Expanded(
                              child: Container(
                                height: profSize,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  this.reviewData.userDetails.firstName.trim() +
                                      " " +
                                      this
                                          .reviewData
                                          .userDetails
                                          .lastName
                                          .trim(),
                                  style: GoogleFonts.yantramanav(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.5,
                                      color: qbDetailDarkColor),
                                  textAlign: TextAlign.start,
                                  textScaleFactor: 1,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),

                            // Rating
                            Container(
                              height: profSize,
                              child: RatingWidget(
                                ratingValue: this.reviewData.rating.toDouble(),
                                toShowRatingText: false,
                                iconSize: 15,
                              ),
                            )
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 5,
                      ),

                      // Review Text
                      Container(
                        padding: EdgeInsets.only(right: 20),
                        child: Text(
                          this.reviewData.text,
                          style: GoogleFonts.roboto(
                            fontSize: 13.5,
                            color: qbAppTextColor,
                          ),
                          textScaleFactor: 1.0,
                          textAlign: TextAlign.start,
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),

                      // Time
                      Container(
                        alignment: Alignment.centerRight,
                        child: Container(
                          child: Text(
                            time + date,
                            style: GoogleFonts.roboto(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w400,
                                color: qbDetailLightColor),
                            textScaleFactor: 1.0,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Divider
          Divider(
            height: 20,
            thickness: 1.5,
            color: qbDividerLightColor,
          )
        ],
      ),
    );
  }
}
