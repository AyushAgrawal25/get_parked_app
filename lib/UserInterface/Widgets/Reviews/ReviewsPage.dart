// TODO: create this page.
// import 'package:getparked/BussinessLogic/RatingsAndReviewsUtils.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/StateManagement/Models/RatingReviewData.dart';
import 'package:getparked/StateManagement/Models/ReviewData.dart';
import 'package:getparked/UserInterface/Widgets/Reviews/Reviews.dart';
import 'package:getparked/UserInterface/Widgets/Reviews/OldReviews.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReviewsPage extends StatefulWidget {
  int slotId;
  ReviewsPage({@required this.slotId});
  @override
  @override
  _ReviewsPageState createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  AppState gpAppState;
  @override
  void initState() {
    super.initState();
    gpAppState = Provider.of<AppState>(context, listen: false);
    initializeReviews();
  }

  List<RatingReviewData> gpRatingReviews;
  bool isLoading = false;

  initializeReviews() async {
    if (gpAppState.isInternetConnected == true) {
      setState(() {
        isLoading = true;
      });
      gpRatingReviews = [];
      // TODO: Create this Utils And Solve this.
      // gpRatingReviews = await RatingsAndReviewsUtils().getRatingReviewsForSlot(
      //     widget.slotId, gpAppState.userData.accessToken);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //     child: Reviews(
      //   reviews: (gpReviews != null) ? gpReviews : [],
      //   isLoading: isLoading,
      // )
      child: Reviews(
        isLoading: isLoading,
        ratingReviews: (gpRatingReviews != null) ? gpRatingReviews : [],
      ),
    );
  }
}
