import 'package:getparked/UserInterface/Widgets/DisplayPicture.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getparked/UserInterface/Widgets/SlotDetails/SlotDetail.dart';
import 'package:getparked/UserInterface/Widgets/Rating/RatingWidget.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SlotDetailsWidget extends StatefulWidget {
  Map details;
  Map moreDetails;
  SlotDetailsWidget({this.details, this.moreDetails});

  @override
  _SlotDetailsWidgetState createState() => _SlotDetailsWidgetState();
}

class _SlotDetailsWidgetState extends State<SlotDetailsWidget>
    with SingleTickerProviderStateMixin {
  var qbDetailWidgetList = <Widget>[];
  var qbMoreDetailsWidgetList = <Widget>[];

  AnimationController qbAccAnimController;
  Animation<double> qbAccHeightAnim;
  String accStatus = "close";

  String accHeaderText = "More Details";
  IconData accHeaderIcon = FontAwesome.angle_down;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    qbAccAnimController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));

    qbAccHeightAnim =
        Tween<double>(begin: 0.0, end: 185.0).animate(qbAccAnimController)
          ..addListener(() {
            setState(() {});
          });
  }

  @override
  Widget build(BuildContext context) {
    qbDetailWidgetList = [];
    if (widget.details != null) {
      //For Name
      if (widget.details['slotName'] != null) {
        qbDetailWidgetList.add(
          Container(
            child: Text(
              widget.details['slotName'],
              style: GoogleFonts.mukta(
                fontSize: 22.5,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.start,
              textScaleFactor: 1,
            ),
          ),
        );

        qbDetailWidgetList.add(
          SizedBox(
            height: 5,
          ),
        );
      }

      //For user
      if (widget.details['user'] != null) {
        qbDetailWidgetList.add(Container(
          padding: EdgeInsets.fromLTRB(15, 5, 0, 5),
          child: Row(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Color.fromRGBO(235, 235, 235, 1)),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/images/male.png',
                                fit: BoxFit.cover,
                                height: 35,
                                width: 35,
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(360),
                              child: CachedNetworkImage(
                                imageUrl: widget.details['user']['imageUrl'],
                                fit: BoxFit.cover,
                                height: 40,
                                width: 40,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.details['user']['name'],
                    style: GoogleFonts.roboto(
                        fontSize: 15, fontWeight: FontWeight.w500),
                    textScaleFactor: 1,
                  ),
                ),
              ),
            ],
          ),
        ));
      }

      //For Email
      if (widget.details['email'] != null) {
        qbDetailWidgetList.add(
          SlotDetailWidget(
            iconName: FontAwesomeIcons.envelope,
            detail: widget.details['email'],
          ),
        );
      }

      //For Rating
      if (widget.details['rating'] != null) {
        qbDetailWidgetList.add(Container(
          padding: EdgeInsets.fromLTRB(30, 10, 0, 10),
          child: RatingWidget(
            fontSize: 12.5,
            ratingValue: widget.details["rating"],
            iconSize: 13,
          ),
        ));
      }

      //For dob
      if (widget.details['dob'] != null) {
        qbDetailWidgetList.add(
          SlotDetailWidget(
            iconName: FontAwesomeIcons.calendar,
            detail: widget.details['dob'],
            isEditable: true,
          ),
        );
      }

      //For UpiId
      if (widget.details['upiId'] != null) {
        qbDetailWidgetList.add(
          SlotDetailWidget(
            iconName: FontAwesomeIcons.wallet,
            detail: widget.details['upiId'],
          ),
        );
      }

      //For number
      if (widget.details['number'] != null) {
        qbDetailWidgetList.add(
          SlotDetailWidget(
            iconName: FontAwesomeIcons.phone,
            detail: widget.details['number'],
            isEditable: true,
          ),
        );
      }
    }

    //MoreDetails address
    if (widget.moreDetails != null) {
      qbMoreDetailsWidgetList = [];

      if (widget.moreDetails['address'] != null) {
        qbMoreDetailsWidgetList.add(Container(
          padding: EdgeInsets.symmetric(vertical: 2.5, horizontal: 10),
          child: Row(
            children: <Widget>[
              Text(
                "Address : ",
                style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: qbAppTextColor),
                textScaleFactor: 1.0,
              ),
              Text(
                widget.moreDetails['address'],
                style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: qbAppTextColor),
                textScaleFactor: 1.0,
              )
            ],
          ),
        ));

        //For dob
        if (widget.details['dob'] != null) {
          qbDetailWidgetList.add(
            SlotDetailWidget(
              iconName: FontAwesomeIcons.calendar,
              detail: widget.details['dob'],
              isEditable: true,
            ),
          );
        }

        //For UpiId
        if (widget.details['upiId'] != null) {
          qbDetailWidgetList.add(
            SlotDetailWidget(
              iconName: FontAwesomeIcons.wallet,
              detail: widget.details['upiId'],
            ),
          );
        }

        //For number
        if (widget.details['number'] != null) {
          qbDetailWidgetList.add(
            SlotDetailWidget(
              iconName: FontAwesomeIcons.phone,
              detail: widget.details['number'],
              isEditable: true,
            ),
          );
        }
      }

      if (widget.moreDetails['timing'] != null) {
        qbMoreDetailsWidgetList.add(Container(
          padding: EdgeInsets.symmetric(vertical: 2.5, horizontal: 10),
          child: Row(
            children: <Widget>[
              Text(
                "Timing : ",
                style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: qbAppTextColor),
                textScaleFactor: 1.0,
              ),
              Text(
                widget.moreDetails['timing'],
                style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: qbAppTextColor),
                textScaleFactor: 1.0,
              )
            ],
          ),
        ));
      }

      if (widget.moreDetails['landmark'] != null) {
        qbMoreDetailsWidgetList.add(Container(
          padding: EdgeInsets.symmetric(vertical: 2.5, horizontal: 10),
          child: Row(
            children: <Widget>[
              Text(
                "Landmark : ",
                style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: qbAppTextColor),
                textScaleFactor: 1.0,
              ),
              Text(
                widget.moreDetails['landmark'],
                style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: qbAppTextColor),
                textScaleFactor: 1.0,
              )
            ],
          ),
        ));
      }

      if (widget.moreDetails['slotImageUrls'] != null) {
        var qbSlotImages = <Widget>[];

        for (var i = 0; i < widget.moreDetails['slotImageUrls'].length; i++) {
          qbSlotImages.add(Container(
            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: DisplayPicture(
              imgUrl: widget.moreDetails["slotImageUrls"][i],
              isEditable: false,
              width: 100,
              height: 100,
            ),
          ));
        }

        qbMoreDetailsWidgetList.add(Container(
            child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            width: ((widget.moreDetails['slotImageUrls'].length * 110) >
                    (MediaQuery.of(context).size.width))
                ? (widget.moreDetails['slotImageUrls'].length * 110).toDouble()
                : (MediaQuery.of(context).size.width),
            child: Row(
                mainAxisSize: MainAxisSize.min,
                children: qbSlotImages,
                mainAxisAlignment: MainAxisAlignment.start),
          ),
        )));
      }
    }

    return Container(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
        child: Column(
          children: <Widget>[
            Column(children: qbDetailWidgetList),
            Container(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  child: IntrinsicWidth(
                    child: Row(
                      children: <Widget>[
                        Text(
                          accHeaderText,
                          style: GoogleFonts.mPlus1p(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          textScaleFactor: 1.0,
                        ),
                        Icon(
                          accHeaderIcon,
                          size: 14,
                        ),
                        SizedBox(
                          width: 20,
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    if (accStatus == "open") {
                      qbAccAnimController.reverse();
                      setState(() {
                        accStatus = "close";
                        accHeaderText = "More Details";
                        accHeaderIcon = FontAwesome.angle_down;
                      });
                    } else {
                      qbAccAnimController.forward();
                      setState(() {
                        accStatus = "open";
                        accHeaderText = "Less Details";
                        accHeaderIcon = FontAwesome.angle_up;
                      });
                    }

                    SystemSound.play(SystemSoundType.click);
                  },
                )),
            AnimatedBuilder(
              animation: qbAccAnimController,
              builder: (context, child) {
                return Container(
                  height: qbAccHeightAnim.value,
                  child: SingleChildScrollView(
                      child: Column(
                    children: qbMoreDetailsWidgetList,
                  )),
                );
              },
            )
          ],
        ));
  }
}
