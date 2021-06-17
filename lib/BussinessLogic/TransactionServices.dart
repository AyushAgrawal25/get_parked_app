import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:getparked/BussinessLogic/UserServices.dart';
import 'package:getparked/Utils/TransactionUtils.dart';
import 'package:http/http.dart' as http;
import 'package:getparked/Utils/DomainUtils.dart';
import 'package:getparked/Utils/SecureStorageUtils.dart';
import 'package:getparked/Utils/JSONUtils.dart';

const TRANSACTIONS_ROUTE = "/app/transactions";

class TransactionServices {
  Future<AddMoneyToWallStatus> addMoneyToWallet(
      {@required String authToken,
      @required String ref,
      @required String txnCode,
      @required int status,
      @required double amount}) async {
    try {
      Map<String, dynamic> txnData =
          TransactionUtils().getEncryptedData(txnCode);
      txnData["ref"] = ref;
      txnData["status"] = status;

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

      if (resp.statusCode == 200) {
        print(resp.body);
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

  Future<String> getTransactionCode({@required String authToken}) async {
    try {
      http.Response resp = await http.get(
          Uri.parse(domainName + TRANSACTIONS_ROUTE + "/realTransactionCode"),
          headers: {AUTH_TOKEN: authToken});

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
      @required int withUserId,
      @required String note}) async {
    try {
      Map<String, dynamic> reqBody = {
        "amount": amount,
        "fromAccountType": "User",
        "transferType": "Add",
        "withUserId": withUserId,
        "withAccountType": "User",
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
