import 'package:getparked/UserInterface/Widgets/SideNav/SideNavRoutes.dart';
import 'package:getparked/UserInterface/Widgets/CustomIcon.dart';

import './SideNavTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SideNavItem extends StatefulWidget {
  final String title;
  final IconData icon;
  final Function onPressed;
  String route;
  double iconSize;
  double fontSize;

  SideNavItem(
      {@required this.title,
      @required this.icon,
      this.onPressed,
      this.route,
      this.fontSize,
      this.iconSize});
  @override
  _SideNavItemState createState() => _SideNavItemState();
}

class _SideNavItemState extends State<SideNavItem> {
  @override
  Widget build(BuildContext context) {
    if (widget.fontSize == null) {
      widget.fontSize = 18;
    }
    if (widget.iconSize == null) {
      widget.iconSize = 18;
    }

    return MaterialButton(
      minWidth: 0,
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        height: 28,
        alignment: Alignment.centerLeft,
        child: Row(
          children: <Widget>[
            Container(
                child: CustomIcon(
              icon: widget.icon,
              size: widget.iconSize,
              color: qbNavItemColor,
            )),
            SizedBox(
              width: 40,
            ),
            Container(
              child: Text(
                widget.title,
                style: GoogleFonts.mukta(
                    fontSize: widget.fontSize,
                    color: qbNavItemColor,
                    fontWeight: FontWeight.w500),
                textScaleFactor: 1,
                textAlign: TextAlign.left,
              ),
            )
          ],
        ),
      ),
      onPressed: () {
        SideNavRoutes.sailor.navigate(widget.route);
      },
    );
  }
}
