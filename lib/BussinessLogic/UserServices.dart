import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart' as dio;
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/StateManagement/Models/UserData.dart';
import 'package:getparked/StateManagement/Models/UserDetails.dart';
import 'package:getparked/Utils/JSONUtils.dart';
import 'package:getparked/Utils/SecureStorageUtils.dart';
import 'package:http/http.dart' as http;
import 'package:getparked/Utils/DomainUtils.dart';
import 'package:provider/provider.dart';

const String USER_ROUTE = "/app/users";
const String PROFILE_PICS_ROUTE = "/images/profilePics";

class UserServices {
  // TODO: get user data from it.
  Future getUser(
      {@required String authToken, @required BuildContext context}) async {
    try {
      AppState appState = Provider.of<AppState>(context, listen: false);
      http.Response resp = await http.get(
          Uri.parse(domainName + USER_ROUTE + "/getUser"),
          headers: {AUTH_TOKEN: authToken});

      // print(resp.body);
      if (resp.statusCode == 200) {
        Map<String, dynamic> respMap = json.decode(resp.body);
        String refreshToken = respMap[REFRESH_TOKEN];
        appState.setAuthToken(refreshToken);
        // print(respMap);

        UserData userData = UserData.fromMap(respMap["user"]);
        if (userData.signUpStatus == 0) {
          return UserGetStatus.notSignedUp;
        }
        UserDetails userDetails =
            UserDetails.fromMap(respMap["user"]["userDetails"]);

        if (userData != null) {
          SecureStorageUtils().setAuthToken(authToken);
          appState.setUserDetails(userDetails);
          appState.setUserData(userData);
          return UserGetStatus.successful;
        }
        return UserGetStatus.failed;
      } else if (resp.statusCode == 403) {
        return UserGetStatus.invalidToken;
      } else if (resp.statusCode == 404) {
        return UserGetStatus.notFound;
      } else if (resp.statusCode == 500) {
        return UserGetStatus.internalServerError;
      }

      return UserGetStatus.failed;
    } catch (e) {
      print(e);

      return UserGetStatus.failed;
    }
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

  Future<String> verifyPhoneNumber(
      {@required String phNum, @required String authToken}) async {
    try {
      var rng = Random();
      String otp = "";

      for (int i = 0; i < 4; i++) {
        int num = rng.nextInt(8);
        num++;
        otp = otp + num.toString();
      }
      Map<String, dynamic> reqBody = {"otp": otp, "phoneNumber": phNum};
      Uri url = Uri.parse(domainName + USER_ROUTE + "/phoneNumberVerification");

      http.Response resp = await http.post(url,
          body: JSONUtils().postBody(reqBody),
          headers: <String, String>{
            AUTH_TOKEN: authToken,
            CONTENT_TYPE_KEY: JSON_CONTENT_VALUE,
          });

      // print(resp.body);
      if (resp.statusCode == 200) {
        return otp;
      }
      return null;
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<UserDetailsUploadStatus> uploadUserDetails(
      {@required String authToken,
      @required String firstName,
      @required String lastName,
      @required String notificationToken,
      @required String dialCode,
      @required String gender,
      @required String phoneNumber}) async {
    try {
      Map<String, dynamic> reqBody = {
        "firstName": firstName,
        "lastName": lastName,
        "dialCode": dialCode,
        "phoneNumber": phoneNumber,
        "gender": gender,
        "fcmToken": notificationToken
      };
      Uri url = Uri.parse(domainName + USER_ROUTE + "/addUserDetails");
      http.Response resp = await http.post(url,
          body: JSONUtils().postBody(reqBody),
          headers: <String, String>{
            AUTH_TOKEN: authToken,
            CONTENT_TYPE_KEY: JSON_CONTENT_VALUE,
          });
      // print(resp.body);
      if (resp.statusCode == 200) {
        return UserDetailsUploadStatus.successful;
      } else if (resp.statusCode == 403) {
        return UserDetailsUploadStatus.invalidToken;
      } else if (resp.statusCode == 500) {
        return UserDetailsUploadStatus.serverError;
      }

      return UserDetailsUploadStatus.failed;
    } catch (e) {
      print(e);
      return UserDetailsUploadStatus.failed;
    }
  }

  Future<UploadProfilePicStatus> uploadProfilePic(
      {@required File profilePic, @required String authToken}) async {
    try {
      Uri url = Uri.parse(domainName + PROFILE_PICS_ROUTE + "/upload");
      http.MultipartRequest postReq = http.MultipartRequest('POST', url);

      postReq.headers[AUTH_TOKEN] = authToken;
      postReq.files.add(http.MultipartFile(
          'image', profilePic.readAsBytes().asStream(), profilePic.lengthSync(),
          filename: profilePic.path.split("/").last));

      http.StreamedResponse resp = await postReq.send();
      if (resp.statusCode == 200) {
        return UploadProfilePicStatus.successful;
      } else if (resp.statusCode == 400) {
        return UploadProfilePicStatus.userDetailsNotFound;
      } else if (resp.statusCode == 403) {
        return UploadProfilePicStatus.invalidToken;
      }
      if (resp.statusCode == 500) {
        return UploadProfilePicStatus.internalServerError;
      }
      return UploadProfilePicStatus.failed;
    } catch (excp) {
      print(excp);
      return UploadProfilePicStatus.failed;
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
enum UserDetailsUploadStatus { successful, invalidToken, serverError, failed }

enum UserGetStatus {
  successful,
  notSignedUp,
  notFound,
  invalidToken,
  internalServerError,
  failed
}

enum UploadProfilePicStatus {
  successful,
  userDetailsNotFound,
  invalidToken,
  internalServerError,
  failed
}

const String API_TOKEN_HEADER = "apitoken";
const String CONTENT_TYPE_KEY = 'Content-Type';
const String JSON_CONTENT_VALUE = 'application/json; charset=UTF-8';
