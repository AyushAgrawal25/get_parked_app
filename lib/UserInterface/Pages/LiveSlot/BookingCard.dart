import 'package:flutter/material.dart';
import 'package:getparked/StateManagement/Models/ParkingRequestData.dart';
import 'package:getparked/StateManagement/Models/UserDetails.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/DisplayPicture.dart';
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
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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

                // Name And Kind Of Status
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Name
                        Container(
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
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
