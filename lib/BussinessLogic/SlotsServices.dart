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
const String SLOT_PARKING_REQUESTS_ROUTE = "/app/slots/parkingRequests";
const String SLOT_BOOKINGS_ROUTE = "/app/slots/bookings";
const String SLOT_PARKINGS_ROUTE = "/app/slots/parkings";
const String SLOT_IMAGES_ROUTE = "/images/slotImages";

class SlotsServices {
  Future<List<ParkingRequestData>> getParkingRequestsForUser(
      {@required String authToken}) async {
    try {
      Uri url =
          Uri.parse(domainName + SLOT_PARKING_REQUESTS_ROUTE + "/forUser");
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
      Uri url =
          Uri.parse(domainName + SLOT_PARKING_REQUESTS_ROUTE + "/forSlot");
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
      Uri url = Uri.parse(domainName + SLOT_PARKING_REQUESTS_ROUTE + "/send");
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
      Uri url =
          Uri.parse(domainName + SLOT_PARKING_REQUESTS_ROUTE + "/respond");
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
      Uri url = Uri.parse(domainName + SLOT_BOOKINGS_ROUTE + "/book");
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

  Future<BookingCancellationStatus> cancelBooking(
      {@required String authToken,
      @required int bookingId,
      @required int duration,
      @required int exceedDuration}) async {
    try {
      Uri url = Uri.parse(domainName + SLOT_BOOKINGS_ROUTE + "/cancel");
      Map<String, dynamic> reqBody = {
        "bookingId": bookingId,
        "duration": duration,
        "exceedDuration": exceedDuration
      };

      http.Response resp = await http.post(url,
          body: JSONUtils().postBody(reqBody),
          headers: {
            AUTH_TOKEN: authToken,
            CONTENT_TYPE_KEY: JSON_CONTENT_VALUE
          });

      if (resp.statusCode == 200) {
        return BookingCancellationStatus.success;
      } else if (resp.statusCode == 422) {
        return BookingCancellationStatus.cannotBeCancelled;
      } else if (resp.statusCode == 403) {
        return BookingCancellationStatus.invalidToken;
      } else if (resp.statusCode == 500) {
        return BookingCancellationStatus.internalServerError;
      }

      return BookingCancellationStatus.failed;
    } catch (excp) {
      print(excp);
      return BookingCancellationStatus.failed;
    }
  }

  Future<ParkingStatus> parking(
      {@required String authToken, @required int bookingId}) async {
    try {
      Uri url = Uri.parse(domainName + SLOT_PARKINGS_ROUTE + "/park");
      Map<String, dynamic> reqBody = {"bookingId": bookingId};

      http.Response resp = await http.post(url,
          body: JSONUtils().postBody(reqBody),
          headers: {
            AUTH_TOKEN: authToken,
            CONTENT_TYPE_KEY: JSON_CONTENT_VALUE
          });

      print(resp.body);
      if (resp.statusCode == 200) {
        return ParkingStatus.success;
      } else if (resp.statusCode == 422) {
        return ParkingStatus.cannotBeParked;
      } else if (resp.statusCode == 403) {
        return ParkingStatus.invalidToken;
      } else if (resp.statusCode == 500) {
        return ParkingStatus.internalServerError;
      }

      return ParkingStatus.failed;
    } catch (excp) {
      print(excp);
      return ParkingStatus.failed;
    }
  }

  Future<ParkingWithdrawStatus> parkingWithdraw(
      {@required String authToken,
      @required int parkingId,
      @required int duration,
      @required int exceedDuration}) async {
    try {
      Uri url = Uri.parse(domainName + SLOT_PARKINGS_ROUTE + "/withdraw");
      Map<String, dynamic> reqBody = {
        "parkingId": parkingId,
        "duration": duration,
        "exceedDuration": exceedDuration
      };

      http.Response resp = await http.post(url,
          body: JSONUtils().postBody(reqBody),
          headers: {
            AUTH_TOKEN: authToken,
            CONTENT_TYPE_KEY: JSON_CONTENT_VALUE
          });

      print(resp.body);
      if (resp.statusCode == 200) {
        return ParkingWithdrawStatus.success;
      } else if (resp.statusCode == 422) {
        return ParkingWithdrawStatus.cannotBeWithdrawn;
      } else if (resp.statusCode == 403) {
        return ParkingWithdrawStatus.invalidToken;
      } else if (resp.statusCode == 500) {
        return ParkingWithdrawStatus.internalServerError;
      }

      return ParkingWithdrawStatus.failed;
    } catch (excp) {
      print(excp);
      return ParkingWithdrawStatus.failed;
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

enum BookingCancellationStatus {
  success,
  cannotBeCancelled,
  invalidToken,
  failed,
  internalServerError,
}

enum ParkingStatus {
  success,
  cannotBeParked,
  invalidToken,
  failed,
  internalServerError,
}

enum ParkingWithdrawStatus {
  success,
  cannotBeWithdrawn,
  invalidToken,
  failed,
  internalServerError,
}
