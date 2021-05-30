import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import './../Theme/AppTheme.dart';
import 'package:google_fonts/google_fonts.dart';

class UnderLineTextFormField extends StatefulWidget {
  Function(String) onChange;
  String value;
  String labelText;
  FontWeight labelTextFontWeight;
  double width;
  double fontSize;
  bool isReadOnly;
  EdgeInsets margin;
  EdgeInsets padding;
  EdgeInsets contentPadding;
  TextInputType keyboardType;
  List<TextInputFormatter> inputFormatters;
  bool showClearButton;
  Widget prefixIcon;

  UnderLineTextFormField(
      {@required this.labelText,
      this.labelTextFontWeight: FontWeight.w500,
      this.onChange,
      this.width,
      this.fontSize: 16,
      this.margin,
      this.padding,
      this.keyboardType: TextInputType.text,
      this.contentPadding: defContentPadding,
      this.value,
      this.prefixIcon,
      this.inputFormatters,
      this.showClearButton: false,
      this.isReadOnly: false});

  //Default Values
  static const EdgeInsets defContentPadding =
      EdgeInsets.only(left: 10, right: 10, top: 7.5, bottom: 7.5);

  @override
  _UnderLineTextFormFieldState createState() => _UnderLineTextFormFieldState();
}

class _UnderLineTextFormFieldState extends State<UnderLineTextFormField> {
  TextEditingController _textEditingController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textEditingController = TextEditingController();
    if (widget.value != null) {
      _textEditingController.text = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    // if (widget.value != null) {
    //   _textEditingController.text = widget.value;
    // }
    return Container(
      width: widget.width,
      padding: widget.padding,
      margin: (widget.margin == null)
          ? EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10)
          : widget.margin,
      child: TextFormField(
        controller: _textEditingController,
        minLines: 1,
        maxLines: 1,
        keyboardType: widget.keyboardType,
        onChanged: (value) {
          widget.onChange(value);
        },
        readOnly: widget.isReadOnly,
        style: GoogleFonts.roboto(
            fontSize: widget.fontSize / MediaQuery.of(context).textScaleFactor),
        decoration: InputDecoration(
            labelText: widget.labelText,
            labelStyle: GoogleFonts.roboto(
              fontSize: widget.fontSize / MediaQuery.textScaleFactorOf(context),
              color: qbAppTextColor,
              fontWeight: widget.labelTextFontWeight,
            ),
            contentPadding: widget.contentPadding,
            alignLabelWithHint: true,
            isDense: true,
            prefixIcon: widget.prefixIcon,
            suffixIcon: (widget.showClearButton)
                ? IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _textEditingController.clear();
                      widget.onChange("");
                    },
                  )
                : Container(
                    height: 0,
                    width: 0,
                  )
            // prefixIcon: Icon(Icons.account_circle)
            ),
        inputFormatters:
            (widget.inputFormatters != null) ? widget.inputFormatters : [],
      ),
    );
  }
}
