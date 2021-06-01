import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart' as dio;
import 'package:getparked/Utils/JSONUtils.dart';
import 'package:getparked/Utils/SecureStorageUtils.dart';
import 'package:http/http.dart' as http;
import 'package:getparked/Utils/DomainUtils.dart';

String USER_ROUTE = "/app/users";

class UserServices {
  // TODO: get user data from it.
  Future getUser({@required String authToken}) async {
    try {
      http.Response resp = await http.get(
          Uri.parse(domainName + USER_ROUTE + "/getUser"),
          headers: {AUTH_TOKEN: authToken});

      print(resp);
    } catch (e) {}
  }

  Future<bool> isEmailRegistered({@required String email}) async {
    try {
      Uri url = Uri.parse(domainName + "/app/users/checkEmail/$email");
      http.Response resp =
          await http.get(url, headers: {API_TOKEN_HEADER: universalAPIToken});
      // print(resp.body);

      if (resp.statusCode == 200) {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> login(
      {@required String email, @required String userToken}) async {
    try {
      Map<String, dynamic> reqBody = {"email": email, "userToken": userToken};
      Uri url = Uri.parse(domainName + USER_ROUTE + '/login');
      http.Response resp = await http.post(url,
          body: JSONUtils().postBody(reqBody),
          headers: <String, String>{
            CONTENT_TYPE_KEY: JSON_CONTENT_VALUE,
          });
      // print(resp.body);
      if (resp.statusCode == 200) {
        return json.decode(resp.body)[AUTH_TOKEN];
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<UserCreateStatus> createUser(
      {@required String email, @required String userToken}) async {
    try {
      Map<String, dynamic> reqBody = {"email": email, "userToken": userToken};
      Uri url = Uri.parse(domainName + USER_ROUTE + "/create");
      http.Response resp = await http.post(url,
          body: JSONUtils().postBody(reqBody),
          headers: {
            API_TOKEN_HEADER: universalAPIToken,
            CONTENT_TYPE_KEY: JSON_CONTENT_VALUE
          });
      // print(resp.body);
      if (resp.statusCode == 200) {
        return UserCreateStatus.successful;
      } else if (resp.statusCode == 401) {
        return UserCreateStatus.unauthorized;
      } else if (resp.statusCode == 409) {
        return UserCreateStatus.duplicateEmail;
      } else if (resp.statusCode == 500) {
        return UserCreateStatus.serverError;
      }
      return UserCreateStatus.failed;
    } catch (e) {
      print(e);
      return UserCreateStatus.failed;
    }
  }
}

enum UserCreateStatus {
  successful,
  unauthorized,
  duplicateEmail,
  serverError,
  failed
}

const String API_TOKEN_HEADER = "apitoken";
const String CONTENT_TYPE_KEY = 'Content-Type';
const String JSON_CONTENT_VALUE = 'application/json; charset=UTF-8';
