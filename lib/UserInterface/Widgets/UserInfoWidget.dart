import 'package:getparked/Utils/ContactUtils.dart';
import 'package:getparked/BussinessLogic/domainDetails.dart';
import 'package:getparked/StateManagement/Models/UserDetails.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/DisplayPicture.dart';
import 'package:getparked/UserInterface/Widgets/SlotNameWidget.dart';
import 'package:getparked/UserInterface/Widgets/qbFAB.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserInfoWidget extends StatefulWidget {
  UserDetails userDetails;
  bool callingOption;
  UserInfoWidgetType type;
  UserInfoWidget(
      {@required this.userDetails,
      this.callingOption: false,
      this.type: UserInfoWidgetType.large});
  @override
  _UserInfoWidgetState createState() => _UserInfoWidgetState();
}

class _UserInfoWidgetState extends State<UserInfoWidget> {
  @override
  Widget build(BuildContext context) {
    String imgUrl = formatImgUrl(widget.userDetails.profilePicUrl);
    String name =
        widget.userDetails.firstName.trim() + " " + widget.userDetails.lastName;
    DisplayPictureType type;
    switch (widget.userDetails.getGenderType()) {
      case UserGender.female:
        type = DisplayPictureType.profilePictureFemale;
        break;
      default:
        type = DisplayPictureType.profilePictureMale;
        break;
    }
    switch (widget.type) {
      case UserInfoWidgetType.large:
        return Container(
          child: Column(
            children: [
              // Main Image
              SizedBox(
                height: 10,
              ),

              Container(
                child: DisplayPicture(
                    // imgUrl:
                    //     "https://scontent.frpr1-1.fna.fbcdn.net/v/t1.0-0/cp0/e15/q65/p320x320/84282892_286556069363233_2980560561357800034_o.jpg?_nc_cat=107&_nc_sid=110474&_nc_ohc=4E0wbXMTlQgAX9KJr3T&_nc_ht=scontent.frpr1-1.fna&tp=3&oh=dc59f4c95855ff730c638686c56db004&oe=5F9C694B",
                    imgUrl: imgUrl,
                    height: MediaQuery.of(context).size.width * 0.375,
                    width: MediaQuery.of(context).size.width * 0.375,
                    isDeletable: false,
                    isEditable: false,
                    type: type,
                    actionButton: (widget.callingOption)
                        ? Container(
                            child: QbFAB(
                              color: qbAppPrimaryGreenColor,
                              size: 45,
                              child: Container(
                                child: Icon(
                                  Icons.phone_rounded,
                                  color: Colors.white,
                                  size: 22.5,
                                ),
                              ),
                              onPressed: () {
                                ContactUtils().makeCall(
                                    widget.userDetails.dialCode +
                                        widget.userDetails.phoneNumber);
                              },
                            ),
                          )
                        : Container(
                            height: 0,
                            width: 0,
                          )),
              ),

              SizedBox(
                height: 10,
              ),

              // Name
              Container(
                child: SlotNameWidget(
                  slotName: name,
                  // slotName: "Anya Chalotra",
                ),
              )
            ],
          ),
        );

      case UserInfoWidgetType.small:
        return Container(
            child: Column(
          children: [
            // Main Image
            SizedBox(
              height: 10,
            ),

            Container(
              child: DisplayPicture(
                  // imgUrl:
                  //     "https://scontent.frpr1-1.fna.fbcdn.net/v/t1.0-0/cp0/e15/q65/p320x320/84282892_286556069363233_2980560561357800034_o.jpg?_nc_cat=107&_nc_sid=110474&_nc_ohc=4E0wbXMTlQgAX9KJr3T&_nc_ht=scontent.frpr1-1.fna&tp=3&oh=dc59f4c95855ff730c638686c56db004&oe=5F9C694B",
                  imgUrl: imgUrl,
                  height: MediaQuery.of(context).size.width * 0.325,
                  width: MediaQuery.of(context).size.width * 0.325,
                  isDeletable: false,
                  isEditable: false,
                  type: type,
                  actionButton: (widget.callingOption)
                      ? Container(
                          child: QbFAB(
                            color: qbAppPrimaryGreenColor,
                            size: 45,
                            child: Container(
                              child: Icon(
                                Icons.phone_rounded,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                            onPressed: () {
                              ContactUtils().makeCall(
                                  widget.userDetails.dialCode +
                                      widget.userDetails.phoneNumber);
                            },
                          ),
                        )
                      : Container(
                          height: 0,
                          width: 0,
                        )),
            ),

            SizedBox(
              height: 15,
            ),

            Container(
              child: Text(
                "user",
                style: GoogleFonts.nunito(
                    color: qbDividerDarkColor,
                    // color: qbDetailLightColor,
                    fontSize: 15,
                    height: 0.75,
                    fontWeight: FontWeight.w500),
                textScaleFactor: 1.0,
              ),
            ),

            // Name
            Container(
              child: SlotNameWidget(
                fontSize: 18.5,
                slotName: name,
                // slotName: "Anya Chalotra",
              ),
            )
          ],
        ));
    }
  }
}

enum UserInfoWidgetType { large, small }
