import 'package:getparked/StateManagement/Models/SlotData.dart';
import 'package:getparked/StateManagement/Models/UserDetails.dart';
import 'package:getparked/StateManagement/Models/TransactionData.dart';
import 'package:getparked/StateManagement/Models/UserData.dart';
import 'package:getparked/StateManagement/Models/UserDetails.dart';

class NonRealTransactionData {
  int id;

  int transactionId;
  TransactionData transactionData;
  NonRealTransactionType type;

  UserAccountType fromUserAccountType;
  int fromUserId;
  UserDetails fromUserDetails;
  SlotData fromSlotData;

  UserAccountType withUserAccountType;
  int withUserId;
  UserDetails withUserDetails;
  SlotData withSlotData;

  double amount;
  MoneyTransferType transferType;
  String refCode;

  String time;
  int status;

  NonRealTransactionData.fromMap(Map txnMap) {
    if (txnMap != null) {
      id = txnMap["id"];

      fromUserId = txnMap["fromUserId"];
      if ((txnMap["fromUser"] != null) &&
          (txnMap["fromUser"]["userDetails"] != null)) {
        fromUserDetails =
            UserDetails.fromMap(txnMap["fromUser"]["userDetails"]);
      }

      // From slot Data
      if ((txnMap["fromUser"] != null) &&
          (txnMap["fromUser"]["slot"] != null)) {
        fromSlotData = SlotData.fromMap(txnMap["fromUser"]["slot"]);
      }
      fromUserAccountType =
          UserDataUtils().accountTypeFromString(txnMap["fromAccountType"]);

      withUserId = txnMap["withUserId"];
      if ((txnMap["withUser"] != null) &&
          (txnMap["withUser"]["userDetails"] != null)) {
        withUserDetails =
            UserDetails.fromMap(txnMap["withUser"]["userDetails"]);
      }

      // With slot data.
      if ((txnMap["withUser"] != null) &&
          (txnMap["withUser"]["slot"] != null)) {
        withSlotData = SlotData.fromMap(txnMap["withUser"]["slot"]);
      }
      withUserAccountType =
          UserDataUtils().accountTypeFromString(txnMap["withAccountType"]);

      transactionId = txnMap["transactionId"];
      if (txnMap["transaction"] != null) {
        transactionData = TransactionData.fromMap(txnMap["transaction"]);
      }
      type = NonRealTransactionDataUtils.getTypeFromString(txnMap["type"]);

      transferType = TransactionDataUtils.getTransferTypeFromString(
          txnMap["transferType"]);
      amount = (txnMap["amount"] != null) ? txnMap["amount"].toDouble() : 0.0;
      refCode = txnMap["refCode"];
      time = txnMap["time"];
      status = txnMap["status"];
    }
  }
}

class NonRealTransactionDataUtils {
  static NonRealTransactionType getTypeFromString(String txnType) {
    if (txnType == "SlotBookings") {
      return NonRealTransactionType.bookings;
    }

    return NonRealTransactionType.transactionRequests;
  }

  static String getTypeAsString(NonRealTransactionType transactionType) {
    if (transactionType == NonRealTransactionType.bookings) {
      return "SlotBookings";
    }
    return "TransactionRequests";
  }
}

enum NonRealTransactionType { bookings, transactionRequests }
