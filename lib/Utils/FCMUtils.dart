import 'package:getparked/Utils/NotificationUtils.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FCMUtils {
  FirebaseMessaging gpFirebaseMessaging = FirebaseMessaging.instance;

  NotificationUtils gpNotificationUtils;
  AppState gpAppState;

  Future<dynamic> onLaunch(Map<String, dynamic> data) async {
    gpNotificationUtils.onSelectNotificationFun(data.toString());
  }

  Future<dynamic> onMessage(Map<String, dynamic> data) async {
    print("Called On Message..");

    gpNotificationUtils.showWithIconImage(data);
  }

  Future<dynamic> onResume(Map<String, dynamic> data) async {
    gpNotificationUtils.onSelectNotificationFun(data.toString());
  }

  static Future<dynamic> onBackgroundMessage(Map<String, dynamic> data) async {
    print(data);
    print("From background..");
  }

  Future<String> getToken() async {
    String gpFCMToken = await gpFirebaseMessaging.getToken();
    return gpFCMToken;
  }
}
