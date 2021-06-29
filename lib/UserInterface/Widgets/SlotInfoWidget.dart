import 'package:getparked/Utils/ContactUtils.dart';
import 'package:getparked/Utils/DomainUtils.dart';
import 'package:getparked/StateManagement/Models/SlotData.dart';
import 'package:getparked/StateManagement/Models/UserDetails.dart';
import 'package:getparked/UserInterface/Widgets/Reviews/ReviewButton.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/DisplayPicture.dart';
import 'package:getparked/UserInterface/Widgets/MoreDetailsAcc.dart';
import 'package:getparked/UserInterface/Widgets/Rating/RatingWidget.dart';
import 'package:getparked/UserInterface/Widgets/SlotNameWidget.dart';
import 'package:getparked/UserInterface/Widgets/qbFAB.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class SlotInfoWidget extends StatefulWidget {
  final SlotData slotData;
  final bool callingOption;
  final SlotInfoWidgetType type;

  SlotInfoWidget(
      {@required this.slotData,
      this.type: SlotInfoWidgetType.large,
      this.callingOption: false});
  @override
  _SlotInfoWidgetState createState() => _SlotInfoWidgetState();
}

class _SlotInfoWidgetState extends State<SlotInfoWidget> {
  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case SlotInfoWidgetType.large:
        return Container(
          child: Column(
            children: [
              // Main Slot Image
              Container(
                child: DisplayPicture(
                  imgUrl: formatImgUrl(widget.slotData.mainImageUrl),
                  height: MediaQuery.of(context).size.width * 0.55,
                  width: MediaQuery.of(context).size.width,
                  isEditable: false,
                ),
              ),

              // Details
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 7.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Slot Name
                    Container(
                      child: SlotNameWidget(slotName: widget.slotData.name),
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    // Slot User Details
                    Container(
                      child: Row(
                        children: [
                          // Profile Pic
                          Container(
                            child: DisplayPicture(
                                imgUrl: formatImgUrl(
                                    widget.slotData.userDetails.profilePicUrl),
                                isEditable: false,
                                height: 45,
                                width: 45,
                                type: (UserDetailsUtils.setGenderTypeFromString(
                                            widget
                                                .slotData.userDetails.gender) ==
                                        UserGender.female)
                                    ? DisplayPictureType.profilePictureFemale
                                    : DisplayPictureType.profilePictureMale),
                          ),

                          SizedBox(
                            width: 10,
                          ),

                          // Name And Rating
                          Expanded(
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Name
                                  Container(
                                    child: Text(
                                      widget.slotData.userDetails.firstName
                                              .trim() +
                                          " " +
                                          widget.slotData.userDetails.lastName,
                                      style: GoogleFonts.yantramanav(
                                          fontSize: 17.5,
                                          fontWeight: FontWeight.w500,
                                          color: qbAppTextColor),
                                      textScaleFactor: 1.0,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),

                                  SizedBox(
                                    height: 2.5,
                                  ),

                                  // Rating
                                  Container(
                                    child: RatingWidget(
                                        ratingValue: widget.slotData.rating,
                                        fontSize: 12.5,
                                        iconSize: 13),
                                  )
                                ],
                              ),
                            ),
                          ),

                          // Reviews
                          (widget.callingOption)
                              ? FlatButton(
                                  onPressed: () {
                                    ContactUtils().makeCall(
                                        widget.slotData.userDetails.dialCode +
                                            widget.slotData.userDetails
                                                .phoneNumber);
                                  },
                                  child: Container(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          child: Icon(
                                            FontAwesome5.phone,
                                            color: qbAppPrimaryGreenColor,
                                            size: 15,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(top: 5),
                                          child: Text(
                                            "Call",
                                            style: GoogleFonts.nunito(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: qbAppPrimaryGreenColor),
                                            textScaleFactor: 1.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : ReviewButton(slotId: widget.slotData.id)
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // More Details
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: MoreDetailsAcc(
                    address: widget.slotData.address,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    city: widget.slotData.city,
                    state: widget.slotData.state,
                    landmark: widget.slotData.landmark),
              ),
            ],
          ),
        );

      case SlotInfoWidgetType.small:
        double slotImgWidth = MediaQuery.of(context).size.width / 1.35;
        double slotImgHeight = slotImgWidth / 1.5;
        double profPicSize = 55;
        double profPicPadding = 10;
        return Container(
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              // // BG
              Positioned.fill(
                child: Container(
                  child: Column(
                    children: [
                      // White Color
                      Expanded(
                          child: Container(
                        color: qbWhiteBGColor,
                      )),

                      // Grey Color
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(),
                      )),
                      Divider(
                        thickness: 1,
                        color: Color.fromRGBO(240, 240, 240, 1),
                        height: 1.5,
                      ),

                      Container(
                        height: profPicSize * 1.5 + profPicPadding,
                        width: MediaQuery.of(context).size.width,
                        color: qbWhiteBGColor,
                      )
                    ],
                  ),
                ),
              ),

              // Front
              Container(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Name
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: SlotNameWidget(
                        slotName: widget.slotData.name,
                        fontSize: 21,
                      ),
                    ),

                    SizedBox(height: 5),

                    Container(
                      padding: EdgeInsets.symmetric(vertical: profPicPadding),
                      child: DisplayPicture(
                        imgUrl: formatImgUrl(widget.slotData.mainImageUrl),
                        isEditable: false,
                        isElevated: true,
                        width: slotImgWidth,
                        height: slotImgHeight,
                        borderRadius: BorderRadius.circular(7.5),
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.symmetric(vertical: profPicPadding),
                      child: DisplayPicture(
                        imgUrl: formatImgUrl(
                            widget.slotData.userDetails.profilePicThumbnailUrl),
                        isEditable: false,
                        isElevated: true,
                        type: (widget.slotData.userDetails.getGenderType() ==
                                UserGender.female)
                            ? DisplayPictureType.profilePictureFemale
                            : DisplayPictureType.profilePictureMale,
                        height: profPicSize,
                        width: profPicSize,
                      ),
                    ),

                    // Slot User Info
                    Container(
                      height: 55,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Text(
                              "owner",
                              style: GoogleFonts.nunito(
                                  color: qbDividerLightColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                              textScaleFactor: 1.0,
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 25),
                              child: SlotNameWidget(
                                  fontSize: 18.5,
                                  slotName: widget
                                          .slotData.userDetails.firstName
                                          .trim() +
                                      " " +
                                      widget.slotData.userDetails.lastName
                                          .trim()))
                        ],
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
}

enum SlotInfoWidgetType { large, small }
