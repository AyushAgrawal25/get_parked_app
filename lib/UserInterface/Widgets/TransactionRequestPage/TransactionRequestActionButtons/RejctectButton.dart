import 'package:getparked/BussinessLogic/TransactionServices.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/StateManagement/Models/TransactionRequestData.dart';
import 'package:getparked/UserInterface/Widgets/EdgeLessButton.dart';
import 'package:getparked/UserInterface/Widgets/SuccessAndFailure/SuccessAndFailurePage.dart';
import 'package:getparked/UserInterface/Widgets/qbFAB.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RejectButton extends StatefulWidget {
  TransactionRequestData transactionRequestData;
  Function(bool) changeLoadStatus;
  RejectButton(
      {@required this.transactionRequestData, @required this.changeLoadStatus});
  @override
  _RejectButtonState createState() => _RejectButtonState();
}

class _RejectButtonState extends State<RejectButton> {
  AppState gpAppState;
  @override
  void initState() {
    super.initState();
    gpAppState = Provider.of<AppState>(context, listen: false);
  }

  rejectRequest() async {
    // TODO: Uncomment it when its ready.
    AppState gpAppState = Provider.of<AppState>(context, listen: false);

    widget.changeLoadStatus(true);

    TransactionRequestRespondStatus respondStatus = await TransactionServices()
        .respondMoneyRequest(
            authToken: gpAppState.authToken,
            requestId: widget.transactionRequestData.id,
            respone: 2);

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return SuccessAndFailurePage(
          buttonText: "Continue",
          onButtonPressed: () {
            Navigator.of(context).pop();

            widget.changeLoadStatus(false);
          },
          status: (respondStatus == TransactionRequestRespondStatus.successful)
              ? SuccessAndFailureStatus.success
              : SuccessAndFailureStatus.failure,
          statusText: "Request Rejection",
        );
      },
    )).then((value) {
      widget.changeLoadStatus(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    // return EdgeLessButton(
    //   height: 35,
    //   width: MediaQuery.of(context).size.width * 0.65,
    //   margin: EdgeInsets.only(top: 1.5, bottom: 5),
    //   color: qbAppPrimaryRedColor,
    //   child: Center(
    //     child: Text(
    //       "Cancel",
    //       style: GoogleFonts.roboto(
    //           fontSize: 17.5, fontWeight: FontWeight.w500, color: Colors.white),
    //       textScaleFactor: 1.0,
    //       textAlign: TextAlign.center,
    //     ),
    //   ),
    //   onPressed: rejectRequest,
    // );

    return Container(
      child: Column(
        children: [
          QbFAB(
            color: qbAppPrimaryRedColor,
            child: Icon(
              FontAwesome5.times,
              color: Colors.white,
            ),
            onPressed: rejectRequest,
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            child: Text(
              "Reject",
              style: GoogleFonts.roboto(
                fontSize: 12.5,
                color: qbAppPrimaryRedColor,
              ),
              textScaleFactor: 1.0,
            ),
          )
        ],
      ),
    );
  }
}
