import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/EdgeLessButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class LowBalancePopUp {
  show(String contentTextOne, String contentTextTwo, String title,
      Function onAddMoney, Function onPaymentRequest, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            contentPadding:
                EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 10),
            content: LowBalancePopUpContent(
              contentTextOne: contentTextOne,
              contentTextTwo: contentTextTwo,
              title: title,
              onAddMoney: onAddMoney,
              onPaymentRequest: onPaymentRequest,
            ));
      },
    );
  }
}

class LowBalancePopUpContent extends StatefulWidget {
  final String contentTextOne;
  final String contentTextTwo;
  final String title;
  final Function onAddMoney;
  final Function onPaymentRequest;

  LowBalancePopUpContent(
      {@required this.contentTextOne,
      @required this.contentTextTwo,
      @required this.onAddMoney,
      @required this.onPaymentRequest,
      @required this.title});

  @override
  _LowBalancePopUpContentState createState() => _LowBalancePopUpContentState();
}

class _LowBalancePopUpContentState extends State<LowBalancePopUpContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            child: Icon(
              FontAwesome5.exclamation_triangle,
              color: qbAppPrimaryRedColor,
              size: 60,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 7.5),
            child: Text(
              widget.title,
              style: GoogleFonts.nunito(
                  fontSize: 17.5,
                  fontWeight: FontWeight.w800,
                  color: qbAppTextColor),
              textScaleFactor: 1.0,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 2.5,
          ),
          Container(
            child: Text(
              widget.contentTextOne,
              style: GoogleFonts.roboto(
                  height: 1.25,
                  fontSize: 13.5,
                  fontWeight: FontWeight.w400,
                  color: qbAppTextColor),
              textScaleFactor: 1.0,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Divider(
            thickness: 1.5,
            color: qbDividerLightColor,
            height: 10,
          ),
          Container(
            child: Row(
              children: [
                // Add
                Expanded(
                  child: GestureDetector(
                    child: Container(
                      height: 40,
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      child: Text(
                        "Add",
                        style: GoogleFonts.nunito(
                            fontSize: 17.5,
                            color: qbAppPrimaryBlueColor,
                            fontWeight: FontWeight.w700),
                        textScaleFactor: 1.0,
                      ),
                    ),
                    onTap: () {
                      SystemSound.play(SystemSoundType.click);
                      widget.onAddMoney();
                    },
                  ),
                ),

                Container(
                  height: 40,
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: VerticalDivider(
                    thickness: 1.5,
                    color: qbDividerLightColor,
                    width: 10,
                  ),
                ),

                // Request
                Expanded(
                  child: GestureDetector(
                    child: Container(
                      height: 40,
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      child: Text(
                        "Request",
                        style: GoogleFonts.nunito(
                            fontSize: 17.5,
                            color: qbAppPrimaryGreenColor,
                            fontWeight: FontWeight.w700),
                        textScaleFactor: 1.0,
                      ),
                    ),
                    onTap: () {
                      SystemSound.play(SystemSoundType.click);
                      widget.onPaymentRequest();
                    },
                  ),
                ),
              ],
            ),
          ),

          // Container(
          //   padding: EdgeInsets.symmetric(horizontal: 7.5),
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: EdgeLessButton(
          //           width: double.infinity,
          //           color: qbAppPrimaryBlueColor,
          //           padding: EdgeInsets.symmetric(vertical: 7.5),
          //           onPressed: () {
          //             Navigator.pop(context);
          //             widget.onAddMoney();
          //           },
          //           child: Text(
          //             "Add",
          //             style: GoogleFonts.roboto(
          //                 fontSize: 15,
          //                 fontWeight: FontWeight.w500,
          //                 color: Colors.white),
          //             textAlign: TextAlign.center,
          //             textScaleFactor: 1.0,
          //           ),
          //         ),
          //       ),
          //       SizedBox(
          //         width: 10,
          //       ),
          //       Expanded(
          //         child: EdgeLessButton(
          //           width: double.infinity,
          //           color: qbAppPrimaryGreenColor,
          //           padding: EdgeInsets.symmetric(vertical: 7.5),
          //           onPressed: () {
          //             Navigator.pop(context);
          //             widget.onPaymentRequest();
          //           },
          //           child: Text(
          //             "Request",
          //             style: GoogleFonts.roboto(
          //                 fontSize: 15,
          //                 fontWeight: FontWeight.w500,
          //                 color: Colors.white),
          //             textAlign: TextAlign.center,
          //             textScaleFactor: 1.0,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}

// LowBalancePopUp lowBalancePopUp = LowBalancePopUp();
// lowBalancePopUp.show(
//     "You need to have atleast Parking Charges of 14 hours for parking in this slot. So you need to have atleast ₹ 500 in your wallet before proceeding.",
//     "Add ₹ 25.00 to your Wallet.",
//     "Not Enough Money", () {
//   print("On Add Money !");
// }, () {
//   print("On Payment Request !");
// }, context);
