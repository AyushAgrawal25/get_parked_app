import 'package:getparked/BussinessLogic/TransactionServices.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/StateManagement/Models/TransactionRequestData.dart';
import 'package:getparked/UserInterface/Pages/Wallet/RequestMoney/SelectContact/SelectContact.dart';
import 'package:getparked/UserInterface/Pages/Wallet/AddMoney/AddMoneyPage.dart';
import 'package:getparked/UserInterface/Widgets/SuccessAndFailure/SuccessAndFailurePage.dart';
import 'package:getparked/UserInterface/Widgets/qbFAB.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/LowBalancePopUp.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:provider/provider.dart';
import 'package:getparked/UserInterface/Icons/g_p_icons_icons.dart';
import 'package:getparked/UserInterface/Widgets/CustomIcon.dart';
import 'package:getparked/UserInterface/Pages/Wallet/AddMoney/AddMoneyPage.dart';

class PayNowButton extends StatefulWidget {
  TransactionRequestData transactionRequestData;
  Function(bool) changeLoadStatus;
  PayNowButton(
      {@required this.transactionRequestData, @required this.changeLoadStatus});
  @override
  _PayNowButtonState createState() => _PayNowButtonState();
}

class _PayNowButtonState extends State<PayNowButton> {
  AppState gpAppState;
  double amountLeftAfterTransaction = 0.0;
  double amountRequired = 0.0;
  @override
  void initState() {
    super.initState();
    gpAppState = Provider.of<AppState>(context, listen: false);
  }

  initTransaction() async {
    // TODO: Uncomment it when its ready.
    widget.changeLoadStatus(true);
    
    TransactionRequestRespondStatus respondStatus = await TransactionServices()
        .respondMoneyRequest(
            authToken: gpAppState.authToken,
            requestId: widget.transactionRequestData.id,
            respone: 1);

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return SuccessAndFailurePage(
          buttonText: "Continue",
          onButtonPressed: () {
            Navigator.of(context).pop();

            widget.changeLoadStatus(false);
          },
          status: (respondStatus==TransactionRequestRespondStatus.successful)
              ? SuccessAndFailureStatus.success
              : SuccessAndFailureStatus.failure,
          statusText: "Request Acception",
        );
      },
    )).then((value) {
      widget.changeLoadStatus(false);
    });
  }

  onAddMoney() {
    // Navigate to Upi Page
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return AddMoneyPage(
          formType: AddMoneyFormType.withAmount,
          amount: amountRequired,
          onTransactionSuccessful: () async {
            initTransaction();
          },
        );
      },
    ));
  }

  onPaymentRequest() {
    // Navigate to Payment Request Page
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return SelectContact(
          amount: amountRequired,
        );
      },
    ));
  }

  onPayPressed() {
    amountLeftAfterTransaction = gpAppState.walletMoney -
        gpAppState.walletSecurityDeposit -
        widget.transactionRequestData.amount;
    if (amountLeftAfterTransaction < 0.0) {
      // Low Balance Problem.
      amountRequired = (-1) * amountLeftAfterTransaction;
      LowBalancePopUp().show(
          "You need to have atleast ₹ ${amountRequired.toStringAsFixed(2)} in your Wallet for Payment.",
          "Add ${amountRequired.toStringAsFixed(2)} to your Wallet.",
          "Not Enough Balance",
          onAddMoney,
          onPaymentRequest,
          context);
    } else {
      // Proper Balance.
      initTransaction();
    }
  }

  @override
  Widget build(BuildContext context) {
    AppState gpAppStateListen = Provider.of<AppState>(context);
    // return EdgeLessButton(
    //   height: 35,
    //   width: MediaQuery.of(context).size.width * 0.65,
    //   margin: EdgeInsets.only(top: 1.5, bottom: 5),
    //   color: qbAppPrimaryGreenColor,
    //   child: Center(
    //     child: Text(
    //       "Pay Now",
    //       style: GoogleFonts.roboto(
    //           fontSize: 17.5, fontWeight: FontWeight.w500, color: Colors.white),
    //       textScaleFactor: 1.0,
    //       textAlign: TextAlign.center,
    //     ),
    //   ),
    //   onPressed: onPayPressed,
    // );

    return Container(
      child: Column(
        children: [
          QbFAB(
            color: qbAppPrimaryGreenColor,
            child: CustomIcon(
              icon: GPIcons.pay_now2,
              color: qbWhiteBGColor,
              size: 25,
            ),
            onPressed: onPayPressed,
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            child: Text(
              "Pay Now",
              style: GoogleFonts.roboto(
                fontSize: 12.5,
                color: qbAppPrimaryGreenColor,
              ),
              textScaleFactor: 1.0,
            ),
          )
        ],
      ),
    );
  }
}
