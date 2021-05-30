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

  int spaceType;
  int parkingHours;
  int otp;

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
    this.otp,
    this.time,
    this.duration,
    this.exceedDuration,
    this.data,
    this.status,
  });

  BookingData.fromMap(Map bookingMap) {
    id = bookingMap["slotBookingId"];

    // Parking Data
    Map parkingMap;
    if (bookingMap["parkingData"] != null) {
      parkingMap = bookingMap["parkingData"];
    } else if (bookingMap["parking"] != null) {
      parkingMap = bookingMap["parking"];
    } else if (bookingMap["slotParking"] != null) {
      parkingMap = bookingMap["slotParking"];
    }
    if (parkingMap != null) {
      if (parkingMap["slotParkingId"] != null) {
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
    userId = bookingMap["slotBookingUserId"];
    if (bookingMap["userData"] != null) {
      userDetails =
          UserDetailsUtils.fromMapToUserDetails(bookingMap["userData"]);
    } else if (bookingMap["userDetails"] != null) {
      userDetails =
          UserDetailsUtils.fromMapToUserDetails(bookingMap["userDetails"]);
    } else if (bookingMap["user"] != null) {
      userDetails = UserDetailsUtils.fromMapToUserDetails(bookingMap["user"]);
    }

    // Slot Data
    slotId = bookingMap["slotBookingSlotId"];
    if (bookingMap["slotData"] != null) {
      slotData = SlotDataUtils.mapToSlotData(bookingMap["slotData"]);
    }

    // Vehicle Data
    vehicleId = bookingMap["slotBookingVehicleId"];
    if (bookingMap["slotVehicle"] != null) {
      vehicleData =
          VehicleDataUtils.mapToVehicleData(bookingMap["slotVehicle"]);
    } else if (bookingMap["vehicle"] != null) {
      vehicleData = VehicleDataUtils.mapToVehicleData(bookingMap["vehicle"]);
    } else if (bookingMap["vehicleData"] != null) {
      vehicleData =
          VehicleDataUtils.mapToVehicleData(bookingMap["vehicleData"]);
    }

    parkingRequestId = bookingMap["slotBookingParkingRequestId"];
    spaceType = bookingMap["slotBookingParkingType"];
    parkingHours = bookingMap["slotBookingParkingHours"];

    otp = bookingMap["slotBookingOTP"];

    // Duration
    time = bookingMap["slotBookingTime"];
    duration = bookingMap["slotBookingDuration"];
    exceedDuration = bookingMap["slotBookingExceedDuration"];

    data = bookingMap;
    status = bookingMap["slotBookingStatus"];
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

class BookingDataUtils {
  static mapToBookingData(Map bookingMap) {
    BookingData bookingData = BookingData(
        id: bookingMap["slotBookingId"],
        userId: bookingMap["slotBookingUserId"],
        slotId: bookingMap["slotBookingSlotId"],
        parkingRequestId: bookingMap["slotBookingParkingRequestId"],
        vehicleId: bookingMap["slotBookingVehicleId"],
        spaceType: bookingMap["slotBookingParkingType"],
        parkingHours: bookingMap["slotBookingParkingHours"],
        otp: bookingMap["slotBookingOTP"],
        time: bookingMap["slotBookingTime"],
        duration: bookingMap["slotBookingDuration"],
        exceedDuration: bookingMap["slotBookingExceedDuration"],
        status: bookingMap["slotBookingStatus"]);

    return bookingData;
  }
}

enum BookingDataType {
  failed,
  bookingGoingON,
  cancelled,
  parkingGoingON,
  parkedAndWithdrawn
}

int bookingValidityTime = 10;
