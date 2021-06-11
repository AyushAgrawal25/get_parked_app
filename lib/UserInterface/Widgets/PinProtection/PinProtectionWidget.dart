import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/PinProtection/CheckPinWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PinProtectionWidget extends StatefulWidget {
  PinOperationType operationType;

  PinProtectionWidget({@required this.operationType});

  @override
  _PinProtectionWidgetState createState() => _PinProtectionWidgetState();
}

class _PinProtectionWidgetState extends State<PinProtectionWidget> {
  AppState gpAppState;
  TextEditingController otpController;

  @override
  void initState() {
    super.initState();

    gpAppState = Provider.of<AppState>(context, listen: false);
    otpController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.operationType == PinOperationType.checkPin) {
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
                      Expanded(
                          child: CheckPinWidget(
                        onDone: (String pin) {
                          print(pin);
                          // Send It to Loader And Then Complete Transaction
                          // Call the Api to check it whether it is correct of not
                        },
                        onChangePinPressed: () {
                          print("Trying Changing IT");
                        },
                        onForgotPinPressed: () {
                          print("Forgot");
                        },
                      )),
                      Expanded(
                        child: Container(
                          width: 0,
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
    } else if (widget.operationType == PinOperationType.setPin) {}
  }
}

enum PinOperationType { checkPin, setPin, forgotPin, changePin }
