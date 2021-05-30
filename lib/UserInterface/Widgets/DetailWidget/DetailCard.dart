import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsCard extends StatefulWidget {
  String slotName;
  String imageUrl;
  String amount;
  String time;
  String date;
  String parkingHours;
  String transactionType;

  DetailsCard(
      {this.slotName: "Jayesh Agrawal's Residence",
      this.amount: "400",
      this.date: "10 March 2020",
      this.imageUrl: "null for now..",
      this.parkingHours: "10",
      this.time: "5:00pm",
      this.transactionType: "-"});

  @override
  _DetailsCardState createState() => _DetailsCardState();
}

class _DetailsCardState extends State<DetailsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 0.025,
                  blurRadius: 5,
                  offset: Offset(4, 4),
                  color: Color.fromRGBO(0, 0, 0, 0.04)),
            ],
            color: Color.fromRGBO(255, 255, 255, 1),
            border: Border.all(
              width: 2,
              color: Color.fromRGBO(238, 238, 238, 1),
            )),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Upper Row
            Row(children: <Widget>[
              //Profile Picture
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(238, 238, 238, 1),
                ),
              ),

              SizedBox(
                width: 12.5,
              ),

              //Slot Name
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.slotName,
                    style: GoogleFonts.yantramanav(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: qbDetailDarkColor),
                    textScaleFactor: 1,
                    maxLines: 2,
                  ),
                ),
              ),

              SizedBox(
                width: 7.5,
              ),

              (widget.transactionType == "+")
                  ? Container(
                      child: Icon(
                        Entypo.up_bold,
                        size: 15,
                        color: Colors.green,
                      ),
                    )
                  : Container(
                      child: Icon(
                        Entypo.down_bold,
                        size: 15,
                        color: Colors.red,
                      ),
                    ),

              SizedBox(
                width: 5,
              ),

              //Amount Paid
              Container(
                child: Text(
                  "Rs ",
                  style: GoogleFonts.roboto(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: qbDetailDarkColor),
                  textScaleFactor: 1.0,
                ),
              ),
              Container(
                child: Text(
                  widget.amount,
                  style: GoogleFonts.roboto(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: qbDetailDarkColor),
                  textScaleFactor: 1.0,
                ),
              ),
              Container(
                child: Text(
                  "/-",
                  style: GoogleFonts.roboto(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                      color: qbDetailDarkColor),
                  textScaleFactor: 1.0,
                ),
              )
            ]),

            //Sized Box
            SizedBox(
              height: 7.5,
            ),

            //Lower Row
            Row(
              children: <Widget>[
                //Time
                Container(
                  child: Text(
                    widget.time,
                    style: GoogleFonts.roboto(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                        color: qbDetailLightColor),
                    textScaleFactor: 1.0,
                  ),
                ),

                SizedBox(
                  width: 20,
                ),

                //Date
                Container(
                  child: Text(
                    widget.date,
                    style: GoogleFonts.roboto(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                        color: qbDetailLightColor),
                    textScaleFactor: 1.0,
                  ),
                ),

                Expanded(
                  child: SizedBox(
                    width: 20,
                  ),
                ),

                Container(
                  child: Text(
                    widget.parkingHours,
                    style: GoogleFonts.roboto(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                        color: qbDetailLightColor),
                    textScaleFactor: 1.0,
                  ),
                ),

                SizedBox(
                  width: 5,
                ),

                Container(
                  child: Text(
                    "Hours Parking",
                    style: GoogleFonts.roboto(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                        color: qbDetailLightColor),
                    textScaleFactor: 1.0,
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
