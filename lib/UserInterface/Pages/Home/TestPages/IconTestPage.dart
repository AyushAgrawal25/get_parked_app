import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/IconShadowWidget.dart';
import 'package:flutter/material.dart';
import 'package:getparked/UserInterface/Widgets/CustomIcon.dart';
import 'package:getparked/UserInterface/Icons/g_p_icons_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';

class IconTestPage extends StatefulWidget {
  @override
  _IconTestPageState createState() => _IconTestPageState();
}

class _IconTestPageState extends State<IconTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: Container(
              height: MediaQuery.of(context).size.width * 0.25,
              width: MediaQuery.of(context).size.width * 0.25,
              // color: Colors.red,
              child: IconShadowWidget(
                icon: GPIcons.pay_now2,
                size: MediaQuery.of(context).size.width * 0.25,
                color: qbAppTextColor,
                iconShadow: IconShadow(
                    blurRadius: 10,
                    color: qbAppTextColor,
                    offset: Offset(5, 5),
                    spreadRadius: 1),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            child: IconShadowWidget(
              icon: FontAwesome.pencil,
              size: 125,
              iconShadow: IconShadow(
                  blurRadius: 10, spreadRadius: 1, offset: Offset(5, 5)),
            ),
          )
        ],
      ),
    );
  }
}
