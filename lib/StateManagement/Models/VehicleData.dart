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
    return VehicleTypeUtils.getTypeAsString(type);
  }

  setType(String typeValue) {
    type = VehicleTypeUtils.getTypeFromString(typeValue);
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
