import 'package:getparked/UserInterface/Widgets/Loaders/LoaderPage.dart';
import 'package:getparked/UserInterface/Pages/Wallet/AddMoney/AddMoney.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:getparked/UserInterface/Widgets/SuccessAndFailure/SuccessAndFailurePage.dart';

class AddMoneyPage extends StatefulWidget {
  AddMoneyFormType formType;
  double amount;
  Function onTransactionSuccessful;
  AddMoneyPage(
      {@required this.formType, this.amount, this.onTransactionSuccessful});
  @override
  _AddMoneyPageState createState() => _AddMoneyPageState();
}

class _AddMoneyPageState extends State<AddMoneyPage> {
  bool isLoading = false;
  loadHandler(bool status, int transactionStatus) {
    setState(() {
      isLoading = status;
    });

    if (transactionStatus == 1) {
      // Success
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) {
          return SuccessAndFailurePage(
            buttonText: "Continue",
            status: SuccessAndFailureStatus.success,
            onButtonPressed: () {
              if (widget.formType == AddMoneyFormType.withAmount) {
                widget.onTransactionSuccessful();
              }
              Navigator.of(context).pop();
            },
            statusText: "Wallet Transaction",
          );
        },
      ));
    } else if (transactionStatus == 2) {
      // Failure
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) {
          return SuccessAndFailurePage(
            buttonText: "Go Back",
            onButtonPressed: () {
              Navigator.of(context).pop();
            },
            status: SuccessAndFailureStatus.failure,
            statusText: "Wallet Transaction",
          );
        },
      ));
    }
  }

  Widget statusPage = Container(
    height: 0,
    width: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          AddMoneyForm(
            changeLoadStatus: loadHandler,
            formType: widget.formType,
            amount: widget.amount,
          ),
          (isLoading)
              ? LoaderPage()
              : Container(
                  height: 0,
                  width: 0,
                ),
        ],
      ),
    );
  }
}

enum AddMoneyFormType { withAmount, withoutAmount }
