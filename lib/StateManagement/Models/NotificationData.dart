import 'package:getparked/StateManagement/Models/BookingData.dart';
import 'package:getparked/StateManagement/Models/ParkingData.dart';
import 'package:getparked/StateManagement/Models/ParkingRequestData.dart';
import 'package:getparked/StateManagement/Models/TransactionData.dart';
import 'package:getparked/StateManagement/Models/TransactionRequestData.dart';

import 'UserDetails.dart';
import 'SlotData.dart';

class NotificationData {
  int id;

  // notificationTypeMasterId and notificationRefId
  int type;
  int refId;
  NotificationDataType notificationType;

  // notificationSenderUserId and notificationSenderType
  int senderUserId;
  int senderType;

  // Slot Data
  SlotData senderSlotData;

  // User Data
  UserDetails senderUserDetails;

  // notificationRecieverType
  int recieverType;

  // Parking Request
  ParkingRequestData parkingRequestData;

  // Booking Data
  BookingData bookingData;

  // Parking Data
  ParkingData parkingData;

  // Real Transaction Data
  TransactionData transactionData;

  // Transaction Request Data
  TransactionRequestData transactionRequestData;

  String time;
  int status;

  NotificationData(
      {this.id,
      this.type,
      this.refId,
      this.senderUserId,
      this.senderType,
      this.senderUserDetails,
      this.senderSlotData,
      this.recieverType,
      this.parkingRequestData,
      this.bookingData,
      this.parkingData,
      this.transactionData,
      this.transactionRequestData,
      this.time,
      this.status});

  NotificationData.fromMap(Map notificationMap) {
    id = notificationMap["notificationId"];
    type = notificationMap["notificationTypeMasterId"];
    refId = notificationMap["notificationRefId"];

    // Sender Data
    senderUserId = notificationMap["notificationSenderUserId"];
    senderType = notificationMap["notificationSenderType"];

    // Sender User Details
    Map senderUserDetailsMap;
    if (notificationMap["senderUserData"] != null) {
      senderUserDetailsMap = notificationMap["senderUserData"];
    } else if (notificationMap["senderUserDetails"] != null) {
      senderUserDetailsMap = notificationMap["senderUserDetails"];
    }

    if (senderUserDetailsMap != null) {
      senderUserDetails = UserDetails.fromMap(senderUserDetailsMap);
    }

    // Sender Slot Data
    if (notificationMap["senderSlotData"] != null) {
      Map senderSlotDataMap = notificationMap["senderSlotData"];
      senderSlotData = SlotDataUtils.mapToSlotData(senderSlotDataMap);
    }

    recieverType = notificationMap["notificationRecieverType"];

    switch (type) {
      // Parking Requests
      case 1:
        {
          if (notificationMap["slotParkingRequest"] != null) {
            parkingRequestData = ParkingRequestData.fromMap(
                notificationMap["slotParkingRequest"]);
          } else if (notificationMap["parkingRequest"] != null) {
            parkingRequestData =
                ParkingRequestData.fromMap(notificationMap["parkingRequest"]);
          }
          notificationType = NotificationDataType.parkingRequest;
          break;
        }

      // Bookings
      case 2:
        {
          if (notificationMap["slotBooking"] != null) {
            bookingData = BookingData.fromMap(notificationMap["slotBooking"]);
          } else if (notificationMap["booking"] != null) {
            bookingData = BookingData.fromMap(notificationMap["booking"]);
          }
          notificationType = NotificationDataType.booking;
          break;
        }

      // Transactions Real
      case 3:
        {
          if (notificationMap["realTransaction"] != null) {
            transactionData =
                TransactionData.fromMap(notificationMap["realTransaction"]);
          }
          notificationType = NotificationDataType.transaction;
          break;
        }

      // Transaction Requests
      case 4:
        {
          if (notificationMap["transactionRequest"] != null) {
            transactionRequestData = TransactionRequestData.fromMap(
                notificationMap["transactionRequest"]);
          }
          notificationType = NotificationDataType.transactionRequest;
          break;
        }

      // Parking
      case 5:
        {
          if (notificationMap["slotParking"] != null) {
            parkingData = ParkingData.fromMap(notificationMap["slotParking"]);
          } else if (notificationMap["parking"] != null) {
            parkingData = ParkingData.fromMap(notificationMap["parking"]);
          }
          notificationType = NotificationDataType.parking;
          break;
        }
    }

    time = notificationMap["notificationTime"];
    status = notificationMap["notificationStatus"];
  }
}

enum NotificationDataType {
  parkingRequest,
  booking,
  transaction,
  transactionRequest,
  parking
}
