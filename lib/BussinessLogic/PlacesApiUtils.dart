import 'package:geolocator/geolocator.dart';
import 'package:dio/dio.dart';

class PlacesApiUtils {
  static String domainName = "http://3.21.53.195:5000";

  Future<List<Map<String, dynamic>>> getAllRegsiteredLocations() async {
    Response placesData = await Dio().get(domainName + "/routes/places");
    List<Map<String, dynamic>> places = [];
    placesData.data.forEach((placeData) {
      Map<String, dynamic> locationData = {
        "name": placeData["placeName"],
        "city": placeData["placeCity"],
        "state": placeData["placeState"],
        "locality": placeData["placeLocality"],
        "subLocality": placeData["placeSubLocality"],
        "country": placeData["placeCountry"],
        "isoCountryCode": placeData["placeISOCountryCode"],
        "latitude": placeData["placeLatitude"],
        "longitude": placeData["placeLongitude"],
        "postalCode": placeData["placePostalCode"],
      };

      places.add(locationData);
    });
    return places;
  }

  Future postingPlaceData(Placemark placemark) async {
    Map locationData = {
      "name": placemark.name,
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
    Response placeResp =
        await Dio().post(domainName + "/routes/places", data: locationData);
    print(placeResp.data);
  }

  Future postingPlaceDataWithoutUnnamedRoad(Placemark placemark) async {
    Map locationData = {
      "name": placemark.name,
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
    Response placeResp = await Dio()
        .post(domainName + "/routes/places/forUnnamedRoad", data: locationData);
    print(placeResp.data);
  }

  Future postingPlaceDataWithDifferentName(
      Placemark placemark, String name) async {
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
    Response placeResp = await Dio()
        .post(domainName + "/routes/places/forUnnamedRoad", data: locationData);
    print(placeResp.data);
  }

  Future postingBackUpLongitude(int longInInt) async {
    String minutes = ((DateTime.now().toLocal().minute % 60) > 9)
        ? (DateTime.now().toLocal().minute % 60).toString()
        : "0" + (DateTime.now().toLocal().minute % 60).toString();
    String currentTime = "${DateTime.now().toLocal().hour}:$minutes";
    Map backupData = {
      "backupId": 1,
      "backupLongitude": longInInt,
      "backupTime": currentTime
    };
    Response placeResp = await Dio()
        .post(domainName + "/routes/places/backup", data: backupData);
  }

  Future<int> gettingBackupLongitude() async {
    Response backupResp =
        await Dio().get(domainName + "/routes/places/backup/1");
    return backupResp.data[0]["placeLongBackupLongitude"];
  }

  Map<String, dynamic> placemarkToMap(Placemark placemark) {
    Map<String, dynamic> locationData = {
      "name": placemark.name,
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

    return locationData;
  }

  String mapToUniqueStringData(Map<String, dynamic> locationData) {
    if (locationData != null) {
      String newData = locationData["name"] +
          locationData["city"] +
          locationData["state"] +
          locationData["locality"] +
          locationData["subLocality"] +
          locationData["country"] +
          locationData["isoCountryCode"] +
          locationData["postalCode"];
      return newData;
    } else {
      return "";
    }
  }

  bool isPlacemarkUnique(
      Map<String, dynamic> newData, Map<String, dynamic> oldData) {
    if (oldData != null) {
      String newStrData = mapToUniqueStringData(newData);
      String oldStrData = mapToUniqueStringData(oldData);
      if (newStrData == oldStrData) {
        return false;
      } else {
        return true;
      }
    } else {
      return true;
    }
  }
}
