import 'package:getparked/StateManagement/Models/TransactionData.dart';
import 'package:getparked/StateManagement/Models/UserData.dart';
import 'package:getparked/StateManagement/Models/UserDetails.dart';

class RealTransactionData {
  int id;

  int userId;
  UserDetails userDetails;

  int transactionId;
  TransactionData transactionData;

  UserAccountType accountType;
  double amount;
  MoneyTransferType transferType;

  String ref;
  String refCode;

  String time;
  int status;

  RealTransactionData.fromMap(Map txnMap) {
    if (txnMap != null) {
      id = txnMap["id"];

      userId = txnMap["userId"];
      if ((txnMap["user"] != null) && (txnMap["user"]["userDetails"] != null)) {
        userDetails = UserDetails.fromMap(txnMap["user"]["userDetails"]);
      }

      transactionId = txnMap["transactionId"];
      if (txnMap["transaction"] != null) {
        transactionData = TransactionData.fromMap(txnMap["transaction"]);
      }

      accountType =
          UserDataUtils().accountTypeFromString(txnMap["accountType"]);

      transferType = TransactionDataUtils.getTransferTypeFromString(
          txnMap["transferType"]);

      ref = txnMap["ref"];
      refCode = txnMap["refCode"];
      time = txnMap["time"];
      status = txnMap["status"];
    }
  }
}
