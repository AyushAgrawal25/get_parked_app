import 'package:flutter/material.dart';
import 'package:getparked/UserInterface/Pages/HelpAndSupport/HelpAndSupport.dart';
import 'package:getparked/UserInterface/Widgets/Loaders/LoaderPage.dart';

class HelpAndSupportPage extends StatefulWidget {
  @override
  _HelpAndSupportPageState createState() => _HelpAndSupportPageState();
}

class _HelpAndSupportPageState extends State<HelpAndSupportPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            child: HelpAndSupport(),
          )
        ],
      ),
    );
  }
}
