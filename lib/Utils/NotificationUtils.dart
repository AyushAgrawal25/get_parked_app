import 'dart:convert';
import 'dart:io';

import 'package:getparked/Utils/DomainUtils.dart';
import 'package:getparked/UserInterface/Widgets/SideNav/SideNavRoutes.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_notifications/awesome_notifications.dart';

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
    });
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
    // print(notificationData["data"]);
    // var androidImage;
    // if (notificationData["data"]["iconImage"] != null) {
    //   var largeIconPath = await downloadAndSaveImage(
    //       formatImgUrl(notificationData["data"]["iconImage"]), 'largeIcon');
    //   androidImage = new AndroidNotificationDetails(
    //     'get_parked-notify',
    //     'Message notifications',
    //     'WHY THIS CHANNEL..',
    //     importance: Importance.Max,
    //     priority: Priority.High,
    //     ticker: 'ticker',
    //     largeIcon: largeIconPath,
    //     largeIconBitmapSource: BitmapSource.FilePath,
    //   );
    // } else if (notificationData["data"]["imageUrl"] != null) {
    //   var largeIconPath = await downloadAndSaveImage(
    //       formatImgUrl(notificationData["data"]["imageUrl"]), 'largeIcon');
    //   androidImage = new AndroidNotificationDetails(
    //     'get_parked-notify',
    //     'Message notifications',
    //     'WHY THIS CHANNEL..',
    //     importance: Importance.Max,
    //     priority: Priority.High,
    //     ticker: 'ticker',
    //     largeIcon: largeIconPath,
    //     largeIconBitmapSource: BitmapSource.FilePath,
    //   );
    // } else {
    //   androidImage = new AndroidNotificationDetails(
    //     'get_parked-notify',
    //     'Message notifications',
    //     'WHY THIS CHANNEL..',
    //     importance: Importance.Max,
    //     priority: Priority.High,
    //     ticker: 'ticker',
    //   );
    // }

    // var iOSImage = new IOSNotificationDetails();

    // var imagePlatform = new NotificationDetails(androidImage, iOSImage);

    // await gpFlutterLocalNotificationsPlugin.show(
    //     0,
    //     notificationData["notification"]["title"],
    //     notificationData["notification"]["body"],
    //     imagePlatform,
    //     payload: json.encode(notificationData["data"]).toString());

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

  showPerson(Map<String, dynamic> notificationData) async {
    // var largeIconPath = await downloadAndSaveImage(
    //     formatImgUrl(notificationData["data"]["userProfilePicUrl"]),
    //     'largeIcon');

    // Person person = Person(
    //     name: notificationData["notification"]["title"],
    //     key: '1',
    //     icon: largeIconPath,
    //     iconSource: IconSource.FilePath);

    // var messagingStyle = MessagingStyleInformation(person,
    //     conversationTitle: 'Team lunch',
    //     htmlFormatContent: true,
    //     htmlFormatTitle: true,
    //     messages: <Message>[
    //       Message(notificationData["notification"]["body"],
    //           DateTime.now().toLocal(), person)
    //     ]);

    // var androidImage = new AndroidNotificationDetails(
    //     'get_parked-notify', 'Message notifications', 'WHY THIS CHANNEL..',
    //     importance: Importance.Max,
    //     priority: Priority.High,
    //     ticker: 'ticker',
    //     style: AndroidNotificationStyle.Messaging,
    //     styleInformation: messagingStyle);

    // var iOSImage = new IOSNotificationDetails();

    // var imagePlatform = new NotificationDetails(androidImage, iOSImage);

    // await gpFlutterLocalNotificationsPlugin.show(
    //   0,
    //   "Normal Show",
    //   "body",
    //   imagePlatform,
    // );

    try {
      bool status = await AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: 45,
              channelKey: "basic_channel",
              title: "Complete this",
              body: "Create for Persons"));
      return status;
    } catch (excp) {
      print(excp);
      return false;
    }
  }

  show(String title) async {
    try {
      bool status = await AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: 45, channelKey: "basic_channel", title: title));
      return status;
    } catch (excp) {
      print(excp);
      return false;
    }
  }

  Future<String> downloadAndSaveImage(String url, String fileName) async {
    var directory = await getApplicationDocumentsDirectory();
    var filePath = '${directory.path}/$fileName';
    var response = await http.get(Uri.parse(url));
    var file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  Future<void> onSelectNotificationFun(String payload) async {
    Map<String, dynamic> notificationData = json.decode(payload);
    SideNavRoutes.sailor.navigate('/Notifications');

    if (notificationData["notificationType"] == "parkingRequest") {
      this.onParkingRequestSelect(notificationData);
    }
  }

  onParkingRequestSelect(Map<String, dynamic> notificationData) {
    //Set All notifications
  }
}
