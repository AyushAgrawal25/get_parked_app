import 'package:getparked/UserInterface/Widgets/DisplayPicture.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import './../Theme/AppTheme.dart';
import 'package:google_fonts/google_fonts.dart';

class MoreDetailsAcc extends StatefulWidget {
  EdgeInsets contentPadding;
  String address;
  String timing;
  String landmark;
  String city;
  String state;
  List<String> imgUrls;

  MoreDetailsAcc(
      {this.address,
      this.contentPadding,
      this.imgUrls,
      this.landmark,
      this.timing,
      this.state,
      this.city});

  @override
  _MoreDetailsAccState createState() => _MoreDetailsAccState();
}

class _MoreDetailsAccState extends State<MoreDetailsAcc>
    with SingleTickerProviderStateMixin {
  var qbMoreDetailsWidgetList = <Widget>[];

  AnimationController qbAccAnimController;
  Animation<double> qbAccHeightAnim;
  String accStatus = "close";

  String accHeaderText = "More Details";
  IconData accHeaderIcon = FontAwesome.angle_down;

  @override
  void initState() {
    super.initState();
  }

  bool isAccOpen = false;

  @override
  Widget build(BuildContext context) {
    if (isAccOpen) {
      accHeaderText = "Less Details";
      accHeaderIcon = FontAwesome.angle_up;
    } else {
      accHeaderText = "More Details";
      accHeaderIcon = FontAwesome.angle_down;
    }

    double contentHeight = 0;
    List<Widget> detailsWidget = [];

    if (widget.address != null) {
      detailsWidget.add(Container(
          padding: EdgeInsets.symmetric(vertical: 1.25),
          child: KeyValueRichText(keyName: "Address", value: widget.address)));

      contentHeight += 27.5;
    }

    if (widget.landmark != null) {
      detailsWidget.add(Container(
          padding: EdgeInsets.symmetric(vertical: 1.25),
          child:
              KeyValueRichText(keyName: "Landmark", value: widget.landmark)));

      contentHeight += 27.5;
    }

    if ((widget.city != null) || (widget.state != null)) {
      List<Widget> cityAndDetails = [];
      if (widget.city != null) {
        cityAndDetails.add(Flexible(
          child: KeyValueRichText(keyName: "City", value: widget.city),
        ));
      }
      if ((widget.city != null) && (widget.state != null)) {
        cityAndDetails.add(SizedBox(
          width: 20,
        ));
      }
      if (widget.state != null) {
        cityAndDetails.add(Flexible(
          child: KeyValueRichText(keyName: "State", value: widget.state),
        ));
      }

      detailsWidget.add(Container(
        padding: EdgeInsets.symmetric(vertical: 1.25),
        child: Row(
          children: cityAndDetails,
        ),
      ));

      contentHeight += 27.5;
    }

    if (widget.imgUrls != null) {
      if (widget.imgUrls.length > 0) {
        List<Widget> picWidgets = [];
        widget.imgUrls.forEach((imgUrl) {
          picWidgets.add(Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: DisplayPicture(
              imgUrl: imgUrl,
              height: 100,
              width: 100,
              isEditable: false,
              isDeletable: false,
            ),
          ));
        });

        detailsWidget.add(Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width:
                    ((picWidgets.length * 100) + ((picWidgets.length - 1) * 10))
                        .toDouble(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: picWidgets,
                ),
              ),
            )));

        contentHeight += 120;
      }
    }

    return Container(
      child: Column(
        children: <Widget>[
          //Header
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
                setState(() {
                  isAccOpen = !isAccOpen;
                });
                SystemSound.play(SystemSoundType.click);
              },
            ),
          ),

          AnimatedContainer(
            margin: (isAccOpen)
                ? EdgeInsets.symmetric(vertical: 2.5)
                : EdgeInsets.symmetric(vertical: 0),
            height: (isAccOpen) ? contentHeight : 0,
            duration: Duration(milliseconds: 200),
            child: Container(
              padding: widget.contentPadding,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: detailsWidget,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class KeyValueRichText extends StatelessWidget {
  String keyName;
  String value;

  KeyValueRichText({@required this.keyName, @required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2.5),
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
              text: "$keyName : ",
              style: GoogleFonts.roboto(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: qbDetailDarkColor)),
          TextSpan(
              text: value,
              style: GoogleFonts.roboto(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: qbDetailLightColor))
        ]),
        maxLines: 1,
        textScaleFactor: 1.0,
        textAlign: TextAlign.start,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
