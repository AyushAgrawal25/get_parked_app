import 'package:getparked/BussinessLogic/SlotsUtils.dart';
// import 'package:getparked/BussinessLogic/TransactionUtils.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/StateManagement/Models/BookingData.dart';
import 'package:getparked/StateManagement/Models/SlotData.dart';
import 'package:getparked/UserInterface/Widgets/SuccessAndFailure/SuccessAndFailurePage.dart';
// import 'package:getparked/UserInterface/Pages/Wallet/RequestMoney/SelectContact/SelectContact.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/CustomButton.dart';
import 'package:getparked/UserInterface/Widgets/EdgeLessButton.dart';
import 'package:getparked/UserInterface/Widgets/WrapButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CancelBookingButton extends StatefulWidget {
  BookingData bookingData;
  SlotData slotData;

  Function(bool) changeLoadStatus;

  CancelBookingButton(
      {@required this.bookingData,
      @required this.slotData,
      @required this.changeLoadStatus});

  @override
  _CancelBookingButtonState createState() => _CancelBookingButtonState();
}

class _CancelBookingButtonState extends State<CancelBookingButton> {
  AppState gpAppState;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    gpAppState = Provider.of<AppState>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return EdgeLessButton(
      height: 35,
      width: MediaQuery.of(context).size.width * 0.6,
      margin: EdgeInsets.only(top: 1.5, bottom: 5),
      color: qbAppPrimaryRedColor,
      child: Center(
        child: Text(
          "Cancel Booking",
          style: GoogleFonts.nunito(
              fontSize: 17.5, fontWeight: FontWeight.w500, color: Colors.white),
          textScaleFactor: 1.0,
          textAlign: TextAlign.center,
        ),
      ),
      onPressed: () async {
        // TODO: Uncomment this.
        // int duration = DateTime.now()
        //     .toLocal()
        //     .difference(DateTime.parse(widget.bookingData.time).toLocal())
        //     .inMinutes;
        // int exceedDuration = 0;
        // int endTime = widget.slotData.endTime;
        // // print("End Time : " + endTime.toString());

        // if ((DateTime.now().toLocal().hour > endTime) ||
        //     ((DateTime.now().toLocal().hour == endTime) &&
        //         (DateTime.now().toLocal().minute > 0))) {
        //   print("Time Exceed");

        //   // Setting Up Date
        //   String day = "";
        //   if (DateTime.now().toLocal().day > 9) {
        //     day = DateTime.parse(widget.bookingData.time)
        //         .toLocal()
        //         .day
        //         .toString();
        //   } else {
        //     day = "0" +
        //         DateTime.parse(widget.bookingData.time)
        //             .toLocal()
        //             .day
        //             .toString();
        //   }

        //   String month = "";
        //   if (DateTime.now().toLocal().month > 9) {
        //     month = DateTime.parse(widget.bookingData.time)
        //         .toLocal()
        //         .month
        //         .toString();
        //   } else {
        //     month = "0" +
        //         DateTime.parse(widget.bookingData.time)
        //             .toLocal()
        //             .month
        //             .toString();
        //   }

        //   String year =
        //       DateTime.parse(widget.bookingData.time).toLocal().year.toString();

        //   String hour = "";
        //   if (endTime > 9) {
        //     hour = endTime.toString();
        //   } else {
        //     hour = "0" + endTime.toString();
        //   }

        //   exceedDuration = DateTime.now()
        //       .toLocal()
        //       .difference(
        //           DateTime.parse("$year-$month-$day $hour:00:00").toLocal())
        //       .inMinutes;
        // }

        // Map bookingCancellationData = {
        //   "userId": gpAppState.userData.id,
        //   "slotBookingId": widget.bookingData.id,
        //   "duration": duration + 1,
        //   "exceedDuration": exceedDuration
        // };

        // // print(bookingCancellationData);

        // this.widget.changeLoadStatus(true);

        // Map bookingCancellationResp = await SlotsUtils().bookingCancellation(
        //     bookingCancellationData, gpAppState.userData.accessToken);
        // print(bookingCancellationResp);

        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) {
        //     return SuccessAndFailurePage(
        //       buttonText: "Go Back",
        //       onButtonPressed: () {
        //         Navigator.of(context).pop();

        //         this.widget.changeLoadStatus(false);
        //       },
        //       status: (bookingCancellationResp["status"] == 1)
        //           ? SuccessAndFailureStatus.success
        //           : SuccessAndFailureStatus.failure,
        //       statusText: "Booking Cancellation",
        //     );
        //   },
        // )).then((value) {
        //   this.widget.changeLoadStatus(false);
        // });
      },
    );
  }
}
