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
  String country;
  String isoCountryCode;

  double latitude;
  double longitude;

  double rating;
  List<VehicleData> vehicles;
  SlotImageData mainImage;
  List<SlotImageData> images;

  double length;
  double breadth;
  double height;

  int startTime;
  int endTime;
  SlotSpaceType spaceType;
  int securityDepositTime;
  int status;

  Map data;

  ParkingLordData.fromMap(Map parkingLordMap) {
    if (parkingLordMap != null) {
      // Complete Data
      data = parkingLordMap;

      // Slot Id;
      if (parkingLordMap["id"] != null) {
        id = parkingLordMap["id"];
      }

      // User Id
      if (parkingLordMap["userId"] != null) {
        userId = parkingLordMap["userId"];
      }

      // Token
      if (parkingLordMap["token"] != null) {
        token = parkingLordMap["token"];
      }

      // Name
      if (parkingLordMap["name"] != null) {
        name = parkingLordMap["name"];
      }

      // Address
      if (parkingLordMap["address"] != null) {
        address = parkingLordMap["address"];
      }

      // State
      if (parkingLordMap["state"] != null) {
        state = parkingLordMap["state"];
      }

      // City
      if (parkingLordMap["city"] != null) {
        city = parkingLordMap["city"];
      }

      // Pincode
      if (parkingLordMap["pincode"] != null) {
        pincode = parkingLordMap["pincode"];
      }

      // Landmark
      if (parkingLordMap["landmark"] != null) {
        landmark = parkingLordMap["landmark"];
      }

      // Location Name
      if (parkingLordMap["locationName"] != null) {
        locationName = parkingLordMap["locationName"];
      }

      // Location Country
      if (parkingLordMap["locationCountry"] != null) {
        country = parkingLordMap["locationCountry"];
      }

      // Location ISO Country Code
      if (parkingLordMap["isoCountryCode"] != null) {
        isoCountryCode = parkingLordMap["isoCountryCode"];
      }

      //Location Latitude
      if (parkingLordMap["latitude"] != null) {
        latitude = (parkingLordMap["latitude"]).toDouble();
      }

      //Location Longitude
      if (parkingLordMap["longitude"] != null) {
        longitude = (parkingLordMap["longitude"]).toDouble();
      }

      // Length
      if (parkingLordMap["length"] != null) {
        length = (parkingLordMap["length"]).toDouble();
      }

      // Breadth
      if (parkingLordMap["breadth"] != null) {
        breadth = (parkingLordMap["breadth"]).toDouble();
      }

      // Height
      if (parkingLordMap["height"] != null) {
        height = (parkingLordMap["height"]).toDouble();
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
          if (slotImage["type"] == "Others") {
            images.add(SlotImageData.fromMap(slotImage));
          } else {
            mainImage = SlotImageData.fromMap(slotImage);
          }
        });
      } else if (parkingLordMap["slotImages"] != null) {
        // Image Urls
        parkingLordMap["slotImages"].forEach((slotImage) {
          if (slotImage["type"] == "Others") {
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
          VehicleData vehicleData = VehicleData.fromMap(slotVehicle);
          vehicles.add(vehicleData);
        });
      } else if (parkingLordMap["slotVehicles"] != null) {
        // Vehicles
        parkingLordMap["slotVehicles"].forEach((slotVehicle) {
          VehicleData vehicleData = VehicleData.fromMap(slotVehicle);
          vehicles.add(vehicleData);
        });
      }

      // Start Time
      if (parkingLordMap["startTime"] != null) {
        startTime = parkingLordMap["startTime"];
      }

      // End Time
      if (parkingLordMap["endTime"] != null) {
        endTime = parkingLordMap["endTime"];
      }

      // Parking Type
      if (parkingLordMap["spaceType"] != null) {
        spaceType =
            SlotDataUtils.getSpaceTypeFromString(parkingLordMap["spaceType"]);
      }

      // Deposit Time
      if (parkingLordMap["securityDepositTime"] != null) {
        securityDepositTime = parkingLordMap["securityDepositTime"];
      }

      // Status
      if (parkingLordMap["status"] != null) {
        status = parkingLordMap["status"];
      }
    }
  }

  SlotData toSlotData() {
    SlotData gpPLSlotData = SlotData.fromMap(this.data);
    return gpPLSlotData;
  }
}
