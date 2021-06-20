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
