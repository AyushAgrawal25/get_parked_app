import 'package:getparked/StateManagement/Models/TransactionData.dart';
import 'package:getparked/StateManagement/Models/UserData.dart';
import 'package:getparked/Utils/DomainUtils.dart';
import 'package:getparked/StateManagement/Models/NotificationData.dart';
import 'package:getparked/UserInterface/Pages/Notifications/NotificationCard/NotificationDetailsPage/NotificationDetailsPage.dart';
import 'package:getparked/UserInterface/Pages/Notifications/NotificationCard/NotificationStatusAndTime.dart';
import 'package:flutter/services.dart';
import 'NotificationSenderDetails.dart';
import 'package:flutter/material.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';

class NotificationCard extends StatefulWidget {
  NotificationData notificationData;

  NotificationCard({@required this.notificationData});
  @override
  _NotificationCardState createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  String name = "";
  String imgUrl = "";

  @override
  Widget build(BuildContext context) {
    // Deciding Name
    switch (widget.notificationData.notificationType) {
      case NotificationDataType.parking_ForSlot:
      case NotificationDataType.parking_ForUser:
      case NotificationDataType.parkingWithdraw_ForSlot:
      case NotificationDataType.parkingWithdraw_ForUser:

      case NotificationDataType.parkingRequest:
      case NotificationDataType.parkingRequestResponse:

      case NotificationDataType.transactionRequest:
      case NotificationDataType.transactionRequestResponse:

      case NotificationDataType.booking_ForSlot:
      case NotificationDataType.booking_ForUser:
      case NotificationDataType.bookingCancellation_ForSlot:
      case NotificationDataType.bookingCancellation_ForUser:
        {
          switch (widget.notificationData.senderType) {
            case UserAccountType.user:
              {
                // For User
                name = widget.notificationData.senderUserDetails.firstName
                        .trim() +
                    " " +
                    widget.notificationData.senderUserDetails.lastName.trim();
                imgUrl = formatImgUrl(widget
                    .notificationData.senderUserDetails.profilePicThumbnailUrl);
              }
              break;
            case UserAccountType.slot:
              {
                // For Lord
                name = widget.notificationData.senderSlotData.name;
                imgUrl = formatImgUrl(
                    widget.notificationData.senderSlotData.thumbnailUrl);
              }
              break;
            case UserAccountType.admin:
              {
                // For App
                name = appName;
                imgUrl = "";
              }
              break;
          }
          break;
        }
      case NotificationDataType.transaction:
        {
          // print(widget.notificationData.transactionData.data);

          name = "Your";
          if (widget.notificationData.transactionData.accountType ==
              UserAccountType.user) {
            name += " Wallet";
          } else if (widget.notificationData.transactionData.accountType ==UserAccountType.slot) {
            name += " Vault";
          } else if (widget.notificationData.transactionData.accountType == UserAccountType.admin) {
            name += " App";
          }

          switch (widget.notificationData.transactionData.status) {
            case 0:
              {
                name += " will be";
                if (widget.notificationData.transactionData.transferType ==
                    MoneyTransferType.add) {
                  name += " Credited with ₹";
                } else {
                  name += " Debited with ₹";
                }
                break;
              }
            case 1:
              {
                name += " is";
                if (widget.notificationData.transactionData.transferType ==
                    MoneyTransferType.add) {
                  name += " Credited with ₹";
                } else {
                  name += " Debited with ₹";
                }
                break;
              }
            case 2:
              {
                name += " is";
                name += " failed to";
                if (widget.notificationData.transactionData.transferType ==
                    MoneyTransferType.add) {
                  name += " Credit with ₹";
                } else {
                  name += " Debit with ₹";
                }
              }
          }
          name +=
              " ${widget.notificationData.transactionData.amount.toStringAsFixed(2)} /-";

          imgUrl = "";
        }
    }
    return GestureDetector(
      onTap: () {
        SystemSound.play(SystemSoundType.click);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return NotificationDetailsPage(
              notificationData: widget.notificationData,
            );
          },
        ));
      },
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
              NotificationSenderDetails(
                name: name,
                imgUrl: imgUrl,
                notificationId: widget.notificationData.id,
                onDeletePressed: () {},
                notificationType: widget.notificationData.notificationType,
                senderType: widget.notificationData.senderType,
                userGender:
                    widget.notificationData.senderUserDetails.getGenderType(),
              ),
              SizedBox(
                height: 10,
              ),
              NotificationStatusAndTime(
                notificationData: widget.notificationData,
              )
            ],
          )),
    );
  }
}
