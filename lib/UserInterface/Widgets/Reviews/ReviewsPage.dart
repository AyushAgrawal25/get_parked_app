// TODO: create this page.
// import 'package:getparked/BussinessLogic/RatingsAndReviewsUtils.dart';
import 'package:getparked/BussinessLogic/RatingsReviewsServices.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/StateManagement/Models/RatingReviewData.dart';
import 'package:getparked/StateManagement/Models/ReviewData.dart';
import 'package:getparked/StateManagement/Models/VehicleRatingReviewData.dart';
import 'package:getparked/UserInterface/Widgets/Loaders/LoaderPage.dart';
import 'package:getparked/UserInterface/Widgets/Reviews/OldReviews.dart';
import 'package:flutter/material.dart';
import 'package:getparked/UserInterface/Widgets/Reviews/ReviewsNew.dart';
import 'package:provider/provider.dart';

class ReviewsPage extends StatefulWidget {
  final int slotId;
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

  List<VehicleRatingReviewData> vehicleRatingReviews;
  bool isLoading = false;

  initializeReviews() async {
    if (gpAppState.isInternetConnected == true) {
      setState(() {
        isLoading = true;
      });
      vehicleRatingReviews = await RatingsReviewsServices().getRatingReviews(
          slotId: widget.slotId, authToken: gpAppState.authToken);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   //     child: Reviews(
    //   //   reviews: (gpReviews != null) ? gpReviews : [],
    //   //   isLoading: isLoading,
    //   // )
    //   child: Reviews(
    //     isLoading: isLoading,
    //     ratingReviews: (gpRatingReviews != null) ? gpRatingReviews : [],
    //   ),
    // );

    if (isLoading) {
      return LoaderPage();
    }

    return ReviewsNew(
      vehicleRatingReviews: vehicleRatingReviews,
    );
  }
}
