import 'package:getparked/Utils/DomainUtils.dart';
import 'package:getparked/UserInterface/Icons/g_p_icons_icons.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/CustomIcon.dart';
import 'package:getparked/UserInterface/Widgets/SlotNameWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppInfoWidget extends StatefulWidget {
  @override
  _AppInfoWidgetState createState() => _AppInfoWidgetState();
}

class _AppInfoWidgetState extends State<AppInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          // App Image
          Container(
            alignment: Alignment.center,
            child: CustomIcon(
              icon: GPIcons.get_parked_logo,
              color: qbAppPrimaryThemeColor,
              size: 120,
            ),
          ),

          // App Name

          Container(
            padding: EdgeInsets.only(right: 10),
            child: Text(
              appName,
              style: GoogleFonts.josefinSans(
                  fontSize: 35,
                  fontWeight: FontWeight.w700,
                  color: qbAppPrimaryThemeColor),
              textScaleFactor: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}
