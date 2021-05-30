import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Parking Details",
          style: GoogleFonts.nunito(
              color: qbDetailDarkColor, fontWeight: FontWeight.w600),
          textScaleFactor: 1.0,
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 35,
            ),

            //profile Pic
            Container(
              alignment: Alignment.topCenter,
              child: Container(
                width: 180,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    'http://3.bp.blogspot.com/-eyqjRseMO64/Tjtyn--QCQI/AAAAAAAAJHg/2YC26e7mvXA/s1600/Beautiful+Home+Wallpapers+1.jpg',
                    fit: BoxFit.cover,
                    height: 180,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
