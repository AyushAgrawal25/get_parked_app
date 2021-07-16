import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:getparked/BussinessLogic/UserServices.dart';
import 'package:getparked/StateManagement/Models/UserBeneficiaryData.dart';
import 'package:getparked/Utils/DomainUtils.dart';
import 'package:getparked/Utils/JSONUtils.dart';
import 'package:getparked/Utils/SecureStorageUtils.dart';
import 'package:http/http.dart' as http;

const String USER_BENEFICIARY_ROUTE = USER_ROUTE + "/beneficiaries";

class UserBeneficiaryServices {
  Future<UserBeneficiaryData> create({
    @required String authToken,
    @required String name,
    @required String accountNumber,
    @required String ifscCode,
    @required String bankName,
    @required String upiId,
  }) async {
    try {
      Map<String, dynamic> reqBody = {
        "beneficiaryName": name,
        "accountNumber": accountNumber,
        "ifscCode": ifscCode,
        "bankName": bankName,
        "upiId": upiId
      };
      Uri url = Uri.parse(domainName + USER_BENEFICIARY_ROUTE);
      http.Response resp = await http.post(url,
          body: JSONUtils().postBody(reqBody),
          headers: {
            CONTENT_TYPE_KEY: JSON_CONTENT_VALUE,
            AUTH_TOKEN: authToken
          });

      if (resp.statusCode == 200) {
        Map respBody = json.decode(resp.body);
        UserBeneficiaryData beneficiaryData =
            UserBeneficiaryData.fromMap(respBody["data"]);
        return beneficiaryData;
      }

      return null;
    } catch (excp) {
      print(excp);
      return null;
    }
  }

  Future<UserBeneficiaryData> update({
    @required String authToken,
    @required int beneficiaryId,
    @required String name,
    @required String accountNumber,
    @required String ifscCode,
    @required String bankName,
    @required String upiId,
  }) async {
    try {
      Map<String, dynamic> reqBody = {
        "beneficiaryId": beneficiaryId,
        "beneficiaryName": name,
        "accountNumber": accountNumber,
        "ifscCode": ifscCode,
        "bankName": bankName,
        "upiId": upiId
      };
      Uri url = Uri.parse(domainName + USER_BENEFICIARY_ROUTE);
      http.Response resp = await http.put(url,
          body: JSONUtils().postBody(reqBody),
          headers: {
            CONTENT_TYPE_KEY: JSON_CONTENT_VALUE,
            AUTH_TOKEN: authToken
          });

      if (resp.statusCode == 200) {
        Map respBody = json.decode(resp.body);
        UserBeneficiaryData beneficiaryData =
            UserBeneficiaryData.fromMap(respBody["data"]);
        return beneficiaryData;
      }

      return null;
    } catch (excp) {
      print(excp);
      return null;
    }
  }
}
