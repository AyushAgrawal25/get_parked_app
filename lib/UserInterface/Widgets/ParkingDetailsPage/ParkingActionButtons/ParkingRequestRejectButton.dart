import 'package:getparked/BussinessLogic/SlotsServices.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/StateManagement/Models/ParkingLordData.dart';
import 'package:getparked/StateManagement/Models/ParkingRequestData.dart';
import 'package:getparked/UserInterface/Widgets/SuccessAndFailure/SuccessAndFailurePage.dart';
import 'package:getparked/UserInterface/Widgets/EdgeLessButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';

class ParkingRequestRejectButton extends StatefulWidget {
  ParkingRequestData parkingRequestData;

  Function(bool) changeLoadStatus;

  ParkingRequestRejectButton(
      {@required this.parkingRequestData, @required this.changeLoadStatus});

  @override
  _ParkingRequestRejectButtonState createState() =>
      _ParkingRequestRejectButtonState();
}

class _ParkingRequestRejectButtonState
    extends State<ParkingRequestRejectButton> {
  @override
  Widget build(BuildContext context) {
    return EdgeLessButton(
      height: 35,
      width: MediaQuery.of(context).size.width * 0.6,
      margin: EdgeInsets.only(top: 1.5, bottom: 5),
      color: qbAppPrimaryRedColor,
      child: Center(
        child: Text(
          "Reject",
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
                response: 2);
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
              statusText: "Parking Request Rejection",
            );
          },
        )).then((value) {
          widget.changeLoadStatus(false);
        });
      },
    );
  }
}
