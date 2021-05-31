import 'package:getparked/Utils/DomainUtils.dart';
import 'package:getparked/StateManagement/Models/ParkingRequestData.dart';
import 'package:getparked/StateManagement/Models/UserDetails.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/DisplayPicture.dart';
import 'package:getparked/UserInterface/Widgets/ParkingCard/ParkingCardStatusAndTime.dart';
import 'package:getparked/UserInterface/Widgets/ParkingCard/ParkingCardSubtitle.dart';
import 'package:getparked/UserInterface/Widgets/ParkingCard/ParkingCardTimeAndTransaction.dart';
// import 'package:getparked/UserInterface/Widgets/ParkingDetailsPage/ParkingDetailsPage.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class ParkingCard extends StatefulWidget {
  ParkingRequestData parkingRequestData;
  ParkingDetailsAccType type;
  ParkingCard({@required this.parkingRequestData, @required this.type});
  @override
  _ParkingCardState createState() => _ParkingCardState();
}

class _ParkingCardState extends State<ParkingCard> {
  double senderImgSize = 40;
  @override
  Widget build(BuildContext context) {
    String displayName;
    String displayImgUrl;
    DisplayPictureType pictureType;
    switch (widget.type) {
      case ParkingDetailsAccType.slot:
        displayName = widget.parkingRequestData.userDetails.firstName.trim() +
            " " +
            widget.parkingRequestData.userDetails.lastName;

        displayImgUrl = formatImgUrl(
            widget.parkingRequestData.userDetails.profilePicThumbnailUrl);

        if (widget.parkingRequestData.userDetails.getGenderType() ==
            UserGender.female) {
          pictureType = DisplayPictureType.profilePictureFemale;
        } else {
          pictureType = DisplayPictureType.profilePictureMale;
        }
        break;
      case ParkingDetailsAccType.user:
        displayName = widget.parkingRequestData.slotData.name;
        displayImgUrl =
            formatImgUrl(widget.parkingRequestData.slotData.thumbnailUrl);
        pictureType = DisplayPictureType.slotMainImage;
        break;
    }
    return GestureDetector(
      onTap: onParkingCardTap,
      child: Container(
        // // Old Deco
        // margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
        // decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(5),
        //     boxShadow: [
        //       BoxShadow(
        //           spreadRadius: 0.025,
        //           blurRadius: 5,
        //           offset: Offset(4, 4),
        //           color: Color.fromRGBO(0, 0, 0, 0.04)),
        //     ],
        //     color: Color.fromRGBO(255, 255, 255, 1),
        //     border: Border.all(
        //       width: 2,
        //       color: Color.fromRGBO(238, 238, 238, 1),
        //     )),
        // // Old Deco End

        // New Deco
        margin: EdgeInsets.symmetric(horizontal: 12.5, vertical: 5),
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
        // New Deco End
        child: Column(
          children: [
            // Upper Row Or Sender Details Row
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
                          // Sort Of Status
                          ParkingCardSubtitle(
                            dataType: widget.parkingRequestData
                                .getParkingRequestDataType(),
                          ),

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

                  // Money Transfer Type
                  if (widget.parkingRequestData.bookingData != null)
                    if (widget.parkingRequestData.bookingData.transactionData !=
                        null)
                      ParkingCardTimeAndTransaction(
                        dataType: widget.parkingRequestData
                            .getParkingRequestDataType(),
                        bookingData: widget.parkingRequestData.bookingData,
                      )
                    else
                      Container(
                        height: 0,
                        width: 0,
                      )
                  else
                    Container(
                      height: 0,
                      width: 0,
                    )
                ],
              ),
            ),

            SizedBox(
              height: 2.5,
            ),

            // Bottom Row Time Date Status
            ParkingCardStatusAndTime(
              parkingRequestData: widget.parkingRequestData,
            )
          ],
        ),
      ),
    );
  }

  onParkingCardTap() {
    // TODO: create the page and uncomment this.
    // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    //   return ParkingDetailsPage(
    //       parkingRequest: widget.parkingRequestData, accType: widget.type);
    // }));
  }
}

enum ParkingDetailsAccType { user, slot }
