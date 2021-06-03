import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageUtils {
  Future<String> getAuthToken() async {
    try {
      String token = await FlutterSecureStorage().read(key: AUTH_TOKEN);
      return token;
    } catch (excp) {
      print(excp);
      return null;
    }
  }

  Future<void> setAuthToken(String authToken) async {
    try {
      await FlutterSecureStorage().write(key: AUTH_TOKEN, value: authToken);
    } catch (excp) {
      print(excp);
      return;
    }
  }

  Future<void> deleteAuthToken(String authToken) async {
    try {
      await FlutterSecureStorage().delete(key: AUTH_TOKEN);
    } catch (excp) {
      print(excp);
      return;
    }
  }
}

const String AUTH_TOKEN = "authorization";
const String REFRESH_TOKEN = "refreshToken";
