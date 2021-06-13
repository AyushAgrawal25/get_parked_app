import 'package:getparked/StateManagement/Models/BookingData.dart';
import 'package:getparked/StateManagement/Models/SlotImageData.dart';
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
  String isoCountryCode;

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
  SlotSpaceType spaceType;

  // Rating
  double rating;

  // Security Deposit Hours
  int securityDepositTime;

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

  SlotData.fromMap(Map slotMap) {
    if (slotMap != null) {
      data = slotMap;

      // Slot Id;
      if (slotMap["id"] != null) {
        id = slotMap["id"];
      }

      // Name
      if (slotMap["name"] != null) {
        name = slotMap["name"];
      }

      // Address
      if (slotMap["address"] != null) {
        address = slotMap["address"];
      }

      // State
      if (slotMap["state"] != null) {
        state = slotMap["state"];
      }

      // City
      if (slotMap["city"] != null) {
        city = slotMap["city"];
      }

      // Pincode
      if (slotMap["pincode"] != null) {
        pincode = slotMap["pincode"];
      }

      // Landmark
      if (slotMap["landmark"] != null) {
        landmark = slotMap["landmark"];
      }

      // Location Name
      if (slotMap["locationName"] != null) {
        locationName = slotMap["locationName"];
      }

      // Location Country
      if (slotMap["locationCountry"] != null) {
        country = slotMap["locationCountry"];
      }

      // Location ISO Country Code
      if (slotMap["isoCountryCode"] != null) {
        isoCountryCode = slotMap["isoCountryCode"];
      }

      //Location Latitude
      if (slotMap["latitude"] != null) {
        latitude = (slotMap["latitude"]).toDouble();
      }

      //Location Longitude
      if (slotMap["longitude"] != null) {
        longitude = (slotMap["longitude"]).toDouble();
      }

      // Length
      if (slotMap["length"] != null) {
        length = (slotMap["length"]).toDouble();
      }

      // Breadth
      if (slotMap["breadth"] != null) {
        breadth = (slotMap["breadth"]).toDouble();
      }

      // Height
      if (slotMap["height"] != null) {
        height = (slotMap["height"]).toDouble();
      }

      // Rating
      if (slotMap["rating"] != null) {
        rating = (slotMap["rating"]).toDouble();
      }

      // Images
      imageUrls = [];
      if (slotMap["images"] != null) {
        // Image Urls
        slotMap["images"].forEach((slotImage) {
          SlotImageData imageData = SlotImageData.fromMap(slotImage);
          if (imageData.type == SlotImageType.main) {
            thumbnailUrl = imageData.thumbnailUrl;
            mainImageUrl = imageData.imageUrl;
          } else {
            imageUrls.add(imageData.imageUrl);
          }
        });
      } else if (slotMap["slotImages"] != null) {
        // Image Urls
        slotMap["slotImages"].forEach((slotImage) {
          SlotImageData imageData = SlotImageData.fromMap(slotImage);
          if (imageData.type == SlotImageType.main) {
            thumbnailUrl = imageData.thumbnailUrl;
            mainImageUrl = imageData.imageUrl;
          } else {
            imageUrls.add(imageData.imageUrl);
          }
        });
      } else if (slotMap["SlotImages"] != null) {
        // Image Urls
        slotMap["SlotImages"].forEach((slotImage) {
          SlotImageData imageData = SlotImageData.fromMap(slotImage);
          if (imageData.type == SlotImageType.main) {
            thumbnailUrl = imageData.thumbnailUrl;
            mainImageUrl = imageData.imageUrl;
          } else {
            imageUrls.add(imageData.imageUrl);
          }
        });
      }

      vehicles = [];
      // Vehicles
      if (slotMap["vehicles"] != null) {
        // Vehicles
        slotMap["vehicles"].forEach((slotVehicle) {
          VehicleData vehicleData = VehicleData.fromMap(slotVehicle);
          vehicles.add(vehicleData);
        });
      } else if (slotMap["slotVehicles"] != null) {
        // Vehicles
        slotMap["slotVehicles"].forEach((slotVehicle) {
          VehicleData vehicleData = VehicleData.fromMap(slotVehicle);
          vehicles.add(vehicleData);
        });
      }

      // TODO: update this bookin data too.
      bookings = [];
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
      userDetails = UserDetailsUtils.fromMapToUserDetails(slotMap);

      // Start Time
      if (slotMap["startTime"] != null) {
        startTime = slotMap["startTime"];
      }

      // End Time
      if (slotMap["endTime"] != null) {
        endTime = slotMap["endTime"];
      }

      // Parking Type
      if (slotMap["spaceType"] != null) {
        spaceType = SlotDataUtils.getSpaceTypeFromString(slotMap["spaceType"]);
      }

      // Deposit Time
      if (slotMap["securityDepositTime"] != null) {
        securityDepositTime = slotMap["securityDepositTime"];
      }

      // Status
      if (slotMap["status"] != null) {
        status = slotMap["status"];
      }
    }
  }

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
      this.isoCountryCode,
      this.latitude,
      this.longitude,
      this.length,
      this.breadth,
      this.height,
      this.startTime,
      this.endTime,
      this.spaceType,
      this.rating,
      this.securityDepositTime,
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
        isoCountryCode: slotMap["slotLocationISOCountryCode"],
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
        securityDepositTime: slotMap["slotSpecSecurityDepositTime"],
        spaceType: (slotMap["slotSpecSpaceParkingType"] == "Open")
            ? SlotSpaceType.open
            : SlotSpaceType.sheded,
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

  static String getSpaceTypeAsString(SlotSpaceType type) {
    if (type == SlotSpaceType.open) {
      return "Open";
    }
    return "Sheded";
  }

  static SlotSpaceType getSpaceTypeFromString(String type) {
    if (type == "Open") {
      return SlotSpaceType.open;
    }
    return SlotSpaceType.sheded;
  }
}

enum SlotSpaceType { open, sheded }
