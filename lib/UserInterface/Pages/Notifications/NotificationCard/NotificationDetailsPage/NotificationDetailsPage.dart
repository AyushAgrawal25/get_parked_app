import 'package:getparked/StateManagement/Models/AppState.dart';
// import 'package:getparked/UserInterface/Widgets/TransactionRequestPage/TransactionRequestPage.dart';
import 'package:flutter/material.dart';
import 'package:getparked/StateManagement/Models/NotificationData.dart';
import 'package:getparked/StateManagement/Models/ParkingData.dart';
import 'package:getparked/StateManagement/Models/ParkingRequestData.dart';
import 'package:getparked/StateManagement/Models/BookingData.dart';
import 'package:getparked/StateManagement/Models/TransactionData.dart';
import 'package:getparked/StateManagement/Models/TransactionRequestData.dart';
import 'package:getparked/StateManagement/Models/UserData.dart';
import 'package:getparked/UserInterface/Widgets/ParkingDetailsPage/ParkingDetailsPage.dart';
import 'package:getparked/UserInterface/Widgets/ParkingCard/ParkingCard.dart';
import 'package:getparked/UserInterface/Widgets/TransactionDetailsPage/TransactionDetailsPage.dart';
import 'package:provider/provider.dart';

class NotificationDetailsPage extends StatefulWidget {
  NotificationData notificationData;

  NotificationDetailsPage({@required this.notificationData});
  @override
  _NotificationDetailsPageState createState() =>
      _NotificationDetailsPageState();
}

class _NotificationDetailsPageState extends State<NotificationDetailsPage> {
  NotificationData notificationData;

  setNotificationData() {
    AppState gpAppStateListen = Provider.of<AppState>(context);
    for (int i = 0; i < gpAppStateListen.notifications.length; i++) {
      if (widget.notificationData.id == gpAppStateListen.notifications[i].id) {
        notificationData = gpAppStateListen.notifications[i];
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    AppState gpAppStateListen = Provider.of<AppState>(context);
    setNotificationData();

    Widget notificationDetailsWidget = Container(
      color: Colors.white,
      child: Text("No Noti"),
    );
    switch (notificationData.notificationType) {
      case NotificationDataType.parkingRequest:
      case NotificationDataType.parkingRequestResponse:
        {
          ParkingRequestData parkingRequestData =
              notificationData.parkingRequestData;
          parkingRequestData.slotData = notificationData.senderSlotData;
          parkingRequestData.slotData.userDetails =
              notificationData.senderUserDetails;
          parkingRequestData.userDetails = notificationData.senderUserDetails;

          // Parking Request
          notificationDetailsWidget = ParkingDetailsPage(
            notificationType: notificationData.notificationType,
            parkingRequest: parkingRequestData,
            accType: (notificationData.senderType == UserAccountType.user)
                ? ParkingDetailsAccType.slot
                : ParkingDetailsAccType.user,
          );
          break;
        }
      case NotificationDataType.booking_ForSlot:
      case NotificationDataType.booking_ForUser:
      case NotificationDataType.bookingCancellation_ForSlot:
      case NotificationDataType.bookingCancellation_ForUser:
        {
          BookingData bookingData = notificationData.bookingData;
          bookingData.slotData = notificationData.senderSlotData;
          bookingData.slotData.userDetails = notificationData.senderUserDetails;
          bookingData.userDetails = notificationData.senderUserDetails;

          // Booking
          notificationDetailsWidget = ParkingDetailsPage(
            notificationType: notificationData.notificationType,
            booking: bookingData,
            accType: (notificationData.senderType == UserAccountType.user)
                ? ParkingDetailsAccType.slot
                : ParkingDetailsAccType.user,
          );
          break;
        }
      case NotificationDataType.parking_ForSlot:
      case NotificationDataType.parking_ForUser:
      case NotificationDataType.parkingWithdraw_ForSlot:
      case NotificationDataType.parkingWithdraw_ForUser:
        {
          ParkingData parkingData = notificationData.parkingData;
          parkingData.slotData = notificationData.senderSlotData;
          parkingData.slotData.userDetails = notificationData.senderUserDetails;
          parkingData.userDetails = notificationData.senderUserDetails;

          BookingData bookingData = parkingData.bookingData;
          bookingData.parkingData = parkingData;

          // Parking
          notificationDetailsWidget = ParkingDetailsPage(
            notificationType: notificationData.notificationType,
            parking: parkingData,
            booking: bookingData,
            accType: (notificationData.senderType == UserAccountType.user)
                ? ParkingDetailsAccType.slot
                : ParkingDetailsAccType.user,
          );
          break;
        }
      case NotificationDataType.transaction:
        {
          if (notificationData.transactionData.id == null) {
            notificationData = widget.notificationData;
          }
          TransactionData transactionData = notificationData.transactionData;
          transactionData.withSlotData = notificationData.senderSlotData;
          transactionData.withSlotData.userDetails =
              notificationData.senderUserDetails;
          transactionData.withUserDetails = notificationData.senderUserDetails;

          notificationDetailsWidget = TransactionDetailsPage(
            transactionData: transactionData,
          );
          break;
        }
      case NotificationDataType.transactionRequest:
      case NotificationDataType.transactionRequestResponse:
        {
          TransactionRequestData transactionRequestData =
              notificationData.transactionRequestData;
          // From User Details And Slot Data
          if (transactionRequestData.fromUserId ==
              notificationData.senderUserId) {
            // From is Sender
            // User Details
            transactionRequestData.fromUserDetails =
                notificationData.senderUserDetails;
            // Slot Data
            if (notificationData.senderSlotData != null) {
              transactionRequestData.fromSlotData =
                  widget.notificationData.senderSlotData;
              transactionRequestData.fromSlotData.userDetails =
                  transactionRequestData.fromUserDetails;
            }
          } else if (transactionRequestData.fromUserId ==
              gpAppStateListen.userData.id) {
            // From is You
            // User Details
            transactionRequestData.fromUserDetails =
                gpAppStateListen.userDetails;
            // Slot Data
            if (gpAppStateListen.parkingLordData != null) {
              transactionRequestData.fromSlotData =
                  gpAppStateListen.parkingLordData.toSlotData();
              transactionRequestData.fromSlotData.userDetails =
                  transactionRequestData.fromUserDetails;
            }
          }

          // With User Details
          if (transactionRequestData.withUserId ==
              notificationData.senderUserId) {
            // With is Sender
            // User Details
            transactionRequestData.withUserDetails =
                notificationData.senderUserDetails;
            // Slot Data
            if (notificationData.senderSlotData != null) {
              transactionRequestData.withSlotData =
                  notificationData.senderSlotData;
              transactionRequestData.withSlotData.userDetails =
                  transactionRequestData.withUserDetails;
            }
          } else if (transactionRequestData.withUserId ==
              gpAppStateListen.userData.id) {
            // With is You
            // User Details
            transactionRequestData.withUserDetails =
                gpAppStateListen.userDetails;
            // Slot Data
            if (gpAppStateListen.parkingLordData != null) {
              transactionRequestData.withSlotData =
                  gpAppStateListen.parkingLordData.toSlotData();
              transactionRequestData.withSlotData.userDetails =
                  transactionRequestData.withUserDetails;
            }
          }

          print("\nTransaction Page required...");
          // TODO: create this page
          // notificationDetailsWidget = TransactionRequestPage(
          //   transactionRequestData: transactionRequestData,
          // );
          break;
        }
    }

    return notificationDetailsWidget;
  }
}
