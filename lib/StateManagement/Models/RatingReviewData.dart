import 'package:getparked/StateManagement/Models/ParkingData.dart';
import 'package:getparked/StateManagement/Models/SlotData.dart';
import 'package:getparked/StateManagement/Models/UserDetails.dart';
import 'package:getparked/StateManagement/Models/VehicleData.dart';

class RatingReviewData {
  int id;

  int slotId;
  SlotData slotData;

  int userId;
  UserDetails userDetails;

  int parkingId;
  ParkingData parkingData;

  int vehicleId;
  VehicleData vehicleData;

  int ratingValue;
  String review;

  String time;
  int status;

  RatingReviewData.fromMap(Map ratingReviewMap) {
    if (ratingReviewMap != null) {
      if (ratingReviewMap["id"] != null) {
        id = ratingReviewMap["id"];
      }

      if (ratingReviewMap["slotId"] != null) {
        slotId = ratingReviewMap["slotId"];
      }
      if (ratingReviewMap["slot"] != null) {
        slotData = SlotData.fromMap(ratingReviewMap["slot"]);
      }

      if (ratingReviewMap["userId"] != null) {
        userId = ratingReviewMap["userId"];
      }
      if (ratingReviewMap["user"] != null) {
        if (ratingReviewMap["user"]["userDetails"] != null) {
          userDetails =
              UserDetails.fromMap(ratingReviewMap["user"]["userDetails"]);
        }
      }

      if (ratingReviewMap["vehicleId"] != null) {
        vehicleId = ratingReviewMap["vehicleId"];
      }
      if (ratingReviewMap["vehicle"] != null) {
        vehicleData = VehicleData.fromMap(ratingReviewMap["vehicle"]);
      }

      if (ratingReviewMap["ratingValue"] != null) {
        ratingValue = ratingReviewMap["ratingValue"];
      }

      if (ratingReviewMap["review"] != null) {
        review = ratingReviewMap["review"];
      }

      if (ratingReviewMap["time"] != null) {
        time = ratingReviewMap["time"];
      }

      if (ratingReviewMap["status"] != null) {
        status = ratingReviewMap["status"];
      }
    }
  }
}
