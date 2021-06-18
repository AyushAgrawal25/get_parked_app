import 'package:getparked/StateManagement/Models/RealTransactionData.dart';
import 'package:getparked/StateManagement/Models/UserData.dart';
import 'package:getparked/StateManagement/Models/UserDetails.dart';
import 'package:getparked/StateManagement/Models/SlotData.dart';

class TransactionData {
  int id;

  // TransactionType
  TransactionDataType type;
  RealTransactionData realTransaction;
  // TODO: create non real transaction

  //transactionFromAccountType
  UserAccountType accountType;

  // transactionAmount
  double amount;

  // transactionMoneyTransferType
  MoneyTransferType transferType;

  // transactionUserId and transactionAccountType
  int withUserId;
  UserAccountType withAccountType;

  // userData
  Map transactionWithUserData;
  UserDetails withUserDetails;

  // slotData
  Map transactionWithSlotData;
  SlotData withSlotData;

  // Complete Data
  Map data;

  String refCode;

  String time;
  int status;

  TransactionData({
    this.id,
    this.accountType,
    this.amount,
    this.transferType,
    this.withUserId,
    this.withAccountType,
    this.refCode,
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

    // Transaction Type
    type =
        TransactionDataUtils.getTypeFromString(transactionMap["transferType"]);
    // switch (type) {
    //   case 1:
    //     transactionWithUserId = transactionMap["realTransactionUserId"];
    //     transactionWithAccountType =
    //         transactionMap["realTransactionAccountType"];
    //     refCode = transactionMap["realTransactionRef"];

    //     if (accountType == null) {
    //       accountType = transactionMap["realTransactionAccountType"];
    //     }

    //     if (amount == null) {
    //       amount = transactionMap["realTransactionAmount"];
    //     }

    //     if (moneyTransferType == null) {
    //       moneyTransferType =
    //           transactionMap["realTransactionMoneyTransferType"];
    //     }

    //     if (transactionWithUserId == null) {
    //       transactionWithUserId = transactionMap["realTransactionUserId"];
    //     }

    //     if (transactionWithAccountType == null) {
    //       transactionWithAccountType =
    //           transactionMap["realTransactionAccountType"];
    //     }

    //     if (time == null) {
    //       time = transactionMap["realTransactionTime"];
    //     }

    //     if (status == null) {
    //       status = transactionMap["realTransactionStatus"];
    //     }
    //     break;

    //   case 2:
    //     transactionWithUserId = transactionMap["nonRealTransactionWithUserId"];
    //     transactionWithAccountType =
    //         transactionMap["nonRealTransactionWithAccountType"];
    //     refCode = transactionMap["nonRealTransactionRef"];
    //     break;
    // }

    // User Data
    if ((transactionMap["user"] != null) &&
        (transactionMap["user"]["userDetails"] != null)) {
      withUserDetails =
          UserDetails.fromMap(transactionMap["user"]["userDetails"]);
      transactionWithUserData = transactionMap["user"];
    }

    //TODO: Think on this
    // Slot Data
    if (transactionMap["slotData"] != null) {
      withSlotData = SlotDataUtils.mapToSlotData(transactionMap["slotData"]);
      transactionWithSlotData = transactionMap["slotData"];
    }

    data = transactionMap;
    time = transactionMap["time"];
    status = transactionMap["status"];
  }

  TransactionStatus getTransactionDataType() {
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
