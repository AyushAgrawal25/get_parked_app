import 'package:getparked/UserInterface/Widgets/OutlineTextFormField.dart';
import 'package:getparked/UserInterface/Widgets/UnderLineTextFormField.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:getparked/UserInterface/Widgets/PhoneNumberWidget/PhoneNumberDialCodes.dart';
import 'package:getparked/UserInterface/Widgets/PhoneNumberWidget/ChangeDialCodePopUp.dart';
import 'package:getparked/UserInterface/Widgets/PhoneNumberWidget/PhoneNumberDialCodeWidget.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:flutter_svg/svg.dart';

class PhoneNumberWidget extends StatefulWidget {
  Function(String, String) onChange;
  PhoneNumberTextFieldType textFieldType;
  bool readOnly;

  PhoneNumberWidget(
      {this.onChange,
      this.textFieldType: PhoneNumberTextFieldType.outline,
      this.readOnly: false});
  @override
  _PhoneNumberWidgetState createState() => _PhoneNumberWidgetState();
}

class _PhoneNumberWidgetState extends State<PhoneNumberWidget> {
  @override
  void initState() {
    super.initState();
  }

  List<Map<String, dynamic>> dialCodes = dialCodesCompleteList;
  String dialCode = "91";
  String flagUrl = "https://restcountries.eu/data/ind.svg";
  onChangeCountryCode() {
    ChangeDialCodePopUp()
        .show(context: context, onDialCodeSelected: onCountryCodeChanged);
  }

  onCountryCodeChanged(String dc, String fu) {
    setState(() {
      dialCode = dc;
      flagUrl = fu;
    });

    onValueChange();
  }

  String phNum = "";
  onPhNumChange(String value) {
    setState(() {
      phNum = value;
    });

    onValueChange();
  }

  onValueChange() {
    if (widget.onChange != null) {
      widget.onChange("+" + dialCode, phNum);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 50,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Dial Code Widget
          Container(
            child: PhoneNumberDialCodeWidget(
              dialCode: dialCode,
              flagUrl: flagUrl,
              isReadOnly: widget.readOnly,
              onPressed: onChangeCountryCode,
            ),
          ),

          SizedBox(
            width: 5,
          ),

          // Number Field
          Expanded(
            child: Container(
              child:
                  (widget.textFieldType == PhoneNumberTextFieldType.underline)
                      ? UnderLineTextFormField(
                          labelText: "Phone Number",
                          isReadOnly: widget.readOnly,
                          keyboardType: TextInputType.phone,
                          onChange: onPhNumChange,
                          labelTextFontWeight: FontWeight.w400,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          margin: EdgeInsets.zero,
                        )
                      : OutlineTextFormField(
                          labelText: "Phone Number",
                          fontSize: 14,
                          keyboardType: TextInputType.phone,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.5, vertical: 12.5),
                          onChange: onPhNumChange,
                          isReadOnly: widget.readOnly,
                          labelTextFontWeight: FontWeight.w400,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          margin: EdgeInsets.zero,
                        ),
            ),
          )
        ],
      ),
    );
  }
}

enum PhoneNumberTextFieldType { underline, outline }
