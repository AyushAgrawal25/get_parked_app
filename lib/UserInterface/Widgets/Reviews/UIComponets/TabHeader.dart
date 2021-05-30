import 'package:getparked/UserInterface/Icons/g_p_icons_icons.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/CustomIcon.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TabHeader extends StatelessWidget {
  IconData icon;
  String name;
  TabHeader({
    @required this.icon,
    @required this.name,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomIcon(
            size: 14.5,
            type: CustomIconType.onHeight,
            icon: this.icon,
            color: qbAppTextColor,
          ),
          SizedBox(
            height: 2.5,
          ),
          Text(
            this.name,
            style: GoogleFonts.nunito(
                fontSize: 11,
                color: qbAppTextColor,
                fontWeight: FontWeight.w600),
            textScaleFactor: 1.0,
          )
        ],
      ),
    );
  }
}
