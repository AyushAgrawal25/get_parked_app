import 'package:flutter/material.dart';
import 'package:getparked/BussinessLogic/AuthProvider.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/UserInterface/Icons/g_p_icons_icons.dart';
import 'package:getparked/UserInterface/Pages/Home/HomePage.dart';
import 'package:getparked/UserInterface/Pages/Login/LoginDetailsForm.dart';
import 'package:getparked/UserInterface/Pages/Login/LoginPage.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/CustomIcon.dart';
import 'package:getparked/Utils/DomainUtils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    initApp();
  }

  initApp() async {
    InitAppStatus initAppStatus =
        await AuthProvider().initApp(context: context);
    print(initAppStatus);

    AppState appState = Provider.of<AppState>(context, listen: false);
    switch (initAppStatus) {
      case InitAppStatus.loggedIn:
        // TODO: send to home page.
        print("Sending to Home Page...");
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return HomePage();
          },
        ));
        break;
      case InitAppStatus.notSignedUp:
        // Sending to login details form.
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) {
            return LoginDetailsForm(
                userData: appState.userData, authToken: appState.authToken);
          },
        ));
        break;
      case InitAppStatus.notLoggedIn:
        // Sending to login page.
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) {
            return LoginPage();
          },
        ));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Container(
              child: CustomIcon(
                icon: GPIcons.get_parked_logo,
                size: 120,
                color: qbAppPrimaryThemeColor,
              ),
            ),

            SizedBox(
              height: 20,
            ),

            // AppName
            Container(
              padding: EdgeInsets.only(right: 10),
              child: Text(
                appName,
                style: GoogleFonts.josefinSans(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: qbAppPrimaryThemeColor),
                textScaleFactor: 1.0,
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.125,
            ),

            // Loader
            Container(
              child: CircularProgressIndicator(),
            )
          ],
        ),
      )),
    );
  }
}
