import 'package:getparked/StateManagement/Models/BookingData.dart';
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

  int withdrawOTP;
  int spaceType;
  int parkingHours;

  // Complete Data
  Map data;

  String time;
  int status;

  ParkingData.fromMap(Map parkingMap) {
    id = parkingMap["slotParkingId"];

    // Vehicle Data
    vehicleId = parkingMap["slotParkingVehicleId"];
    if (parkingMap["vehicleData"] != null) {
      vehicleData =
          VehicleDataUtils.mapToVehicleData(parkingMap["vehicleData"]);
    } else if (parkingMap["vehicle"] != null) {
      vehicleData = VehicleDataUtils.mapToVehicleData(parkingMap["vehicle"]);
    } else if (parkingMap["slotVehicle"] != null) {
      vehicleData =
          VehicleDataUtils.mapToVehicleData(parkingMap["slotVehicle"]);
    }

    // User Details
    userId = parkingMap["slotParkingUserId"];
    if (parkingMap["userData"] != null) {
      userDetails =
          UserDetailsUtils.fromMapToUserDetails(parkingMap["userData"]);
    } else if (parkingMap["userDetails"] != null) {
      userDetails =
          UserDetailsUtils.fromMapToUserDetails(parkingMap["userDetails"]);
    }

    // Slot Data
    slotId = parkingMap["slotParkingSlotId"];
    if (parkingMap["slotData"] != null) {
      slotData = SlotDataUtils.mapToSlotData(parkingMap["slotData"]);
    }

    // Booking Data
    bookingId = parkingMap["slotParkingBookingId"];
    if (parkingMap["bookingData"] != null) {
      bookingData = BookingData.fromMap(parkingMap["bookingData"]);
    } else if (parkingMap["booking"] != null) {
      bookingData = BookingData.fromMap(parkingMap["booking"]);
    } else if (parkingMap["slotBooking"] != null) {
      bookingData = BookingData.fromMap(parkingMap["slotBooking"]);
    }

    withdrawOTP = parkingMap["slotParkingWithdrawOTP"];
    parkingHours = parkingMap["slotParkingParkingHours"];
    spaceType = parkingMap["slotParkingParkingType"];

    data = parkingMap;

    time = parkingMap["slotParkingTime"];
    status = parkingMap["slotParkingStatus"];
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
