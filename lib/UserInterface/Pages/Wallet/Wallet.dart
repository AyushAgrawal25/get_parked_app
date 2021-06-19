import 'dart:collection';

import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/StateManagement/Models/TransactionData.dart';
import 'package:getparked/StateManagement/Models/UserData.dart';
import 'package:getparked/StateManagement/Models/UserDetails.dart';
import 'package:getparked/UserInterface/Icons/g_p_icons_icons.dart';
import 'package:getparked/UserInterface/Pages/Wallet/AddMoney/AddMoneyPage.dart';
import 'package:getparked/UserInterface/Pages/Wallet/RequestMoney/SelectContact/SelectContact.dart';
import 'package:getparked/UserInterface/Widgets/CustomIcon.dart';
import 'package:getparked/UserInterface/Widgets/DisplayPicture.dart';
import 'package:getparked/UserInterface/Widgets/Loaders/LoaderPage.dart';
import 'package:getparked/UserInterface/Widgets/TransactionCard/TransactionCard.dart';
import 'package:flutter/material.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:getparked/Utils/DomainUtils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Wallet extends StatefulWidget {
  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  bool isLoading = false;
  loadHandler(bool status) {
    setState(() {
      isLoading = status;
    });
  }

  AppState gpAppState;
  @override
  void initState() {
    super.initState();
    gpAppState = Provider.of<AppState>(context, listen: false);
  }

  Widget profilePicWidget = Container();
  setProfilePicWidget() {
    profilePicWidget = Container(
      child: DisplayPicture(
          imgUrl: formatImgUrl(gpAppState.userDetails.profilePicThumbnailUrl),
          height: 45,
          width: 45,
          isEditable: false,
          type: (gpAppState.userDetails.getGenderType() == UserGender.female)
              ? DisplayPictureType.profilePictureFemale
              : DisplayPictureType.profilePictureMale),
    );
  }

  Widget topWalletWidget = Container();
  setTopWalletWidget() {
    double horiPadding = 25.0;
    double actionBoxHeight = 100;
    topWalletWidget = // Top Widget
        Container(
      padding: EdgeInsets.only(top: 10),
      color: qbAppPrimaryThemeColor,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: horiPadding),
            child: WalletAmountWidget(
              amount: gpAppState.walletMoney,
            ),
          ),

          Container(
            padding:
                EdgeInsets.symmetric(horizontal: horiPadding, vertical: 7.5),
            child: Row(
              children: [
                Container(
                  child: Icon(
                    FontAwesome5.exclamation_circle,
                    color: qbWhiteBGColor,
                    size: 17.5,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  child: Text(
                    "Security Deposit is ₹ ${gpAppState.walletSecurityDeposit.toStringAsFixed(2)}",
                    style: GoogleFonts.roboto(
                        color: qbWhiteBGColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                    textScaleFactor: 1.0,
                  ),
                ),
              ],
            ),
          ),

          // Container(
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: [
          //       Text(
          //         "UPI",
          //         style: GoogleFonts.sarpanch(
          //             fontSize: 17.5,
          //             fontWeight: FontWeight.w600,
          //             color: qbWhiteBGColor,
          //             fontStyle: FontStyle.italic),
          //       ),
          //       Text(
          //         "UPI",
          //         style: GoogleFonts.turretRoad(
          //             fontSize: 17.5,
          //             fontWeight: FontWeight.w900,
          //             color: qbWhiteBGColor,
          //             fontStyle: FontStyle.italic),
          //       ),
          //       Text(
          //         "UPI",
          //         style: GoogleFonts.iceland(
          //             fontSize: 17.5,
          //             fontWeight: FontWeight.w900,
          //             color: qbWhiteBGColor,
          //             fontStyle: FontStyle.italic),
          //       ),
          //       Text(
          //         "UPI",
          //         style: GoogleFonts.quantico(
          //             fontSize: 17.5,
          //             fontWeight: FontWeight.w500,
          //             color: qbWhiteBGColor,
          //             fontStyle: FontStyle.italic),
          //       ),
          //     ],
          //   ),
          // ),

          SizedBox(
            height: 12.5,
          ),

          // Buttons
          Container(
              height: actionBoxHeight,
              child: Stack(
                children: [
                  // BG Color
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: actionBoxHeight * 0.5,
                      color: qbWhiteBGColor,
                    ),
                  ),
                  // Actions
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: horiPadding),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.1),
                              offset: Offset(5, 5),
                              blurRadius: 15,
                              spreadRadius: 10),
                        ],
                        borderRadius: BorderRadius.circular(2.5),
                        color: qbWhiteBGColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: WalletActionButton(
                              actionName: "Add",
                              icon: GPIcons.add_money,
                              onPressed: onAddMoney,
                            ),
                          ),
                          Container(
                            child: WalletActionButton(
                              actionName: "Request",
                              icon: GPIcons.request_money,
                              onPressed: onMoneyRequest,
                            ),
                          ),
                          Container(
                            child: WalletActionButton(
                              actionName: "Withdraw",
                              icon: GPIcons.bank_or_withdraw,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }

  Widget transactionTitle = Container();
  setTransactionTitle() {
    transactionTitle = Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Container(
            child: CustomIcon(
              icon: GPIcons.transaction_history,
              size: 22.5,
              color: qbDetailLightColor,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            child: Text(
              "Transactions",
              style: GoogleFonts.nunito(
                  color: qbDetailLightColor,
                  fontSize: 17.5,
                  fontWeight: FontWeight.w700),
              textScaleFactor: 1.0,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> walletWidgets = [];
  setWalletWidgets() {
    AppState gpAppStateListen = Provider.of<AppState>(context);
    setTransactionTitle();
    setTopWalletWidget();

    walletWidgets = [
      topWalletWidget,
      SizedBox(
        height: 25,
      ),
      transactionTitle,
    ];

    gpAppStateListen.transactions.forEach((TransactionData gpTransactionData) {
      if (gpTransactionData.accountType == UserAccountType.user) {
        walletWidgets.add(TransactionCard(transactionData: gpTransactionData));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setWalletWidgets();
    return Container(
      child: Stack(
        children: [
          Container(
            color: qbAppPrimaryThemeColor,
            child: SafeArea(
              top: false,
              maintainBottomViewPadding: true,
              child: Container(
                child: Scaffold(
                    appBar: AppBar(
                      backgroundColor: qbAppPrimaryThemeColor,
                      title: Container(
                        child: Row(
                          children: [
                            // Icons
                            Container(
                              child: CustomIcon(
                                icon: GPIcons.wallet_outlined,
                                size: 20,
                              ),
                            ),

                            SizedBox(
                              width: 10,
                            ),

                            // Text Wallet
                            Container(
                              child: Text(
                                "Wallet",
                                style: GoogleFonts.nunito(
                                    color: qbWhiteBGColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                                textScaleFactor: 1.0,
                              ),
                            )
                          ],
                        ),
                      ),
                      brightness: Brightness.dark,
                      elevation: 0.0,
                    ),
                    body: Container(
                      child: Scrollbar(
                        radius: Radius.elliptical(2.5, 15),
                        child: ListView(
                          children: new UnmodifiableListView(walletWidgets),
                        ),
                      ),
                    )),
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
                )
        ],
      ),
    );
  }

  onMoneyRequest() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return SelectContact();
      },
    ));
  }

  onAddMoney() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return AddMoneyPage(
          formType: AddMoneyFormType.withoutAmount,
        );
      },
    ));
  }
}

class WalletActionButton extends StatelessWidget {
  String actionName;
  IconData icon;
  Function onPressed;
  WalletActionButton({
    @required this.actionName,
    @required this.icon,
    @required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    Color color = qbDetailLightColor;
    return GestureDetector(
      onTap: () {
        SystemSound.play(SystemSoundType.click);
        if (this.onPressed != null) {
          this.onPressed();
        }
      },
      child: Container(
        color: Colors.transparent,
        width: MediaQuery.of(context).size.width * 0.25,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // icon
            Container(
              child: Icon(
                this.icon,
                size: 25,
                color: color,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              child: Text(
                this.actionName,
                style: GoogleFonts.nunito(
                    fontSize: 12.5, fontWeight: FontWeight.w600, color: color),
                textScaleFactor: 1.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class WalletAmountWidget extends StatelessWidget {
  double amount;
  WalletAmountWidget({@required this.amount});
  @override
  Widget build(BuildContext context) {
    String amtRs = (this.amount.toStringAsFixed(2).split('.'))[0];
    String amtPaisa = (this.amount.toStringAsFixed(2).split('.'))[1];
    return Container(
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 7.5, right: 1.5),
            child: Text(
              "₹",
              style: GoogleFonts.roboto(
                  color: qbWhiteBGColor,
                  fontSize: 32.5,
                  fontWeight: FontWeight.w400),
              textScaleFactor: 1.0,
            ),
          ),
          SizedBox(
            width: 2.5,
          ),
          Text(
            amtRs,
            style: GoogleFonts.cabin(
                color: qbWhiteBGColor,
                fontSize: 55,
                letterSpacing: 2.25,
                fontWeight: FontWeight.w500),
            textScaleFactor: 1.0,
          ),
          Container(
            padding: EdgeInsets.only(top: 27.5),
            child: Text(
              "." + amtPaisa,
              style: GoogleFonts.cabin(
                  color: qbWhiteBGColor,
                  fontSize: 25,
                  letterSpacing: 2.25,
                  fontWeight: FontWeight.w500),
              textScaleFactor: 1.0,
            ),
          )
        ],
      ),
    );
  }
}
