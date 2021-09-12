import 'dart:math';

import 'package:getparked/BussinessLogic/TransactionServices.dart';
import 'package:getparked/StateManagement/Models/AppOverlayStyleData.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Theme/AppOverlayStyle.dart';
import 'package:getparked/UserInterface/Widgets/SuccessAndFailure/SuccessAndFailurePage.dart';
import 'package:getparked/UserInterface/Widgets/UPIRoundIcon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:getparked/UserInterface/Widgets/qbFAB.dart';
import 'package:getparked/Utils/DomainUtils.dart';
import 'package:getparked/Utils/TransactionUtils.dart';
import 'package:getparked/encryptionConfig.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:getparked/UserInterface/Icons/g_p_icons_icons.dart';
import 'package:getparked/UserInterface/Widgets/CustomIcon.dart';
import 'package:getparked/UserInterface/Pages/Wallet/AddMoney/AddMoneyPage.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

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

    initRazorpay();
  }

  Razorpay razorpay;
  initRazorpay() {
    razorpay = Razorpay();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, onTransactionSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, onTransactionError);
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
                  )
                ],
              ),
            ),
          ),
          floatingActionButton: QbFAB(
            color: qbAppPrimaryThemeColor,
            child: Container(
                child: CustomIcon(
              icon: GPIcons.pay_now2,
              size: 27.5,
              color: qbWhiteBGColor,
            )),
            onPressed: initiateTransaction,
          ),
        ),
      ),
    );
  }

  String txnCode;

  initiateTransaction() async {
    if ((gpAmount != null) && (gpAmount != "")) {
      widget.changeLoadStatus(true, 0);
      txnCode = await TransactionServices().getAddMoneyToWalletCode(
          authToken: gpAppState.authToken, amount: double.parse(gpAmount));

      Map<String, dynamic> txnInitData =
          TransactionUtils().getEncryptedData(txnCode);
      Map<String, dynamic> razorpayOptions = {
        'key': RAZORPAY_API_ID,
        'amount': txnInitData["amount"],
        'name': appName,
        'description': 'Add Money to Wallet',
        'order_id': txnInitData["orderId"],
        'timeout': 300,
        'prefill': {
          'contact': gpAppState.userDetails.phoneNumber,
          'email': gpAppState.userData.email
        }
      };

      razorpay.open(razorpayOptions);
    }
  }

  onTransactionSuccess(PaymentSuccessResponse response) async {
    AddMoneyToWallStatus addMoneyToWallStatus = await TransactionServices()
        .addMoneyToWallet(
            authToken: gpAppState.authToken,
            paymentId: response.paymentId,
            signature: response.signature,
            txnCode: txnCode,
            status: 1,
            amount: double.parse(gpAmount));

    if (addMoneyToWallStatus == AddMoneyToWallStatus.successful) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return SuccessAndFailurePage(
            statusText: "Transaction",
            buttonText: "Continue",
            status: SuccessAndFailureStatus.success,
            onButtonPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
          );
        },
      ));
    } else {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return SuccessAndFailurePage(
            statusText: "Transaction",
            buttonText: "Continue",
            status: SuccessAndFailureStatus.failure,
            onButtonPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
          );
        },
      ));
    }
  }

  onTransactionError(PaymentFailureResponse response) async {
    print(response.code);
    AddMoneyToWallStatus addMoneyToWallStatus = await TransactionServices()
        .addMoneyToWallet(
            authToken: gpAppState.authToken,
            paymentId: null,
            signature: null,
            txnCode: txnCode,
            status: 2,
            amount: double.parse(gpAmount));
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return SuccessAndFailurePage(
          statusText: "Transaction",
          buttonText: "Continue",
          status: SuccessAndFailureStatus.failure,
          onButtonPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        );
      },
    ));
  }

  @override
  void dispose() {
    if (razorpay != null) {
      razorpay.clear();
    }
    super.dispose();
  }
}
