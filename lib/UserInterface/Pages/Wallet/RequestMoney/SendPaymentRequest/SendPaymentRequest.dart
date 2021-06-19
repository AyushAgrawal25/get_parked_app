import 'package:getparked/StateManagement/Models/AppOverlayStyleData.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/StateManagement/Models/ContactData.dart';
import 'package:getparked/UserInterface/Widgets/DisplayPicture.dart';
import 'package:getparked/UserInterface/Widgets/EdgeLessButton.dart';
import 'package:getparked/UserInterface/Widgets/ErrorPopUp.dart';
import 'package:getparked/UserInterface/Widgets/Loaders/LoaderPage.dart';
import 'package:getparked/UserInterface/Widgets/SlotNameWidget.dart';
import 'package:getparked/UserInterface/Widgets/SuccessAndFailure/SuccessAndFailurePage.dart';
import 'package:getparked/UserInterface/Widgets/TransactionDetailsPage/TransactionDetailsWidgets/TransactionAmountWidget.dart';
import 'package:getparked/UserInterface/Widgets/qbFAB.dart';
import 'package:getparked/Utils/ContactUtils.dart';
import 'package:getparked/Utils/DomainUtils.dart';
import '../../../../Theme/AppOverlayStyle.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/WrapButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:getparked/UserInterface/Icons/g_p_icons_icons.dart';
import 'package:getparked/UserInterface/Widgets/CustomIcon.dart';

class RequestPayment extends StatefulWidget {
  ContactData contactData;
  double amount;

  RequestPayment({@required this.contactData, this.amount});
  @override
  _RequestPaymentState createState() => _RequestPaymentState();
}

class _RequestPaymentState extends State<RequestPayment> {
  AppState gpAppState;
  String amount;
  String note;
  Map paymentRequestData = {};

  TextEditingController gpAmountController;
  TextEditingController gpNoteController;
  bool isLoading = false;
  bool onRequestSent = false;
  bool isRequestSendSuccess = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    gpAppState = Provider.of<AppState>(context, listen: false);
    gpAmountController = TextEditingController();
    gpNoteController = TextEditingController();

    if (widget.amount != null) {
      gpAmountController.text = widget.amount.toString();
      amount = widget.amount.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    // gpAppState.applyOverlayStyle();
    if (isLoading) {
      return LoaderPage();
    } else if (onRequestSent) {
      return SuccessAndFailurePage(
        onButtonPressed: () {
          Navigator.of(context).pop();
        },
        status: (isRequestSendSuccess)
            ? SuccessAndFailureStatus.success
            : SuccessAndFailureStatus.failure,
        statusText: "Transaction Request",
        buttonText: "Continue",
      );
    } else {
      return Container(
        color: qbWhiteBGColor,
        child: SafeArea(
          top: false,
          maintainBottomViewPadding: true,
          child: Container(
            child: Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    CustomIcon(
                      icon: GPIcons.request_money,
                      size: 20,
                      color: qbAppTextColor,
                    ),
                    SizedBox(
                      width: 12.5,
                    ),
                    Text(
                      "Request Payment",
                      style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w600, color: qbAppTextColor),
                      textScaleFactor: 1.0,
                    ),
                  ],
                ),
                elevation: 0.5,
                brightness: Brightness.light,
                backgroundColor: Color.fromRGBO(250, 250, 250, 1),
                iconTheme: IconThemeData(color: qbAppTextColor),
              ),
              body: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                "Request proceeding to",
                                style: GoogleFonts.nunito(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: qbAppTextColor,
                                ),
                                textScaleFactor: 1.0,
                              ),
                            ),
                            Container(
                              child: Text(
                                widget.contactData.displayName,
                                style: GoogleFonts.nunito(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: qbDetailDarkColor,
                                ),
                                textScaleFactor: 1.0,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 15,
                      ),

                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                "Enter Amount",
                                style: GoogleFonts.nunito(
                                    fontSize: 18.5,
                                    fontWeight: FontWeight.w600,
                                    color: qbAppTextColor),
                                textScaleFactor: 1.0,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              child: TextField(
                                style: GoogleFonts.roboto(
                                    fontSize: 17.5 /
                                        MediaQuery.of(context).textScaleFactor,
                                    fontWeight: FontWeight.w400,
                                    color: qbAppTextColor),
                                onChanged: (value) {
                                  String allowedNum = "0123456789.";
                                  amount = "";
                                  for (int i = 0; i < value.length; i++) {
                                    if (allowedNum.contains(value[i])) {
                                      amount += value[i];
                                    }
                                  }
                                },
                                readOnly:
                                    (widget.amount != null) ? true : false,
                                controller: gpAmountController,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                    isDense: true,
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: qbAppTextColor),
                                        borderRadius:
                                            BorderRadius.circular(7.5)),
                                    prefix: Text(
                                      "₹ ",
                                      style: GoogleFonts.roboto(
                                          fontSize: 17.5,
                                          fontWeight: FontWeight.w500,
                                          color: qbAppTextColor),
                                      textScaleFactor: 1.0,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 12.5, horizontal: 20),
                                    filled:
                                        (widget.amount != null) ? true : false,
                                    fillColor:
                                        Color.fromRGBO(240, 240, 240, 1)),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 35,
                      ),

                      //Note
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                "Note",
                                style: GoogleFonts.nunito(
                                    fontSize: 17.5,
                                    fontWeight: FontWeight.w600,
                                    color: qbAppTextColor),
                                textScaleFactor: 1.0,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              child: TextField(
                                style: GoogleFonts.roboto(
                                    fontSize: 17.5 /
                                        MediaQuery.of(context).textScaleFactor,
                                    fontWeight: FontWeight.w400,
                                    color: qbAppTextColor),
                                onChanged: (value) {
                                  setState(() {
                                    note = value;
                                  });
                                },
                                controller: gpNoteController,
                                maxLines: 5,
                                decoration: InputDecoration(
                                  isDense: true,
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: qbAppTextColor),
                                      borderRadius: BorderRadius.circular(7.5)),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 12.5, horizontal: 20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.symmetric(vertical: 25),
                        alignment: Alignment.centerRight,
                        child: WrapButton(
                          child: Text(
                            "Send Request",
                            style: GoogleFonts.roboto(
                                fontSize: 17.5,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                            textScaleFactor: 1.0,
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 22.5),
                          borderRadius: BorderRadius.circular(5),
                          color: qbAppPrimaryBlueColor,
                          onPressed: () {
                            if ((amount != null && amount != "") &&
                                (note != null && note != "")) {
                              showPaymentRequestDialog();
                            } else {
                              showErrorDialog();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  showPaymentRequestDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: PaymentRequestPopUp(
                amount: double.parse(amount),
                note: note,
                contactData: widget.contactData,
                onRequestPressed: onRequestFun),
          );
        });
  }

  onRequestFun() async {
    // TODO: uncomment..
    // setState(() {
    //   isLoading = true;
    // });
    // Navigator.pop(context);

    // Map<String, dynamic> transactionRequest = {
    //   "fromUserId": gpAppState.userData.id,
    //   "fromAccountType": 0,
    //   "withUserId": widget.contactData.userId,
    //   "withAccountType": 0,
    //   "amount": amount,
    //   "note": note,
    //   "moneyTransferType": 1,
    //   "status": 0
    // };
    // // Calling Send Request Fun
    // Map<String, dynamic> requestResp = await TransactionUtils()
    //     .moneyRequest(transactionRequest, gpAppState.userData.accessToken);
    // print(requestResp);
    // if (requestResp["status"] == 1) {
    //   isRequestSendSuccess = true;
    // } else {
    //   isRequestSendSuccess = false;
    // }

    // setState(() {
    //   isLoading = false;
    //   onRequestSent = true;
    // });
  }

  showErrorDialog() {
    ErrorPopUp().show(
        "You need to Enter Amount And a Brief Note Before Proceeding.",
        context);
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class PaymentRequestPopUp extends StatelessWidget {
  ContactData contactData;
  double amount;
  String note;
  Function onRequestPressed;

  PaymentRequestPopUp(
      {@required this.amount,
      @required this.contactData,
      @required this.note,
      @required this.onRequestPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            child: Text(
              "Requesting From",
              style: GoogleFonts.roboto(
                  fontSize: 17.5,
                  fontWeight: FontWeight.w500,
                  color: qbDetailDarkColor),
              textScaleFactor: 1.0,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 25,
          ),

          // ProfilePic
          Container(
            child: DisplayPicture(
              imgUrl: formatImgUrl(this.contactData.profilePicUrl),
              height: 60,
              width: 60,
              isEditable: false,
              type: (this.contactData.gender == "f")
                  ? DisplayPictureType.profilePictureFemale
                  : DisplayPictureType.profilePictureMale,
            ),
          ),

          SizedBox(
            height: 10,
          ),

          // Name
          Container(
            child: SlotNameWidget(
              slotName: this.contactData.displayName,
              fontSize: 17.5,
            ),
          ),

          // Phone Number
          Container(
            child: Text(
              this.contactData.dialCode +
                  " " +
                  ContactUtils.encodePhNum(this.contactData.phoneNumber),
              style: GoogleFonts.roboto(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: qbDividerDarkColor),
              textScaleFactor: 1.0,
              textAlign: TextAlign.center,
            ),
          ),

          // Amount
          Container(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: TransactionAmountWidget(
              amount: this.amount,
              sizeFactor: 0.6,
            ),
          ),

          // Note
          Container(
            child: Text(
              this.note,
              style: GoogleFonts.roboto(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: qbDetailDarkColor),
              textScaleFactor: 1.0,
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(
            height: 15,
          ),

          // Request Button
          Container(
            child: EdgeLessButton(
              color: qbAppPrimaryGreenColor,
              padding: EdgeInsets.symmetric(vertical: 8.5),
              width: MediaQuery.of(context).size.width * 0.55,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "Request",
                  style: GoogleFonts.nunito(
                      color: qbWhiteBGColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 15),
                ),
              ),
              onPressed: this.onRequestPressed,
            ),
          )
        ],
      ),
    );
  }
}
