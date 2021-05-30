import 'package:getparked/StateManagement/Models/AppOverlayStyleData.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:provider/provider.dart';
import '../../Theme/AppOverlayStyle.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoaderPage extends StatefulWidget {
  Color bgColor;

  LoaderPage({this.bgColor: Colors.white});

  @override
  _LoaderPageState createState() => _LoaderPageState();
}

class _LoaderPageState extends State<LoaderPage> {
  AppState gpAppState;
  AppOverlayStyleType appOverlayStyleType;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gpAppState = Provider.of(context, listen: false);
    if (widget.bgColor == qbAppBGBluishGreyColor) {
      appOverlayStyleType = AppOverlayStyleType.greyBG;
    } else {
      appOverlayStyleType = AppOverlayStyleType.whiteBG;
    }
  }

  @override
  Widget build(BuildContext context) {
    gpAppState.applySpecificOverlayStyle(appOverlayStyleType);
    return Container(
      child: SafeArea(
        top: false,
        maintainBottomViewPadding: true,
        child: Container(
          child: Scaffold(
            backgroundColor: widget.bgColor,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
