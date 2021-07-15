import 'package:flutter/services.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:flutter/material.dart';

class SettingCard extends StatelessWidget {
  final IconData icon;
  final Widget child;
  final Function onPressed;
  SettingCard({@required this.child, @required this.icon, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (this.onPressed != null) {
          SystemSound.play(SystemSoundType.click);
          this.onPressed();
        }
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 18.5, horizontal: 10),
              child: Row(
                children: [
                  // Icon
                  Container(
                    width: 50,
                    child: Icon(
                      this.icon,
                      color: qbAppPrimaryThemeColor,
                      size: 25,
                    ),
                  ),

                  SizedBox(width: 10),

                  Container(
                    child: this.child,
                  ),
                ],
              ),
            ),
            Divider(
              color: qbDividerLightColor,
              thickness: 1.5,
              height: 2.5,
            ),
          ],
        ),
      ),
    );
  }
}
