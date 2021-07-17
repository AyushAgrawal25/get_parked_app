import 'package:getparked/StateManagement/Models/BookingData.dart';
import 'package:getparked/StateManagement/Models/RatingReviewData.dart';
import 'package:getparked/StateManagement/Models/SlotData.dart';
import 'package:getparked/StateManagement/Models/UserDetails.dart';
import 'package:getparked/StateManagement/Models/VehicleData.dart';

class ParkingData {
  int id;

  // Vehicle
  int vehicleId;
  VehicleData vehicleData;

  // User Details
  int userId;
  UserDetails userDetails;

  // Slot Data
  int slotId;
  SlotData slotData;

  // Booking Data
  int bookingId;
  BookingData bookingData;

  String withdrawOTP;
  SlotSpaceType spaceType;
  int parkingHours;

  RatingReviewData ratingReviewData;

  // Complete Data
  Map data;

  String time;
  int status;

  ParkingData.fromMap(Map parkingMap) {
    id = parkingMap["id"];

    // Vehicle Data
    vehicleId = parkingMap["vehicleId"];
    if (parkingMap["vehicleData"] != null) {
      vehicleData = VehicleData.fromMap(parkingMap["vehicleData"]);
    } else if (parkingMap["vehicle"] != null) {
      vehicleData = VehicleData.fromMap(parkingMap["vehicle"]);
    } else if (parkingMap["slotVehicle"] != null) {
      vehicleData = VehicleData.fromMap(parkingMap["slotVehicle"]);
    }

    // User Details
    userId = parkingMap["userId"];
    if (parkingMap["userData"] != null) {
      userDetails = UserDetails.fromMap(parkingMap["userData"]);
    } else if ((parkingMap["user"] != null) &&
        (parkingMap["user"]["userDetails"] != null)) {
      userDetails = UserDetails.fromMap(parkingMap["user"]["userDetails"]);
    } else if (parkingMap["userDetail"] != null) {
      userDetails = UserDetails.fromMap(parkingMap["userDetail"]);
    } else if (parkingMap["userDetails"] != null) {
      userDetails = UserDetails.fromMap(parkingMap["userDetails"]);
    }

    // Slot Data
    slotId = parkingMap["slotId"];
    if (parkingMap["slotData"] != null) {
      slotData = SlotData.fromMap(parkingMap["slotData"]);
    } else if (parkingMap["slot"] != null) {
      slotData = SlotData.fromMap(parkingMap["slot"]);
    }

    // Booking Data
    bookingId = parkingMap["bookingId"];
    if (parkingMap["bookingData"] != null) {
      bookingData = BookingData.fromMap(parkingMap["bookingData"]);
    } else if (parkingMap["booking"] != null) {
      bookingData = BookingData.fromMap(parkingMap["booking"]);
    } else if (parkingMap["slotBooking"] != null) {
      bookingData = BookingData.fromMap(parkingMap["slotBooking"]);
    } else if (parkingMap["SlotBooking"] != null) {
      bookingData = BookingData.fromMap(parkingMap["SlotBooking"]);
    }

    withdrawOTP = parkingMap["withdrawOTP"];
    parkingHours = parkingMap["parkingHours"];
    spaceType = SlotDataUtils.getSpaceTypeFromString(parkingMap["spaceType"]);

    if (parkingMap["slotRatingReview"] != null) {
      ratingReviewData =
          RatingReviewData.fromMap(parkingMap["slotRatingReview"]);
    }

    data = parkingMap;

    time = parkingMap["time"];
    status = parkingMap["status"];
  }

  ParkingDataType getParkingDataType() {
    ParkingDataType type;
    switch (status) {
      case 0:
        type = ParkingDataType.completed;
        break;
      case 1:
        type = ParkingDataType.goingON;
        break;
    }

    return type;
  }
}

enum ParkingDataType { completed, goingON }
