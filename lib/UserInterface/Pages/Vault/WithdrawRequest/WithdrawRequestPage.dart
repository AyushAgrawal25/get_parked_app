import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/UserInterface/Pages/Vault/BeneficiaryDetails/BeneficiaryDetailsPage.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/EdgeLessButton.dart';
import 'package:getparked/UserInterface/Widgets/Loaders/LoaderPage.dart';
import 'package:getparked/UserInterface/Widgets/TermDisplayWidget.dart';
import 'package:getparked/UserInterface/Widgets/TransactionDetailsPage/TransactionDetailsWidgets/TransactionAmountWidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class WithdrawRequestPage extends StatefulWidget {
  @override
  _WithdrawRequestPageState createState() => _WithdrawRequestPageState();
}

class _WithdrawRequestPageState extends State<WithdrawRequestPage> {
  bool isLoading = false;
  AppState appState;
  @override
  void initState() {
    super.initState();
    appState = Provider.of<AppState>(context, listen: false);
  }

  Widget termsAndConditions() {
    List<String> terms = [
      "This is your current balance in the vault you can add a request when your vault balance is more than ₹ 100.",
      "Once your request has been accepted the amount will be credited to your account.",
      "You need to provide Bank Details for successful withdrawal of money.",
      "You cannot request withdraw until and unless your current request is processed."
    ];

    List<Widget> termWidgets = [];
    terms.forEach((term) {
      termWidgets.add(TermDisplayWidget(
        term: term,
        addHashtag: true,
        fontSize: 15,
      ));
    });

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: termWidgets,
      ),
    );
  }

  bool isBeneficiaryDetailsAdded = false;
  bool isAmountSufficient = false;

  Widget currentStatusWidget() {
    IconData icon = FontAwesome5.exclamation_circle;
    Color iconColor = qbAppPrimaryRedColor;
    if (isBeneficiaryDetailsAdded && isAmountSufficient) {
      icon = FontAwesome5.check_circle;
      iconColor = qbAppPrimaryGreenColor;
    }

    String statusText = "";
    if (isAmountSufficient) {
      if (isBeneficiaryDetailsAdded) {
        statusText = "You are all set.";
      } else {
        statusText = "Beneficiary Details are missing.";
      }
    } else {
      statusText = "You don't have enough money to withdraw.";
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      decoration: BoxDecoration(
          border: Border.all(
            width: 1.5,
            color: qbDividerLightColor,
          ),
          borderRadius: BorderRadius.circular(10)),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            // Icon
            Container(
              child: Icon(
                icon,
                size: 35,
                color: iconColor,
              ),
            ),
            SizedBox(
              height: 15,
            ),

            // Status
            Container(
              child: Text(
                statusText,
                style: GoogleFonts.roboto(
                    color: qbDetailLightColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
                textScaleFactor: 1.0,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget beneficiaryDetailsButton() {
    String buttonText = "Add Beneficiary Details";
    if (isBeneficiaryDetailsAdded) {
      buttonText = "Update Beneficiary Details";
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 1.5),
      child: EdgeLessButton(
        height: 40,
        width: MediaQuery.of(context).size.width,
        color: qbAppPrimaryBlueColor,
        child: Center(
          child: Text(
            buttonText,
            style: GoogleFonts.nunito(
                fontSize: 17.5,
                fontWeight: FontWeight.w500,
                color: Colors.white),
            textScaleFactor: 1.0,
            textAlign: TextAlign.center,
          ),
        ),
        onPressed: () {
          if (isBeneficiaryDetailsAdded) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return BeneficiaryDetailsPage(
                  beneficiaryData: appState.beneficiaryData,
                );
              },
            ));
          } else {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return BeneficiaryDetailsPage(
                  beneficiaryData: null,
                );
              },
            ));
          }
        },
      ),
    );
  }

  Widget sendRequestButtton() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1.5),
      child: EdgeLessButton(
        height: 40,
        width: MediaQuery.of(context).size.width,
        color: (isBeneficiaryDetailsAdded && isAmountSufficient)
            ? qbAppPrimaryThemeColor
            : qbDividerDarkColor,
        child: Center(
          child: Text(
            "Send Request",
            style: GoogleFonts.nunito(
                fontSize: 17.5,
                fontWeight: FontWeight.w500,
                color: Colors.white),
            textScaleFactor: 1.0,
            textAlign: TextAlign.center,
          ),
        ),
        onPressed: () {
          if (isBeneficiaryDetailsAdded && isAmountSufficient) {}
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AppState gpAppStateListen = Provider.of<AppState>(context);
    if (gpAppStateListen.beneficiaryData != null) {
      isBeneficiaryDetailsAdded = true;
    } else {
      isBeneficiaryDetailsAdded = false;
    }

    if (gpAppStateListen.vaultMoney > 100) {
      isAmountSufficient = true;
    } else {
      isAmountSufficient = false;
    }

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
                      "Withdraw Request",
                      style: GoogleFonts.nunito(
                          color: qbAppTextColor, fontWeight: FontWeight.w600),
                      textScaleFactor: 1.0,
                    ),
                    backgroundColor: qbWhiteBGColor,
                    elevation: 0.0,
                    iconTheme: IconThemeData(color: qbAppTextColor),
                    brightness: Brightness.light,
                  ),
                  body: Container(
                    child: SingleChildScrollView(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 25, horizontal: 30),
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text("Balance Money",
                                  style: GoogleFonts.poppins(
                                      color: qbAppSecondaryGreenColor,
                                      fontSize: 17.5,
                                      fontWeight: FontWeight.w600),
                                  textScaleFactor: 1.0),
                            ),

                            // Amount
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 22.5),
                              child: TransactionAmountWidget(
                                amount: gpAppStateListen.vaultMoney,
                                sizeFactor: 0.95,
                              ),
                            ),

                            // Terms and conditions.
                            termsAndConditions(),

                            SizedBox(
                              height: 5,
                            ),
                            // Status
                            currentStatusWidget(),

                            SizedBox(
                              height: 15,
                            ),

                            // Beneficiary Details
                            beneficiaryDetailsButton(),

                            // Send Request
                            sendRequestButtton()
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              (isLoading)
                  ? LoaderPage()
                  : Container(
                      height: 0,
                      width: 0,
                    )
            ],
          ),
        ));
  }
}
