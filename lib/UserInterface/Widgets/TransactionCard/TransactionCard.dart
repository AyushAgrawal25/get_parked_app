import 'dart:math';

import 'package:getparked/StateManagement/Models/TransactionData.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/TransactionCard/TransactionStatusAndTime.dart';
import 'package:getparked/UserInterface/Widgets/TransactionCard/TransactionWithDetails.dart';
// import 'package:getparked/UserInterface/Widgets/TransactionDetailsPage/TransactionDetailsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TransactionCard extends StatefulWidget {
  TransactionData transactionData;

  TransactionCard({@required this.transactionData});
  @override
  _TransactionCardState createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        SystemSound.play(SystemSoundType.click);
        // TODO: create this page and uncomment this.
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) {
        //     return TransactionDetailsPage(
        //         transactionData: widget.transactionData);
        //   },
        // ));
      },
      child: Container(
        // // Old Deco
        // margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
        // decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(5),
        //     boxShadow: [
        //       BoxShadow(
        //           spreadRadius: 0.025,
        //           blurRadius: 5,
        //           offset: Offset(4, 4),
        //           color: Color.fromRGBO(0, 0, 0, 0.04)),
        //     ],
        //     color: Color.fromRGBO(255, 255, 255, 1),
        //     border: Border.all(
        //       width: 2,
        //       color: Color.fromRGBO(238, 238, 238, 1),
        //     )),
        // // Old Deco End

        // New Deco
        margin: EdgeInsets.symmetric(horizontal: 12.5, vertical: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.5),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 0.025,
                  blurRadius: 5,
                  offset: Offset(10, 5),
                  color: Color.fromRGBO(0, 0, 0, 0.04)),
            ],
            color: qbWhiteBGColor),
        // New Deco End

        padding: EdgeInsets.fromLTRB(20, 15, 20, 10),
        child: Column(
          children: [
            TransactionWithDetails(
              accountType: widget.transactionData.accountType,
              withAccountType:
                  widget.transactionData.transactionWithAccountType,
              moneyTransferType: widget.transactionData.moneyTransferType,
              slotData: widget.transactionData.withSlotData,
              amount: widget.transactionData.amount,
              transactionType: widget.transactionData.type,
              userDetails: widget.transactionData.withUserDetails,
            ),
            TransactionStatusAndTime(
              transactionTime: widget.transactionData.time,
              transactionStatus: widget.transactionData.status,
            )
          ],
        ),
      ),
    );
  }
}
