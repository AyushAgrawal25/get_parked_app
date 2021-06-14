import 'package:flutter/material.dart';
import 'package:getparked/BussinessLogic/SlotsServices.dart';
import 'package:getparked/StateManagement/Models/ParkingRequestData.dart';
import 'package:getparked/BussinessLogic/SlotsUtils.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/StateManagement/Models/ParkingLordData.dart';
import 'package:getparked/UserInterface/WIdgets/SuccessAndFailure/SuccessAndFailurePage.dart';
import 'package:getparked/UserInterface/Widgets/EdgeLessButton.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';

class ParkingRequestAcceptButton extends StatefulWidget {
  ParkingRequestData parkingRequestData;
  Function(bool) changeLoadStatus;

  ParkingRequestAcceptButton(
      {@required this.parkingRequestData, @required this.changeLoadStatus});

  @override
  _ParkingRequestAcceptButtonState createState() =>
      _ParkingRequestAcceptButtonState();
}

class _ParkingRequestAcceptButtonState
    extends State<ParkingRequestAcceptButton> {
  @override
  Widget build(BuildContext context) {
    return EdgeLessButton(
      height: 35,
      width: MediaQuery.of(context).size.width * 0.6,
      margin: EdgeInsets.only(top: 1.5, bottom: 5),
      color: qbAppPrimaryGreenColor,
      child: Center(
        child: Text(
          "Accept",
          style: GoogleFonts.nunito(
              fontSize: 17.5, fontWeight: FontWeight.w500, color: Colors.white),
          textScaleFactor: 1.0,
          textAlign: TextAlign.center,
        ),
      ),
      onPressed: () async {
        AppState gpAppState = Provider.of<AppState>(context, listen: false);

        widget.changeLoadStatus(true);
        bool respondStatus = false;
        ParkingRequestRespondStatus reqeustRespondStatus = await SlotsServices()
            .respondParkingRequest(
                authToken: gpAppState.authToken,
                parkingRequestId: widget.parkingRequestData.id,
                response: 1);
        if (reqeustRespondStatus == ParkingRequestRespondStatus.success) {
          respondStatus = true;
        }
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return SuccessAndFailurePage(
              buttonText: "Continue",
              onButtonPressed: () {
                Navigator.of(context).pop();
                widget.changeLoadStatus(false);
              },
              status: (respondStatus)
                  ? SuccessAndFailureStatus.success
                  : SuccessAndFailureStatus.failure,
              statusText: "Parking Response Acceptance",
            );
          },
        )).then((value) {
          widget.changeLoadStatus(false);
        });
      },
    );
  }
}
