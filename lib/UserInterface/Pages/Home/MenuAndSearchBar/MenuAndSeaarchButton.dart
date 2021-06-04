import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuAndSearchButton extends StatefulWidget {
  Function onMenuPressed;
  Function onSearchPressed;

  MenuAndSearchButton(
      {@required this.onMenuPressed, @required this.onSearchPressed});
  @override
  _MenuAndSearchButtonState createState() => _MenuAndSearchButtonState();
}

class _MenuAndSearchButtonState extends State<MenuAndSearchButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        width: MediaQuery.of(context).size.width - 30,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: new BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                blurRadius: 5,
                spreadRadius: 0.25,
                offset: Offset(2, 2),
              )
            ],
            color: Colors.white,
            border:
                Border.all(color: Color.fromRGBO(230, 230, 230, 1), width: 1),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: [
            //Menu Button
            GestureDetector(
              child: Container(
                color: Colors.transparent,
                padding: EdgeInsets.symmetric(vertical: 7.5, horizontal: 15),
                child: Icon(
                  Entypo.menu,
                  size: 25,
                  color: qbAppTextColor,
                ),
              ),
              onTap: () async {
                SystemSound.play(SystemSoundType.click);
                widget.onMenuPressed();
              },
            ),

            Expanded(
              child: GestureDetector(
                child: Container(
                  color: Colors.transparent,
                  height: 42,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Search nearby your destination.",
                    style: GoogleFonts.montserrat(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w400,
                        color: qbAppTextColor,
                        decoration: TextDecoration.none),
                    textScaleFactor: 1.0,
                  ),
                ),
                onTap: () async {
                  SystemSound.play(SystemSoundType.click);
                  widget.onSearchPressed();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
