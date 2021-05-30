import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/UserInterface/Icons/g_p_icons_icons.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/CustomButton.dart';
import 'package:getparked/UserInterface/Widgets/CustomIcon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:provider/provider.dart';

class ForgotPinWidget extends StatefulWidget {
  @override
  _ForgotPinWidgetState createState() => _ForgotPinWidgetState();
}

class _ForgotPinWidgetState extends State<ForgotPinWidget> {
  AppState gpAppState;
  TextEditingController otpController;
  bool isOTPVerified = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    gpAppState = Provider.of<AppState>(context, listen: false);
    otpController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(250, 250, 250, 1),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: qbAppTextColor),
            elevation: 0.0,
            backgroundColor: Colors.transparent,
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    // Logo And OTP Section
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomIcon(
                            icon: GPIcons.get_parked_logo,
                            color: qbAppPrimaryThemeColor,
                            size: 50,
                          ),
                          SizedBox(
                            height: 12.5,
                          ),
                          Container(
                            child: Text(
                              "OTP sent to +91 ${gpAppState.userDetails.phoneNumber}",
                              style: GoogleFonts.nunito(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w600,
                                  color: qbDetailDarkColor),
                              textScaleFactor: 1.0,
                            ),
                          ),
                          SizedBox(
                            height: 12.5,
                          ),
                          Container(
                            width: 150,
                            child: PinCodeTextField(
                              autofocus: false,
                              highlight: true,
                              keyboardType: TextInputType.phone,
                              hideCharacter: true,
                              maskCharacter: "*",
                              highlightColor: qbAppSecondaryBlueColor,
                              pinBoxColor: qbAppTextColor,
                              controller: otpController,
                              pinBoxHeight: 25,
                              pinBoxWidth: 25,
                              pinBoxDecoration: ProvidedPinBoxDecoration
                                  .underlinedPinBoxDecoration,
                              wrapAlignment: WrapAlignment.spaceAround,
                              pinTextStyle: GoogleFonts.roboto(
                                  fontSize: 20 /
                                      MediaQuery.of(context).textScaleFactor,
                                  fontWeight: FontWeight.w500,
                                  color: qbAppTextColor),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          (!isOTPVerified)
                              ? Container(
                                  child: CustomButton(
                                    child: Text(
                                      "Verify",
                                      style: GoogleFonts.roboto(
                                          fontSize: 13.5,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                      textScaleFactor: 1.0,
                                    ),
                                    color: qbAppPrimaryGreenColor,
                                    borderRadius: BorderRadius.circular(2.5),
                                    onPressed: () {},
                                  ),
                                )
                              : Container(
                                  child: Text(
                                    "Verified",
                                    style: GoogleFonts.roboto(
                                        fontSize: 13.5,
                                        fontWeight: FontWeight.w500,
                                        color: qbAppSecondaryGreenColor),
                                    textScaleFactor: 1.0,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 9, horizontal: 25),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: qbAppSecondaryGreenColor,
                                          width: 1.5),
                                      borderRadius: BorderRadius.circular(2.5)),
                                )
                        ],
                      ),
                    ),

                    // Change pin
                    Container(
                      width: 240,
                      padding: EdgeInsets.symmetric(vertical: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Change Pin Text
                          Container(
                            child: Text(
                              "Enter New Pin",
                              style: GoogleFonts.nunito(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: qbAppTextColor),
                              textScaleFactor: 1.0,
                            ),
                          ),

                          Container(
                            width: 150,
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: PinCodeTextField(
                              autofocus: false,
                              highlight: true,
                              keyboardType: TextInputType.phone,
                              hideCharacter: true,
                              maskCharacter: "*",
                              highlightColor: qbAppSecondaryBlueColor,
                              pinBoxColor: qbAppTextColor,
                              controller: otpController,
                              pinBoxHeight: 20,
                              pinBoxWidth: 20,
                              pinBoxDecoration: ProvidedPinBoxDecoration
                                  .underlinedPinBoxDecoration,
                              wrapAlignment: WrapAlignment.spaceBetween,
                              pinTextStyle: GoogleFonts.roboto(
                                  fontSize: 17.5 /
                                      MediaQuery.of(context).textScaleFactor,
                                  fontWeight: FontWeight.w500,
                                  color: qbAppTextColor),
                            ),
                          ),

                          SizedBox(
                            height: 10,
                          ),

                          // Change Pin Text
                          Container(
                            child: Text(
                              "Confirm Pin",
                              style: GoogleFonts.nunito(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: qbAppTextColor),
                              textScaleFactor: 1.0,
                            ),
                          ),

                          Container(
                            width: 150,
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: PinCodeTextField(
                              autofocus: false,
                              highlight: true,
                              keyboardType: TextInputType.phone,
                              hideCharacter: true,
                              maskCharacter: "*",
                              highlightColor: qbAppSecondaryBlueColor,
                              pinBoxColor: qbAppTextColor,
                              controller: otpController,
                              pinBoxHeight: 20,
                              pinBoxWidth: 20,
                              pinBoxDecoration: ProvidedPinBoxDecoration
                                  .underlinedPinBoxDecoration,
                              wrapAlignment: WrapAlignment.spaceBetween,
                              pinTextStyle: GoogleFonts.roboto(
                                  fontSize: 17.5 /
                                      MediaQuery.of(context).textScaleFactor,
                                  fontWeight: FontWeight.w500,
                                  color: qbAppTextColor),
                            ),
                          ),
                        ],
                      ),
                    )
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
