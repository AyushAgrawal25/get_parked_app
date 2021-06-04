import 'package:getparked/UserInterface/Pages/Login/UIComponents/CircleSectionWidget.dart';
import 'package:flutter/material.dart';

final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

class CurveTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double rad = MediaQuery.of(context).size.width;
    double height = rad * (1 - (1.732 / 2));
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: darkBlue,
      alignment: Alignment.center,
      // Main Code
      child: Container(
        color: Colors.red,
        child: ClipRect(
          child: Align(
            alignment: Alignment.topCenter,
            heightFactor: height / rad,
            child: Container(
              height: rad,
              width: rad,
              child: FractionallySizedBox(
                heightFactor: 2,
                widthFactor: 2,
                alignment: Alignment.topCenter,
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.5),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(rad),
                        topRight: Radius.circular(rad),
                      )),
                ),
              ),
            ),
          ),
        ),
      ),

      // child: CircleSectionWidget(
      //     color: Colors.white,
      //     radius: MediaQuery.of(context).size.width,
      //     height: 60,
      //     width: MediaQuery.of(context).size.width - 20),
    );
  }
}
