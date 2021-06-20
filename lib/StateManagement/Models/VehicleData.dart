import 'package:getparked/StateManagement/Models/VehicleTypeData.dart';

class VehicleData {
  int id;
  int slotId;

  // Vehicle Data
  int typeMasterId;
  VehicleType type;
  VehicleTypeData typeData;

  double fair;
  Map data;
  int status;

  int getTypeId() {
    int tmId = 0;
    switch (type) {
      case VehicleType.bike:
        tmId = 1;
        break;
      case VehicleType.mini:
        tmId = 2;
        break;
      case VehicleType.sedan:
        tmId = 3;
        break;
      case VehicleType.van:
        tmId = 4;
        break;
      case VehicleType.suv:
        tmId = 5;
        break;
    }
    return tmId;
  }

  String getTypeValue() {
    String tmId = "BIKE";
    switch (type) {
      case VehicleType.bike:
        tmId = "BIKE";
        break;
      case VehicleType.mini:
        tmId = "MINI";
        break;
      case VehicleType.sedan:
        tmId = "SEDAN";
        break;
      case VehicleType.van:
        tmId = "VAN";
        break;
      case VehicleType.suv:
        tmId = "SUV";
        break;
    }
    return tmId;
  }

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

  VehicleData(
      {this.id,
      this.slotId,
      this.typeMasterId,
      this.type,
      this.fair,
      this.data,
      this.typeData,
      this.status});

  VehicleData.fromMap(Map vehicleData) {
    if (vehicleData != null) {
      id = vehicleData["id"];
      slotId = vehicleData["slotId"];
      typeMasterId = vehicleData["vehicleMasterId"];
      setType(vehicleData["type"]);
      typeData = VehicleTypeData.fromMap(vehicleData["typeData"]);

      fair = (vehicleData["fair"] != null)
          ? (vehicleData["fair"]).toDouble()
          : 0.0;
      data = vehicleData;
      status = vehicleData["status"];
    }
  }
}

class VehicleDataUtils {}

enum VehicleType { bike, mini, sedan, van, suv }
