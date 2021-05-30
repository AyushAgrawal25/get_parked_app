import 'package:getparked/StateManagement/Models/UserDetails.dart';
import 'package:getparked/StateManagement/Models/SlotData.dart';

class TransactionData {
  int id;

  // transactionTypeMasterId
  int type;

  //transactionFromAccountType
  int accountType;

  // transactionAmount
  double amount;

  // transactionMoneyTransferType
  int moneyTransferType;

  // transactionUserId and transactionAccountType
  int transactionWithUserId;
  int transactionWithAccountType;

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
    this.moneyTransferType,
    this.transactionWithUserId,
    this.transactionWithAccountType,
    this.refCode,
    this.time,
    this.type,
    this.transactionWithUserData,
    this.transactionWithSlotData,
    this.data,
    this.status,
  });

  TransactionData.fromMap(Map transactionMap) {
    id = transactionMap["transactionId"];

    accountType = transactionMap["transactionAccountType"];
    amount = (transactionMap["transactionAmount"] != null)
        ? (transactionMap["transactionAmount"]).toDouble()
        : 0.0;
    moneyTransferType = transactionMap["transactionMoneyTransferType"];

    // Transaction Type
    type = transactionMap["transactionTypeMasterId"];
    switch (type) {
      case 1:
        transactionWithUserId = transactionMap["realTransactionUserId"];
        transactionWithAccountType =
            transactionMap["realTransactionAccountType"];
        refCode = transactionMap["realTransactionRef"];

        if (accountType == null) {
          accountType = transactionMap["realTransactionAccountType"];
        }

        if (amount == null) {
          amount = transactionMap["realTransactionAmount"];
        }

        if (moneyTransferType == null) {
          moneyTransferType =
              transactionMap["realTransactionMoneyTransferType"];
        }

        if (transactionWithUserId == null) {
          transactionWithUserId = transactionMap["realTransactionUserId"];
        }

        if (transactionWithAccountType == null) {
          transactionWithAccountType =
              transactionMap["realTransactionAccountType"];
        }

        if (time == null) {
          time = transactionMap["realTransactionTime"];
        }

        if (status == null) {
          status = transactionMap["realTransactionStatus"];
        }
        break;

      case 2:
        transactionWithUserId = transactionMap["nonRealTransactionWithUserId"];
        transactionWithAccountType =
            transactionMap["nonRealTransactionWithAccountType"];
        refCode = transactionMap["nonRealTransactionRef"];
        break;
    }

    // User Data
    if (transactionMap["userData"] != null) {
      withUserDetails =
          UserDetailsUtils.fromMapToUserDetails(transactionMap["userData"]);
      transactionWithUserData = transactionMap["userData"];
    }

    // Slot Data
    if (transactionMap["slotData"] != null) {
      withSlotData = SlotDataUtils.mapToSlotData(transactionMap["slotData"]);
      transactionWithSlotData = transactionMap["slotData"];
    }

    data = transactionMap;
    time = transactionMap["transactionTime"];
    status = transactionMap["transactionStatus"];
  }

  TransactionDataType getTransactionDataType() {
    TransactionDataType type;
    switch (status) {
      case 0:
        type = TransactionDataType.pending;
        break;
      case 1:
        type = TransactionDataType.successful;
        break;
      case 2:
        type = TransactionDataType.failed;
        break;
    }

    return type;
  }
}

enum TransactionDataType { pending, successful, failed }
