import 'package:getparked/StateManagement/Models/RatingReviewData.dart';
import 'package:getparked/StateManagement/Models/ReviewData.dart';
import 'package:getparked/UserInterface/Icons/g_p_icons_icons.dart';
import 'package:getparked/UserInterface/Widgets/Reviews/UIComponets/ReviewCard.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/CustomIcon.dart';
import 'package:getparked/UserInterface/Widgets/Loaders/LoaderPage.dart';
import 'package:getparked/UserInterface/Widgets/Reviews/UIComponets/VehicleRatingWidget.dart';
import 'package:flutter/material.dart';

class TabContent extends StatelessWidget {
  RatingReviewData ratingReview;
  bool isLoading;
  TabContent({
    @required this.isLoading,
    @required this.ratingReview,
  });

  Widget reviewsWidget = Container();
  setReviewsWidget() {
    if (this.ratingReview != null) {
      if (this.ratingReview.reviews != null) {
        if (this.ratingReview.reviews.length == 0) {
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
                itemCount: this.ratingReview.reviews.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return VehicleRatingWidget(
                      rating: this.ratingReview.rating,
                      vehicleType: this.ratingReview.vehicleType,
                    );
                  } else {
                    return ReviewCard(
                        reviewData: this.ratingReview.reviews[index - 1]);
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
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    setReviewsWidget();
    return Container(
      child: Stack(
        children: [
          // Main Page,
          reviewsWidget,

          (this.isLoading)
              ? LoaderPage()
              : Container(
                  height: 0,
                  width: 0,
                )
        ],
      ),
    );
  }
}
