class VehicleData {
  int id;
  int slotId;

  // Vehicle Data
  int typeMasterId;
  VehicleType type;
  String name;
  double length;
  double breadth;
  double height;

  int getTypeMasterId() {
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

  double fair;

  Map data;

  int status;

  VehicleData(
      {this.id,
      this.slotId,
      this.typeMasterId,
      this.type,
      this.name,
      this.length,
      this.breadth,
      this.height,
      this.fair,
      this.data,
      this.status});
}

class VehicleDataUtils {
  static mapToVehicleData(Map vehicleMap) {
    VehicleType vehicleType;
    switch (vehicleMap["slotVehicleTypeMasterId"]) {
      case 1:
        vehicleType = VehicleType.bike;
        break;
      case 2:
        vehicleType = VehicleType.mini;
        break;
      case 3:
        vehicleType = VehicleType.sedan;
        break;
      case 4:
        vehicleType = VehicleType.van;
        break;
      case 5:
        vehicleType = VehicleType.suv;
        break;
      default:
    }

    VehicleData vehicleData = VehicleData(
        id: vehicleMap["slotVehicleId"],
        slotId: vehicleMap["slotVehicleSlotId"],
        typeMasterId: vehicleMap["slotVehicleTypeMasterId"],
        type: vehicleType,
        name: vehicleMap["slotVehicleMasterName"],
        length: (vehicleMap["slotVehicleMasterLength"] != null)
            ? (vehicleMap["slotVehicleMasterLength"]).toDouble()
            : null,
        breadth: (vehicleMap["slotVehicleMasterBreadth"] != null)
            ? (vehicleMap["slotVehicleMasterBreadth"]).toDouble()
            : null,
        height: (vehicleMap["slotVehicleMasterHeight"] != null)
            ? (vehicleMap["slotVehicleMasterHeight"]).toDouble()
            : null,
        fair: (vehicleMap["slotVehicleFair"] != null)
            ? (vehicleMap["slotVehicleFair"]).toDouble()
            : 0.0,
        data: vehicleMap,
        status: vehicleMap["slotVehicleStatus"]);

    return vehicleData;
  }
}

enum VehicleType { bike, mini, sedan, van, suv }
