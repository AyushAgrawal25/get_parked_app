import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:getparked/BussinessLogic/SlotsServices.dart';
import 'package:getparked/BussinessLogic/UserServices.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/StateManagement/Models/ParkingData.dart';
import 'package:getparked/StateManagement/Models/ParkingLordData.dart';
import 'package:getparked/StateManagement/Models/SlotData.dart';
import 'package:getparked/StateManagement/Models/SlotImageData.dart';
import 'package:getparked/StateManagement/Models/VehicleData.dart';
import 'package:getparked/Utils/DomainUtils.dart';
import 'package:getparked/Utils/JSONUtils.dart';
import 'package:getparked/Utils/SecureStorageUtils.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

const String PARKING_LORD_ROUTE = "/app/slots";

class ParkingLordServices {
  Future<ParkingLordCreateStatus> become(
      {@required String authToken, @required SlotData slotData}) async {
    try {
      List<Map> sVPostData = [];
      slotData.vehicles.forEach((vehicleData) {
        Map svData = {
          "type": vehicleData.getTypeValue(),
          "fair": vehicleData.fair
        };

        sVPostData.add(svData);
      });

      Map<String, dynamic> reqBody = {
        "slotData": {
          "name": slotData.name,
          "address": slotData.address,
          "state": slotData.state,
          "city": slotData.city,
          "pincode": slotData.pincode,
          "landmark": slotData.landmark,
          "locationName": slotData.locationName,
          "country": slotData.country,
          "isoCountryCode": slotData.isoCountryCode,
          "latitude": slotData.latitude,
          "longitude": slotData.longitude,
          "breadth": slotData.breadth,
          "height": slotData.height,
          "length": slotData.length,
          "securityDepositTime": slotData.securityDepositTime,
          "spaceType": SlotDataUtils.getSpaceTypeAsString(slotData.spaceType),
          "startTime": slotData.startTime,
          "endTime": slotData.endTime
        },
        "vehicles": sVPostData
      };

      Uri url = Uri.parse(domainName + PARKING_LORD_ROUTE + "/create");
      http.Response resp = await http.post(url,
          body: JSONUtils().postBody(reqBody),
          headers: {
            CONTENT_TYPE_KEY: JSON_CONTENT_VALUE,
            AUTH_TOKEN: authToken
          });
      // print(resp.body);
      if (resp.statusCode == 200) {
        return ParkingLordCreateStatus.successful;
      } else if (resp.statusCode == 403) {
        return ParkingLordCreateStatus.invalidToken;
      } else if (resp.statusCode == 500) {
        return ParkingLordCreateStatus.internalServerError;
      }
      return ParkingLordCreateStatus.failed;
    } catch (excp) {
      print(excp);
      return ParkingLordCreateStatus.failed;
    }
  }

  Future<ParkingLordDetailsUpdateStatus> updateDetails(
      {@required String authToken,
      @required String name,
      @required AppState appState}) async {
    try {
      Map<String, dynamic> reqBody = {"name": name};
      Uri url = Uri.parse(domainName + PARKING_LORD_ROUTE + "/details");
      http.Response resp = await http.put(url,
          body: JSONUtils().postBody(reqBody),
          headers: {
            CONTENT_TYPE_KEY: JSON_CONTENT_VALUE,
            AUTH_TOKEN: authToken
          });
      // print(resp.body);

      if (resp.statusCode == 200) {
        // Manually Updating details for now.
        ParkingLordData parkingLordData = appState.parkingLordData;
        parkingLordData.name = name;
        appState.setParkingLordData(parkingLordData);

        return ParkingLordDetailsUpdateStatus.successful;
      } else if (resp.statusCode == 403) {
        return ParkingLordDetailsUpdateStatus.invalidToken;
      } else if (resp.statusCode == 400) {
        return ParkingLordDetailsUpdateStatus.notFound;
      } else if (resp.statusCode == 500) {
        return ParkingLordDetailsUpdateStatus.internalServerError;
      }

      return ParkingLordDetailsUpdateStatus.failed;
    } catch (excp) {
      print(excp);
      return ParkingLordDetailsUpdateStatus.failed;
    }
  }

  Future<ParkingLordGetStatus> getParkingLord(
      {@required BuildContext context}) async {
    AppState appState = Provider.of<AppState>(context, listen: false);
    try {
      String authToken = appState.authToken;
      Uri url = Uri.parse(domainName + PARKING_LORD_ROUTE + "/parkingLord");
      http.Response resp =
          await http.get(url, headers: {AUTH_TOKEN: authToken});
      // print(resp.body);
      if (resp.statusCode == 200) {
        // Parking lord found.
        Map parkingLordMap = json.decode(resp.body)["data"];
        ParkingLordData parkingLordData =
            ParkingLordData.fromMap(parkingLordMap);

        // SlotData slotData = SlotData.fromMap(parkingLordMap);
        appState.setParkingLordData(parkingLordData);
        return ParkingLordGetStatus.successful;
      } else if (resp.statusCode == 400) {
        // User not registered as parking lord.
        return ParkingLordGetStatus.successful;
      } else if (resp.statusCode == 403) {
        return ParkingLordGetStatus.invlidToken;
      } else if (resp.statusCode == 500) {
        return ParkingLordGetStatus.internalServerError;
      }
      return ParkingLordGetStatus.failed;
    } catch (excp) {
      print(excp);
      return ParkingLordGetStatus.failed;
    }
  }

  Future<SlotImageUploadStatus> uploadSlotImage(
      {@required SlotImageType type,
      @required File imgFile,
      @required String authToken}) async {
    try {
      Uri url = Uri.parse(domainName + SLOT_IMAGES_ROUTE);
      http.MultipartRequest uploadReq = http.MultipartRequest('POST', url);

      uploadReq.headers[AUTH_TOKEN] = authToken;
      uploadReq.files.add(http.MultipartFile(
          'image', imgFile.readAsBytes().asStream(), imgFile.lengthSync(),
          filename: imgFile.path.split("/").last));
      uploadReq.fields["type"] =
          (type == SlotImageType.main) ? "Main" : "Others";

      http.StreamedResponse resp = await uploadReq.send();

      print(resp.statusCode);
      if (resp.statusCode == 200) {
        return SlotImageUploadStatus.successful;
      } else if (resp.statusCode == 403) {
        return SlotImageUploadStatus.invalidToken;
      } else if (resp.statusCode == 400) {
        return SlotImageUploadStatus.notFound;
      } else if (resp.statusCode == 409) {
        return SlotImageUploadStatus.alreadyExists;
      } else if (resp.statusCode == 500) {
        return SlotImageUploadStatus.internalServerError;
      }

      return SlotImageUploadStatus.failed;
    } catch (excp) {
      print(excp);
      return SlotImageUploadStatus.failed;
    }
  }

  Future<SlotImageUpdateStatus> updateSlotImage(
      {@required SlotImageType type,
      @required File imgFile,
      @required int slotImageId,
      @required String authToken}) async {
    try {
      Uri url = Uri.parse(domainName + SLOT_IMAGES_ROUTE);
      http.MultipartRequest uploadReq = http.MultipartRequest('PUT', url);

      uploadReq.headers[AUTH_TOKEN] = authToken;
      uploadReq.files.add(http.MultipartFile(
          'image', imgFile.readAsBytes().asStream(), imgFile.lengthSync(),
          filename: imgFile.path.split("/").last));
      uploadReq.fields["type"] =
          (type == SlotImageType.main) ? "Main" : "Others";
      uploadReq.fields["slotImageId"] = slotImageId.toString();

      http.StreamedResponse resp = await uploadReq.send();

      print(resp.statusCode);
      if (resp.statusCode == 200) {
        return SlotImageUpdateStatus.successful;
      } else if (resp.statusCode == 403) {
        return SlotImageUpdateStatus.invalidToken;
      } else if (resp.statusCode == 400) {
        return SlotImageUpdateStatus.oldImageNotFound;
      } else if (resp.statusCode == 500) {
        return SlotImageUpdateStatus.internalServerError;
      }

      return SlotImageUpdateStatus.failed;
    } catch (excp) {
      print(excp);
      return SlotImageUpdateStatus.failed;
    }
  }

  Future<SlotImageDeleteStatus> deleteSlotImage(
      {@required String authToken, @required int slotImageId}) async {
    try {
      Map<String, dynamic> reqBody = {"slotImageId": slotImageId};
      Uri url = Uri.parse(domainName + SLOT_IMAGES_ROUTE);
      http.Response resp = await http.delete(url,
          body: JSONUtils().postBody(reqBody),
          headers: {
            CONTENT_TYPE_KEY: JSON_CONTENT_VALUE,
            AUTH_TOKEN: authToken
          });

      // print(resp.body);
      if (resp.statusCode == 200) {
        return SlotImageDeleteStatus.successful;
      } else if (resp.statusCode == 422) {
        return SlotImageDeleteStatus.nonDeletable;
      } else if (resp.statusCode == 400) {
        return SlotImageDeleteStatus.notFound;
      } else if (resp.statusCode == 403) {
        return SlotImageDeleteStatus.invalidToken;
      } else if (resp.statusCode == 500) {
        return SlotImageDeleteStatus.internalServerError;
      }

      return SlotImageDeleteStatus.failed;
    } catch (excp) {
      print(excp);
      return SlotImageDeleteStatus.failed;
    }
  }

  Future<SlotActivateStatus> activateSlot({@required String authToken}) async {
    try {
      Uri url = Uri.parse(domainName + PARKING_LORD_ROUTE + "/activate");
      http.Response resp = await http.post(url, headers: {
        AUTH_TOKEN: authToken,
        CONTENT_TYPE_KEY: JSON_CONTENT_VALUE
      });

      if (resp.statusCode == 200) {
        return SlotActivateStatus.success;
      } else if (resp.statusCode == 404) {
        return SlotActivateStatus.notFound;
      } else if (resp.statusCode == 421) {
        return SlotActivateStatus.alreadyActive;
      } else if (resp.statusCode == 500) {
        return SlotActivateStatus.internalServerError;
      }

      return SlotActivateStatus.failed;
    } catch (excp) {
      print(excp);
      return SlotActivateStatus.failed;
    }
  }

  Future<SlotDeactivateStatus> deactivateSlot(
      {@required String authToken}) async {
    try {
      Uri url = Uri.parse(domainName + PARKING_LORD_ROUTE + "/deactivate");

      http.Response resp = await http.post(url, headers: {
        AUTH_TOKEN: authToken,
        CONTENT_TYPE_KEY: JSON_CONTENT_VALUE
      });

      if (resp.statusCode == 200) {
        return SlotDeactivateStatus.success;
      } else if (resp.statusCode == 404) {
        return SlotDeactivateStatus.notFound;
      } else if (resp.statusCode == 421) {
        return SlotDeactivateStatus.alreadyDeactive;
      } else if (resp.statusCode == 422) {
        return SlotDeactivateStatus.cannotBeDeactivated;
      } else if (resp.statusCode == 500) {
        return SlotDeactivateStatus.internalServerError;
      }

      return SlotDeactivateStatus.failed;
    } catch (excp) {
      print(excp);
      return SlotDeactivateStatus.failed;
    }
  }

  Future<SlotDimensionUpdateStatus> updateDimensions({
    @required BuildContext context,
    @required double length,
    @required double breadth,
    @required double height,
  }) async {
    try {
      AppState appState = Provider.of<AppState>(context, listen: false);
      String authToken = appState.authToken;
      Map<String, dynamic> reqBody = {
        "length": length,
        "breadth": breadth,
        "height": height
      };

      Uri url =
          Uri.parse(domainName + PARKING_LORD_ROUTE + "/changeDimensions");
      http.Response resp = await http.post(url,
          body: JSONUtils().postBody(reqBody),
          headers: {
            AUTH_TOKEN: authToken,
            CONTENT_TYPE_KEY: JSON_CONTENT_VALUE
          });

      if (resp.statusCode == 200) {
        Map data = json.decode(resp.body)["data"];
        List vehicles = data["vehicles"];
        List<VehicleData> vehicleDatas = [];
        vehicles.forEach((vehicle) {
          vehicleDatas.add(VehicleData.fromMap(vehicle));
        });

        ParkingLordData parkingLordData = appState.parkingLordData;
        parkingLordData.length = length;
        parkingLordData.breadth = breadth;
        parkingLordData.height = height;
        parkingLordData.vehicles = vehicleDatas;
        appState.setParkingLordData(parkingLordData);

        return SlotDimensionUpdateStatus.success;
      } else if (resp.statusCode == 404) {
        return SlotDimensionUpdateStatus.slotNotFound;
      } else if (resp.statusCode == 422) {
        return SlotDimensionUpdateStatus.cannotBeUpdated;
      } else if (resp.statusCode == 500) {
        return SlotDimensionUpdateStatus.internalServerError;
      } else if (resp.statusCode == 403) {
        return SlotDimensionUpdateStatus.invalidToken;
      }

      return SlotDimensionUpdateStatus.failed;
    } catch (excp) {
      print(excp);
      return SlotDimensionUpdateStatus.failed;
    }
  }
}

enum ParkingLordGetStatus {
  successful,
  invlidToken,
  internalServerError,
  failed
}

enum ParkingLordCreateStatus {
  successful,
  invalidToken,
  internalServerError,
  failed
}

enum ParkingLordDetailsUpdateStatus {
  successful,
  invalidToken,
  internalServerError,
  notFound,
  failed
}

enum SlotImageUploadStatus {
  successful,
  invalidToken,
  internalServerError,
  failed,
  alreadyExists,
  notFound
}

enum SlotImageUpdateStatus {
  successful,
  invalidToken,
  internalServerError,
  failed,
  oldImageNotFound
}

enum SlotImageDeleteStatus {
  successful,
  nonDeletable,
  notFound,
  invalidToken,
  internalServerError,
  failed
}

enum SlotActivateStatus {
  success,
  notFound,
  alreadyActive,
  failed,
  internalServerError
}

enum SlotDeactivateStatus {
  success,
  notFound,
  alreadyDeactive,
  failed,
  cannotBeDeactivated,
  internalServerError
}

enum SlotDimensionUpdateStatus {
  success,
  slotNotFound,
  cannotBeUpdated,
  internalServerError,
  invalidToken,
  failed
}
