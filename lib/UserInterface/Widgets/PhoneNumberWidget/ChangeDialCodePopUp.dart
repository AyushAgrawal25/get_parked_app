import 'dart:collection';

import 'package:getparked/UserInterface/Widgets/PhoneNumberWidget/PhoneNumberDialCodes.dart';
import 'package:getparked/UserInterface/Widgets/PhoneNumberWidget/CountryDialCodeWidget.dart';
import 'package:getparked/UserInterface/Widgets/UnderLineTextFormField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangeDialCodePopUp {
  show({BuildContext context, Function(String, String) onDialCodeSelected}) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          // insetPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          content: Container(
            width: double.maxFinite,
            child: ChangeDialCodeContent(
              onSelect: (String dialCode, String flagUrl) {
                onDialCodeSelected(dialCode, flagUrl);
                Navigator.of(context).pop();
              },
            ),
          ),
        );
      },
    );
  }
}

class ChangeDialCodeContent extends StatefulWidget {
  Function(String, String) onSelect;
  ChangeDialCodeContent({@required this.onSelect});
  @override
  _ChangeDialCodeContentState createState() => _ChangeDialCodeContentState();
}

class _ChangeDialCodeContentState extends State<ChangeDialCodeContent> {
  @override
  void initState() {
    super.initState();
    dialCodes = dialCodesCompleteList;
  }

  List<Map<String, dynamic>> dialCodes = [];

  String qbSearchText = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          UnderLineTextFormField(
            labelText: "Search by Country Name",
            labelTextFontWeight: FontWeight.w400,
            onChange: (value) {
              print(value);
              setState(() {
                qbSearchText = value;
              });
            },
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.5),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: dialCodes.length,
                itemBuilder: (BuildContext context, int index) {
                  return CountryDialCodeWidget(
                    dialCode: dialCodes[index]["dialCode"],
                    flagUrl: dialCodes[index]["flagUrl"],
                    isoCode: dialCodes[index]["isoCode"],
                    name: dialCodes[index]["name"],
                    searchText: qbSearchText,
                    onSelect: widget.onSelect,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
