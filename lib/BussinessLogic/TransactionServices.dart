import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:getparked/BussinessLogic/UserServices.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/StateManagement/Models/TransactionData.dart';
import 'package:getparked/Utils/TransactionUtils.dart';
import 'package:http/http.dart' as http;
import 'package:getparked/Utils/DomainUtils.dart';
import 'package:getparked/Utils/SecureStorageUtils.dart';
import 'package:getparked/Utils/JSONUtils.dart';
import 'package:provider/provider.dart';

const TRANSACTIONS_ROUTE = "/app/transactions";

class TransactionServices {
  Future<TransactionGetStatus> getAllTransactions(
      {@required BuildContext context}) async {
    try {
      AppState gpAppState = Provider.of<AppState>(context, listen: false);
      Uri url = Uri.parse(domainName + TRANSACTIONS_ROUTE);
      http.Response resp = await http.get(url, headers: {
        AUTH_TOKEN: gpAppState.authToken,
      });

      if (resp.statusCode == 200) {
        Map txnsData = json.decode(resp.body);
        double walletMoney = (txnsData["walletBalance"] != null)
            ? (txnsData["walletBalance"]).toDouble()
            : 0.0;
        gpAppState.setWalletMoney(walletMoney);

        double vaultBalance = (txnsData["vaultBalance"] != null)
            ? (txnsData["vaultBalance"]).toDouble()
            : 0.0;
        gpAppState.setVaultMoney(vaultBalance);

        List<TransactionData> transactions = [];
        List txnsMap = txnsData["transactions"];
        txnsMap.forEach((txn) {
          transactions.add(TransactionData.fromMap(txn));
        });

        gpAppState.setTransactions(transactions);

        return TransactionGetStatus.successful;
      } else if (resp.statusCode == 403) {
        return TransactionGetStatus.invalidToken;
      } else if (resp.statusCode == 500) {
        return TransactionGetStatus.internalServerError;
      }

      return TransactionGetStatus.failed;
    } catch (excp) {
      print(excp);
      return TransactionGetStatus.failed;
    }
  }

  Future<AddMoneyToWallStatus> addMoneyToWallet(
      {@required String authToken,
      @required String signature,
      @required String paymentId,
      @required String txnCode,
      @required int status,
      @required double amount}) async {
    try {
      Map<String, dynamic> txnData =
          TransactionUtils().getEncryptedData(txnCode);
      txnData["signature"] = signature;
      txnData["status"] = status;
      txnData["paymentId"] = paymentId;

      String encryptedCode = TransactionUtils().encryptData(txnData);

      Map<String, dynamic> reqBody = {
        "accountType": "User",
        "moneyTransferType": "Add",
        "amount": amount,
        "code": encryptedCode
      };

      Uri url = Uri.parse(domainName + TRANSACTIONS_ROUTE + "/realTransaction");
      http.Response resp = await http.post(url,
          body: JSONUtils().postBody(reqBody),
          headers: {
            AUTH_TOKEN: authToken,
            CONTENT_TYPE_KEY: JSON_CONTENT_VALUE
          });

      // print(resp.body);
      if (resp.statusCode == 200) {
        return AddMoneyToWallStatus.successful;
      } else if (resp.statusCode == 403) {
        return AddMoneyToWallStatus.invalidToken;
      } else if (resp.statusCode == 422) {
        return AddMoneyToWallStatus.invalidTransaction;
      } else if (resp.statusCode == 500) {
        return AddMoneyToWallStatus.internalServerError;
      }
      return AddMoneyToWallStatus.failed;
    } catch (excp) {
      print(excp);
      return AddMoneyToWallStatus.failed;
    }
  }

  Future<String> getTransactionCode(
      {@required String authToken, @required double amount}) async {
    try {
      Map<String, dynamic> reqBody = {
        "amount": (amount * 100).toInt().toString()
      };
      http.Response resp = await http.post(
          Uri.parse(domainName + TRANSACTIONS_ROUTE + "/realTransactionCode"),
          body: JSONUtils().postBody(reqBody),
          headers: {
            AUTH_TOKEN: authToken,
            CONTENT_TYPE_KEY: JSON_CONTENT_VALUE
          });

      if (resp.statusCode == 200) {
        String encryptedCode = json.decode(resp.body)["code"];
        return encryptedCode;
      }
      return null;
    } catch (excp) {
      print(excp);
      return null;
    }
  }

  Future<TransactionRequestSendStatus> moneyRequest(
      {@required String authToken,
      @required double amount,
      @required int requestedFromUserId,
      @required String note}) async {
    try {
      Map<String, dynamic> reqBody = {
        "amount": amount,
        "requesterAccountType": "User",
        "transferType": "Add",
        "requestedFromUserId": requestedFromUserId,
        "requestedFromAccountType": "User",
        "note": note
      };

      Uri url = Uri.parse(domainName + TRANSACTIONS_ROUTE + "/request");
      http.Response resp = await http.post(url,
          body: JSONUtils().postBody(reqBody),
          headers: {
            AUTH_TOKEN: authToken,
            CONTENT_TYPE_KEY: JSON_CONTENT_VALUE
          });

      if (resp.statusCode == 200) {
        return TransactionRequestSendStatus.successful;
      } else if (resp.statusCode == 403) {
        return TransactionRequestSendStatus.invalidToken;
      } else if (resp.statusCode == 500) {
        return TransactionRequestSendStatus.internalServerError;
      }

      return TransactionRequestSendStatus.failed;
    } catch (excp) {
      print(excp);
      return TransactionRequestSendStatus.failed;
    }
  }

  Future<TransactionRequestRespondStatus> respondMoneyRequest(
      {@required String authToken,
      @required int requestId,
      @required int respone}) async {
    try {
      Map<String, dynamic> reqBody = {
        "requestId": requestId,
        "response": respone
      };

      Uri url = Uri.parse(domainName + TRANSACTIONS_ROUTE + "/respondRequest");
      http.Response resp = await http.post(url,
          body: JSONUtils().postBody(reqBody),
          headers: {
            AUTH_TOKEN: authToken,
            CONTENT_TYPE_KEY: JSON_CONTENT_VALUE
          });

      print(resp.body);
      if (resp.statusCode == 200) {
        return TransactionRequestRespondStatus.successful;
      } else if (resp.statusCode == 403) {
        return TransactionRequestRespondStatus.invalidToken;
      } else if (resp.statusCode == 422) {
        return TransactionRequestRespondStatus.cannotBeProceed;
      } else if (resp.statusCode == 400) {
        return TransactionRequestRespondStatus.lowBalance;
      } else if (resp.statusCode == 500) {
        return TransactionRequestRespondStatus.internalServerError;
      }

      return TransactionRequestRespondStatus.failed;
    } catch (excp) {
      print(excp);
      return TransactionRequestRespondStatus.failed;
    }
  }
}

enum TransactionGetStatus {
  successful,
  failed,
  invalidToken,
  internalServerError
}

enum AddMoneyToWallStatus {
  successful,
  failed,
  invalidToken,
  invalidTransaction,
  internalServerError
}

enum TransactionRequestSendStatus {
  successful,
  failed,
  invalidToken,
  internalServerError
}

enum TransactionRequestRespondStatus {
  successful,
  failed,
  invalidToken,
  lowBalance,
  cannotBeProceed,
  internalServerError
}
