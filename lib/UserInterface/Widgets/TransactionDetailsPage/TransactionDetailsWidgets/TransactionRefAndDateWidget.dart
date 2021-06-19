import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/Utils/DateTimeUtils.dart';
import 'package:getparked/UserInterface/Widgets/ExtraDetailsKeyValue.dart';

class TransactionRefAndDateWidget extends StatelessWidget {
  String refCodeORId;
  String time;
  TransactionRefAndDateWidget(
      {@required this.refCodeORId, @required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ExtraDetailKey(keyText: "Ref Id"),
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
                ExtraDetailValue(valueText: this.refCodeORId),
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
