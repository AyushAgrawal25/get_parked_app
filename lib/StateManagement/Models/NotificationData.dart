import 'package:getparked/StateManagement/Models/BookingData.dart';
import 'package:getparked/StateManagement/Models/ParkingData.dart';
import 'package:getparked/StateManagement/Models/ParkingRequestData.dart';
import 'package:getparked/StateManagement/Models/TransactionData.dart';
import 'package:getparked/StateManagement/Models/TransactionRequestData.dart';
import 'package:getparked/StateManagement/Models/UserData.dart';

import 'UserDetails.dart';
import 'SlotData.dart';

class NotificationData {
  int id;

  // notificationTypeMasterId and notificationRefId
  NotificationDataType notificationType;

  // notificationSenderUserId and notificationSenderType
  int senderUserId;
  UserAccountType senderType;

  // Slot Data
  SlotData senderSlotData;

  // User Data
  UserDetails senderUserDetails;

  // notificationRecieverType
  UserAccountType recieverType;

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

  NotificationData.fromMap(Map notificationMap) {
    // id = notificationMap["notificationId"];
    // type = notificationMap["notificationTypeMasterId"];
    // refId = notificationMap["notificationRefId"];

    // // Sender Data
    // senderUserId = notificationMap["notificationSenderUserId"];
    // senderType = notificationMap["notificationSenderType"];

    // // Sender User Details
    // Map senderUserDetailsMap;
    // if (notificationMap["senderUserData"] != null) {
    //   senderUserDetailsMap = notificationMap["senderUserData"];
    // } else if (notificationMap["senderUserDetails"] != null) {
    //   senderUserDetailsMap = notificationMap["senderUserDetails"];
    // }

    // if (senderUserDetailsMap != null) {
    //   senderUserDetails = UserDetails.fromMap(senderUserDetailsMap);
    // }

    // // Sender Slot Data
    // if (notificationMap["senderSlotData"] != null) {
    //   Map senderSlotDataMap = notificationMap["senderSlotData"];
    //   senderSlotData = SlotDataUtils.mapToSlotData(senderSlotDataMap);
    // }

    // recieverType = notificationMap["notificationRecieverType"];

    // switch (type) {
    //   // Parking Requests
    //   case 1:
    //     {
    //       if (notificationMap["slotParkingRequest"] != null) {
    //         parkingRequestData = ParkingRequestData.fromMap(
    //             notificationMap["slotParkingRequest"]);
    //       } else if (notificationMap["parkingRequest"] != null) {
    //         parkingRequestData =
    //             ParkingRequestData.fromMap(notificationMap["parkingRequest"]);
    //       }
    //       notificationType = NotificationDataType.parkingRequest;
    //       break;
    //     }

    //   // Bookings
    //   case 2:
    //     {
    //       if (notificationMap["slotBooking"] != null) {
    //         bookingData = BookingData.fromMap(notificationMap["slotBooking"]);
    //       } else if (notificationMap["booking"] != null) {
    //         bookingData = BookingData.fromMap(notificationMap["booking"]);
    //       }
    //       notificationType = NotificationDataType.booking;
    //       break;
    //     }

    //   // Transactions Real
    //   case 3:
    //     {
    //       if (notificationMap["realTransaction"] != null) {
    //         transactionData =
    //             TransactionData.fromMap(notificationMap["realTransaction"]);
    //       }
    //       notificationType = NotificationDataType.transaction;
    //       break;
    //     }

    //   // Transaction Requests
    //   case 4:
    //     {
    //       if (notificationMap["transactionRequest"] != null) {
    //         transactionRequestData = TransactionRequestData.fromMap(
    //             notificationMap["transactionRequest"]);
    //       }
    //       notificationType = NotificationDataType.transactionRequest;
    //       break;
    //     }

    //   // Parking
    //   case 5:
    //     {
    //       if (notificationMap["slotParking"] != null) {
    //         parkingData = ParkingData.fromMap(notificationMap["slotParking"]);
    //       } else if (notificationMap["parking"] != null) {
    //         parkingData = ParkingData.fromMap(notificationMap["parking"]);
    //       }
    //       notificationType = NotificationDataType.parking;
    //       break;
    //     }
    // }

    // time = notificationMap["notificationTime"];
    // status = notificationMap["notificationStatus"];

    id = notificationMap["id"];
    recieverType = UserDataUtils()
        .accountTypeFromString(notificationMap["recieverAccountType"]);

    senderUserId = notificationMap["senderUserId"];
    senderType = UserDataUtils()
        .accountTypeFromString(notificationMap["senderAccountType"]);

    if (notificationMap["senderUser"] != null) {
      // User Details
      if (notificationMap["senderUser"]["userDetails"] != null) {
        senderUserDetails =
            UserDetails.fromMap(notificationMap["senderUser"]["userDetails"]);
      }

      // Slot Data
      if (notificationMap["senderUser"]["slot"] != null) {
        senderSlotData =
            SlotData.fromMap(notificationMap["senderUser"]["slot"]);
      }
    }

    notificationType = NotificationUtils.getNotificationTypeFromString(
        notificationMap["type"]);

    switch (notificationType) {
      case NotificationDataType.parkingRequest:
        {
          parkingRequestData =
              ParkingRequestData.fromMap(notificationMap["parkingRequest"]);
          break;
        }
      case NotificationDataType.parkingRequestResponse:
        {
          parkingRequestData = ParkingRequestData.fromMap(
              notificationMap["parkingRequest_withResponse"]);
          break;
        }
      case NotificationDataType.booking_ForSlot:
        {
          bookingData = BookingData.fromMap(notificationMap["booking_ForSlot"]);
          break;
        }
      case NotificationDataType.booking_ForUser:
        {
          bookingData = BookingData.fromMap(notificationMap["booking_ForUser"]);
          break;
        }

      case NotificationDataType.bookingCancellation_ForSlot:
        {
          bookingData = BookingData.fromMap(
              notificationMap["bookingCancellation_ForSlot"]);
          break;
        }
      case NotificationDataType.bookingCancellation_ForUser:
        {
          bookingData = BookingData.fromMap(
              notificationMap["bookingCancellation_ForUser"]);
          break;
        }

      case NotificationDataType.parking_ForSlot:
        {
          parkingData = ParkingData.fromMap(notificationMap["parking_ForSlot"]);
          break;
        }
      case NotificationDataType.parking_ForUser:
        {
          parkingData = ParkingData.fromMap(notificationMap["parking_ForUser"]);
          break;
        }

      case NotificationDataType.parkingWithdraw_ForSlot:
        {
          parkingData =
              ParkingData.fromMap(notificationMap["parkingWithdraw_ForSlot"]);
          break;
        }
      case NotificationDataType.parkingWithdraw_ForUser:
        {
          parkingData =
              ParkingData.fromMap(notificationMap["parkingWithdraw_ForUser"]);
          break;
        }

      case NotificationDataType.transaction:
        {
          transactionData =
              TransactionData.fromMap(notificationMap["transaction"]);
          break;
        }

      case NotificationDataType.transactionRequest:
        {
          transactionRequestData = TransactionRequestData.fromMap(
              notificationMap["transactionRequest"]);
          break;
        }
      case NotificationDataType.transactionRequestResponse:
        {
          transactionRequestData = TransactionRequestData.fromMap(
              notificationMap["transactionRequest_withResponse"]);
          break;
        }
    }

    time = notificationMap["time"];
    status = notificationMap["status"];
  }
}

enum NotificationDataType {
  parkingRequest,
  parkingRequestResponse,

  booking_ForSlot,
  booking_ForUser,
  bookingCancellation_ForSlot,
  bookingCancellation_ForUser,

  parking_ForSlot,
  parking_ForUser,
  parkingWithdraw_ForSlot,
  parkingWithdraw_ForUser,

  transaction,

  transactionRequest,
  transactionRequestResponse,
}

class NotificationUtils {
  static NotificationDataType getNotificationTypeFromString(String type) {
    NotificationDataType notificationDataType;
    switch (type) {

      // Parking Request
      case "ParkingRequest":
        notificationDataType = NotificationDataType.parkingRequest;
        break;
      case "ParkingRequestResponse":
        notificationDataType = NotificationDataType.parkingRequestResponse;
        break;

      // Booking
      case "Booking_ForSlot":
        notificationDataType = NotificationDataType.booking_ForSlot;
        break;
      case "Booking_ForUser":
        notificationDataType = NotificationDataType.booking_ForUser;
        break;

      // Booking Cancellation
      case "BookingCancellation_ForSlot":
        notificationDataType = NotificationDataType.bookingCancellation_ForSlot;
        break;
      case "BookingCancellation_ForUser":
        notificationDataType = NotificationDataType.bookingCancellation_ForUser;
        break;

      // Parking
      case "Parking_ForSlot":
        notificationDataType = NotificationDataType.parking_ForSlot;
        break;
      case "Parking_ForUser":
        notificationDataType = NotificationDataType.parking_ForUser;
        break;

      // Parking Withdraw
      case "ParkingWithdraw_ForSlot":
        notificationDataType = NotificationDataType.parkingWithdraw_ForSlot;
        break;
      case "ParkingWithdraw_ForUser":
        notificationDataType = NotificationDataType.parkingWithdraw_ForUser;
        break;

      // Transaction
      case "Transaction":
        notificationDataType = NotificationDataType.transaction;
        break;

      // Transaction Requests
      case "TransactionRequest":
        notificationDataType = NotificationDataType.transactionRequest;
        break;
      case "TransactionRequestResponse":
        notificationDataType = NotificationDataType.transactionRequestResponse;
        break;
    }

    return notificationDataType;
  }
}
