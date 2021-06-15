import 'package:getparked/StateManagement/Models/ParkingData.dart';
import 'package:getparked/StateManagement/Models/SlotData.dart';
import 'package:getparked/StateManagement/Models/TransactionData.dart';
import 'package:getparked/StateManagement/Models/UserDetails.dart';
import 'package:getparked/StateManagement/Models/VehicleData.dart';

class BookingData {
  int id;
  int parkingRequestId;

  // Parking Data
  ParkingData parkingData;

  // Transaction Data
  TransactionData transactionData;

  // User Details
  int userId;
  UserDetails userDetails;

  // Slot Data
  int slotId;
  SlotData slotData;

  // Vehicle Data
  int vehicleId;
  VehicleData vehicleData;

  SlotSpaceType spaceType;
  int parkingHours;
  int parkingOTP;

  String time;

  // Durations
  int duration;
  int exceedDuration;

  // Conplete Data
  Map data;

  int status;

  BookingData({
    this.id,
    this.parkingRequestId,
    this.spaceType,
    this.parkingHours,
    this.vehicleId,
    this.userId,
    this.slotId,
    this.parkingOTP,
    this.time,
    this.duration,
    this.exceedDuration,
    this.data,
    this.status,
  });

  BookingData.fromMap(Map bookingMap) {
    id = bookingMap["id"];

    // Parking Data
    Map parkingMap;
    if (bookingMap["parkingData"] != null) {
      parkingMap = bookingMap["parkingData"];
    } else if (bookingMap["parking"] != null) {
      parkingMap = bookingMap["parking"];
    } else if (bookingMap["slotParking"] != null) {
      parkingMap = bookingMap["slotParking"];
    } else if (bookingMap["SlotParking"] != null) {
      parkingMap = bookingMap["SlotParking"];
    }

    if (parkingMap != null) {
      if (parkingMap["id"] != null) {
        parkingData = ParkingData.fromMap(parkingMap);
      }
    }

    // Transaction Data
    Map transactionMap;
    if (bookingMap["transactionData"] != null) {
      transactionMap = bookingMap["transactionData"];
    } else if (bookingMap["transaction"] != null) {
      transactionMap = bookingMap["transaction"];
    }
    if (transactionMap != null) {
      if (transactionMap["transactionId"] != null) {
        transactionData = TransactionData.fromMap(transactionMap);
      }
    }

    // User Details
    userId = bookingMap["userId"];
    if (bookingMap["userData"] != null) {
      userDetails = UserDetails.fromMap(bookingMap["userData"]);
    } else if ((bookingMap["user"] != null) &&
        (bookingMap["user"]["userDetails"] != null)) {
      userDetails = UserDetails.fromMap(bookingMap["user"]["userDetails"]);
    } else if (bookingMap["userDetail"] != null) {
      userDetails = UserDetails.fromMap(bookingMap["userDetail"]);
    } else if (bookingMap["userDetails"] != null) {
      userDetails = UserDetails.fromMap(bookingMap["userDetails"]);
    }

    // Slot Data
    slotId = bookingMap["slotId"];
    if (bookingMap["slotData"] != null) {
      slotData = SlotData.fromMap(bookingMap["slotData"]);
    } else if (bookingMap["slot"] != null) {
      slotData = SlotData.fromMap(bookingMap["slot"]);
    }

    // Vehicle Data
    vehicleId = bookingMap["vehicleId"];
    if (bookingMap["slotVehicle"] != null) {
      vehicleData = VehicleData.fromMap(bookingMap["slotVehicle"]);
    } else if (bookingMap["vehicle"] != null) {
      vehicleData = VehicleData.fromMap(bookingMap["vehicle"]);
    } else if (bookingMap["vehicleData"] != null) {
      vehicleData = VehicleData.fromMap(bookingMap["vehicleData"]);
    }

    parkingRequestId = bookingMap["parkingRequestId"];
    spaceType = SlotDataUtils.getSpaceTypeFromString(bookingMap["spaceType"]);
    parkingHours = bookingMap["parkingHours"];

    parkingOTP = (bookingMap["parkingOTP"] != null)
        ? int.parse(bookingMap["parkingOTP"])
        : 0;

    // Duration
    time = bookingMap["time"];
    duration = bookingMap["duration"];
    exceedDuration = bookingMap["exceedDuration"];

    data = bookingMap;
    status = bookingMap["status"];
  }

  BookingDataType getBookingDataType() {
    BookingDataType type;
    switch (status) {
      case 0:
        type = BookingDataType.failed;
        break;

      case 1:
        type = BookingDataType.bookingGoingON;
        break;
      case 2:
        type = BookingDataType.cancelled;
        break;
      case 3:
        type = BookingDataType.parkingGoingON;
        break;
      case 4:
        type = BookingDataType.parkedAndWithdrawn;
        break;
    }

    return type;
  }
}

class BookingDataUtils {}

enum BookingDataType {
  failed,
  bookingGoingON,
  cancelled,
  parkingGoingON,
  parkedAndWithdrawn
}

int bookingValidityTime = 10;
