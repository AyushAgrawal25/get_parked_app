import 'dart:convert';

import 'package:getparked/StateManagement/Models/VehicleTypeData.dart';
import 'package:flutter/material.dart';
import 'package:getparked/Utils/DomainUtils.dart';
import 'package:getparked/Utils/SecureStorageUtils.dart';
import 'package:http/http.dart' as http;

const String VEHICLES_ROUTE = "/app/vehicles";

class VehiclesServices {
  Future<List<VehicleTypeData>> getTypes({@required String authToken}) async {
    try {
      Uri url = Uri.parse(domainName + VEHICLES_ROUTE + "/types");
      http.Response resp =
          await http.get(url, headers: {AUTH_TOKEN: authToken});
      // print(resp.body);
      if (resp.statusCode == 200) {
        Map respData = json.decode(resp.body);
        List<VehicleTypeData> typesData = [];
        for (int i = 0; i < respData["data"].length; i++) {
          typesData.add(VehicleTypeData.fromMap(respData["data"][i]));
        }

        return typesData;
      }
      return [];
    } catch (excp) {
      print(excp);
      return [];
    }
  }
}
