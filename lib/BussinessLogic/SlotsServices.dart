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
  // TODO: complete this wrap with AppState and all.
  Future<List<ParkingRequestData>> getParkingRequestsForUser(
      {@required String authToken}) async {
    try {
      Uri url = Uri.parse(domainName + SLOTS_ROUTE + "/parkingRequestsForUser");
      http.Response resp = await http.get(url, headers: {
        CONTENT_TYPE_KEY: JSON_CONTENT_VALUE,
        AUTH_TOKEN: authToken
      });

      Map respMap = json.decode(resp.body);
      List parkingReqsMap = respMap["data"];
      List<ParkingRequestData> parkingReqs = [];
      parkingReqsMap.forEach((parkingRequestMap) {
        parkingReqs.add(ParkingRequestData.fromMap(parkingRequestMap));
      });
    } catch (excp) {
      print(excp);
    }
  }
}
