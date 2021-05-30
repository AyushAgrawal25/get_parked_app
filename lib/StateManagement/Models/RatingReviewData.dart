import 'package:getparked/StateManagement/Models/ReviewData.dart';
import 'package:getparked/StateManagement/Models/VehicleData.dart';
import 'package:getparked/Utils/VehiclesUtils.dart';

class RatingReviewData {
  int vehicleTypeId;
  VehicleType vehicleType;
  double rating;
  List<ReviewData> reviews = [];

  RatingReviewData.fromMap(Map ratingReviewMap) {
    if (ratingReviewMap != null) {
      if (ratingReviewMap["vehicleTypeMasterId"] != null) {
        vehicleTypeId = ratingReviewMap["vehicleTypeMasterId"];
        vehicleType = VehiclesUtils().typeFromVehicleTypeId(vehicleTypeId);
      }

      if (ratingReviewMap["rating"] != null) {
        rating = (ratingReviewMap["rating"]).toDouble();
      }

      reviews = [];
      List reviewsMap = ratingReviewMap["reviews"];

      reviewsMap.forEach((reviewMap) {
        reviews.add(ReviewData.fromMap(reviewMap));
      });
    }
  }
}
