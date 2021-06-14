import 'package:getparked/BussinessLogic/SlotsServices.dart';
import 'package:getparked/BussinessLogic/SlotsUtils.dart';
// import 'package:getparked/BussinessLogic/TransactionUtils.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/StateManagement/Models/ParkingRequestData.dart';
import 'package:getparked/StateManagement/Models/SlotData.dart';
import 'package:getparked/StateManagement/Models/VehicleData.dart';
import 'package:getparked/UserInterface/Widgets/LowBalancePopUp.dart';
import 'package:getparked/UserInterface/Widgets/SuccessAndFailure/SuccessAndFailurePage.dart';
// import 'package:getparked/UserInterface/Pages/Wallet/RequestMoney/SelectContact/SelectContact.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/CustomButton.dart';
import 'package:getparked/UserInterface/Widgets/EdgeLessButton.dart';
import 'package:getparked/UserInterface/Widgets/WrapButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
// import 'package:getparked/UserInterface/Pages/Wallet/AddMoney/AddMoneyPage.dart';

class BookNowButton extends StatefulWidget {
  SlotData slotData;
  ParkingRequestData parkingRequestData;
  VehicleData vehicleData;

  Function(bool) changeLoadStatus;

  BookNowButton(
      {@required this.slotData,
      @required this.parkingRequestData,
      @required this.vehicleData,
      @required this.changeLoadStatus});

  @override
  _BookNowButtonState createState() => _BookNowButtonState();
}

class _BookNowButtonState extends State<BookNowButton> {
  AppState gpAppState;
  double totalSecurityDeposit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    gpAppState = Provider.of(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return EdgeLessButton(
      height: 35,
      width: MediaQuery.of(context).size.width * 0.6,
      margin: EdgeInsets.only(top: 1.5, bottom: 5),
      color: qbAppPrimaryBlueColor,
      child: Center(
        child: Text(
          "Book Now",
          style: GoogleFonts.nunito(
              fontSize: 17.5, fontWeight: FontWeight.w500, color: Colors.white),
          textScaleFactor: 1.0,
          textAlign: TextAlign.center,
        ),
      ),
      onPressed: () async {
        totalSecurityDeposit = widget.vehicleData.fair.toDouble() *
            widget.slotData.securityDepositTime.toDouble();
        print(totalSecurityDeposit);

        // TODO: Uncomment this when wallet is done.
        // if (double.parse((gpAppState.walletMoney -
        //             (gpAppState.walletSecurityDeposit + totalSecurityDeposit))
        //         .toStringAsFixed(2)) >
        //     0) {
        
        // TODO: remove this when wallet is done.
        if (true) {
          //Starting Load
          this.widget.changeLoadStatus(true);

          BookSlotStatus bookStatus = await SlotsServices().bookSlot(
              authToken: gpAppState.authToken,
              parkingRequestId: widget.parkingRequestData.id);

          // TODO: handle low balance and unavailable space if required.

          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return SuccessAndFailurePage(
                buttonText: "Continue",
                onButtonPressed: () {
                  Navigator.of(context).pop();

                  //Stoping Load
                  this.widget.changeLoadStatus(false);
                },
                status: (bookStatus == BookSlotStatus.success)
                    ? SuccessAndFailureStatus.success
                    : SuccessAndFailureStatus.failure,
                statusText: "Booking",
              );
            },
          )).then((value) {
            //Stoping Load
            this.widget.changeLoadStatus(false);
          });
        } else {
          //Showing Add Money Alert Dialog
          showAlertDialog(onAddMoney, onPaymentRequest);
        }
      },
    );
  }

  onAddMoney() async {
    // TODO: Uncomment this.
    // // Navigate to Upi Page
    // Navigator.of(context).push(MaterialPageRoute(
    //   builder: (context) {
    //     return AddMoneyPage(
    //       formType: AddMoneyFormType.withAmount,
    //       amount: double.parse(
    //           ((gpAppState.walletSecurityDeposit + totalSecurityDeposit) -
    //                   gpAppState.walletMoney)
    //               .toStringAsFixed(2)),
    //       onTransactionSuccessful: () async {
    //         print("Transaction Successful");
    //         Map bookingData = {
    //           "userId": gpAppState.userData.id,
    //           "slotId": widget.parkingRequestData.slotId,
    //           "slotParkingRequestId": widget.parkingRequestData.id
    //         };

    //         //Starting Load
    //         this.widget.changeLoadStatus(true);

    //         Map bookingResponse = await SlotsUtils()
    //             .booking(bookingData, gpAppState.userData.accessToken);
    //         print(bookingResponse);

    //         Navigator.of(context).push(MaterialPageRoute(
    //           builder: (context) {
    //             return SuccessAndFailurePage(
    //               buttonText: "Continue",
    //               onButtonPressed: () {
    //                 Navigator.of(context).pop();

    //                 //Stoping Load
    //                 this.widget.changeLoadStatus(false);
    //               },
    //               status: (bookingResponse["bookingStatus"] == 1)
    //                   ? SuccessAndFailureStatus.success
    //                   : SuccessAndFailureStatus.failure,
    //               statusText: "Booking",
    //             );
    //           },
    //         )).then((value) {
    //           //Stoping Load
    //           this.widget.changeLoadStatus(false);
    //         });
    //       },
    //     );
    //   },
    // ));
  }

  onPaymentRequest() async {
    // TODO: Uncomment this.
    // Navigate to Payment Request Page
    // Navigator.of(context).push(MaterialPageRoute(
    //   builder: (context) {
    //     return SelectContact(
    //       amount: double.parse(
    //           ((gpAppState.walletSecurityDeposit + totalSecurityDeposit) -
    //                   gpAppState.walletMoney)
    //               .toStringAsFixed(2)),
    //     );
    //   },
    // ));
  }

  showAlertDialog(
      Function onAddMoneySelect, Function onPaymentRequestSelect) async {
    LowBalancePopUp().show(
        "You need to have atleast Parking Charges of ${widget.slotData.securityDepositTime} hours for parking in this slot. So you need to have atleast $totalSecurityDeposit in your wallet before proceeding.",
        "Add ${((gpAppState.walletSecurityDeposit + totalSecurityDeposit) - gpAppState.walletMoney).toStringAsFixed(2)} to your Wallet.",
        "Not Enough Balance",
        onAddMoneySelect,
        onPaymentRequestSelect,
        context);
  }
}
