import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:getparked/BussinessLogic/AuthProvider.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/UserInterface/Pages/Login/LoginPage.dart';
import 'package:getparked/UserInterface/Pages/SplashScreen/SplashScreePage.dart';
import 'package:getparked/UserInterface/Widgets/SideNav/SideNavRoutes.dart';
import 'package:getparked/Utils/DomainUtils.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
