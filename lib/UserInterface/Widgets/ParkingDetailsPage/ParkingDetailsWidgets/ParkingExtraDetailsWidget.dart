import 'package:getparked/Utils/DateTimeUtils.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:getparked/UserInterface/Widgets/ExtraDetailsKeyValue.dart';

class ParkingExtraDetailsWidget extends StatelessWidget {
  String time;
  String idText;
  String id;
  ParkingExtraDetailsWidget(
      {@required this.id, @required this.time, @required this.idText});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Keys
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ExtraDetailKey(keyText: "${this.idText}"),
                ExtraDetailKey(keyText: "Date"),
                ExtraDetailKey(keyText: "Time")
              ],
            ),
          ),

          SizedBox(
            width: 5,
          ),

          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ExtraDetailKey(keyText: " : "),
                ExtraDetailKey(keyText: " : "),
                ExtraDetailKey(keyText: " : ")
              ],
            ),
          ),

          SizedBox(
            width: 5,
          ),

          // Values
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ExtraDetailValue(valueText: this.id.toString()),
                ExtraDetailValue(
                    valueText: DateTimeUtils.dateIn12MonthsFormat(this.time)),
                ExtraDetailValue(
                    valueText: DateTimeUtils.timeIn12HoursFormat(this.time))
              ],
            ),
          )
        ],
      ),
    );
  }
}
