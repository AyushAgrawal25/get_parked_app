import 'package:getparked/StateManagement/Models/RatingReviewData.dart';
import 'package:getparked/StateManagement/Models/ReviewData.dart';
import 'package:getparked/StateManagement/Models/VehicleRatingReviewData.dart';
import 'package:getparked/UserInterface/Icons/g_p_icons_icons.dart';
import 'package:getparked/UserInterface/Widgets/Reviews/UIComponets/ReviewCard.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/CustomIcon.dart';
import 'package:getparked/UserInterface/Widgets/Loaders/LoaderPage.dart';
import 'package:getparked/UserInterface/Widgets/Reviews/UIComponets/VehicleRatingWidget.dart';
import 'package:flutter/material.dart';

class TabContent extends StatelessWidget {
  final VehicleRatingReviewData ratingReviewData;
  TabContent({
    @required this.ratingReviewData,
  });

  Widget reviewsWidget = Container();
  setReviewsWidget() {
    if (this.ratingReviewData != null) {
      if (this.ratingReviewData.reviews.length == 0) {
        reviewsWidget = Container(
          child: Center(
            child: Text(
              "No Reviews Found !",
              textScaleFactor: 1.0,
            ),
          ),
        );
      } else {
        reviewsWidget = Container(
          child: ListView.builder(
              itemCount: this.ratingReviewData.reviews.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return VehicleRatingWidget(
                    rating: this.ratingReviewData.rating,
                    vehicleType: this.ratingReviewData.vehicleType,
                  );
                } else {
                  return ReviewCard(
                      reviewData: this.ratingReviewData.reviews[index - 1]);
                }
              }),
        );
      }
    } else {
      reviewsWidget = Container(
        child: Center(
          child: Text(
            "No Reviews Found !\nMay be Due to Poor Internet Connection.",
            textScaleFactor: 1.0,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    setReviewsWidget();
    return Container(
      child: Stack(
        children: [
          // Main Page,
          reviewsWidget,
        ],
      ),
    );
  }
}
