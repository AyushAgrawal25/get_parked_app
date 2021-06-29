import 'dart:async';
import 'dart:collection';

import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/StateManagement/Models/TransactionData.dart';
import 'package:getparked/StateManagement/Models/UserData.dart';
import 'package:getparked/UserInterface/Icons/g_p_icons_icons.dart';
import 'package:getparked/UserInterface/Pages/Wallet/Wallet.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/CustomIcon.dart';
import 'package:getparked/UserInterface/Widgets/Loaders/LoaderPage.dart';
import 'package:getparked/UserInterface/Widgets/TransactionCard/TransactionCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Vault extends StatefulWidget {
  @override
  _VaultState createState() => _VaultState();
}

class _VaultState extends State<Vault> {
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

  Widget topVaultWidget = Container();
  setTopVaultWidget() {
    double horiPadding = 25.0;
    double actionBoxHeight = 80;
    topVaultWidget = // Top Widget
        Container(
      padding: EdgeInsets.only(top: 10),
      color: qbAppPrimaryThemeColor,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: horiPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                WalletAmountWidget(
                  amount: gpAppState.vaultMoney,
                ),
                // Container(
                //   width: actionBoxHeight * 1.2,
                //   child: Icon(
                //     FontAwesome.bank,
                //     size: 40,
                //     color: qbWhiteBGColor,
                //   ),
                // )
              ],
            ),
          ),

          Container(
            padding:
                EdgeInsets.symmetric(horizontal: horiPadding, vertical: 7.5),
            child: VaultFutureAmount(),
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

          // Withdraw Button
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
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: onWithdraw,
                      child: Container(
                        height: actionBoxHeight,
                        padding: EdgeInsets.symmetric(horizontal: horiPadding),
                        child: Container(
                          width: actionBoxHeight * 1.2,
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Icon
                              Container(
                                child: Icon(
                                  GPIcons.bank_or_withdraw,
                                  size: 25,
                                  color: qbDetailLightColor,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                child: Text(
                                  "Withdraw",
                                  style: GoogleFonts.nunito(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w600,
                                      color: qbDetailLightColor),
                                  textScaleFactor: 1.0,
                                ),
                              )
                            ],
                          ),
                        ),
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

  List<Widget> vaultWidgets = [];
  setVaultWidgets() {
    AppState gpAppStateListen = Provider.of<AppState>(context);
    setTransactionTitle();
    setTopVaultWidget();

    vaultWidgets = [
      topVaultWidget,
      SizedBox(
        height: 25,
      ),
      transactionTitle
    ];

    gpAppStateListen.transactions.forEach((TransactionData gpTransactionData) {
      if (gpTransactionData.accountType == UserAccountType.slot) {
        vaultWidgets.add(TransactionCard(transactionData: gpTransactionData));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setVaultWidgets();
    return Container(
      color: qbAppPrimaryThemeColor,
      child: Stack(
        children: [
          Container(
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
                              child: Icon(
                                GPIcons.vault_circular_gear_outlined,
                                size: 20,
                              ),
                            ),

                            SizedBox(
                              width: 10,
                            ),

                            // Text Vault
                            Container(
                              child: Text(
                                "Vault",
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
                          children: new UnmodifiableListView(vaultWidgets),
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

  onWithdraw() {
    SystemSound.play(SystemSoundType.click);
  }
}

class VaultFutureAmount extends StatefulWidget {
  @override
  _VaultFutureAmountState createState() => _VaultFutureAmountState();
}

class _VaultFutureAmountState extends State<VaultFutureAmount> {
  double futAmt = 0.0;
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  Timer amtResetTimer;
  startTimer() {
    amtResetTimer = new Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    AppState gpAppStateListen = Provider.of<AppState>(context);
    futAmt = gpAppStateListen.getVaultFutureDeposit();
    // print(futAmt);
    return Container(
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
            "Future Profits is ₹ ${futAmt.toStringAsFixed(2)}.",
            style: GoogleFonts.roboto(
                color: qbWhiteBGColor,
                fontSize: 15,
                fontWeight: FontWeight.w400),
            textScaleFactor: 1.0,
          )),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    amtResetTimer.cancel();
  }
}
