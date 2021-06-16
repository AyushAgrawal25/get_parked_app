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
}

enum AddMoneyToWallStatus {
  successful,
  failed,
  invalidTransaction,
  internalServerError
}
