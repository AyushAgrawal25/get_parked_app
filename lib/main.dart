import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:getparked/BussinessLogic/AuthProvider.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/UserInterface/Pages/Login/LoginPage.dart';
import 'package:getparked/UserInterface/Pages/SplashScreen/SplashScreenPage.dart';
import 'package:getparked/UserInterface/Widgets/SideNav/SideNavRoutes.dart';
import 'package:getparked/Utils/DomainUtils.dart';
import 'package:getparked/Utils/NotificationUtils.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

// Firebase BG Services
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await NotificationUtils().init();
  FirebaseMessaging.onMessage.listen((RemoteMessage _message) {
    // For Sending Notification at time of app running foreground
    // Do check once.
    AwesomeNotifications().createNotificationFromJsonData(_message.data);
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  SideNavRoutes.createRoutes();
  runApp(ChangeNotifierProvider(
    create: (_) {
      return AppState();
    },
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreenPage(),
      onGenerateRoute: SideNavRoutes.sailor.generator(),
      navigatorKey: SideNavRoutes.sailor.navigatorKey,
    );
  }
}
