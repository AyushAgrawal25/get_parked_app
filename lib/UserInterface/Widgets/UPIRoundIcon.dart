import 'package:getparked/Utils/DomainUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:upi_pay/upi_pay.dart';

class UPIAppRoundWidget extends StatefulWidget {
  final UpiApplication upiApplication;
  final Function payFun;

  UPIAppRoundWidget({this.upiApplication, this.payFun});

  @override
  _UPIAppRoundWidgetState createState() => _UPIAppRoundWidgetState();
}

class _UPIAppRoundWidgetState extends State<UPIAppRoundWidget> {
  String appIconPath = "assets/images/upiApps/";

  @override
  void initState() {
    super.initState();
    String appIconName = "Airtel.jpg";
    if (widget.upiApplication == UpiApplication.airtel) {
      appIconName = "Airtel.jpg";
    } else if (widget.upiApplication == UpiApplication.amazonPay) {
      appIconName = "Amazon Pay.jpg";
    } else if (widget.upiApplication == UpiApplication.bhim) {
      appIconName = "BHIM.jpg";
    } else if (widget.upiApplication == UpiApplication.googlePay) {
      appIconName = "Google Pay.jpg";
    } else if (widget.upiApplication == UpiApplication.iMobile) {
      appIconName = "iMobile by ICICI.jpg";
    } else if (widget.upiApplication == UpiApplication.miPay) {
      appIconName = "MiPay.jpg";
    } else if (widget.upiApplication == UpiApplication.paytm) {
      appIconName = "Paytm.jpg";
    } else if (widget.upiApplication == UpiApplication.phonePe) {
      appIconName = "PhonePe.jpg";
    } else if (widget.upiApplication == UpiApplication.sbiPay) {
      appIconName = "SBI Pay.jpg";
    } else if (widget.upiApplication == UpiApplication.trueCaller) {
      appIconName = "Truecaller.jpg";
    } else if (widget.upiApplication == UpiApplication.whatsApp) {
      appIconName = "whatsapp.PNG";
    }

    appIconPath += appIconName;
    print(appIconPath);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        child: GestureDetector(
          child: Container(
              width: 75,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Column(
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 5,
                                spreadRadius: 0.35,
                                offset: Offset(4, 4),
                                color: Color.fromRGBO(0, 0, 0, 0.15))
                          ]),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(45445),
                        child: Image.asset(
                          appIconPath,
                          height: 45,
                          width: 45,
                        ),
                      )),
                  Container(
                    padding:
                        EdgeInsets.only(top: 10, bottom: 5, left: 5, right: 5),
                    child: Text(
                      widget.upiApplication.getAppName(),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 12.5),
                      textAlign: TextAlign.center,
                      textScaleFactor: 1.0,
                    ),
                  ),
                ],
              )),
          onTap: () {
            SystemSound.play(SystemSoundType.click);
            widget.payFun(widget.upiApplication);
          },
        ));
  }
}
