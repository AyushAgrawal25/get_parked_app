import 'package:getparked/Utils/ContactUtils.dart';
// import 'package:getparked/UserInterface/Widgets/ParkingDetailsPage/ParkingDetailsWidgets/ParkingDetailsWidget.dart';
import 'package:getparked/UserInterface/Widgets/qbFAB.dart';
// import 'package:getparked/UserInterface/Widgets/ParkingDetailsPage/ParkingDetailsWidgets/ParkingDurationWidget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:getparked/BussinessLogic/AuthProvider.dart';
import 'package:getparked/UserInterface/Widgets/PhoneNumberWidget/PhoneNumberWidget.dart';
import 'package:getparked/UserInterface/Widgets/OutlineTextFormField.dart';

class CallTestPage extends StatefulWidget {
  @override
  _CallTestPageState createState() => _CallTestPageState();
}

class _CallTestPageState extends State<CallTestPage> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phone Number"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            // ParkingDetailsWidget(
            //   charges: 12.5,
            //   parkingHours: 5,
            //   spaceType: 1,
            // ),
            // SizedBox(
            //   height: 40,
            // ),
            // ParkingDurationWidget(
            //   bookingTime: "2020-12-13 23:00:00",
            //   bookingDuration: -1,
            // ),
            SizedBox(
              height: 40,
            ),
            Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: PhoneNumberWidget(
                  onChange: (dc, phNum) {
                    print(dc + " " + phNum);
                  },
                )),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: OutlineTextFormField(
                labelText: "Phone Number",
              ),
            )
          ],
        ),
      ),
    );
  }
}
