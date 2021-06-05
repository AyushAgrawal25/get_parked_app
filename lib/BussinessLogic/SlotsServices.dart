import 'package:flutter/material.dart';
import 'package:getparked/BussinessLogic/NotificationServices.dart';
import 'package:getparked/BussinessLogic/UserServices.dart';
import 'package:getparked/StateManagement/Models/SlotData.dart';
import 'package:getparked/Utils/DomainUtils.dart';
import 'package:getparked/Utils/JSONUtils.dart';
import 'package:getparked/Utils/SecureStorageUtils.dart';
import 'package:http/http.dart' as http;

class SlotsServices {
  Future<SlotCreateStatus> createSlot(
      {@required String authToken, @required SlotData slotData}) async {
    try {
      Map<String, dynamic> reqBody = {
        "name": slotData.name,
        "address": slotData.address,
        "state": slotData.state,
        "city": slotData.city,
        "pincode": slotData.pincode,
        "landmark": slotData.landmark,
        "locationName": slotData.locationName,
        "country": slotData.country,
        "isoCountryCode": slotData.countryCode,
        "latitude": slotData.latitude,
        "longitude": slotData.longitude,
        "breadth": slotData.breadth,
        "height": slotData.height,
        "length": slotData.length,
        "securityDepositTime": slotData.securityDepositHours,
        "spaceType": slotData.spaceType,
        "startTime": slotData.startTime,
        "endTime": slotData.endTime
      };

      Uri url = Uri.parse(domainName + NOTIFICATION_ROUTE + "/create");
      http.Response resp = await http.post(url,
          body: JSONUtils().postBody(reqBody),
          headers: {
            CONTENT_TYPE_KEY: JSON_CONTENT_VALUE,
            AUTH_TOKEN: authToken
          });
      print(resp);
      if (resp.statusCode == 200) {
        return SlotCreateStatus.successful;
      } else if (resp.statusCode == 403) {
        return SlotCreateStatus.invalidToken;
      } else if (resp.statusCode == 500) {
        return SlotCreateStatus.internalServerError;
      }
      return SlotCreateStatus.failed;
    } catch (excp) {
      print(excp);
      return SlotCreateStatus.failed;
    }
  }
}

enum SlotCreateStatus { successful, invalidToken, internalServerError, failed }
const SLOTS_ROUTE = "/app/slots";
