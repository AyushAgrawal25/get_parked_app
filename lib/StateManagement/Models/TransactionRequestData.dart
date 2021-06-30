import 'package:getparked/StateManagement/Models/TransactionData.dart';
import 'package:getparked/StateManagement/Models/UserData.dart';
import 'package:getparked/StateManagement/Models/UserDetails.dart';
import 'package:getparked/StateManagement/Models/SlotData.dart';

class TransactionRequestData {
  int id;

  // From Details
  int requesterUserId;
  UserDetails requesterUserDetails;
  SlotData requesterSlotData;
  UserAccountType requesterAccountType;

  // With User Details
  int requestedFromUserId;
  UserDetails requestedFromUserDetails;
  SlotData requestedFromSlotData;
  UserAccountType requestedFromAccountType;

  double amount;
  String note;
  MoneyTransferType transferType;

  // Transactions
  int requesterTransactionId;
  TransactionData requesterTransaction;

  int requestedFromTransactionId;
  TransactionData requestedFromTransaction;

  String time;
  int status;

  TransactionRequestData.fromMap(Map transactionRequestMap) {
    id = transactionRequestMap["id"];

    requesterUserId = transactionRequestMap["requesterUserId"];
    requesterAccountType = UserDataUtils()
        .accountTypeFromString(transactionRequestMap["requesterAccountType"]);

    if (transactionRequestMap["requesterUser"] != null) {
      // Requester User Details
      if (transactionRequestMap["requesterUser"]["userDetails"] != null) {
        requesterUserDetails = UserDetails.fromMap(
            transactionRequestMap["requesterUser"]["userDetails"]);
      }

      // Requester Slot Data
      if (transactionRequestMap["requesterUser"]["slot"] != null) {
        requesterSlotData =
            SlotData.fromMap(transactionRequestMap["requesterUser"]["slot"]);
      }
    }

    // Requested From User Details
    requestedFromUserId = transactionRequestMap["requestedFromUserId"];
    requestedFromAccountType = UserDataUtils().accountTypeFromString(
        transactionRequestMap["requestedFromAccountType"]);

    if (transactionRequestMap["requestedFromUser"] != null) {
      // Requester User Details
      if (transactionRequestMap["requestedFromUser"]["userDetails"] != null) {
        requestedFromUserDetails = UserDetails.fromMap(
            transactionRequestMap["requestedFromUser"]["userDetails"]);
      }

      // Requester Slot Data
      if (transactionRequestMap["requestedFromUser"]["slot"] != null) {
        requestedFromSlotData = SlotData.fromMap(
            transactionRequestMap["requestedFromUser"]["slot"]);
      }
    }

    // Transactions
    if (transactionRequestMap["requesterTransactionId"] != null) {
      requesterTransactionId = transactionRequestMap["requesterTransactionId"];
      requesterTransaction = TransactionData.fromMap(
          transactionRequestMap["requesterTransaction"]);
    }

    if (transactionRequestMap["requestedFromTransactionId"] != null) {
      requestedFromTransactionId =
          transactionRequestMap["requestedFromTransactionId"];
      requestedFromTransaction = TransactionData.fromMap(
          transactionRequestMap["requestedFromTransaction"]);
    }

    amount = (transactionRequestMap["amount"] != null)
        ? (transactionRequestMap["amount"]).toDouble()
        : 0.0;
    note = transactionRequestMap["note"];
    transferType = TransactionDataUtils.getTransferTypeFromString(
        transactionRequestMap["transferType"]);

    time = transactionRequestMap["time"];
    status = transactionRequestMap["status"];
  }

  TransactionRequestStatus getTransactionRequestStatus() {
    TransactionRequestStatus type;
    switch (status) {
      case 0:
        type = TransactionRequestStatus.pending;
        break;
      case 1:
        type = TransactionRequestStatus.accepted;
        break;
      case 2:
        type = TransactionRequestStatus.rejected;
        break;
    }

    return type;
  }
}

enum TransactionRequestStatus { pending, rejected, accepted }
