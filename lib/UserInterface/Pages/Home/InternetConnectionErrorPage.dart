import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InternetConnectionErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Color.fromRGBO(250, 250, 250, 1),
      alignment: Alignment.center,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                child: Image.asset(
              'assets/images/ConnectionError.png',
              width: MediaQuery.of(context).size.width * 5 / 6,
              fit: BoxFit.cover,
              color: Color.fromRGBO(170, 170, 170, 1),
            )),
            SizedBox(
              height: 25,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 4 / 6,
              child: Text(
                "Internet Connection Error!",
                style: GoogleFonts.nunito(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(170, 170, 170, 1)),
                textAlign: TextAlign.center,
                textScaleFactor: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
