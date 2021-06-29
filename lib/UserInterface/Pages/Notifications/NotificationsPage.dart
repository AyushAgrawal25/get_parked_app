import 'package:getparked/UserInterface/Pages/Notifications/Notifications.dart';
import 'package:getparked/UserInterface/Widgets/Loaders/LoaderPage.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool isLoading = false;

  loadHandler(loadingStatus) {
    setState(() {
      isLoading = loadingStatus;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Notifications(),
          (isLoading)
              ? LoaderPage()
              : Container(
                  height: 0,
                  width: 0,
                )
        ],
      ),
    );
  }
}
