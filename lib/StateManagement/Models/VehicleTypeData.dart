import 'package:flutter/cupertino.dart';
import 'package:getparked/StateManagement/Models/VehicleData.dart';

class VehicleTypeData {
  VehicleType type;
  int id;
  String name;
  double length;
  double breadth;
  double height;
  double area;
  int status;

  setType(String typeValue) {
    switch (typeValue) {
      case "BIKE":
        type = VehicleType.bike;
        break;
      case "MINI":
        type = VehicleType.mini;
        break;
      case "SEDAN":
        type = VehicleType.sedan;
        break;
      case "VAN":
        type = VehicleType.van;
        break;
      case "SUV":
        type = VehicleType.suv;
        break;
    }
  }

  VehicleTypeData(
      {this.type,
      this.id,
      this.name,
      this.length,
      this.breadth,
      this.height,
      this.area,
      this.status});

  VehicleTypeData.fromMap(Map vehicleTypeData) {
    id = vehicleTypeData["vehicleMasterId"];
    name = vehicleTypeData["name"];
    setType(vehicleTypeData["type"]);
    length = (vehicleTypeData["length"] != null)
        ? (vehicleTypeData["length"]).toDouble()
        : 0.0;
    breadth = (vehicleTypeData["breadth"] != null)
        ? (vehicleTypeData["breadth"]).toDouble()
        : 0.0;
    height = (vehicleTypeData["height"] != null)
        ? (vehicleTypeData["height"]).toDouble()
        : 0.0;
    area = (vehicleTypeData["area"] != null)
        ? (vehicleTypeData["area"]).toDouble()
        : 0.0;
    status = vehicleTypeData["status"];
  }
}

class VehicleTypeUtils {
  static VehicleType getTypeFromString(String typeValue) {
    VehicleType type;
    switch (typeValue) {
      case "BIKE":
        type = VehicleType.bike;
        break;
      case "MINI":
        type = VehicleType.mini;
        break;
      case "SEDAN":
        type = VehicleType.sedan;
        break;
      case "VAN":
        type = VehicleType.van;
        break;
      case "SUV":
        type = VehicleType.suv;
        break;
    }

    return type;
  }

  static String getTypeAsString(VehicleType type) {
    String typeValue = "BIKE";
    switch (type) {
      case VehicleType.bike:
        typeValue = "BIKE";
        break;
      case VehicleType.mini:
        typeValue = "MINI";
        break;
      case VehicleType.sedan:
        typeValue = "SEDAN";
        break;
      case VehicleType.van:
        typeValue = "VAN";
        break;
      case VehicleType.suv:
        typeValue = "SUV";
        break;
    }
    return typeValue;
  }
}

enum VehicleType { bike, mini, sedan, van, suv }
