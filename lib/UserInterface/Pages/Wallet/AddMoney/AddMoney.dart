import 'dart:math';

import 'package:getparked/StateManagement/Models/AppOverlayStyleData.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Theme/AppOverlayStyle.dart';
import 'package:getparked/UserInterface/Widgets/UPIRoundIcon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:getparked/UserInterface/Icons/g_p_icons_icons.dart';
import 'package:getparked/UserInterface/Widgets/CustomIcon.dart';
import 'package:getparked/UserInterface/Pages/Wallet/AddMoney/AddMoneyPage.dart';
import 'package:upi_pay/upi_pay.dart';

class AddMoneyForm extends StatefulWidget {
  Function(bool, int) changeLoadStatus;
  double amount;
  AddMoneyFormType formType;

  AddMoneyForm(
      {@required this.changeLoadStatus, this.amount, @required this.formType});

  @override
  _AddMoneyFormWithAmountState createState() => _AddMoneyFormWithAmountState();
}

class _AddMoneyFormWithAmountState extends State<AddMoneyForm> {
  AppState gpAppState;

  List<UPIAppRoundWidget> upiAppList = [];

  initiateUPI() async {
    var appList = await UpiPay.getInstalledUpiApplications();
    appList.forEach((app) {
      upiAppList.add(UPIAppRoundWidget(
        payFun: (UpiApplication upiApplication) {
          initiateUPIPayment(upiApplication, widget);
        },
        upiApplication: app.upiApplication,
      ));
    });

    setState(() {});
  }

  initiateUPIPayment(UpiApplication upiApplication, widget) async {
    // print(gpAmount);

    // //Transaction Reference
    // String txnRef =
    //     await TransactionUtils().getTxnRefCode(gpAppState.userData.accessToken);

    // var ran = new Random();
    // if (txnRef == null) {
    //   txnRef = "txn1";
    //   for (int i = 0; i < 10; i++) {
    //     txnRef += ran.nextInt(9).toString();
    //   }
    // }

    // if ((gpAmount != null) && (gpAmount != "")) {
    //   widget.changeLoadStatus(true, 0);

    //   // UpiTransactionResponse upiTransactionResponse =
    //   //     await UpiPay.initiateTransaction(
    //   //   app: upiApplication,
    //   //   receiverUpiAddress: 'agrawal.ayush2500@okaxis',
    //   //   receiverName: 'Ayush Agrawal',
    //   //   transactionRef: txnRef,
    //   //   amount: double.parse(gpAmount).toStringAsFixed(2),
    //   //   merchantCode: '7372',
    //   //   transactionNote: 'Transaction With Get Parked',
    //   // );

    //   UpiTransactionResponse upiTransactionResponse =
    //       await UpiPay.initiateTransaction(
    //     app: upiApplication,
    //     receiverUpiAddress: '9329718444@okbizaxis',
    //     receiverName: 'Qpd Web Solutions',
    //     transactionRef: txnRef,
    //     amount: gpAmount,
    //     merchantCode: '7372',
    //     transactionNote: 'Transaction With Get Parked',
    //   );

    //   int transactionStatus = 0;
    //   switch (upiTransactionResponse.status) {
    //     case UpiTransactionStatus.success:
    //       transactionStatus = 1;
    //       break;

    //     case UpiTransactionStatus.failure:
    //       transactionStatus = 2;
    //       break;

    //     default:
    //   }

    //   Map transactionData = {
    //     "userId": gpAppState.userData.id,
    //     "accountType": 0,
    //     "amount": double.parse(double.parse(gpAmount).toStringAsFixed(2)),
    //     "ref": txnRef,
    //     "refId": upiTransactionResponse.txnId,
    //     "moneyTransferType": 1,
    //     "status": transactionStatus
    //   };

    //   Map resp = await TransactionUtils()
    //       .addMoneyToWallet(transactionData, gpAppState.userData.accessToken);
    //   print(resp);

    //   widget.changeLoadStatus(true, transactionStatus);
    // }
  }

  // Amount
  String gpAmount = "";
  TextEditingController gpAmountController;

  @override
  void initState() {
    super.initState();

    gpAppState = Provider.of<AppState>(context, listen: false);

    gpAmountController = TextEditingController();
    if ((widget.amount != null) &&
        (widget.formType == AddMoneyFormType.withAmount)) {
      gpAmountController.text = widget.amount.toStringAsFixed(2);
      gpAmount = widget.amount.toStringAsFixed(2);
    } else {
      gpAmountController.text = "";
      gpAmount = "";
    }

    initiateUPI();
  }

  @override
  Widget build(BuildContext context) {
    double textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Container(
      child: SafeArea(
        top: false,
        maintainBottomViewPadding: true,
        child: Scaffold(
          appBar: AppBar(
            title: Container(
              child: Row(
                children: [
                  CustomIcon(
                    icon: GPIcons.add_money,
                    size: 20,
                    color: qbAppTextColor,
                  ),
                  SizedBox(
                    width: 12.5,
                  ),
                  Container(
                    child: Text(
                      "Add Money",
                      style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w600, color: qbAppTextColor),
                      textScaleFactor: 1.0,
                    ),
                  )
                ],
              ),
            ),
            brightness: Brightness.light,
            iconTheme: IconThemeData(color: qbAppTextColor),
            elevation: 0.0,
            backgroundColor: Colors.transparent,
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
              height: 700,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: Text(
                      "Add Money to your Wallet",
                      style: GoogleFonts.nunito(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: qbAppTextColor),
                      textScaleFactor: 1.0,
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: Row(
                      children: [
                        Container(
                          child: Text(
                            "Current Balance : ",
                            style: GoogleFonts.roboto(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: qbDetailDarkColor),
                            textScaleFactor: 1.0,
                          ),
                        ),
                        Container(
                          child: Text(
                            "₹ ${gpAppState.walletMoney.toStringAsFixed(2)} /-",
                            style: GoogleFonts.mukta(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: qbDetailDarkColor),
                            textScaleFactor: 1.0,
                          ),
                        )
                      ],
                    ),
                  ),

                  //Text Field
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    margin: EdgeInsets.only(bottom: 5),
                    child: TextField(
                      controller: gpAmountController,
                      onChanged: (value) {
                        String allNum = "0123456789.";
                        String amount = "";
                        for (int i = 0; i < value.length; i++) {
                          if (allNum.contains(value[i])) {
                            amount += value[i];
                          }
                        }
                        setState(() {
                          gpAmount = amount;
                        });
                      },
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      readOnly: (widget.amount != null) ? true : false,
                      autofocus: (widget.amount != null) ? false : true,
                      style: GoogleFonts.mukta(
                          fontSize: 17.5 / textScaleFactor,
                          fontWeight: FontWeight.w500,
                          color: qbAppTextColor),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: qbAppTextColor),
                              gapPadding: 4),
                          prefix: Container(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Icon(
                              FontAwesome5.rupee_sign,
                              color: qbAppTextColor,
                              size: 15,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 22.5),
                          filled: ((widget.amount != null) &&
                              (widget.formType == AddMoneyFormType.withAmount)),
                          fillColor: ((widget.amount != null) &&
                                  (widget.formType ==
                                      AddMoneyFormType.withAmount))
                              ? Color.fromRGBO(235, 235, 235, 1)
                              : qbWhiteBGColor,
                          labelText: "Amount",
                          labelStyle: GoogleFonts.roboto(
                              fontSize: 17.5,
                              fontWeight: FontWeight.w500,
                              color: qbAppTextColor),
                          errorText: ((gpAmount == null) || (gpAmount == ""))
                              ? "Enter Amount to proceed."
                              : null,
                          errorStyle: GoogleFonts.roboto(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w400,
                              color: qbAppSecondaryRedColor),
                          isDense: true),
                    ),
                  ),

                  //A Simple Note
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            alignment: Alignment.topCenter,
                            child: Text(
                              "#",
                              style: GoogleFonts.roboto(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: qbDetailLightColor),
                              textScaleFactor: 1.0,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Text(
                                "This Amount in your Wallet will never expire",
                                style: GoogleFonts.roboto(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: qbDetailLightColor),
                                textScaleFactor: 1.0,
                              ),
                            ),
                          ),
                        ],
                      )),

                  //A Simple Note
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            alignment: Alignment.topCenter,
                            child: Text(
                              "#",
                              style: GoogleFonts.roboto(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: qbDetailLightColor),
                              textScaleFactor: 1.0,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Text(
                                "You cannot withdraw this amount but can be used for any of our services.",
                                style: GoogleFonts.roboto(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: qbDetailLightColor),
                                textScaleFactor: 1.0,
                              ),
                            ),
                          ),
                        ],
                      )),

                  SizedBox(
                    height: 15,
                  ),

                  //UPI Apps
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Divider(
                              color: qbDetailLightColor,
                              thickness: 1,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 7.5),
                          child: Text(
                            "Select UPI Apps",
                            style: GoogleFonts.roboto(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w500,
                                color: qbAppTextColor),
                            textScaleFactor: 1.0,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Divider(
                              color: qbDetailLightColor,
                              thickness: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Upi Apps
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      children: upiAppList,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
