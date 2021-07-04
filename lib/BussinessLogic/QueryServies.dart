import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:getparked/BussinessLogic/UserServices.dart';
import 'package:getparked/StateManagement/Models/FAQData.dart';
import 'package:getparked/Utils/DomainUtils.dart';
import 'package:getparked/Utils/JSONUtils.dart';
import 'package:getparked/Utils/SecureStorageUtils.dart';
import 'package:http/http.dart' as http;

const QUERIES_ROUTE = "/app/queries/userQueries";

class QueryServies {
  Future<QuerySendStatus> sendQuery(
      {@required String authToken,
      @required String title,
      String description}) async {
    try {
      Uri url = Uri.parse(domainName + QUERIES_ROUTE);
      Map<String, dynamic> reqBody = {
        "query": title,
        "description": description
      };

      http.Response resp = await http.post(url,
          body: JSONUtils().postBody(reqBody),
          headers: {
            AUTH_TOKEN: authToken,
            CONTENT_TYPE_KEY: JSON_CONTENT_VALUE
          });

      print(resp);
      if (resp.statusCode == 200) {
        return QuerySendStatus.successful;
      } else if (resp.statusCode == 403) {
        return QuerySendStatus.invalidToken;
      } else if (resp.statusCode == 500) {
        return QuerySendStatus.internalServerError;
      }

      return QuerySendStatus.failed;
    } catch (excp) {
      print(excp);
      return QuerySendStatus.failed;
    }
  }
}

enum QuerySendStatus { successful, internalServerError, invalidToken, failed }
