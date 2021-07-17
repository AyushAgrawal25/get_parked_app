import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:getparked/BussinessLogic/UserServices.dart';
import 'package:getparked/StateManagement/Models/RatingReviewData.dart';
import 'package:getparked/StateManagement/Models/VehicleRatingReviewData.dart';
import 'package:getparked/Utils/DomainUtils.dart';
import 'package:getparked/Utils/JSONUtils.dart';
import 'package:getparked/Utils/SecureStorageUtils.dart';
import 'package:http/http.dart' as http;

const String SLOTS_RATING_REVIEWS_ROUTE = "/app/slots/ratingsReviews";

class RatingsReviewsServices {
  Future<RatingReviewData> rateSlot(
      {@required int parkingId,
      @required int ratingValue,
      @required String authToken,
      @required String review}) async {
    try {
      Map<String, dynamic> reqBody = {
        "parkingId": parkingId,
        "ratingValue": ratingValue,
        "review": review
      };
      Uri url = Uri.parse(domainName + SLOTS_RATING_REVIEWS_ROUTE);
      http.Response resp = await http.post(url,
          body: JSONUtils().postBody(reqBody),
          headers: {
            CONTENT_TYPE_KEY: JSON_CONTENT_VALUE,
            AUTH_TOKEN: authToken
          });

      print(resp.body);
      if (resp.statusCode == 200) {
        Map ratingReview = json.decode(resp.body)["data"];
        return RatingReviewData.fromMap(ratingReview);
      }
      return null;
    } catch (excp) {
      print(excp);
      return null;
    }
  }

  Future<List<VehicleRatingReviewData>> getRatingReviews(
      {@required int slotId, @required String authToken}) async {
    try {
      Uri url = Uri.parse(domainName + SLOTS_RATING_REVIEWS_ROUTE + "/$slotId");
      http.Response resp =
          await http.get(url, headers: {AUTH_TOKEN: authToken});
      if (resp.statusCode == 200) {
        List vehicleMaps = json.decode(resp.body)["data"];
        List<VehicleRatingReviewData> vehicleReviewsData = [];
        vehicleMaps.forEach((vehicleRatingReviewMap) {
          // print(vehicleRatingReviewMap);
          vehicleReviewsData
              .add(VehicleRatingReviewData.fromMap(vehicleRatingReviewMap));
        });

        return vehicleReviewsData;
      } else if (resp.statusCode == 403) {
        return [];
      } else if (resp.statusCode == 500) {
        return [];
      }
      return [];
    } catch (excp) {
      print(excp);
      return [];
    }
  }
}
