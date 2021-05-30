import 'package:getparked/UserInterface/Icons/g_p_icons_icons.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/CustomIcon.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

class CheckPinWidget extends StatelessWidget {
  Function(String) onDone;
  Function onForgotPinPressed;
  Function onChangePinPressed;

  CheckPinWidget(
      {@required this.onDone,
      @required this.onForgotPinPressed,
      @required this.onChangePinPressed});

  TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // App Logo
          Container(
            child: CustomIcon(
              icon: GPIcons.get_parked_logo,
              color: qbAppPrimaryGreenColor,
              size: 75,
            ),
          ),

          SizedBox(
            height: 15,
          ),

          // Enter Transaction Pin
          Container(
            child: Text(
              "Enter Transaction Pin",
              style: GoogleFonts.nunito(
                  fontSize: 17.5,
                  fontWeight: FontWeight.w700,
                  color: qbDetailDarkColor),
              textScaleFactor: 1.0,
            ),
          ),

          Container(
            width: 220,
            padding: EdgeInsets.only(top: 15),
            child: PinCodeTextField(
                autofocus: true,
                highlight: true,
                keyboardType: TextInputType.phone,
                hideCharacter: true,
                maskCharacter: "*",
                highlightColor: qbAppSecondaryBlueColor,
                pinBoxColor: qbAppTextColor,
                controller: otpController,
                pinBoxHeight: 25,
                pinBoxWidth: 25,
                pinBoxDecoration:
                    ProvidedPinBoxDecoration.underlinedPinBoxDecoration,
                wrapAlignment: WrapAlignment.spaceAround,
                pinTextStyle: GoogleFonts.roboto(
                    fontSize: 20 / MediaQuery.of(context).textScaleFactor,
                    fontWeight: FontWeight.w500,
                    color: qbAppTextColor),
                onDone: this.onDone),
          ),

          Container(
            width: 220,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: FlatButton(
                      child: Text(
                        "Forgot Pin",
                        style: GoogleFonts.roboto(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w500,
                            color: qbAppPrimaryBlueColor),
                        textScaleFactor: 1.0,
                      ),
                      onPressed: this.onForgotPinPressed),
                ),
                Container(
                  child: FlatButton(
                      child: Text(
                        "Change Pin",
                        style: GoogleFonts.roboto(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w500,
                            color: qbAppPrimaryBlueColor),
                        textScaleFactor: 1.0,
                      ),
                      onPressed: this.onChangePinPressed),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
