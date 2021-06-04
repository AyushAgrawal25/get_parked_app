import 'package:getparked/Utils/MapPlacesUtils.dart';
import 'package:getparked/Utils/StringUtils.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

bool printStatus = false;

class PlacesDataCollection {
  static String domainName = "http://3.21.53.195:5000";

  Future fetchAndPostPlacesForCamPos(CameraPosition gpCamPos) async {
    try {
      List<Placemark> placemarks = await Geolocator().placemarkFromCoordinates(
          gpCamPos.target.latitude, gpCamPos.target.longitude);
      for (int i = 0; i < placemarks.length; i++) {
        exploreAndPostPlacemark(placemarks[i]);
      }
    } catch (excep) {
      if (printStatus) {
        print("\nGeocoding Error For This Coordinates..\n");
      }
    }
  }

  Future exploreAndPostPlacemark(Placemark placemark) async {
    if ((placemark.name == "Unnamed Road") ||
        (!StringUtils.isPlaceAlphabetic(placemark.name))) {
      // Exploring And Pushing For Unnamed Road Or Numeric Place Name

      // For Locality
      exploreAndPostPlacemarkWithDiffName(placemark.locality, placemark);

      // For Sub Locality
      exploreAndPostPlacemarkWithDiffName(placemark.subLocality, placemark);
    } else {
      await postingPlacemarkForDiifName(placemark, placemark.name);
    }
  }

  Future exploreAndPostPlacemarkWithDiffName(
      String newName, Placemark placemark) async {
    if (!((newName == "") ||
        (newName == "Unnamed Road") ||
        (!StringUtils.isPlaceAlphabetic(newName)))) {
      String address = (newName +
              " " +
              placemark.subAdministrativeArea +
              " " +
              placemark.subAdministrativeArea)
          .trim();
      try {
        List<Placemark> placemarks =
            await Geolocator().placemarkFromAddress(address);

        for (int i = 0; i < placemarks.length; i++) {
          postingPlacemarkForDiifName(placemark, newName);
        }
      } catch (excep) {
        if (printStatus) {
          print("\nGeoCoding Error For New place Name : $newName\n");
        }
      }
    }
  }

  Future<bool> postingPlacemarkForDiifName(
      Placemark placemark, String name) async {
    try {
      Map locationData = {
        "name": name,
        "city": placemark.subAdministrativeArea,
        "state": placemark.administrativeArea,
        "locality": placemark.locality,
        "subLocality": placemark.subLocality,
        "country": placemark.country,
        "isoCountryCode": placemark.isoCountryCode,
        "latitude": placemark.position.latitude,
        "longitude": placemark.position.longitude,
        "postalCode": placemark.postalCode,
      };
      Response placeResp = await Dio().post(
          domainName + "/routes/places/specific",
          data: locationData,
          options: Options(headers: {"apiToken": MapPlacesUtils.apiToken}));
      if (placeResp.data["status"] == 1) {
        if (printStatus) {
          print(
              "\n New Place Registered...\t Place Name : $name \t $placeResp");
        }
        return true;
      } else {
        if (printStatus) {
          print(
              "Registration Failed May be duplication Error!.. \t Place Name : $name \t $placeResp");
        }
        return false;
      }
    } catch (excep) {
      if (printStatus) {
        print("\nHttp Request Failed For\t Place Name : $name\n");
      }
      return false;
    }
  }
}
