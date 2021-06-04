import 'package:getparked/UserInterface/Pages/Home/MapSearch/SearchSuggestionCard.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPlaceDataUtils {
  List<MapPlaceData> extractPlacesOnTheBasisOfType(
      List places, MapPlaceDataType type) {
    if (places != null) {
      List<MapPlaceData> requiredPlaces = [];
      places.forEach((place) {
        double gpSuggestionZoom;
        bool isThisPlaceDemanded = false;
        switch (type) {
          case MapPlaceDataType.country:
            if (place["placeName"] == place["placeCountry"]) {
              isThisPlaceDemanded = true;
              gpSuggestionZoom = 5.5;
            }
            break;
          case MapPlaceDataType.states:
            // The Place Must Not be Country
            if ((place["placeName"] == place["placeState"]) &&
                (place["placeName"] != place["placeCountry"])) {
              isThisPlaceDemanded = true;
              gpSuggestionZoom = 8.5;
            }
            break;
          case MapPlaceDataType.city:
            // The Place Must Not be Country, State
            if ((place["placeName"] == place["placeCity"]) &&
                (place["placeName"] != place["placeState"]) &&
                (place["placeName"] != place["placeCountry"])) {
              isThisPlaceDemanded = true;
              gpSuggestionZoom = 13.5;
            }
            break;
          case MapPlaceDataType.locality:
            if ((place["placeName"] == place["placeLocality"]) &&
                !((place["placeName"] == place["placeCity"]) ||
                    (place["placeName"] == place["placeCountry"]) ||
                    (place["placeName"] == place["placeState"]))) {
              isThisPlaceDemanded = true;
              gpSuggestionZoom = 15.0;
            }
            break;
          case MapPlaceDataType.smallPlace:
            // The Place Must Not be Country, State, City, Locality, SubLocality.
            if ((place["placeName"] == place["placeLocality"]) ||
                (place["placeName"] == place["placeSubLocality"]) ||
                (place["placeName"] == place["placeCity"]) ||
                (place["placeName"] == place["placeState"]) ||
                (place["placeName"] == place["placeCountry"])) {
            } else {
              isThisPlaceDemanded = true;
              gpSuggestionZoom = 16.0;
            }
            break;
        }

        if (isThisPlaceDemanded) {
          bool isAlreadyRegistered = false;
          requiredPlaces.forEach((requiredPlace) {
            if (requiredPlace.name == place["placeName"]) {
              isAlreadyRegistered = true;
            }
          });

          if (!isAlreadyRegistered) {
            requiredPlaces.add(MapPlaceData(
                id: place["placeId"],
                name: place["placeName"],
                city: place["placeCity"],
                state: place["placeState"],
                country: place["placeCountry"],
                isoCountryCode: place["placeISOCountryCode"],
                locality: place["placeLocality"],
                subLocality: place["placeSubLocality"],
                type: type,
                postalCode: place["placePostalCode"],
                cameraPosition: CameraPosition(
                    zoom: gpSuggestionZoom,
                    target: LatLng(
                        (place["placeLatitude"] != null)
                            ? (place["placeLatitude"]).toDouble()
                            : 0.0,
                        (place["placeLongitude"] != null)
                            ? (place["placeLongitude"]).toDouble()
                            : 0.0))));
          }
        }
      });

      return requiredPlaces;
    } else {
      return null;
    }
  }
}

class MapPlaceData {
  int id;
  String name;
  String city;
  String state;
  String locality;
  String subLocality;
  String country;
  String isoCountryCode;
  CameraPosition cameraPosition;
  MapPlaceDataType type;
  String postalCode;

  MapPlaceData(
      {this.cameraPosition,
      this.city,
      this.country,
      this.id,
      this.isoCountryCode,
      this.locality,
      this.name,
      this.postalCode,
      this.state,
      this.subLocality,
      this.type});

  String getAddress() {
    String address = "";
    if ((this.locality != null) && (this.locality != "")) {
      address += this.locality + " ";
    }
    if ((this.city != null) && (this.city != "")) {
      address += this.city + " ";
    }
    if ((this.state != null) && (this.state != "")) {
      address += this.state + " ";
    }
    if ((this.country != null) && (this.country != "")) {
      address += this.country + " ";
    }
    return address;
  }

  createSearchSuggestionData() {
    return SearchSuggestionData(
        address: this.getAddress(),
        id: this.id,
        title: this.name,
        cameraPosition: this.cameraPosition);
  }
}

enum MapPlaceDataType { smallPlace, locality, city, states, country }
