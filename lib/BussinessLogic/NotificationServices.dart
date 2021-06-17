import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart' as dio;
import 'package:getparked/BussinessLogic/UserServices.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/StateManagement/Models/UserData.dart';
import 'package:getparked/Utils/JSONUtils.dart';
import 'package:getparked/Utils/SecureStorageUtils.dart';
import 'package:http/http.dart' as http;
import 'package:getparked/Utils/DomainUtils.dart';

class NotificationServices {
  Future<FCMTokenUpdateStatus> updateFCMToken(
      {@required String authToken}) async {
    try {
      String fcmToken = await FirebaseMessaging.instance.getToken();
      Map<String, dynamic> reqBody = {"fcmToken": fcmToken};
      Uri url = Uri.parse(domainName + NOTIFICATION_ROUTE + "/fcmToken");
      http.Response resp = await http.put(url,
          body: JSONUtils().postBody(reqBody),
          headers: <String, String>{
            CONTENT_TYPE_KEY: JSON_CONTENT_VALUE,
            AUTH_TOKEN: authToken
          });

      // print(resp.body);
      if (resp.statusCode == 200) {
        return FCMTokenUpdateStatus.successful;
      } else if (resp.statusCode == 403) {
        return FCMTokenUpdateStatus.invalidToken;
      } else if (resp.statusCode == 500) {
        return FCMTokenUpdateStatus.internalServerError;
      }
      return FCMTokenUpdateStatus.failed;
    } catch (excp) {
      print(excp);
      return FCMTokenUpdateStatus.failed;
    }
  }
}

enum FCMTokenUpdateStatus {
  successful,
  invalidToken,
  internalServerError,
  failed
}
const String NOTIFICATION_ROUTE = "/app/notifications";