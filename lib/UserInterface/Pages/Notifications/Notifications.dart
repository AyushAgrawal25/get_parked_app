import 'package:getparked/StateManagement/Models/AppOverlayStyleData.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/StateManagement/Models/NotificationData.dart';
import 'package:getparked/UserInterface/Pages/Notifications/NotificationCard/NotificationCard.dart';
import 'package:getparked/UserInterface/Widgets/Loaders/LoaderPage.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  void initState() {
    super.initState();

    gpAppState = Provider.of<AppState>(context, listen: false);
  }

  AppState gpAppState;
  @override
  Widget build(BuildContext context) {
    AppState gpAppStateListen = Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(
              FontAwesome.bell,
              size: 20,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Notifications",
              style: GoogleFonts.nunito(
                  color: Colors.white, fontWeight: FontWeight.w500),
              textScaleFactor: 1.0,
            ),
          ],
        ),
        brightness: Brightness.dark,
        backgroundColor: qbAppPrimaryThemeColor,
      ),
      body: Stack(
        children: [
          Container(
            child: LoaderPage(),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              color: Color.fromRGBO(250, 250, 250, 1),
              child: Scrollbar(
                radius: Radius.elliptical(2.5, 15),
                child: Container(
                    child: ListView(
                  children:
                      gpAppStateListen.notifications.map((gpNotificationData) {
                    return NotificationCard(
                      notificationData: gpNotificationData,
                    );
                  }).toList(),
                )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
