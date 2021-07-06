import 'package:getparked/StateManagement/Models/ParkingRatingReviewData.dart';
import 'package:getparked/StateManagement/Models/RatingReviewData.dart';
import 'package:getparked/StateManagement/Models/VehicleData.dart';
import 'package:getparked/StateManagement/Models/VehicleTypeData.dart';
import 'package:getparked/Utils/VehiclesUtils.dart';

class VehicleRatingReviewData {
  VehicleType vehicleType;
  double rating;
  List<RatingReviewData> reviews = [];

  VehicleRatingReviewData.fromMap(Map vehicleRatingReviewMap) {
    if (vehicleRatingReviewMap["type"] != null) {
      vehicleType =
          VehicleTypeUtils.getTypeFromString(vehicleRatingReviewMap["type"]);
    }

    if (vehicleRatingReviewMap["rating"] != null) {
      rating = (vehicleRatingReviewMap["rating"]).toDouble();
    } else {
      rating = 0.0;
    }

    if (vehicleRatingReviewMap["reviews"] != null) {
      List reviewMaps = vehicleRatingReviewMap["reviews"];
      reviewMaps.forEach((reviewMap) {
        reviews.add(RatingReviewData.fromMap(reviewMap));
      });
    }
  }
}
