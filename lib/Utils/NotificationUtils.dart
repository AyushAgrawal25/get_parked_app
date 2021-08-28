import 'dart:convert';
import 'dart:io';

import 'package:getparked/Utils/DomainUtils.dart';
import 'package:getparked/UserInterface/Widgets/SideNav/SideNavRoutes.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:sailor/sailor.dart';
import 'package:getparked/UserInterface/Widgets/SideNav/SideNavRoutes.dart';

class NotificationUtils {
  Future<void> init() async {
    // Awe Code
    AwesomeNotifications().initialize(
        // set the icon to null if you want to use the default app icon
        'resource://mipmap/ic_launcher',
        [
          NotificationChannel(
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            channelShowBadge: true,
            enableVibration: true,
            enableLights: true,
            importance: NotificationImportance.Max,
          )
        ]);
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        // Insert here your friendly dialog box before call the request method
        // This is very important to not harm the user experience
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    // Stream Code
    AwesomeNotifications().actionStream.listen((receivedNotification) {
      print("Found Something....");
      SideNavRoutes.sailor.navigate("/Notifications");
    });
  }

  Future<String> downloadAndSaveImage(String url, String fileName) async {
    var directory = await getApplicationDocumentsDirectory();
    var filePath = '${directory.path}/$fileName';
    var response = await http.get(Uri.parse(url));
    var file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  showWithImage() async {
    try {
      bool status = await AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: 15,
              channelKey: "basic_channel",
              title: "Create this one.",
              body: "Create it man.."));
      return status;
    } catch (excp) {
      print(excp);
      return false;
    }
  }

  showWithIconImage(Map<String, dynamic> notificationData) async {
    try {
      bool status = await AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: 45,
              channelKey: "basic_channel",
              title: "Complete this",
              body: "Create for icons and all."));
      return status;
    } catch (excp) {
      print(excp);
      return false;
    }
  }

  Future<void> onSelectNotificationFun(String payload) async {
    SideNavRoutes.sailor.navigate("/Notifications");
  }
}
