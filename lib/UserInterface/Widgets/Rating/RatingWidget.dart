import 'package:getparked/UserInterface/Widgets/Rating/RatingTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import '../../Theme/AppTheme.dart';
import 'package:google_fonts/google_fonts.dart';

class RatingWidget extends StatefulWidget {
  double ratingValue;
  double fontSize;
  double iconSize;
  bool toShowRatingText;

  RatingWidget(
      {@required this.ratingValue,
      this.fontSize,
      this.iconSize,
      this.toShowRatingText: true});

  @override
  _RatingWidgetState createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  var qbRatingWidget = <Widget>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget ratingWidget;
    if ((widget.ratingValue == null) || (widget.ratingValue == 0)) {
      ratingWidget = Container(
        child: Text(
          "No Ratings",
          style: GoogleFonts.roboto(
            color: qbAppTextColor,
            fontSize: widget.fontSize,
            fontWeight: FontWeight.w500,
          ),
          textScaleFactor: 1.0,
        ),
      );
    } else {
      qbRatingWidget = [];
      if (this.widget.toShowRatingText) {
        qbRatingWidget.add(Text(
          "Rating : ",
          style: GoogleFonts.roboto(
            color: qbDetailDarkColor,
            fontSize: widget.fontSize,
            fontWeight: FontWeight.w500,
          ),
          textScaleFactor: 1.0,
        ));
      }

      for (int i = 0; i < 5; i++) {
        if (i < widget.ratingValue) {
          qbRatingWidget.add(Icon(FontAwesome.star,
              size: widget.iconSize, color: qbRatingStarFilledColor));
        } else {
          qbRatingWidget.add(Icon(FontAwesome.star_empty,
              size: widget.iconSize - 1.5, color: qbRatingStarEmptyColor));
        }
        qbRatingWidget.add(SizedBox(
          width: 2.5,
        ));
      }

      ratingWidget = Container(
        child: Row(children: qbRatingWidget),
      );
    }

    return ratingWidget;
  }
}
