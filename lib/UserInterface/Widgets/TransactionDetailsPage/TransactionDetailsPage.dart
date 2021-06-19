import 'dart:math';

import 'package:getparked/StateManagement/Models/AppOverlayStyleData.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/StateManagement/Models/SlotData.dart';
import 'package:getparked/StateManagement/Models/TransactionData.dart';
import 'package:getparked/StateManagement/Models/UserData.dart';
import 'package:getparked/UserInterface/Widgets/Loaders/LoaderPage.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/AppInfoWidget.dart';
import 'package:getparked/UserInterface/Widgets/SlotInfoWidget.dart';
import 'package:getparked/UserInterface/Widgets/SlotNameWidget.dart';
import 'package:getparked/UserInterface/Widgets/UserInfoWidget.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:getparked/Utils/DateTimeUtils.dart';
import 'package:getparked/UserInterface/Icons/g_p_icons_icons.dart';
import 'package:getparked/UserInterface/Widgets/CustomIcon.dart';
import 'package:getparked/UserInterface/Widgets/TransactionDetailsPage/TransactionDetailsWidgets/TransactionStatusWidget.dart';
import 'package:getparked/UserInterface/Widgets/TransactionDetailsPage/TransactionDetailsWidgets/TransactionAmountWidget.dart';
import 'package:getparked/UserInterface/Widgets/TransactionDetailsPage/TransactionDetailsWidgets/TransactionRefAndDateWidget.dart';
import 'package:getparked/UserInterface/Widgets/TransactionDetailsPage/TransactionDetailsWidgets/MoneyTransferTypeWidget.dart';

class TransactionDetailsPage extends StatefulWidget {
  TransactionData transactionData;
  TransactionDetailsPage({@required this.transactionData});
  @override
  _TransactionDetailsPageState createState() => _TransactionDetailsPageState();
}

class _TransactionDetailsPageState extends State<TransactionDetailsPage> {
  AppState gpAppState;
  bool isLoading = false;

  loadHandler(loadingStatus) {
    setState(() {
      isLoading = loadingStatus;
    });
  }

  @override
  void initState() {
    super.initState();

    gpAppState = Provider.of<AppState>(context, listen: false);
  }

  Widget withInfoWidget = Container();
  setWithInfoWidget() {
    switch (widget.transactionData.withAccountType) {
      case UserAccountType.user:
        {
          if (widget.transactionData.type == TransactionDataType.real) {
            // Real
            withInfoWidget = Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Container(
                      child: CustomIcon(
                        icon: GPIcons.wallet,
                        size: 80,
                        color: qbAppTextColor,
                      ),
                    ),
                  ),
                  Container(
                    child: SlotNameWidget(
                      slotName: "Wallet Transaction",
                      fontSize: 20,
                    ),
                  )
                ],
              ),
            );
          } else {
            // Non Real
            withInfoWidget = Container(
              child: UserInfoWidget(
                type: UserInfoWidgetType.small,
                userDetails: widget.transactionData.withUserDetails,
              ),
            );
          }
          break;
        }
      case UserAccountType.slot:
        {
          if (widget.transactionData.type == TransactionDataType.real) {
            // Real
            withInfoWidget = Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Icon(
                      FontAwesome.bank,
                      size: 80,
                      color: qbAppTextColor,
                    ),
                  ),
                  Container(
                    child: SlotNameWidget(
                      slotName: "Vault Transaction",
                      fontSize: 20,
                    ),
                  )
                ],
              ),
            );
          } else {
            // Non Real
            SlotData withSlotData = widget.transactionData.withSlotData;
            withSlotData.userDetails = widget.transactionData.withUserDetails;
            withInfoWidget = Container(
                child: SlotInfoWidget(
              type: SlotInfoWidgetType.small,
              slotData: widget.transactionData.withSlotData,
            ));
          }
          break;
        }
      case UserAccountType.admin:
        withInfoWidget = Container(
          child: AppInfoWidget(),
        );
        break;
    }
  }

  Widget moneyTranferType = Container();
  setMoneyTranferType() {
    moneyTranferType = Container(
      child: MoneyTransferTypeWidget(
        moneyTransferType: widget.transactionData.transferType,
        status: isSuccess,
      ),
    );
  }

  bool isSuccess = false;
  Widget statusWidget = Container();
  setStatusWidget() {
    String statusText = "Wrong";
    Color statusColor = qbAppTextColor;
    IconData statusIcon = FontAwesome.anchor;
    switch (widget.transactionData.getTransactionStatus()) {
      case TransactionStatus.pending:
        statusText = "Pending";
        statusColor = qbAppSecondaryBlueColor;
        statusIcon = FontAwesome5.hourglass_half;
        break;
      case TransactionStatus.failed:
        statusText = "Failed";
        statusColor = qbAppPrimaryRedColor;
        statusIcon = FontAwesome5.exclamation_triangle;
        break;
      case TransactionStatus.successful:
        statusText = "Successful";
        statusColor = qbAppSecondaryGreenColor;
        statusIcon = FontAwesome5.check_circle;
        isSuccess = true;
        break;
    }

    statusWidget = Container(
      child: TransactionStatusWidget(
        text: statusText,
        color: statusColor,
        icon: statusIcon,
      ),
    );
  }

  Widget amountWidget = Container();
  setAmountWidget() {
    amountWidget = Container(
      child: TransactionAmountWidget(
        amount: widget.transactionData.amount,
      ),
    );
  }

  Widget refAndDateWidget = Container();
  setRefAndDateWidget() {
    refAndDateWidget = Container(
      padding: EdgeInsets.symmetric(vertical: 12.5, horizontal: 20),
      child: TransactionRefAndDateWidget(
        refCodeORId: widget.transactionData.refCode,
        time: widget.transactionData.time,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    setWithInfoWidget();
    setStatusWidget();
    setMoneyTranferType();
    setAmountWidget();
    setRefAndDateWidget();
    return Container(
      color: qbWhiteBGColor,
      child: SafeArea(
        top: false,
        maintainBottomViewPadding: true,
        child: Stack(
          children: [
            Container(
              child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    "Transaction Detail",
                    style: GoogleFonts.nunito(
                        color: qbAppTextColor, fontWeight: FontWeight.w600),
                    textScaleFactor: 1.0,
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  iconTheme: IconThemeData(color: qbAppTextColor),
                  brightness: Brightness.light,
                ),
                body: Container(
                  child: SingleChildScrollView(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          statusWidget,
                          SizedBox(
                            height: 30,
                          ),
                          withInfoWidget,
                          SizedBox(
                            height: 30,
                          ),
                          moneyTranferType,
                          amountWidget,
                          SizedBox(
                            height: 40,
                          ),
                          Divider(
                            height: 30,
                            color: qbDividerLightColor,
                            thickness: 1,
                          ),
                          refAndDateWidget,
                          Divider(
                            height: 30,
                            color: qbDividerLightColor,
                            thickness: 1,
                          ),
                          SizedBox(
                            height: 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            (isLoading)
                ? Container(
                    child: LoaderPage(),
                  )
                : Container(
                    height: 0,
                    width: 0,
                  ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
