import 'package:getparked/StateManagement/Models/NotificationData.dart';
import 'package:getparked/StateManagement/Models/UserData.dart';
import 'package:getparked/StateManagement/Models/UserDetails.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/DisplayPicture.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:getparked/UserInterface/Widgets/CustomIcon.dart';
import 'package:getparked/UserInterface/Icons/g_p_icons_icons.dart';

class NotificationSenderDetails extends StatefulWidget {
  final String name;
  final notificationId;
  final String imgUrl;
  final NotificationDataType notificationType;
  final UserAccountType senderType;
  final Function onDeletePressed;
  final UserGender userGender;

  NotificationSenderDetails(
      {@required this.name,
      @required this.notificationId,
      @required this.imgUrl,
      @required this.notificationType,
      @required this.senderType,
      @required this.onDeletePressed,
      @required this.userGender});
  @override
  _NotificationSenderDetailsState createState() =>
      _NotificationSenderDetailsState();
}

class _NotificationSenderDetailsState extends State<NotificationSenderDetails> {
  Widget senderIconOrImage = Container();
  String titleText = "";
  @override
  Widget build(BuildContext context) {
    // Display Picture Type
    DisplayPictureType displayPictureType;
    if (widget.senderType == UserAccountType.user) {
      if (widget.userGender == UserGender.female) {
        displayPictureType = DisplayPictureType.profilePictureFemale;
      } else {
        displayPictureType = DisplayPictureType.profilePictureMale;
      }
    } else {
      displayPictureType = DisplayPictureType.slotMainImage;
    }

    // Deciding Icon
    switch (widget.notificationType) {
      case NotificationDataType.booking_ForSlot:
      case NotificationDataType.booking_ForUser:
      case NotificationDataType.bookingCancellation_ForSlot:
      case NotificationDataType.bookingCancellation_ForUser:

      case NotificationDataType.parking_ForSlot:
      case NotificationDataType.parking_ForUser:
      case NotificationDataType.parkingWithdraw_ForSlot:
      case NotificationDataType.parkingWithdraw_ForUser:

      case NotificationDataType.transactionRequest:
      case NotificationDataType.transactionRequestResponse:

      case NotificationDataType.parkingRequest:
      case NotificationDataType.parkingRequestResponse:
        {
          if (widget.senderType == UserAccountType.admin) {
            senderIconOrImage = Container(
              height: 40,
              width: 40,
              child: Icon(
                FontAwesome.mobile,
                size: 35,
                color: qbAppTextColor,
              ),
            );
          } else {
            senderIconOrImage = Container(
              child: DisplayPicture(
                imgUrl: widget.imgUrl,
                height: 40,
                width: 40,
                isEditable: false,
                isDeletable: false,
                type: displayPictureType,
              ),
            );
          }
          break;
        }
      case NotificationDataType.transaction:
        {
          if (widget.senderType == UserAccountType.admin) {
            senderIconOrImage = Container(
              height: 40,
              width: 40,
              child: Icon(
                FontAwesome.magnet,
                size: 35,
                color: qbAppTextColor,
              ),
            );
          } else {
            senderIconOrImage = Container(
              height: 40,
              width: 40,
              child: Container(
                child: CustomIcon(
                  icon: GPIcons.wallet,
                  size: 27.5,
                  color: qbAppTextColor,
                ),
              ),
            );
          }
          break;
        }
    }
    // Deciding Status
    switch (widget.notificationType) {
      case NotificationDataType.booking_ForSlot:
      case NotificationDataType.booking_ForUser:
      case NotificationDataType.bookingCancellation_ForUser:
      case NotificationDataType.bookingCancellation_ForSlot:
        {
          titleText = "Booking";
          break;
        }
      case NotificationDataType.parking_ForSlot:
      case NotificationDataType.parking_ForUser:
      case NotificationDataType.parkingWithdraw_ForSlot:
      case NotificationDataType.parkingWithdraw_ForUser:
        {
          titleText = "Parking";
          break;
        }
      case NotificationDataType.transactionRequest:
      case NotificationDataType.transactionRequestResponse:
        {
          titleText = "Transaction Request";
          break;
        }
      case NotificationDataType.parkingRequest:
      case NotificationDataType.parkingRequestResponse:
        {
          titleText = "Parking Request";
          break;
        }
      case NotificationDataType.transaction:
        {
          titleText = "Transaction";
          break;
        }
    }
    return Container(
      child: Row(
        children: [
          // Image
          Container(
            child: senderIconOrImage,
          ),

          // Name And Status
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 4, bottom: 4, left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      titleText,
                      style: GoogleFonts.yantramanav(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w500,
                          color: qbDetailLightColor),
                      textScaleFactor: 1.0,
                    ),
                  ),
                  SizedBox(
                    height: 2.5,
                  ),
                  Container(
                    child: Text(
                      (widget.name != null) ? widget.name : "Dummy Name",
                      style: GoogleFonts.yantramanav(
                          fontSize: 15.5,
                          fontWeight: FontWeight.w500,
                          color: qbDetailDarkColor),
                      textAlign: TextAlign.start,
                      textScaleFactor: 1.0,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Delete Option if Required
          Container(
            height: 0,
            width: 0,
          )
        ],
      ),
    );
  }
}
