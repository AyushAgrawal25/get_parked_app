import 'package:getparked/StateManagement/Models/BookingData.dart';
import 'package:getparked/StateManagement/Models/UserDetails.dart';
import 'package:getparked/StateManagement/Models/VehicleData.dart';

class SlotData {
  int id;
  String name;

  // Address
  String address;
  String state;
  String city;
  String pincode;
  String landmark;
  String locationName;
  String country;
  String countryCode;

  // User Details
  UserDetails userDetails;

  // Lat Long
  double latitude;
  double longitude;

  // dimensions
  double length;
  double breadth;
  double height;

  // Timing
  int startTime;
  int endTime;

  // Parking Type
  int spaceType;

  // Rating
  double rating;

  // Security Deposit Hours
  int securityDepositHours;

  // Images
  List<String> imageUrls;

  // Main Image
  String mainImageUrl;
  String thumbnailUrl;

  // Vehicles Data
  List<VehicleData> vehicles;

  // Bookings Data
  List<BookingData> bookings;

  // Ratings And Reviews Data

  // CompleteData
  Map data;

  // Status
  int status;

  SlotData(
      {this.id,
      this.name,
      this.userDetails,
      this.address,
      this.state,
      this.city,
      this.pincode,
      this.landmark,
      this.locationName,
      this.country,
      this.countryCode,
      this.latitude,
      this.longitude,
      this.length,
      this.breadth,
      this.height,
      this.startTime,
      this.endTime,
      this.spaceType,
      this.rating,
      this.securityDepositHours,
      this.vehicles,
      this.bookings,
      this.imageUrls,
      this.mainImageUrl,
      this.thumbnailUrl,
      this.data,
      this.status});
}

class SlotDataUtils {
  static SlotData mapToSlotData(Map slotMap) {
    List<String> imageUrls = [];
    String mainImageUrl = "";
    String thumbnailUrl = "";
    if (slotMap["images"] != null) {
      // Image Urls
      slotMap["images"].forEach((slotImage) {
        if (slotImage["slotImageType"] == 1) {
          imageUrls.add(slotImage["slotImageUrl"]);
        } else {
          thumbnailUrl = slotImage["slotImageThumbnailUrl"];
          mainImageUrl = slotImage["slotImageUrl"];
        }
      });
    } else if (slotMap["slotImages"] != null) {
      // Image Urls
      slotMap["slotImages"].forEach((slotImage) {
        if (slotImage["slotImageType"] == 1) {
          imageUrls.add(slotImage["slotImageUrl"]);
        } else {
          thumbnailUrl = slotImage["slotImageThumbnailUrl"];
          mainImageUrl = slotImage["slotImageUrl"];
        }
      });
    }

    List<VehicleData> vehicles = [];
    if (slotMap["vehicles"] != null) {
      // Vehicles
      slotMap["vehicles"].forEach((slotVehicle) {
        VehicleData vehicleData =
            VehicleDataUtils.mapToVehicleData(slotVehicle);
        vehicles.add(vehicleData);
      });
    } else if (slotMap["slotVehicles"] != null) {
      // Vehicles
      slotMap["slotVehicles"].forEach((slotVehicle) {
        VehicleData vehicleData =
            VehicleDataUtils.mapToVehicleData(slotVehicle);
        vehicles.add(vehicleData);
      });
    }

    List<BookingData> bookings = [];
    if (slotMap["bookings"] != null) {
      // Bookings
      slotMap["bookings"].forEach((slotBooking) {
        BookingData bookingData =
            BookingDataUtils.mapToBookingData(slotBooking);
        bookings.add(bookingData);
      });
    } else if (slotMap["slotBookings"] != null) {
      // Bookings
      slotMap["slotBookings"].forEach((slotBooking) {
        BookingData bookingData =
            BookingDataUtils.mapToBookingData(slotBooking);
        bookings.add(bookingData);
      });
    }

    // User Details
    UserDetails userDetails = UserDetailsUtils.fromMapToUserDetails(slotMap);

    // Rating
    double rating;
    if (slotMap["slotRating"] != null) {
      rating = (slotMap["slotRating"] != null)
          ? slotMap["slotRating"].toDouble()
          : 0.0;
    } else if (slotMap["rating"] != null) {
      rating = (slotMap["rating"] != null) ? slotMap["rating"].toDouble() : 0.0;
    }

    SlotData slotData = SlotData(
        id: slotMap["slotId"],
        name: slotMap["slotName"],
        userDetails: userDetails,
        address: slotMap["slotAddress"],
        state: slotMap["slotState"],
        city: slotMap["slotCity"],
        pincode: slotMap["slotPincode"],
        landmark: slotMap["slotLandmark"],
        locationName: slotMap["slotLocationName"],
        country: slotMap["slotLocationCountry"],
        countryCode: slotMap["slotLocationISOCountryCode"],
        latitude: (slotMap["slotLocationLatitude"] != null)
            ? (slotMap["slotLocationLatitude"]).toDouble()
            : 0.0,
        longitude: (slotMap["slotLocationLongitude"] != null)
            ? (slotMap["slotLocationLongitude"]).toDouble()
            : 0.0,
        length: (slotMap["slotSpecLength"] != null)
            ? (slotMap["slotSpecLength"]).toDouble()
            : null,
        breadth: (slotMap["slotSpecBreadth"] != null)
            ? (slotMap["slotSpecBreadth"]).toDouble()
            : null,
        height: (slotMap["slotSpecHeight"] != null)
            ? (slotMap["slotSpecHeight"]).toDouble()
            : null,
        startTime: slotMap["slotSpecParkingStartTime"],
        endTime: slotMap["slotSpecParkingEndTime"],
        securityDepositHours: slotMap["slotSpecSecurityDepositTime"],
        spaceType: slotMap["slotSpecSpaceParkingType"],
        rating: rating,
        imageUrls: imageUrls,
        mainImageUrl: mainImageUrl,
        thumbnailUrl: thumbnailUrl,
        vehicles: vehicles,
        bookings: bookings,
        data: slotMap,
        status: slotMap["slotStatus"]);
    return slotData;
  }

  String convertToShowTime(int startTime, int endTime) {
    String parkingTime = "";

    // Adding Start Time
    if (startTime == 0) {
      parkingTime += "12 am";
    } else if ((startTime > 0) && (startTime < 12)) {
      parkingTime += "$startTime am";
    } else if ((startTime > 12) && (startTime < 24)) {
      parkingTime += "${(startTime % 12)} pm";
    }

    parkingTime += " To ";

    // Adding End Time
    if (endTime == 0) {
      parkingTime += "12 am";
    } else if ((endTime > 0) && (endTime < 12)) {
      parkingTime += "$endTime am";
    } else if ((endTime > 12) && (endTime < 24)) {
      parkingTime += "${(endTime % 12)} pm";
    }

    return parkingTime;
  }

  static SlotData mapToSlotDataOnSlotId(List slotsMap, int slotId) {
    SlotData slotData;
    slotsMap.forEach((slotMap) {
      if (slotMap["slotId"] == slotId) {
        slotData = mapToSlotData(slotMap);
      }
    });

    return slotData;
  }
}
