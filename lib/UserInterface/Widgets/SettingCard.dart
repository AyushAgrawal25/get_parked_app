import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:flutter/material.dart';

class SettingCard extends StatelessWidget {
  Widget child;
  SettingCard({@required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.symmetric(vertical: 10), child: this.child),
          // Divider
          // Divider(
          //   height: 15,
          //   thickness: 1.5,
          //   color: qbDividerDarkColor,
          // )
        ],
      ),
    );
  }
}
