import 'package:getparked/StateManagement/Models/RatingReviewData.dart';
import 'package:getparked/StateManagement/Models/ReviewData.dart';
import 'package:getparked/UserInterface/Icons/g_p_icons_icons.dart';
import 'package:getparked/UserInterface/Widgets/Reviews/UIComponets/TabContent.dart';
import 'package:getparked/UserInterface/Widgets/Reviews/UIComponets/TabHeader.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/CustomIcon.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Reviews extends StatefulWidget {
  List<RatingReviewData> ratingReviews;
  bool isLoading;
  Reviews({this.isLoading, @required this.ratingReviews});
  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        top: false,
        maintainBottomViewPadding: true,
        child: Container(
          child: DefaultTabController(
              length: 5,
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
                  bottom: TabBar(
                    isScrollable: true,
                    tabs: [
                      TabHeader(
                        icon: GPIcons.bike_bag,
                        name: "Bike",
                      ),
                      TabHeader(
                        icon: GPIcons.hatch_back_car,
                        name: "Mini",
                      ),
                      TabHeader(
                        icon: GPIcons.sedan_car,
                        name: "Sedan",
                      ),
                      TabHeader(
                        icon: GPIcons.van,
                        name: "Van",
                      ),
                      TabHeader(
                        icon: GPIcons.suv_car,
                        name: "SUV",
                      ),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    TabContent(
                        isLoading: widget.isLoading,
                        ratingReview: (widget.ratingReviews.length > 0)
                            ? widget.ratingReviews[0]
                            : null),
                    TabContent(
                        isLoading: widget.isLoading,
                        ratingReview: (widget.ratingReviews.length > 0)
                            ? widget.ratingReviews[1]
                            : null),
                    TabContent(
                        isLoading: widget.isLoading,
                        ratingReview: (widget.ratingReviews.length > 0)
                            ? widget.ratingReviews[2]
                            : null),
                    TabContent(
                        isLoading: widget.isLoading,
                        ratingReview: (widget.ratingReviews.length > 0)
                            ? widget.ratingReviews[3]
                            : null),
                    TabContent(
                        isLoading: widget.isLoading,
                        ratingReview: (widget.ratingReviews.length > 0)
                            ? widget.ratingReviews[4]
                            : null),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
