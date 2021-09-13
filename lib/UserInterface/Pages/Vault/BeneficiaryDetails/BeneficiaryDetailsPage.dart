import 'package:flutter/material.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:getparked/BussinessLogic/UserBeneficiaryServices.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/StateManagement/Models/UserBeneficiaryData.dart';
import 'package:getparked/UserInterface/Icons/g_p_icons_icons.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/CustomIcon.dart';
import 'package:getparked/UserInterface/Widgets/EdgeLessButton.dart';
import 'package:getparked/UserInterface/Widgets/FormFieldHeader.dart';
import 'package:getparked/UserInterface/Widgets/Loaders/LoaderPage.dart';
import 'package:getparked/UserInterface/Widgets/SuccessAndFailure/SuccessAndFailurePage.dart';
import 'package:getparked/UserInterface/Widgets/UnderLineTextFormField.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BeneficiaryDetailsPage extends StatefulWidget {
  final UserBeneficiaryData beneficiaryData;

  BeneficiaryDetailsPage({@required this.beneficiaryData});
  @override
  _BeneficiaryDetailsPageState createState() => _BeneficiaryDetailsPageState();
}

class _BeneficiaryDetailsPageState extends State<BeneficiaryDetailsPage> {
  bool isLoading = false;
  AppState appState;

  @override
  void initState() {
    super.initState();

    appState = Provider.of<AppState>(context, listen: false);
    if (widget.beneficiaryData != null) {
      setInitialValues();
    }
  }

  setInitialValues() {
    beneficiaryName = widget.beneficiaryData.name;
    beneficiaryNameController.text = widget.beneficiaryData.name;

    accountNumber = widget.beneficiaryData.accountNumber;
    accountNumberController.text = widget.beneficiaryData.accountNumber;

    reEnterAccountNumber = widget.beneficiaryData.accountNumber;
    reEnterAccountNumberController.text = widget.beneficiaryData.accountNumber;

    ifscCode = widget.beneficiaryData.ifscCode;
    ifscCodeController.text = widget.beneficiaryData.ifscCode;

    upiId = widget.beneficiaryData.upiId;
    upiIdController.text = widget.beneficiaryData.upiId;

    bankName = widget.beneficiaryData.bankName;
    if (bankName == SBI_BANK) {
      isSBI = true;
    }
    bankNameController.text = widget.beneficiaryData.bankName;
  }

  String beneficiaryName = "";
  TextEditingController beneficiaryNameController = TextEditingController();

  String accountNumber = "";
  TextEditingController accountNumberController = TextEditingController();

  String reEnterAccountNumber = "";
  TextEditingController reEnterAccountNumberController =
      TextEditingController();

  String ifscCode = "";
  TextEditingController ifscCodeController = TextEditingController();

  String upiId;
  TextEditingController upiIdController = TextEditingController();

  bool isSBI = true;
  String bankName = "";
  TextEditingController bankNameController = TextEditingController();

  bool isFormValid = true;

  checkFormValidity() {
    // TODO: Add VPA Validation and all for account number validation.
    isFormValid = true;
    if ((beneficiaryName == "") || (beneficiaryName == null)) {
      isFormValid = false;
    }
    if ((accountNumber == "") || (accountNumber == null)) {
      isFormValid = false;
    }
    if ((reEnterAccountNumber == "") || (reEnterAccountNumber == null)) {
      isFormValid = false;
    }
    if (accountNumber != reEnterAccountNumber) {
      isFormValid = false;
    }
    if ((ifscCode == "") || (ifscCode == null)) {
      isFormValid = false;
    }

    if (isSBI) {
      bankName = SBI_BANK;
    } else {
      if ((bankName == "") || (bankName == null)) {
        isFormValid = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    checkFormValidity();
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
                            icon: GPIcons.withdraw_or_bank,
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
                      backgroundColor: qbWhiteBGColor,
                      elevation: 0.0,
                      iconTheme: IconThemeData(color: qbAppTextColor),
                      brightness: Brightness.light,
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
                                    value: beneficiaryName,
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
                                    controller: accountNumberController,
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
                                    controller: reEnterAccountNumberController,
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
                                    value: ifscCode,
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
                                    : Container(
                                        child: UnderLineTextFormField(
                                          labelText: "Bank Name",
                                          contentPadding: EdgeInsets.only(
                                              left: 10,
                                              right: 10,
                                              top: 10,
                                              bottom: 10),
                                          value: bankName,
                                          onChange: (value) {
                                            setState(() {
                                              if ((value != null) &&
                                                  (value != "")) {
                                                bankName = value;
                                              }
                                            });
                                          },
                                        ),
                                      ),

                                // UPI Id
                                Container(
                                  child: UnderLineTextFormField(
                                    labelText: "UPI Id",
                                    contentPadding: EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        top: 10,
                                        bottom: 10),
                                    value: upiId,
                                    onChange: (value) {
                                      setState(() {
                                        upiId = value;
                                      });
                                    },
                                  ),
                                ),

                                Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    alignment: Alignment.centerRight,
                                    child: FormFieldHeader(
                                      headerText: "Optional",
                                      fontSize: 13.5,
                                      color: qbDetailLightColor,
                                    )),

                                SizedBox(
                                  height: 10,
                                ),

                                // Continue Button
                                Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 2.5),
                                    alignment: Alignment.center,
                                    child: EdgeLessButton(
                                      child: Text(
                                        "Continue",
                                        style: GoogleFonts.nunito(
                                            fontSize: 16.5,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                        textAlign: TextAlign.center,
                                        textScaleFactor: 1.0,
                                      ),
                                      color: (isFormValid)
                                          ? qbAppPrimaryBlueColor
                                          : qbDividerDarkColor,
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8.5),
                                      onPressed: onSubmitPressed,
                                    )),
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

  onSubmitPressed() async {
    if (!isFormValid) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    if (widget.beneficiaryData != null) {
      UserBeneficiaryData beneficiaryData = await UserBeneficiaryServices()
          .update(
              beneficiaryId: widget.beneficiaryData.id,
              authToken: appState.authToken,
              name: beneficiaryName,
              accountNumber: accountNumber,
              ifscCode: ifscCode,
              bankName: bankName,
              upiId: upiId);

      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return SuccessAndFailurePage(
            statusText: "Updation",
            buttonText: "Continue",
            status: (beneficiaryData != null)
                ? SuccessAndFailureStatus.success
                : SuccessAndFailureStatus.failure,
            onButtonPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
          );
        },
      )).then((value) {
        setState(() {
          isLoading = false;
        });
      });
      if (beneficiaryData != null) {
        appState.setBeneficiaryData(beneficiaryData);
      }
    } else {
      UserBeneficiaryData beneficiaryData = await UserBeneficiaryServices()
          .create(
              authToken: appState.authToken,
              name: beneficiaryName,
              accountNumber: accountNumber,
              ifscCode: ifscCode,
              bankName: bankName,
              upiId: upiId);

      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return SuccessAndFailurePage(
            statusText: "Registration",
            buttonText: "Continue",
            status: (beneficiaryData != null)
                ? SuccessAndFailureStatus.success
                : SuccessAndFailureStatus.failure,
            onButtonPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
          );
        },
      )).then((value) {
        setState(() {
          isLoading = false;
        });
      });
      if (beneficiaryData != null) {
        appState.setBeneficiaryData(beneficiaryData);
      }
    }

    setState(() {
      isLoading = false;
    });
  }
}
