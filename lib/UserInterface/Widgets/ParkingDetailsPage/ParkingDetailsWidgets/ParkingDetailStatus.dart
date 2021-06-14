import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:getparked/UserInterface/Widgets/ParkingDetailsPage/ParkingDetailsWidgets/ParkingDetailsTheme.dart';

class ParkingDetailStatus extends StatelessWidget {
  String title;
  Color color;
  String status;
  IconData icon;
  ParkingDetailStatus({
    @required this.color,
    @required this.icon,
    @required this.status,
    @required this.title,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(vertical: 25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: Text(title,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: qbHeadColor,
                    fontSize: 16),
                textScaleFactor: 1.0,
                textAlign: TextAlign.center),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon
                Container(
                  child: Icon(
                    icon,
                    size: 25,
                    color: color,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),

                // Status Text
                Container(
                  child: Text(status,
                      style: GoogleFonts.nunito(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: color),
                      textScaleFactor: 1.0,
                      textAlign: TextAlign.center),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
