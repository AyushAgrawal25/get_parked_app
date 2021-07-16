import 'package:flutter/material.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:getparked/UserInterface/Icons/g_p_icons_icons.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/CustomIcon.dart';
import 'package:getparked/UserInterface/Widgets/FormFieldHeader.dart';
import 'package:getparked/UserInterface/Widgets/Loaders/LoaderPage.dart';
import 'package:getparked/UserInterface/Widgets/UnderLineTextFormField.dart';
import 'package:google_fonts/google_fonts.dart';

class BeneficiaryDetailsPage extends StatefulWidget {
  @override
  _BeneficiaryDetailsPageState createState() => _BeneficiaryDetailsPageState();
}

class _BeneficiaryDetailsPageState extends State<BeneficiaryDetailsPage> {
  bool isLoading = false;

  String beneficiaryName = "";
  String accountNumber = "";
  String reEnterAccountNumber = "";
  String ifscCode = "";
  String upiId = "";

  String bankName = "";
  bool isSBI = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: qbWhiteBGColor,
            child: SafeArea(
                top: false,
                maintainBottomViewPadding: true,
                child: Scaffold(
                    appBar: AppBar(
                      title: Row(
                        children: [
                          CustomIcon(
                            icon: Typicons.user,
                            size: 25,
                            color: qbAppTextColor,
                          ),
                          SizedBox(
                            width: 7.5,
                          ),
                          Container(
                            child: Text(
                              "Bank Details",
                              style: GoogleFonts.nunito(
                                  fontWeight: FontWeight.w600,
                                  color: qbAppTextColor),
                              textScaleFactor: 1,
                            ),
                          ),
                        ],
                      ),
                      brightness: Brightness.light,
                      backgroundColor: Colors.transparent,
                      elevation: 0.0,
                      iconTheme: IconThemeData(color: qbAppTextColor),
                    ),
                    body: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: SingleChildScrollView(
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 15,
                                ),

                                // Name
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: FormFieldHeader(
                                    headerText: "Beneficiary Details",
                                    fontSize: 20,
                                    color: qbAppTextColor,
                                  ),
                                ),

                                Container(
                                  child: UnderLineTextFormField(
                                    labelText: "Name",
                                    contentPadding: EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 10,
                                        bottom: 10),
                                    onChange: (value) {
                                      setState(() {
                                        if ((value != null) && (value != "")) {
                                          beneficiaryName = value;
                                        }
                                      });
                                    },
                                  ),
                                ),

                                SizedBox(
                                  height: 15,
                                ),

                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.5, vertical: 10),
                                  child: FormFieldHeader(
                                    headerText: "Account Number",
                                    fontSize: 15,
                                    color: qbAppTextColor,
                                  ),
                                ),

                                // Account Number
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  child: TextFormField(
                                    minLines: 1,
                                    maxLines: 1,
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      setState(() {
                                        int accNum;
                                        try {
                                          accNum = int.parse(value);
                                        } catch (excp) {}
                                        if (accNum != null) {
                                          accountNumber = value;
                                        }
                                      });
                                    },
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: qbAppTextColor)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                width: 1.5,
                                                color:
                                                    qbAppSecondaryBlueColor)),
                                        contentPadding: EdgeInsets.only(
                                            left: 25,
                                            right: 25,
                                            top: 12.5,
                                            bottom: 12.5),
                                        alignLabelWithHint: false,
                                        isDense: true),
                                  ),
                                ),

                                // Re enter account Number
                                SizedBox(
                                  height: 15,
                                ),

                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.5, vertical: 10),
                                  child: FormFieldHeader(
                                    headerText: "Re-Enter ccount Number",
                                    fontSize: 15,
                                    color: qbAppTextColor,
                                  ),
                                ),

                                // Account Number
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  child: TextFormField(
                                    minLines: 1,
                                    maxLines: 1,
                                    keyboardType: TextInputType.number,
                                    onChanged: (value) {
                                      setState(() {
                                        int accNum;
                                        try {
                                          accNum = int.parse(value);
                                        } catch (excp) {}
                                        if (accNum != null) {
                                          reEnterAccountNumber = value;
                                        }
                                      });
                                    },
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: qbAppTextColor)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                width: 1.5,
                                                color:
                                                    qbAppSecondaryBlueColor)),
                                        contentPadding: EdgeInsets.only(
                                            left: 25,
                                            right: 25,
                                            top: 12.5,
                                            bottom: 12.5),
                                        alignLabelWithHint: false,
                                        isDense: true),
                                  ),
                                ),

                                // ifsc code
                                SizedBox(
                                  height: 10,
                                ),

                                Container(
                                  child: UnderLineTextFormField(
                                    labelText: "IFSC Code",
                                    contentPadding: EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 10,
                                        bottom: 10),
                                    onChange: (value) {
                                      setState(() {
                                        if ((value != null) && (value != "")) {
                                          ifscCode = value;
                                        }
                                      });
                                    },
                                  ),
                                ),

                                // Bank Name
                                SizedBox(
                                  height: 15,
                                ),

                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.5, vertical: 7.5),
                                  child: FormFieldHeader(
                                    headerText: "Bank Name",
                                    fontSize: 15,
                                    color: qbAppTextColor,
                                  ),
                                ),

                                // To check SBI
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        child: Checkbox(
                                            onChanged: (value) {
                                              setState(() {
                                                isSBI = value;
                                              });
                                            },
                                            value: isSBI,
                                            activeColor:
                                                qbAppPrimaryGreenColor),
                                      ),
                                      Expanded(
                                          child: Container(
                                        child: FormFieldHeader(
                                          headerText: "is SBI Account",
                                          fontSize: 15,
                                        ),
                                      ))
                                    ],
                                  ),
                                ),

                                (isSBI)
                                    ? Container(
                                        height: 0,
                                      )
                                    : Container(),
                                // TODO: complete this.

                                // UPI Id

                                // Continue Button
                              ],
                            ),
                          ),
                        )))),
          ),

          // Loader
          (isLoading) ? LoaderPage() : Container()
        ],
      ),
    );
  }
}
