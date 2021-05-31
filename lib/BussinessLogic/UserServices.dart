import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart' as dio;
import 'package:getparked/Utils/DomainUtils.dart';

class UserServices {
  Future getUser({@required String authToken, @required String email}) async {}

  Future<bool> isEmailRegistered({@required String email}) async {
    try {
      dio.Response resp =
          await dio.Dio().get(domainName + "/app/users/checkEmail/$email");
      // print(resp.data);
      if (resp.statusCode == 200) {
        return false;
      }
      return true;
    } catch (e) {
      print(e);
      return true;
    }
  }

  Future<String> login(
      {@required String email, @required String userToken}) async {
    try {
      dio.Response resp = await dio.Dio().post(domainName + "/app/users/login",
          data: {"email": email, "userToken": userToken});

      // print(resp.data);
      if (resp.statusCode == 200) {
        return resp.data["authToken"];
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
      dio.Response resp = await dio.Dio().post(domainName + "/app/users/create",
          data: {"email": email, "userToken": userToken}, options: dio.Options(
              //  TODO: change with the correct api toke getter
              headers: {"apitoken": universalAPIToken}));
      // print(resp.data);
      if (resp.statusCode == 200) {
        return UserCreateStatus.successful;
      } else if (resp.statusCode == 401) {
        return UserCreateStatus.unauthorized;
      } else if (resp.statusCode == 409) {
        return UserCreateStatus.duplicateEmail;
      } else {
        return UserCreateStatus.serverError;
      }
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
