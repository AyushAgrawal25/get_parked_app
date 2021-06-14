import 'package:getparked/StateManagement/Models/BookingData.dart';
import 'package:getparked/StateManagement/Models/SlotData.dart';
import 'package:getparked/StateManagement/Models/UserDetails.dart';
import 'package:getparked/StateManagement/Models/VehicleData.dart';

class ParkingRequestData {
  int id;
  int parkingHours;
  SlotSpaceType spaceType;

  // Booking Data
  BookingData bookingData;

  // Slot Data
  int slotId;
  SlotData slotData;

  // User Details
  int userId;
  UserDetails userDetails;

  // Vehicle
  int vehicleId;
  VehicleData vehicleData;

  // Complete Data
  Map data;

  String time;
  int status;

  ParkingRequestData.fromMap(Map parkingRequestMap) {
    id = parkingRequestMap["id"];
    parkingHours = parkingRequestMap["id"];
    spaceType =
        SlotDataUtils.getSpaceTypeFromString(parkingRequestMap["spaceType"]);

    // Booking Data
    Map bookingMap;
    if ((parkingRequestMap["SlotBooking"]) != null) {
      bookingMap = parkingRequestMap["SlotBooking"];
    } else if ((parkingRequestMap["booking"]) != null) {
      bookingMap = parkingRequestMap["booking"];
    } else if ((parkingRequestMap["slotBooking"]) != null) {
      bookingMap = parkingRequestMap["slotBooking"];
    }
    if (bookingMap != null) {
      if (bookingMap["id"] != null) {
        bookingData = BookingData.fromMap(bookingMap);
      }
    }

    // Slot Data
    slotId = parkingRequestMap["slotId"];
    if (parkingRequestMap["slot"] != null) {
      slotData = SlotData.fromMap(parkingRequestMap["slot"]);
    } else if (parkingRequestMap["slotData"] != null) {
      slotData = SlotData.fromMap(parkingRequestMap["slotData"]);
    }

    // User Details
    userId = parkingRequestMap["userId"];
    if (parkingRequestMap["userData"] != null) {
      userDetails = UserDetails.fromMap(parkingRequestMap["userData"]);
    } else if ((parkingRequestMap["user"] != null) &&
        (parkingRequestMap["user"]["userDetails"] != null)) {
      userDetails =
          UserDetails.fromMap(parkingRequestMap["user"]["userDetails"]);
    } else if (parkingRequestMap["userDetail"] != null) {
      userDetails = UserDetails.fromMap(parkingRequestMap["userDetail"]);
    } else if (parkingRequestMap["userDetails"] != null) {
      userDetails = UserDetails.fromMap(parkingRequestMap["userDetails"]);
    }

    // Vehicle Data
    vehicleId = parkingRequestMap["vehicleId"];
    if (parkingRequestMap["vehicleData"] != null) {
      vehicleData = VehicleData.fromMap(parkingRequestMap["vehicleData"]);
    } else if (parkingRequestMap["vehicle"] != null) {
      vehicleData = VehicleData.fromMap(parkingRequestMap["vehicle"]);
    } else if (parkingRequestMap["slotVehicle"] != null) {
      vehicleData = VehicleData.fromMap(parkingRequestMap["slotVehicle"]);
    }

    data = parkingRequestMap;

    time = parkingRequestMap["time"];
    status = parkingRequestMap["status"];
  }

  ParkingRequestDataType getParkingRequestDataType() {
    DateTime currentTime = DateTime.now().toLocal();
    DateTime parkingTime = DateTime.parse(time).toLocal();

    int timeDiff = currentTime.difference(parkingTime).inMinutes;
    ParkingRequestDataType type;
    switch (status) {
      case 0:
        if (timeDiff < parkingRequestValidityTime) {
          type = ParkingRequestDataType.pending;
        } else {
          type = ParkingRequestDataType.pendingButExpired;
        }
        break;

      case 1:
        if (timeDiff < bookingValidityTime) {
          type = ParkingRequestDataType.accepted_BookingPending;
        } else {
          type = ParkingRequestDataType.accepted_BookingExpired;
        }
        break;

      case 2:
        type = ParkingRequestDataType.rejected;
        break;

      case 3:
        if (bookingData != null) {
          switch (bookingData.status) {
            case 0:
              type = ParkingRequestDataType.booked_BookingFailed;
              break;
            case 1:
              type = ParkingRequestDataType.booked_BookingGoingON;
              break;
            case 2:
              type = ParkingRequestDataType.booked_BookingCancelled;
              break;
            case 3:
              type = ParkingRequestDataType.booked_ParkingGoingON;
              break;
            case 4:
              type = ParkingRequestDataType.booked_ParkedAndWithdrawn;
              break;
          }
        } else {
          type = ParkingRequestDataType.booked;
        }
    }

    return type;
  }
}

enum ParkingRequestDataType {
  // Pending Types Status 0
  pending,
  pendingButExpired,

  // Accepted Types Status 1
  accepted,
  accepted_BookingPending,
  accepted_BookingExpired,

  // Booked Types Status 3
  booked,
  booked_BookingFailed,
  booked_BookingGoingON,
  booked_BookingCancelled,
  booked_ParkingGoingON,
  booked_ParkedAndWithdrawn,

  // Rejected Status 2
  rejected
}

int parkingRequestValidityTime = 60;
