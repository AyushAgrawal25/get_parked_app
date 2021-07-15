import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getparked/BussinessLogic/AuthProvider.dart';
import 'package:getparked/UserInterface/Pages/SplashScreen/SplashScreenPage.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/Loaders/LoaderPage.dart';
import 'package:getparked/UserInterface/Widgets/SettingCard.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            child: SafeArea(
              top: false,
              maintainBottomViewPadding: true,
              child: Container(
                child: Scaffold(
                  appBar: AppBar(
                    title: Row(
                      children: [
                        Icon(FontAwesomeIcons.slidersH, size: 20),
                        SizedBox(
                          width: 12.5,
                        ),
                        Text(
                          "Settings",
                          style:
                              GoogleFonts.nunito(fontWeight: FontWeight.w500),
                          textScaleFactor: 1.0,
                        ),
                      ],
                    ),
                    brightness: Brightness.dark,
                    elevation: 0.0,
                    backgroundColor: qbAppPrimaryThemeColor,
                  ),
                  body: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    child: Column(
                      children: [
                        SettingCard(
                          child: Text(
                            "Sign Out",
                            style: GoogleFonts.roboto(
                                color: qbAppTextColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 17.5),
                            textScaleFactor: 1.0,
                          ),
                          icon: FontAwesomeIcons.signOutAlt,
                          onPressed: onSignOutPressed,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          (isLoading) ? LoaderPage() : Container()
        ],
      ),
    );
  }

  onSignOutPressed() async {
    setState(() {
      isLoading = true;
    });

    await AuthProvider().signOut();
    Navigator.of(context).popUntil((route) {
      return route.isFirst;
    });
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) {
        return SplashScreenPage();
      },
    ));
  }
}
