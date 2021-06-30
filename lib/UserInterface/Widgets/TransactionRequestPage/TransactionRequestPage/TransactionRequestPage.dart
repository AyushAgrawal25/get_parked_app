import 'package:getparked/StateManagement/Models/TransactionRequestData.dart';
import 'package:getparked/StateManagement/Models/UserData.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:getparked/UserInterface/Widgets/Loaders/LoaderPage.dart';
import 'package:getparked/UserInterface/Widgets/TransactionRequestPage/TransactionRequestActionButtons/PayNowButton.dart';
import 'package:getparked/UserInterface/Widgets/TransactionRequestPage/TransactionRequestActionButtons/RejctectButton.dart';
import 'package:getparked/UserInterface/Widgets/TransactionRequestPage/TransactionRequestActionButtons/TransactionRequestNote.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/StateManagement/Models/UserDetails.dart';
import 'package:getparked/StateManagement/Models/SlotData.dart';
import 'package:provider/provider.dart';
import 'package:getparked/UserInterface/Widgets/AppInfoWidget.dart';
import 'package:getparked/UserInterface/Widgets/SlotInfoWidget.dart';
import 'package:getparked/UserInterface/Widgets/UserInfoWidget.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:getparked/UserInterface/Widgets/TransactionDetailsPage/TransactionDetailsWidgets/TransactionStatusWidget.dart';
import 'package:getparked/UserInterface/Widgets/TransactionDetailsPage/TransactionDetailsWidgets/TransactionAmountWidget.dart';
import 'package:getparked/UserInterface/Widgets/TransactionDetailsPage/TransactionDetailsWidgets/TransactionRefAndDateWidget.dart';

class TransactionRequestPage extends StatefulWidget {
  final TransactionRequestData transactionRequestData;
  final TransactionRequestCardType cardType;
  TransactionRequestPage(
      {@required this.transactionRequestData,
      this.cardType: TransactionRequestCardType.consumer});
  @override
  _TransactionRequestPageState createState() => _TransactionRequestPageState();
}

class _TransactionRequestPageState extends State<TransactionRequestPage> {
  bool isLoading = false;
  AppState gpAppState;
  @override
  void initState() {
    super.initState();
    gpAppState = Provider.of<AppState>(context, listen: false);
  }

  loadHandler(bool status) {
    setState(() {
      isLoading = status;
    });
  }

  int dispAccType = 0;
  SlotData dispSlotData;
  UserDetails dispUserDetails;
  setSenderInfo() {
    if ((widget.transactionRequestData.requesterAccountType ==
            UserAccountType.user) &&
        (widget.transactionRequestData.requestedFromAccountType ==
            UserAccountType.user)) {
      // User To User
      if (widget.transactionRequestData.requesterUserId !=
          gpAppState.userData.id) {
        // From is Not You. disp Data is of fromData
        dispUserDetails = widget.transactionRequestData.requesterUserDetails;
      } else {
        // From is You. disp Data is of WithData
        dispUserDetails =
            widget.transactionRequestData.requestedFromUserDetails;
      }

      dispAccType = 0;
    } else if ((widget.transactionRequestData.requesterAccountType ==
            UserAccountType.user) &&
        (widget.transactionRequestData.requestedFromAccountType ==
            UserAccountType.admin)) {
      // From User With App
      if (widget.transactionRequestData.requesterUserId ==
          gpAppState.userData.id) {
        // From is You. App info for Display
        dispAccType = 2;
      } else {
        // With is You. You are the Admin.
        dispUserDetails = widget.transactionRequestData.requesterUserDetails;
        dispAccType = 0;
      }
    } else if ((widget.transactionRequestData.requesterAccountType ==
            UserAccountType.slot) &&
        (widget.transactionRequestData.requestedFromAccountType ==
            UserAccountType.admin)) {
      // From Slot With App
      if (widget.transactionRequestData.requesterUserId ==
          gpAppState.userData.id) {
        // From is You. App info for Display
        dispAccType = 2;
      } else {
        // With is You. You You are the Admin.
        dispSlotData = widget.transactionRequestData.requesterSlotData;
        dispAccType = 1;
      }
    }
  }

  Widget senderInfoWidget = Container();
  setSenderInfoWidget() {
    setSenderInfo();
    switch (dispAccType) {
      case 0:
        // User Details of From
        senderInfoWidget = Container(
          child: UserInfoWidget(
            userDetails: dispUserDetails,
            type: UserInfoWidgetType.small,
          ),
        );
        break;
      case 1:
        // Slot Data of From
        senderInfoWidget = Container(
          child: SlotInfoWidget(
            slotData: dispSlotData,
            type: SlotInfoWidgetType.small,
          ),
        );
        break;
      case 2:
        // App Data
        senderInfoWidget = Container(
          child: AppInfoWidget(),
        );
        break;
      default:
    }
  }

  Widget statusWidget = Container(
    height: 0,
    width: 0,
  );
  setStatusWidget() {
    String statusText = "Pending";
    IconData statuIcon = FontAwesome.hourglass;
    Color statusColor = qbAppSecondaryGreenColor;
    switch (widget.transactionRequestData.status) {
      case 0:
        statusText = "Pending";
        statusColor = qbAppSecondaryBlueColor;
        statuIcon = FontAwesome5.hourglass_half;
        break;
      case 1:
        if (widget.transactionRequestData.requestedFromAccountType ==
            UserAccountType.user) {
          // For User to User
          statusText = "Paid";
        } else if (widget.transactionRequestData.requestedFromAccountType ==
            UserAccountType.admin) {
          // For User or Slot To App
          statusText = "Withdrawn";
        }
        statusColor = qbAppSecondaryGreenColor;
        statuIcon = FontAwesome5.check_circle;
        break;
      case 2:
        statusText = "Rejected";
        statusColor = qbAppPrimaryRedColor;
        statuIcon = FontAwesome5.times_circle;
        break;
    }

    statusWidget = Container(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: TransactionStatusWidget(
        color: statusColor,
        icon: statuIcon,
        text: statusText,
      ),
    );
  }

  Widget amountWidget = Container(
    height: 0,
    width: 0,
  );
  setAmountWidget() {
    amountWidget = Container(
      child: TransactionAmountWidget(
        amount: widget.transactionRequestData.amount,
      ),
    );
  }

  Widget transactionNoteWidget = Container(
    height: 0,
    width: 0,
  );
  setTransactionNoteWidget() {
    transactionNoteWidget = Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: TransactionRequestNote(note: widget.transactionRequestData.note),
    );
  }

  Widget actionWidget = Container(
    height: 0,
    width: 0,
  );
  setActionWidget() {
    actionWidget = Container(
      height: 0,
      width: 0,
    );

    if ((widget.transactionRequestData.status == 0) &&
        (widget.transactionRequestData.requestedFromUserId ==
            gpAppState.userData.id)) {
      if (widget.transactionRequestData.requestedFromAccountType ==
          UserAccountType.user) {
        // For User To User
        actionWidget = Container(
          padding: EdgeInsets.only(bottom: 20, top: 5),
          width: MediaQuery.of(context).size.width * 0.75,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              PayNowButton(
                  transactionRequestData: widget.transactionRequestData,
                  changeLoadStatus: loadHandler),
              RejectButton(
                  transactionRequestData: widget.transactionRequestData,
                  changeLoadStatus: loadHandler)
            ],
          ),
        );
      } else if (widget.transactionRequestData.requestedFromAccountType ==
          UserAccountType.admin) {
        // For User OR Slot To AppAdmin
        actionWidget = Container(
          child: Text("Action Buttons"),
        );
      }
    }
  }

  Widget refAndDateWidget = Container(
    height: 0,
    width: 0,
  );
  setRefAndDateWidget() {
    refAndDateWidget = Container(
      child: TransactionRefAndDateWidget(
        refCodeORId: widget.transactionRequestData.id.toString(),
        time: widget.transactionRequestData.time,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AppState gpAppStateListen = Provider.of<AppState>(context);
    setSenderInfoWidget();
    setStatusWidget();
    setAmountWidget();
    setTransactionNoteWidget();
    setActionWidget();
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
                    "Transaction Request",
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
                        children: [
                          statusWidget,
                          senderInfoWidget,
                          SizedBox(
                            height: 30,
                          ),
                          amountWidget,
                          SizedBox(
                            height: 30,
                          ),
                          transactionNoteWidget,
                          SizedBox(
                            height: 20,
                          ),
                          actionWidget,
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
                ? Container(child: LoaderPage())
                : Container(
                    height: 0,
                    width: 0,
                  ),
          ],
        ),
      ),
    );
  }
}

enum TransactionRequestCardType { consumer, admin }
