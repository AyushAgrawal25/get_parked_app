import 'package:getparked/StateManagement/Models/SlotImageData.dart';
import 'package:getparked/StateManagement/Models/SlotData.dart';
import 'package:getparked/StateManagement/Models/VehicleData.dart';

class ParkingLordData {
  int id;
  int userId;
  String token;

  String name;
  String address;
  String state;
  String city;
  String pincode;
  String landmark;
  String locationName;
  String locationCountry;
  String locationISOCountryCode;

  double locationLatitude;
  double locationLongitude;

  double rating;
  List<VehicleData> vehicles;
  SlotImageData mainImage;
  List<SlotImageData> images;

  double specLength;
  double specBreadth;
  double specHeight;

  int specParkingStartTime;
  int specParkingEndTime;
  int specSpaceParkingType;
  int specSecurityDepositTime;
  int status;

  Map data;

  ParkingLordData.fromMap(Map parkingLordMap) {
    if (parkingLordMap != null) {
      // Complete Data
      data = parkingLordMap;

      // Slot Id;
      if (parkingLordMap["slotId"] != null) {
        id = parkingLordMap["slotId"];
      }

      // User Id
      if (parkingLordMap["slotUserId"] != null) {
        userId = parkingLordMap["slotUserId"];
      }

      // Token
      if (parkingLordMap["slotToken"] != null) {
        token = parkingLordMap["slotToken"];
      }

      // Name
      if (parkingLordMap["slotName"] != null) {
        name = parkingLordMap["slotName"];
      }

      // Address
      if (parkingLordMap["slotAddress"] != null) {
        address = parkingLordMap["slotAddress"];
      }

      // State
      if (parkingLordMap["slotState"] != null) {
        state = parkingLordMap["slotState"];
      }

      // City
      if (parkingLordMap["slotCity"] != null) {
        city = parkingLordMap["slotCity"];
      }

      // Pincode
      if (parkingLordMap["slotPincode"] != null) {
        pincode = parkingLordMap["slotPincode"];
      }

      // Landmark
      if (parkingLordMap["slotLandmark"] != null) {
        landmark = parkingLordMap["slotLandmark"];
      }

      // Location Name
      if (parkingLordMap["slotLocationName"] != null) {
        locationName = parkingLordMap["slotLocationName"];
      }

      // Location Country
      if (parkingLordMap["slotLocationCountry"] != null) {
        locationCountry = parkingLordMap["slotLocationCountry"];
      }

      // Location ISO Country Code
      if (parkingLordMap["slotLocationISOCountryCode"] != null) {
        locationISOCountryCode = parkingLordMap["slotLocationISOCountryCode"];
      }

      //Location Latitude
      if (parkingLordMap["slotLocationLatitude"] != null) {
        locationLatitude = (parkingLordMap["slotLocationLatitude"]).toDouble();
      }

      //Location Longitude
      if (parkingLordMap["slotLocationLongitude"] != null) {
        locationLongitude =
            (parkingLordMap["slotLocationLongitude"]).toDouble();
      }

      // Length
      if (parkingLordMap["slotSpecLength"] != null) {
        specLength = (parkingLordMap["slotSpecLength"]).toDouble();
      }

      // Breadth
      if (parkingLordMap["slotSpecBreadth"] != null) {
        specBreadth = (parkingLordMap["slotSpecBreadth"]).toDouble();
      }

      // Height
      if (parkingLordMap["slotSpecHeight"] != null) {
        specHeight = (parkingLordMap["slotSpecHeight"]).toDouble();
      }

      // Rating
      if (parkingLordMap["rating"] != null) {
        rating = (parkingLordMap["rating"]).toDouble();
      }

      // Images
      images = [];
      if (parkingLordMap["images"] != null) {
        // Image Urls
        parkingLordMap["images"].forEach((slotImage) {
          if (slotImage["slotImageType"] == 1) {
            images.add(SlotImageData.fromMap(slotImage));
          } else {
            mainImage = SlotImageData.fromMap(slotImage);
          }
        });
      } else if (parkingLordMap["slotImages"] != null) {
        // Image Urls
        parkingLordMap["slotImages"].forEach((slotImage) {
          if (slotImage["slotImageType"] == 1) {
            images.add(SlotImageData.fromMap(slotImage));
          } else {
            mainImage = SlotImageData.fromMap(slotImage);
          }
        });
      }

      vehicles = [];
      // Vehicles
      if (parkingLordMap["vehicles"] != null) {
        // Vehicles
        parkingLordMap["vehicles"].forEach((slotVehicle) {
          VehicleData vehicleData =
              VehicleDataUtils.mapToVehicleData(slotVehicle);
          vehicles.add(vehicleData);
        });
      } else if (parkingLordMap["slotVehicles"] != null) {
        // Vehicles
        parkingLordMap["slotVehicles"].forEach((slotVehicle) {
          VehicleData vehicleData =
              VehicleDataUtils.mapToVehicleData(slotVehicle);
          vehicles.add(vehicleData);
        });
      }

      // Start Time
      if (parkingLordMap["slotSpecParkingStartTime"] != null) {
        specParkingStartTime = parkingLordMap["slotSpecParkingStartTime"];
      }

      // End Time
      if (parkingLordMap["slotSpecParkingEndTime"] != null) {
        specParkingEndTime = parkingLordMap["slotSpecParkingEndTime"];
      }

      // Parking Type
      if (parkingLordMap["slotSpecSpaceParkingType"] != null) {
        specSpaceParkingType = parkingLordMap["slotSpecSpaceParkingType"];
      }

      // Deposit Time
      if (parkingLordMap["slotSpecSecurityDepositTime"] != null) {
        specSecurityDepositTime = parkingLordMap["slotSpecSecurityDepositTime"];
      }

      // Status
      if (parkingLordMap["slotStatus"] != null) {
        status = parkingLordMap["slotStatus"];
      }
    }
  }

  SlotData toSlotData() {
    SlotData gpPLSlotData = SlotDataUtils.mapToSlotData(this.data);
    return gpPLSlotData;
  }
}
