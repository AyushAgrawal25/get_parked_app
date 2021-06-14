import 'dart:async';

import 'package:getparked/UserInterface/Widgets/FormFieldHeader.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:getparked/UserInterface/Icons/g_p_icons_icons.dart';
import 'package:getparked/UserInterface/Widgets/ParkingDetailsPage/ParkingDetailsWidgets/ParkingDetailsTheme.dart';

class ParkingDurationWidget extends StatefulWidget {
  String bookingTime;
  int bookingDuration;
  ParkingDurationWidget(
      {@required this.bookingTime, @required this.bookingDuration});
  @override
  _ParkingDurationWidgetState createState() => _ParkingDurationWidgetState();
}

class _ParkingDurationWidgetState extends State<ParkingDurationWidget> {
  Timer timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    timer = Timer.periodic(const Duration(minutes: 1), (_timer) {
      setState(() {});
    });
  }

  Color qbHeadColor = Color.fromRGBO(175, 175, 175, 1);
  Color qbBodyColor = Color.fromRGBO(60, 60, 60, 1);

  @override
  Widget build(BuildContext context) {
    int diffInMin = -1;
    if ((widget.bookingDuration != -1) && (widget.bookingDuration != null)) {
      diffInMin = widget.bookingDuration;
    } else if ((widget.bookingTime != "") && (widget.bookingTime != null)) {
      int timeDiffInMin = DateTime.now()
          .toLocal()
          .difference(DateTime.parse(widget.bookingTime).toLocal())
          .inMinutes;

      diffInMin = timeDiffInMin;
    }

    if (diffInMin == -1) {
      return Container(
        height: 0,
        width: 0,
      );
    } else {
      EdgeInsets textPadding = EdgeInsets.symmetric(horizontal: 1.5);
      double verticalPadding = 12.5;
      double bookingDurationTextSize = 11;

      return Container(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: verticalPadding),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: qbDividerLightColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5)),
                padding: EdgeInsets.only(
                    top: verticalPadding, bottom: verticalPadding),
                child: Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Clock
                      Container(
                        child: Icon(
                          GPIcons.stopwatch_outlined,
                          color: qbBodyColor,
                          size: 25,
                        ),
                      ),

                      SizedBox(
                        width: 5,
                      ),

                      // Hours
                      Container(
                          padding: textPadding,
                          child: Text(
                            "${(diffInMin ~/ 60).toInt()}",
                            style: GoogleFonts.cabin(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: qbBodyColor),
                            textScaleFactor: 1.0,
                          )),
                      Container(
                        padding: textPadding,
                        child: Text("hours",
                            style: GoogleFonts.cabin(
                                fontSize: 12.5,
                                height: 2,
                                fontWeight: FontWeight.w600,
                                color: qbBodyColor),
                            textScaleFactor: 1.0),
                      ),

                      SizedBox(
                        width: 2.5,
                      ),

                      // Minutes
                      Container(
                          padding: textPadding,
                          child: Text("${(diffInMin % 60).toInt()}",
                              style: GoogleFonts.cabin(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: qbBodyColor),
                              textScaleFactor: 1.0)),
                      Container(
                        padding: textPadding,
                        child: Text("minutes",
                            style: GoogleFonts.cabin(
                                fontSize: 12.5,
                                height: 2,
                                fontWeight: FontWeight.w600,
                                color: qbBodyColor),
                            textScaleFactor: 1.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                color: qbWhiteBGColor,
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                margin: EdgeInsets.only(
                    left: 15,
                    right: 15,
                    top:
                        (verticalPadding - 2.5 - (bookingDurationTextSize / 2)),
                    bottom: (verticalPadding - (bookingDurationTextSize / 2))),
                // child: FormFieldHeader(
                //   headerText: "Booking Duration",
                //   fontSize: bookingDurationTextSize,
                //   color: qbHeadColor,
                // ),

                child: Container(
                    child: Text(
                  "Booking Duration",
                  style: GoogleFonts.poppins(
                      fontSize: bookingDurationTextSize,
                      fontWeight: FontWeight.w500,
                      color: qbHeadColor),
                  textAlign: TextAlign.left,
                  textScaleFactor: 1.0,
                )),
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
  }
}
