import 'package:getparked/StateManagement/Models/UserDetails.dart';
import 'package:getparked/StateManagement/Models/SlotData.dart';

class TransactionRequestData {
  int id;

  // From Details
  int fromUserId;
  UserDetails fromUserDetails;
  SlotData fromSlotData;
  int fromAccountType;

  // With User Details
  int withUserId;
  UserDetails withUserDetails;
  SlotData withSlotData;
  int withAccountType;

  // Amount
  double amount;

  // Note
  String note;

  // Money Transfer Type
  int moneyTransferType;

  String time;
  int status;

  TransactionRequestData.fromMap(Map transactionRequestMap) {
    id = transactionRequestMap["transactionRequestId"];

    // From User Details
    // UserId
    fromUserId = transactionRequestMap["transactionRequestFromUserId"];

    // User Details
    Map fromUserDetailsMap;
    if (transactionRequestMap["transactionRequestFromUserData"] != null) {
      fromUserDetailsMap =
          transactionRequestMap["transactionRequestFromUserData"];
    } else if (transactionRequestMap["fromUserData"] != null) {
      fromUserDetailsMap = transactionRequestMap["fromUserData"];
    } else if (transactionRequestMap["transactionRequestFromUserDetails"] !=
        null) {
      fromUserDetailsMap =
          transactionRequestMap["transactionRequestFromUserDetails"];
    } else if (transactionRequestMap["fromUserDetails"] != null) {
      fromUserDetailsMap = transactionRequestMap["fromUserDetails"];
    }
    if (fromUserDetailsMap != null) {
      if (fromUserDetailsMap["userId"] != null) {
        fromUserDetails = UserDetails.fromMap(fromUserDetailsMap);
      }
    }

    // Slot Data
    Map fromSlotDataMap;
    if (transactionRequestMap["transactionRequestFromSlotData"] != null) {
      fromSlotDataMap = transactionRequestMap["transactionRequestFromSlotData"];
    } else if (transactionRequestMap["fromSlotData"] != null) {
      fromSlotDataMap = transactionRequestMap["fromSlotData"];
    }
    if (fromSlotDataMap != null) {
      if (fromSlotDataMap["slotId"] != null) {
        fromSlotData = SlotDataUtils.mapToSlotData(fromSlotDataMap);
      }
    }

    // Account Type
    fromAccountType =
        transactionRequestMap["transactionRequestFromAccountType"];

    // With User Details
    // UserId
    withUserId = transactionRequestMap["transactionRequestWithUserId"];

    // User Details
    Map withUserDetailsMap;
    if (transactionRequestMap["transactionRequestWithUserData"] != null) {
      withUserDetailsMap =
          transactionRequestMap["transactionRequestWithUserData"];
    } else if (transactionRequestMap["withUserData"] != null) {
      withUserDetailsMap = transactionRequestMap["withUserData"];
    } else if (transactionRequestMap["transactionRequestWithUserDetails"] !=
        null) {
      withUserDetailsMap =
          transactionRequestMap["transactionRequestWithUserDetails"];
    } else if (transactionRequestMap["withUserDetails"] != null) {
      withUserDetailsMap = transactionRequestMap["withUserDetails"];
    }
    if (withUserDetailsMap != null) {
      if (withUserDetailsMap["userId"] != null) {
        withUserDetails = UserDetails.fromMap(withUserDetailsMap);
      }
    }

    // Slot Data
    Map withSlotDataMap;
    if (transactionRequestMap["transactionRequestWithSlotData"] != null) {
      withSlotDataMap = transactionRequestMap["transactionRequestWithSlotData"];
    } else if (transactionRequestMap["withSlotData"] != null) {
      withSlotDataMap = transactionRequestMap["withSlotData"];
    }
    if (withSlotDataMap != null) {
      if (withSlotDataMap["slotId"] != null) {
        withSlotData = SlotDataUtils.mapToSlotData(withSlotDataMap);
      }
    }

    // Account Type
    withAccountType =
        transactionRequestMap["transactionRequestWithAccountType"];

    amount = (transactionRequestMap["transactionRequestAmount"] != null)
        ? (transactionRequestMap["transactionRequestAmount"]).toDouble()
        : 0.0;
    note = transactionRequestMap["transactionRequestNote"];
    moneyTransferType =
        transactionRequestMap["transactionRequestMoneyTransferType"];
    time = transactionRequestMap["transactionRequestTime"];
    status = transactionRequestMap["transactionRequestStatus"];
  }

  TransactionRequestDataType getTransactionRequestDataType() {
    TransactionRequestDataType type;
    switch (status) {
      case 0:
        type = TransactionRequestDataType.pending;
        break;
      case 1:
        type = TransactionRequestDataType.accepted;
        break;
      case 2:
        type = TransactionRequestDataType.rejected;
        break;
    }

    return type;
  }
}

enum TransactionRequestDataType { pending, rejected, accepted }
