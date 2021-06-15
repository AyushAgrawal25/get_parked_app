import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:getparked/BussinessLogic/UserServices.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/StateManagement/Models/ParkingLordData.dart';
import 'package:getparked/StateManagement/Models/ParkingRequestData.dart';
import 'package:getparked/StateManagement/Models/SlotData.dart';
import 'package:getparked/Utils/DomainUtils.dart';
import 'package:getparked/Utils/JSONUtils.dart';
import 'package:getparked/Utils/SecureStorageUtils.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

const String SLOTS_ROUTE = "/app/slots";
const String SLOT_IMAGES_ROUTE = "/images/slotImages";

class SlotsServices {
  Future<List<ParkingRequestData>> getParkingRequestsForUser(
      {@required String authToken}) async {
    try {
      Uri url = Uri.parse(domainName + SLOTS_ROUTE + "/parkingRequestsForUser");
      http.Response resp = await http.get(url, headers: {
        CONTENT_TYPE_KEY: JSON_CONTENT_VALUE,
        AUTH_TOKEN: authToken
      });

      if (resp.statusCode == 200) {
        Map respMap = json.decode(resp.body);
        List parkingReqsMap = respMap["data"];
        List<ParkingRequestData> parkingReqs = [];
        parkingReqsMap.forEach((parkingRequestMap) {
          parkingReqs.add(ParkingRequestData.fromMap(parkingRequestMap));
        });
        return parkingReqs;
      }
      return [];
    } catch (excp) {
      print(excp);
      return [];
    }
  }

  Future<List<ParkingRequestData>> getParkingRequestsForSlot(
      {@required String authToken}) async {
    try {
      Uri url = Uri.parse(domainName + SLOTS_ROUTE + "/parkingRequestsForSlot");
      http.Response resp = await http.get(url, headers: {
        CONTENT_TYPE_KEY: JSON_CONTENT_VALUE,
        AUTH_TOKEN: authToken
      });

      if (resp.statusCode == 200) {
        Map respMap = json.decode(resp.body);
        List parkingReqsMap = respMap["data"];
        List<ParkingRequestData> parkingReqs = [];
        parkingReqsMap.forEach((parkingRequestMap) {
          parkingReqs.add(ParkingRequestData.fromMap(parkingRequestMap));
        });
        return parkingReqs;
      }
      return [];
    } catch (excp) {
      print(excp);
      return [];
    }
  }

  Future<ParkingRequestStatus> sendParkingRequest(
      {@required String authToken,
      @required int slotId,
      @required int vehicleId,
      @required SlotSpaceType spaceType,
      @required int parkingHours}) async {
    try {
      Uri url = Uri.parse(domainName + SLOTS_ROUTE + "/parkingRequest");
      Map<String, dynamic> reqBody = {
        "slotId": slotId,
        "vehicleId": vehicleId,
        "spaceType": SlotDataUtils.getSpaceTypeAsString(spaceType),
        "parkingHours": parkingHours
      };

      http.Response resp = await http.post(url,
          body: JSONUtils().postBody(reqBody),
          headers: {
            AUTH_TOKEN: authToken,
            CONTENT_TYPE_KEY: JSON_CONTENT_VALUE
          });

      if (resp.statusCode == 200) {
        return ParkingRequestStatus.success;
      } else if (resp.statusCode == 403) {
        return ParkingRequestStatus.invalidToken;
      } else if (resp.statusCode == 500) {
        return ParkingRequestStatus.internalServerError;
      }
      return ParkingRequestStatus.failed;
    } catch (excp) {
      print(excp);
      return ParkingRequestStatus.failed;
    }
  }

  Future<ParkingRequestRespondStatus> respondParkingRequest(
      {@required String authToken,
      @required int parkingRequestId,
      @required int response}) async {
    try {
      Uri url = Uri.parse(domainName + SLOTS_ROUTE + "/parkingRequestResponse");
      Map<String, dynamic> reqBody = {
        "parkingRequestId": parkingRequestId,
        "response": response
      };

      http.Response resp = await http.post(url,
          body: JSONUtils().postBody(reqBody),
          headers: {
            AUTH_TOKEN: authToken,
            CONTENT_TYPE_KEY: JSON_CONTENT_VALUE
          });
      if (resp.statusCode == 200) {
        return ParkingRequestRespondStatus.success;
      } else if (resp.statusCode == 403) {
        return ParkingRequestRespondStatus.invalidToken;
      } else if (resp.statusCode == 400) {
        return ParkingRequestRespondStatus.cannotBeAccepted;
      } else if (resp.statusCode == 498) {
        return ParkingRequestRespondStatus.expired;
      } else if (resp.statusCode == 500) {
        return ParkingRequestRespondStatus.internalServerError;
      }
      return ParkingRequestRespondStatus.failed;
    } catch (excp) {
      print(excp);
      return ParkingRequestRespondStatus.failed;
    }
  }

  Future<BookSlotStatus> bookSlot(
      {@required String authToken, @required int parkingRequestId}) async {
    try {
      Uri url = Uri.parse(domainName + SLOTS_ROUTE + "/booking");
      Map<String, dynamic> reqBody = {
        "parkingRequestId": parkingRequestId,
      };

      http.Response resp = await http.post(url,
          body: JSONUtils().postBody(reqBody),
          headers: {
            AUTH_TOKEN: authToken,
            CONTENT_TYPE_KEY: JSON_CONTENT_VALUE
          });

      if (resp.statusCode == 200) {
        return BookSlotStatus.success;
      } else if (resp.statusCode == 400) {
        return BookSlotStatus.spaceUnavailable;
      } else if (resp.statusCode == 402) {
        return BookSlotStatus.balanceLow;
      } else if (resp.statusCode == 422) {
        return BookSlotStatus.requestNotFound;
      } else if (resp.statusCode == 423) {
        return BookSlotStatus.requestNotAccepted;
      } else if (resp.statusCode == 500) {
        return BookSlotStatus.spaceUnavailable;
      }

      return BookSlotStatus.failed;
    } catch (excp) {
      print(excp);
      return BookSlotStatus.failed;
    }
  }
}

enum ParkingRequestStatus { success, invalidToken, failed, internalServerError }
enum ParkingRequestRespondStatus {
  success,
  cannotBeAccepted,
  expired,
  invalidToken,
  failed,
  internalServerError
}

enum BookSlotStatus {
  success,
  spaceUnavailable,
  balanceLow,
  requestNotFound,
  requestNotAccepted,
  internalServerError,
  failed
}
