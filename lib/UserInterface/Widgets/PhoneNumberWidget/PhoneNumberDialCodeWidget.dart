import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';

class PhoneNumberDialCodeWidget extends StatelessWidget {
  String dialCode;
  String flagUrl;
  bool isReadOnly;
  Function onPressed;
  PhoneNumberDialCodeWidget(
      {@required this.dialCode,
      @required this.flagUrl,
      this.onPressed,
      this.isReadOnly: false});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          SystemSound.play(SystemSoundType.click);
          if ((this.onPressed != null) && (!this.isReadOnly)) {
            this.onPressed();
          }
        },
        child: Container(
          color: Colors.transparent,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Flag
              Container(
                height: 15,
                width: 22.5,
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Container(
                        height: 7.5,
                        width: 7.5,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                        ),
                      ),
                    ),
                    Container(
                      height: 15,
                      width: 22.5,
                      child: SvgPicture.network(
                        this.flagUrl,
                        height: 17.5,
                        width: 17.5,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                width: 5,
              ),

              // Dial Code
              Container(
                child: Text(
                  "+ " + this.dialCode,
                  style: GoogleFonts.roboto(
                      fontSize: 12.5,
                      color: qbAppTextColor,
                      fontWeight: FontWeight.w500),
                  textScaleFactor: 1.0,
                ),
              ),

              // Drop Down Arrow
              Container(
                child: Icon(
                  FontAwesome.angle_down,
                  size: 15,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
