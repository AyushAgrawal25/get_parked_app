import 'package:getparked/Utils/DomainUtils.dart';
import 'package:dio/dio.dart';
import 'package:getparked/StateManagement/Models/VehicleData.dart';
import 'package:getparked/StateManagement/Models/VehicleTypeData.dart';

class VehiclesUtils {
  Future<List<VehicleTypeData>> initVehicleTypeData(String accessToken) async {
    List<VehicleTypeData> vehicleTypeDatas = [];
    Response vehiclesResp = await Dio().get(
        domainName + "/appRoute/slots/vehicles/masterData",
        options: Options(headers: {"userAccessToken": accessToken}));

    // Setting Up Vehicles Master Data
    vehiclesResp.data["data"].forEach((vehicleMasterData) {
      VehicleType vehicleType;
      switch (vehicleMasterData["slotVehicleMasterId"]) {
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
      }

      vehicleTypeDatas.add(VehicleTypeData(
          id: vehicleMasterData["slotVehicleMasterId"],
          type: vehicleType,
          name: vehicleMasterData["slotVehicleMasterName"],
          length: (vehicleMasterData["slotVehicleMasterLength"] != null)
              ? vehicleMasterData["slotVehicleMasterLength"].toDouble()
              : 0.0,
          breadth: (vehicleMasterData["slotVehicleMasterBreadth"] != null)
              ? vehicleMasterData["slotVehicleMasterBreadth"].toDouble()
              : 0.0,
          height: (vehicleMasterData["slotVehicleMasterHeight"] != null)
              ? vehicleMasterData["slotVehicleMasterHeight"].toDouble()
              : 0.0));
    });
    return vehicleTypeDatas;
  }

  bool isVehicleParkable(VehicleTypeData vehicleTypeData, double length,
      double height, double breadth) {
    bool isValid = true;

    if (((vehicleTypeData.breadth <= breadth) &&
            (vehicleTypeData.length <= length)) ||
        ((vehicleTypeData.breadth <= length) &&
            (vehicleTypeData.length <= breadth))) {
      isValid = true;
    } else {
      isValid = false;
    }

    if (vehicleTypeData.height > height) {
      isValid = false;
    }

    if ((vehicleTypeData.length * vehicleTypeData.breadth) >
        (length * breadth)) {
      isValid = false;
    }

    return isValid;
  }

  VehicleType typeFromVehicleTypeId(int vehicleTypeId) {
    VehicleType vehicleType = VehicleType.bike;

    switch (vehicleTypeId) {
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
    }

    return vehicleType;
  }
}
