import 'package:getparked/StateManagement/Models/NonRealTransactionData.dart';
import 'package:getparked/StateManagement/Models/RealTransactionData.dart';
import 'package:getparked/StateManagement/Models/UserData.dart';
import 'package:getparked/StateManagement/Models/UserDetails.dart';
import 'package:getparked/StateManagement/Models/SlotData.dart';

class TransactionData {
  int id;

  // TransactionType
  TransactionDataType type;
  RealTransactionData realTransaction;
  NonRealTransactionData nonRealTransaction;

  //transactionFromAccountType or your account type.
  UserAccountType accountType;

  // transactionAmount
  double amount;

  // transactionMoneyTransferType
  MoneyTransferType transferType;

  // transactionUserId and transactionAccountType
  int withUserId;
  UserAccountType withAccountType;

  // with userData and details
  Map transactionWithUserData;
  UserDetails withUserDetails;

  // with slotData
  Map transactionWithSlotData;
  SlotData withSlotData;

  // Complete Data
  Map data;

  String txnCode;

  String time;
  int status;

  TransactionData({
    this.id,
    this.accountType,
    this.amount,
    this.transferType,
    this.withUserId,
    this.withAccountType,
    this.txnCode,
    this.time,
    this.type,
    this.transactionWithUserData,
    this.transactionWithSlotData,
    this.data,
    this.status,
  });

  TransactionData.fromMap(Map transactionMap) {
    id = transactionMap["id"];

    accountType =
        UserDataUtils().accountTypeFromString(transactionMap["accountType"]);
    amount = (transactionMap["amount"] != null)
        ? (transactionMap["amount"]).toDouble()
        : 0.0;
    transferType = TransactionDataUtils.getTransferTypeFromString(
        transactionMap["transferType"]);

    // TODO: complete this.
    // Transaction Type
    type = TransactionDataUtils.getTypeFromString(transactionMap["type"]);
    switch (type) {
      case TransactionDataType.real:
        realTransaction =
            RealTransactionData.fromMap(transactionMap["transactionReal"]);
        if (realTransaction != null) {
          withAccountType = realTransaction.accountType;
          txnCode = realTransaction.txnCode;
          withUserId = realTransaction.userId;
          withUserDetails = realTransaction.userDetails;
          withSlotData = realTransaction.slotData;
        }
        break;
      case TransactionDataType.nonReal:
        nonRealTransaction = NonRealTransactionData.fromMap(
            transactionMap["transactionNonReal"]);
        if (nonRealTransaction != null) {
          withAccountType = nonRealTransaction.withUserAccountType;
          txnCode = nonRealTransaction.txnCode;
          withUserId = nonRealTransaction.withUserId;
          withUserDetails = nonRealTransaction.withUserDetails;
          withSlotData = nonRealTransaction.withSlotData;
        }
        break;
    }

    //TODO: Send slot data with transactions if required...

    data = transactionMap;
    time = transactionMap["time"];
    status = transactionMap["status"];
  }

  TransactionStatus getTransactionStatus() {
    TransactionStatus type;
    switch (status) {
      case 0:
        type = TransactionStatus.pending;
        break;
      case 1:
        type = TransactionStatus.successful;
        break;
      case 2:
        type = TransactionStatus.failed;
        break;
    }

    return type;
  }
}

class TransactionDataUtils {
  static TransactionDataType getTypeFromString(String txnType) {
    if (txnType == "Real") {
      return TransactionDataType.real;
    }
    return TransactionDataType.nonReal;
  }

  static String getTypeAsString(TransactionDataType txnDataType) {
    if (txnDataType == TransactionDataType.real) {
      return "Real";
    }
    return "NonReal";
  }

  static MoneyTransferType getTransferTypeFromString(String transferType) {
    if (transferType == "Add") {
      return MoneyTransferType.add;
    }
    return MoneyTransferType.remove;
  }

  static String getTransferTypeAsString(MoneyTransferType transferType) {
    if (transferType == MoneyTransferType.add) {
      return "Add";
    }
    return "Remove";
  }
}

enum TransactionStatus { pending, successful, failed }
enum TransactionDataType { real, nonReal }
enum MoneyTransferType { add, remove }
