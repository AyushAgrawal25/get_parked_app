import 'package:flutter/material.dart';
import 'package:getparked/StateManagement/Models/VehicleRatingReviewData.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/Reviews/UIComponets/TabContent.dart';
import 'package:getparked/UserInterface/Widgets/Reviews/UIComponets/TabHeader.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewsNew extends StatefulWidget {
  final List<VehicleRatingReviewData> vehicleRatingReviews;
  ReviewsNew({@required this.vehicleRatingReviews});

  @override
  _ReviewsNewState createState() => _ReviewsNewState();
}

class _ReviewsNewState extends State<ReviewsNew> {
  @override
  Widget build(BuildContext context) {
    List<Widget> headers = [];
    List<Widget> contents = [];
    widget.vehicleRatingReviews.forEach((element) {
      headers.add(TabHeader(vehicleType: element.vehicleType));
      contents.add(TabContent(ratingReviewData: element));
    });

    return Container(
      child: SafeArea(
        top: false,
        maintainBottomViewPadding: true,
        child: Container(
          child: DefaultTabController(
            length: widget.vehicleRatingReviews.length,
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  "Reviews",
                  style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w600, color: qbAppTextColor),
                  textScaleFactor: 1.0,
                ),
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                brightness: Brightness.light,
                iconTheme: IconThemeData(color: qbAppTextColor),
                bottom: TabBar(isScrollable: true, tabs: headers),
              ),
              body: TabBarView(
                children: contents,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
