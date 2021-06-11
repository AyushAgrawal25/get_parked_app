import 'dart:collection';

import 'package:getparked/StateManagement/Models/AppOverlayStyleData.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/StateManagement/Models/ReviewData.dart';
import 'package:getparked/UserInterface/Widgets/Reviews/UIComponets/OldReviewCard.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OldReviews extends StatefulWidget {
  List<ReviewData> reviews;
  bool isLoading;
  OldReviews({@required this.reviews, @required this.isLoading});
  @override
  _OldReviewsState createState() => _OldReviewsState();
}

class _OldReviewsState extends State<OldReviews> {
  AppState gpAppState;
  @override
  void initState() {
    super.initState();
    gpAppState = Provider.of<AppState>(context, listen: false);
  }

  List<ReviewCard> gpReviewCards = [];
  Widget gpReviewWidget;
  setReviewsCards() {
    if (!widget.isLoading) {
      if (widget.reviews == null) {
        gpReviewWidget = Container(
          child: Center(
            child: Text(
              "No Reviews Found !\nMay be Due to Poor Internet Connection.",
              textScaleFactor: 1.0,
            ),
          ),
        );
      } else {
        if (widget.reviews.length == 0) {
          gpReviewWidget = Container(
            child: Center(
              child: Text(
                "No Reviews Found !",
                textScaleFactor: 1.0,
              ),
            ),
          );
        } else {
          // Main Code
          if (widget.reviews != null) {
            gpReviewCards = [];
            widget.reviews.forEach((gpReview) {
              gpReviewCards.add(ReviewCard(
                reviewData: gpReview,
              ));
            });

            gpReviewWidget = Container(
              child: ListView(
                children: gpReviewCards,
              ),
            );
          }
        }
      }
    } else {
      gpReviewWidget = Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    setReviewsCards();
    return Scaffold(
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
        ),
        body: gpReviewWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
