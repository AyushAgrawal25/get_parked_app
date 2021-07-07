// import 'package:getparked/StateManagement/Models/VehicleData.dart';
// import 'package:getparked/StateManagement/Models/VehicleTypeData.dart';
// import 'package:getparked/Utils/VehiclesUtils.dart';
// import 'package:getparked/StateManagement/Models/UserDetails.dart';

// class ReviewData {
//   int id;
//   int slotId;
//   int rating;
//   int parkingId;
//   int vehicleTypeId;
//   VehicleType vehicleType;
//   String text;
//   String time;
//   int status;

//   UserDetails userDetails;

//   ReviewData(Map reviewDataMap) {
//     id = reviewDataMap["slotReviewId"];
//     slotId = reviewDataMap["slotReviewSlotId"];
//     text = reviewDataMap["slotReviewText"];
//     time = reviewDataMap["slotReviewTime"];
//     status = reviewDataMap["slotReviewStatus"];

//     userDetails = UserDetailsUtils.fromMapToUserDetails(reviewDataMap);
//   }

//   ReviewData.fromMap(Map reviewDataMap) {
//     id = reviewDataMap["slotReviewId"];
//     slotId = reviewDataMap["slotReviewSlotId"];
//     rating = reviewDataMap["slotRatingValue"];
//     parkingId = reviewDataMap["slotReviewParkingId"];
//     vehicleTypeId = reviewDataMap["slotReviewVehicleTypeMasterId"];
//     vehicleType = VehiclesUtils().typeFromVehicleTypeId(vehicleTypeId);
//     text = reviewDataMap["slotReviewText"];
//     time = reviewDataMap["slotReviewTime"];
//     status = reviewDataMap["slotReviewStatus"];

//     userDetails = UserDetailsUtils.fromMapToUserDetails(reviewDataMap);
//   }
// }
