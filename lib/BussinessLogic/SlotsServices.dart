import 'package:flutter/material.dart';
import 'package:getparked/BussinessLogic/UserServices.dart';
import 'package:getparked/StateManagement/Models/SlotData.dart';
import 'package:getparked/Utils/DomainUtils.dart';
import 'package:getparked/Utils/JSONUtils.dart';
import 'package:getparked/Utils/SecureStorageUtils.dart';
import 'package:http/http.dart' as http;

const String SLOTS_ROUTE = "/app/slots";

class SlotsServices {
  Future<SlotCreateStatus> createSlot(
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
        },
        "vehicles": sVPostData
      };
      Uri url = Uri.parse(domainName + SLOTS_ROUTE + "/create");
      http.Response resp = await http.post(url,
          body: JSONUtils().postBody(reqBody),
          headers: {
            CONTENT_TYPE_KEY: JSON_CONTENT_VALUE,
            AUTH_TOKEN: authToken
          });
      // print(resp.body);
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
