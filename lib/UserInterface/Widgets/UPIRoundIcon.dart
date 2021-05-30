import 'package:getparked/BussinessLogic/domainDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:upi_pay/upi_applications.dart';

class UPIAppRoundWidget extends StatefulWidget {
  UpiApplication upiApplication;
  Function payFun;

  UPIAppRoundWidget({this.upiApplication, this.payFun});

  @override
  _UPIAppRoundWidgetState createState() => _UPIAppRoundWidgetState();
}

class _UPIAppRoundWidgetState extends State<UPIAppRoundWidget> {
  String appIconImageUrl =
      "https://lh3.googleusercontent.com/AeMKuV3iGZsHPeSU_g13oYW0msutmjt3QiEbJvTiMh6dqFvyeTS-LHVs4Sa0d9q7RElI=s180";

  @override
  void initState() {
    appIconImageUrl = formatImgUrl(
        "/images/appIconImages/" + widget.upiApplication.getAppName());
    print(appIconImageUrl);

    super.initState();
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
                        child: Image.network(
                          appIconImageUrl,
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
