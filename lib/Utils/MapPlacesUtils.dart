import 'package:getparked/Utils/StringUtils.dart';
import 'package:getparked/StateManagement/Models/MapPlaceData.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart' as GeoLoc;
import 'package:location/location.dart';

class MapPlacesUtils {
  static String domainName = "http://3.21.53.195:5000";
  static String apiToken = "ZaranInfoTechPlacesAPI";
  Future<MapPlacesSearchResult> getPlacesOnCityBasis(String accessToken) async {
    LocationData currentLocation = await Location().getLocation();
    GeoLoc.Placemark currentPositionData = (await GeoLoc.Geolocator()
        .placemarkFromCoordinates(
            currentLocation.latitude, currentLocation.longitude))[0];
    Response placesResp = await Dio().get(
        domainName +
            "/routes/places/onCityBasis/${currentPositionData.subAdministrativeArea}/${currentPositionData.administrativeArea}",
        options: Options(headers: {"apiToken": apiToken}));

    // Locality Basis
    List<MapPlaceData> localityPlaces = MapPlaceDataUtils()
        .extractPlacesOnTheBasisOfType(
            placesResp.data["data"], MapPlaceDataType.locality);

    //Small Places
    List<MapPlaceData> smallPlaces = MapPlaceDataUtils()
        .extractPlacesOnTheBasisOfType(
            placesResp.data["data"], MapPlaceDataType.smallPlace);

    return MapPlacesSearchResult(
        cities: null,
        countries: null,
        localities: localityPlaces,
        smallPlaces: smallPlaces,
        states: null);
  }

  Future<MapPlacesSearchResult> searchFromDB(
      String accessToken, String gpSearchText) async {
    Response placesResp = await Dio().get(
        domainName + "/routes/places/search/$gpSearchText",
        options: Options(headers: {"apiToken": apiToken}));

    // Cities Basis
    List<MapPlaceData> cityPlaces = MapPlaceDataUtils()
        .extractPlacesOnTheBasisOfType(
            placesResp.data["data"], MapPlaceDataType.city);

    // Countries Basis
    List<MapPlaceData> countryPlaces = MapPlaceDataUtils()
        .extractPlacesOnTheBasisOfType(
            placesResp.data["data"], MapPlaceDataType.country);

    // States Basis
    List<MapPlaceData> statePlaces = MapPlaceDataUtils()
        .extractPlacesOnTheBasisOfType(
            placesResp.data["data"], MapPlaceDataType.states);

    // Locality Basis
    List<MapPlaceData> localityPlaces = MapPlaceDataUtils()
        .extractPlacesOnTheBasisOfType(
            placesResp.data["data"], MapPlaceDataType.locality);

    //Small Places
    List<MapPlaceData> smallPlaces = MapPlaceDataUtils()
        .extractPlacesOnTheBasisOfType(
            placesResp.data["data"], MapPlaceDataType.smallPlace);

    return MapPlacesSearchResult(
        cities: cityPlaces,
        countries: countryPlaces,
        localities: localityPlaces,
        smallPlaces: smallPlaces,
        states: statePlaces);
  }

  Future<MapPlacesSearchResult> searchFasterFromDB(
      String accessToken, String gpSearchText) async {
    Response placesResp = await Dio().get(
        domainName + "/routes/places/searchFaster/ordered/$gpSearchText",
        options: Options(headers: {"apiToken": apiToken}));

    print(
        "New Data Recieved From API Call For ${placesResp.data["searchText"]}");
    // Cities Basis
    List<MapPlaceData> cityPlaces = MapPlaceDataUtils()
        .extractPlacesOnTheBasisOfType(
            placesResp.data["data"], MapPlaceDataType.city);

    // Countries Basis
    List<MapPlaceData> countryPlaces = MapPlaceDataUtils()
        .extractPlacesOnTheBasisOfType(
            placesResp.data["data"], MapPlaceDataType.country);

    // States Basis
    List<MapPlaceData> statePlaces = MapPlaceDataUtils()
        .extractPlacesOnTheBasisOfType(
            placesResp.data["data"], MapPlaceDataType.states);

    // Locality Basis
    List<MapPlaceData> localityPlaces = MapPlaceDataUtils()
        .extractPlacesOnTheBasisOfType(
            placesResp.data["data"], MapPlaceDataType.locality);

    //Small Places
    List<MapPlaceData> smallPlaces = MapPlaceDataUtils()
        .extractPlacesOnTheBasisOfType(
            placesResp.data["data"], MapPlaceDataType.smallPlace);

    return MapPlacesSearchResult(
        cities: cityPlaces,
        countries: countryPlaces,
        localities: localityPlaces,
        smallPlaces: smallPlaces,
        states: statePlaces);
  }

  MapPlacesSearchResult search(
      MapPlacesSearchResult mapPlacesSearchResult, String gpSearchText) {
    return MapPlacesSearchResult(
        cities: this.findOnWordBasis(mapPlacesSearchResult.cities, gpSearchText,
            MapPlaceDataType.smallPlace),
        countries: this.findOnWordBasis(mapPlacesSearchResult.countries,
            gpSearchText, MapPlaceDataType.smallPlace),
        localities: this.findOnWordBasis(mapPlacesSearchResult.localities,
            gpSearchText, MapPlaceDataType.smallPlace),
        smallPlaces: this.mergeTwoList(
            this.findOnWordBasis(mapPlacesSearchResult.smallPlaces,
                gpSearchText, MapPlaceDataType.smallPlace),
            this.findOnWordBasis(mapPlacesSearchResult.smallPlaces,
                gpSearchText, MapPlaceDataType.locality)),
        states: this.findOnWordBasis(mapPlacesSearchResult.states, gpSearchText,
            MapPlaceDataType.smallPlace));
  }

  List<MapPlaceData> findOnWordBasis(List<MapPlaceData> mapPlaces,
      String gpSearchText, MapPlaceDataType gpMapPlaceDataType) {
    if (mapPlaces != null) {
      List<MapPlaceData> gpSearchedMapPlaces = [];
      mapPlaces.forEach((MapPlaceData mapPlaceData) {
        bool isThisMapPlaceRequired = false;

        switch (gpMapPlaceDataType) {
          case MapPlaceDataType.city:
            if (mapPlaceData.city
                .trim()
                .toLowerCase()
                .contains(gpSearchText.trimLeft().toLowerCase())) {
              isThisMapPlaceRequired = true;
            }
            break;
          case MapPlaceDataType.country:
            if (mapPlaceData.country
                .trim()
                .toLowerCase()
                .contains(gpSearchText.trimLeft().toLowerCase())) {
              isThisMapPlaceRequired = true;
            }
            break;
          case MapPlaceDataType.locality:
            if (mapPlaceData.locality
                .trim()
                .toLowerCase()
                .contains(gpSearchText.trimLeft().toLowerCase())) {
              isThisMapPlaceRequired = true;
            }
            break;
          case MapPlaceDataType.smallPlace:
            if (mapPlaceData.name
                .trim()
                .toLowerCase()
                .contains(gpSearchText.trimLeft().toLowerCase())) {
              isThisMapPlaceRequired = true;
            }
            break;
          case MapPlaceDataType.states:
            if (mapPlaceData.state
                .trim()
                .toLowerCase()
                .contains(gpSearchText.trimLeft().toLowerCase())) {
              isThisMapPlaceRequired = true;
            }
            break;
        }

        if (isThisMapPlaceRequired) {
          gpSearchedMapPlaces.add(mapPlaceData);
        }
      });

      return gpSearchedMapPlaces;
    } else {
      return null;
    }
  }

  MapPlacesSearchResult mergeTwoMapPlacesSearchResult(
      MapPlacesSearchResult mapPlacesSearchResultOne,
      MapPlacesSearchResult mapPlacesSearchResultTwo) {
    if ((mapPlacesSearchResultOne != null) &&
        (mapPlacesSearchResultTwo != null)) {
      List<MapPlaceData> cities;
      if ((mapPlacesSearchResultOne.cities != null) &&
          (mapPlacesSearchResultTwo.cities != null)) {
        cities = this.mergeTwoList(
            mapPlacesSearchResultOne.cities, mapPlacesSearchResultTwo.cities);
      } else {
        if (mapPlacesSearchResultOne.cities != null) {
          cities = mapPlacesSearchResultOne.cities;
        } else if (mapPlacesSearchResultTwo.cities != null) {
          cities = mapPlacesSearchResultTwo.cities;
        }
      }

      List<MapPlaceData> countries;
      if ((mapPlacesSearchResultOne.countries != null) &&
          (mapPlacesSearchResultTwo.countries != null)) {
        countries = this.mergeTwoList(mapPlacesSearchResultOne.countries,
            mapPlacesSearchResultTwo.countries);
      } else {
        if (mapPlacesSearchResultOne.countries != null) {
          countries = mapPlacesSearchResultOne.countries;
        } else if (mapPlacesSearchResultTwo.countries != null) {
          countries = mapPlacesSearchResultTwo.countries;
        }
      }

      List<MapPlaceData> localities;
      if ((mapPlacesSearchResultOne.localities != null) &&
          (mapPlacesSearchResultTwo.localities != null)) {
        localities = this.mergeTwoList(mapPlacesSearchResultOne.localities,
            mapPlacesSearchResultTwo.localities);
      } else {
        if (mapPlacesSearchResultOne.localities != null) {
          localities = mapPlacesSearchResultOne.localities;
        } else if (mapPlacesSearchResultTwo.localities != null) {
          localities = mapPlacesSearchResultTwo.localities;
        }
      }

      List<MapPlaceData> smallPlaces;
      if ((mapPlacesSearchResultOne.smallPlaces != null) &&
          (mapPlacesSearchResultTwo.smallPlaces != null)) {
        smallPlaces = this.mergeTwoList(mapPlacesSearchResultOne.smallPlaces,
            mapPlacesSearchResultTwo.smallPlaces);
      } else {
        if (mapPlacesSearchResultOne.smallPlaces != null) {
          smallPlaces = mapPlacesSearchResultOne.smallPlaces;
        } else if (mapPlacesSearchResultTwo.smallPlaces != null) {
          smallPlaces = mapPlacesSearchResultTwo.smallPlaces;
        }
      }

      List<MapPlaceData> states;
      if ((mapPlacesSearchResultOne.states != null) &&
          (mapPlacesSearchResultTwo.states != null)) {
        states = this.mergeTwoList(
            mapPlacesSearchResultOne.states, mapPlacesSearchResultTwo.states);
      } else {
        if (mapPlacesSearchResultOne.states != null) {
          states = mapPlacesSearchResultOne.states;
        } else if (mapPlacesSearchResultTwo.states != null) {
          states = mapPlacesSearchResultTwo.states;
        }
      }

      MapPlacesSearchResult gpMapPlacesSearchResultMerged =
          MapPlacesSearchResult(
        cities: cities,
        countries: countries,
        localities: localities,
        smallPlaces: smallPlaces,
        states: states,
      );

      return gpMapPlacesSearchResultMerged;
    } else {
      if (mapPlacesSearchResultOne != null) {
        return mapPlacesSearchResultOne;
      } else if (mapPlacesSearchResultTwo != null) {
        return mapPlacesSearchResultTwo;
      } else {
        return null;
      }
    }
  }

  List<MapPlaceData> mergeTwoList(
      List<MapPlaceData> placesListOne, List<MapPlaceData> placesListTwo) {
    List<MapPlaceData> mergedPlacesList = placesListOne;
    if (placesListTwo != null) {
      placesListTwo.forEach((MapPlaceData newMapPlaceData) {
        bool isMapPlaceAlreadyPresent = false;

        if (mergedPlacesList != null) {
          mergedPlacesList.forEach((MapPlaceData mapPlaceData) {
            if (newMapPlaceData.id == mapPlaceData.id) {
              isMapPlaceAlreadyPresent = true;
            }
          });
        } else {
          mergedPlacesList = [];
        }

        if (!isMapPlaceAlreadyPresent) {
          mergedPlacesList.add(newMapPlaceData);
        }
      });
    }

    return mergedPlacesList;
  }

  List<MapPlaceData> findOnLetterBasis(
      List<MapPlaceData> mapPlaces, String letter, int position) {
    List<MapPlaceData> gpMapPlacesSearched = [];
    int maxLength = 0;
    if (mapPlaces != null) {
      mapPlaces.forEach((mapPlaceData) {
        if (maxLength < mapPlaceData.name.length) {
          maxLength = mapPlaceData.name.length;
        }
      });

      for (int i = position; i < maxLength; i++) {
        mapPlaces.forEach((mapPlaceData) {
          if (mapPlaceData.name.length > i) {
            if (mapPlaceData.name[i].trim().toLowerCase() ==
                letter.trim().toLowerCase()) {
              gpMapPlacesSearched.add(mapPlaceData);
            }
          }
        });
      }

      return gpMapPlacesSearched;
    } else {
      return null;
    }
  }

  int getMaxStringLength(MapPlacesSearchResult gpMapPlacesSearchResult) {
    // Getting Max Length
    int maxLength = 0;
    if (gpMapPlacesSearchResult.cities != null) {
      // Cities
      gpMapPlacesSearchResult.cities.forEach((MapPlaceData mapPlaceData) {
        if (mapPlaceData.name.length > maxLength) {
          maxLength = mapPlaceData.name.length;
        }
        if (mapPlaceData.getAddress().length > maxLength) {
          maxLength = mapPlaceData.getAddress().length;
        }
      });
    }

    if (gpMapPlacesSearchResult.states != null) {
      // States
      gpMapPlacesSearchResult.states.forEach((MapPlaceData mapPlaceData) {
        if (mapPlaceData.name.length > maxLength) {
          maxLength = mapPlaceData.name.length;
        }
        if (mapPlaceData.getAddress().length > maxLength) {
          maxLength = mapPlaceData.getAddress().length;
        }
      });
    }

    if (gpMapPlacesSearchResult.smallPlaces != null) {
      // Small Places
      gpMapPlacesSearchResult.smallPlaces.forEach((MapPlaceData mapPlaceData) {
        if (mapPlaceData.name.length > maxLength) {
          maxLength = mapPlaceData.name.length;
        }
        if (mapPlaceData.getAddress().length > maxLength) {
          maxLength = mapPlaceData.getAddress().length;
        }
      });
    }

    if (gpMapPlacesSearchResult.countries != null) {
      // Countries
      gpMapPlacesSearchResult.countries.forEach((MapPlaceData mapPlaceData) {
        if (mapPlaceData.name.length > maxLength) {
          maxLength = mapPlaceData.name.length;
        }
        if (mapPlaceData.getAddress().length > maxLength) {
          maxLength = mapPlaceData.getAddress().length;
        }
      });
    }

    if (gpMapPlacesSearchResult.localities != null) {
      // Localities
      gpMapPlacesSearchResult.localities.forEach((MapPlaceData mapPlaceData) {
        if (mapPlaceData.name.length > maxLength) {
          maxLength = mapPlaceData.name.length;
        }
        if (mapPlaceData.getAddress().length > maxLength) {
          maxLength = mapPlaceData.getAddress().length;
        }
      });
    }

    return maxLength;
  }

  List<MapPlaceData> getSearchAndSortedList(
      MapPlacesSearchResult gpMapPlacesSearchResult, String gpSearchText) {
    int maxLength = this.getMaxStringLength(gpMapPlacesSearchResult);
    List<MapPlaceData> gpSearchAndSortedMapPlaces = [];
    for (int i = 0; i < (maxLength - gpSearchText.length); i++) {
      // For Adding Places With Names

      // Adding Localities
      if (gpMapPlacesSearchResult.localities != null) {
        gpMapPlacesSearchResult.localities
            .forEach((MapPlaceData gpMapPlaceData) {
          // Name has Search Text
          if (StringUtils.trimStringTillPosition(
                  gpMapPlaceData.name, i + gpSearchText.length)
              .toLowerCase()
              .trim()
              .contains(gpSearchText.trim().toLowerCase())) {
            bool isMapPlaceAlreadyPresent = false;
            gpSearchAndSortedMapPlaces.forEach((gpSearchAndSortedMapPlace) {
              if (gpSearchAndSortedMapPlace.id == gpMapPlaceData.id) {
                isMapPlaceAlreadyPresent = true;
              }
            });
            if (!isMapPlaceAlreadyPresent) {
              gpSearchAndSortedMapPlaces.add(gpMapPlaceData);
            }
          }
        });
      }

      // Adding SmallPlaces
      if (gpMapPlacesSearchResult.smallPlaces != null) {
        gpMapPlacesSearchResult.smallPlaces
            .forEach((MapPlaceData gpMapPlaceData) {
          // Name has Search Text
          if (StringUtils.trimStringTillPosition(
                  gpMapPlaceData.name, i + gpSearchText.length)
              .toLowerCase()
              .trim()
              .contains(gpSearchText.trim().toLowerCase())) {
            bool isMapPlaceAlreadyPresent = false;
            gpSearchAndSortedMapPlaces.forEach((gpSearchAndSortedMapPlace) {
              if (gpSearchAndSortedMapPlace.id == gpMapPlaceData.id) {
                isMapPlaceAlreadyPresent = true;
              }
            });
            if (!isMapPlaceAlreadyPresent) {
              gpSearchAndSortedMapPlaces.add(gpMapPlaceData);
            }
          }
        });
      }

      // Adding Ciites
      if (gpMapPlacesSearchResult.cities != null) {
        gpMapPlacesSearchResult.cities.forEach((MapPlaceData gpMapPlaceData) {
          // Name has Search Text
          if (StringUtils.trimStringTillPosition(
                  gpMapPlaceData.name, i + gpSearchText.length)
              .toLowerCase()
              .trim()
              .contains(gpSearchText.trim().toLowerCase())) {
            bool isMapPlaceAlreadyPresent = false;
            gpSearchAndSortedMapPlaces.forEach((gpSearchAndSortedMapPlace) {
              if (gpSearchAndSortedMapPlace.id == gpMapPlaceData.id) {
                isMapPlaceAlreadyPresent = true;
              }
            });
            if (!isMapPlaceAlreadyPresent) {
              gpSearchAndSortedMapPlaces.add(gpMapPlaceData);
            }
          }
        });
      }

      // Adding States
      if (gpMapPlacesSearchResult.states != null) {
        gpMapPlacesSearchResult.states.forEach((MapPlaceData gpMapPlaceData) {
          // Name has Search Text
          if (StringUtils.trimStringTillPosition(
                  gpMapPlaceData.name, i + gpSearchText.length)
              .toLowerCase()
              .trim()
              .contains(gpSearchText.trim().toLowerCase())) {
            bool isMapPlaceAlreadyPresent = false;
            gpSearchAndSortedMapPlaces.forEach((gpSearchAndSortedMapPlace) {
              if (gpSearchAndSortedMapPlace.id == gpMapPlaceData.id) {
                isMapPlaceAlreadyPresent = true;
              }
            });
            if (!isMapPlaceAlreadyPresent) {
              gpSearchAndSortedMapPlaces.add(gpMapPlaceData);
            }
          }
        });
      }

      // Adding Countires
      if (gpMapPlacesSearchResult.countries != null) {
        gpMapPlacesSearchResult.countries
            .forEach((MapPlaceData gpMapPlaceData) {
          // Name has Search Text
          if (StringUtils.trimStringTillPosition(
                  gpMapPlaceData.name, i + gpSearchText.length)
              .toLowerCase()
              .trim()
              .contains(gpSearchText.trim().toLowerCase())) {
            bool isMapPlaceAlreadyPresent = false;
            gpSearchAndSortedMapPlaces.forEach((gpSearchAndSortedMapPlace) {
              if (gpSearchAndSortedMapPlace.id == gpMapPlaceData.id) {
                isMapPlaceAlreadyPresent = true;
              }
            });
            if (!isMapPlaceAlreadyPresent) {
              gpSearchAndSortedMapPlaces.add(gpMapPlaceData);
            }
          }
        });
      }

      // For Adding Addresses

      // Adding Localities
      if (gpMapPlacesSearchResult.localities != null) {
        gpMapPlacesSearchResult.localities
            .forEach((MapPlaceData gpMapPlaceData) {
          // Name has Search Text
          if (StringUtils.trimStringTillPosition(
                  gpMapPlaceData.getAddress(), i + gpSearchText.length)
              .trim()
              .toLowerCase()
              .contains(gpSearchText.trim().toLowerCase())) {
            bool isMapPlaceAlreadyPresent = false;
            gpSearchAndSortedMapPlaces.forEach((gpSearchAndSortedMapPlace) {
              if (gpSearchAndSortedMapPlace.id == gpMapPlaceData.id) {
                isMapPlaceAlreadyPresent = true;
              }
            });
            if (!isMapPlaceAlreadyPresent) {
              gpSearchAndSortedMapPlaces.add(gpMapPlaceData);
            }
          }
        });
      }

      // Adding SmallPlaces
      if (gpMapPlacesSearchResult.smallPlaces != null) {
        gpMapPlacesSearchResult.smallPlaces
            .forEach((MapPlaceData gpMapPlaceData) {
          // Name has Search Text
          if (StringUtils.trimStringTillPosition(
                  gpMapPlaceData.getAddress(), i + gpSearchText.length)
              .trim()
              .toLowerCase()
              .contains(gpSearchText.trim().toLowerCase())) {
            bool isMapPlaceAlreadyPresent = false;
            gpSearchAndSortedMapPlaces.forEach((gpSearchAndSortedMapPlace) {
              if (gpSearchAndSortedMapPlace.id == gpMapPlaceData.id) {
                isMapPlaceAlreadyPresent = true;
              }
            });
            if (!isMapPlaceAlreadyPresent) {
              gpSearchAndSortedMapPlaces.add(gpMapPlaceData);
            }
          }
        });
      }

      // Adding Ciites
      if (gpMapPlacesSearchResult.cities != null) {
        gpMapPlacesSearchResult.cities.forEach((MapPlaceData gpMapPlaceData) {
          // Name has Search Text
          if (StringUtils.trimStringTillPosition(
                  gpMapPlaceData.getAddress(), i + gpSearchText.length)
              .trim()
              .toLowerCase()
              .contains(gpSearchText.trim().toLowerCase())) {
            bool isMapPlaceAlreadyPresent = false;
            gpSearchAndSortedMapPlaces.forEach((gpSearchAndSortedMapPlace) {
              if (gpSearchAndSortedMapPlace.id == gpMapPlaceData.id) {
                isMapPlaceAlreadyPresent = true;
              }
            });
            if (!isMapPlaceAlreadyPresent) {
              gpSearchAndSortedMapPlaces.add(gpMapPlaceData);
            }
          }
        });
      }

      // Adding States
      if (gpMapPlacesSearchResult.states != null) {
        gpMapPlacesSearchResult.states.forEach((MapPlaceData gpMapPlaceData) {
          // Name has Search Text
          if (StringUtils.trimStringTillPosition(
                  gpMapPlaceData.getAddress(), i + gpSearchText.length)
              .trim()
              .toLowerCase()
              .contains(gpSearchText.trim().toLowerCase())) {
            bool isMapPlaceAlreadyPresent = false;
            gpSearchAndSortedMapPlaces.forEach((gpSearchAndSortedMapPlace) {
              if (gpSearchAndSortedMapPlace.id == gpMapPlaceData.id) {
                isMapPlaceAlreadyPresent = true;
              }
            });
            if (!isMapPlaceAlreadyPresent) {
              gpSearchAndSortedMapPlaces.add(gpMapPlaceData);
            }
          }
        });
      }

      // Adding Countires
      if (gpMapPlacesSearchResult.countries != null) {
        gpMapPlacesSearchResult.countries
            .forEach((MapPlaceData gpMapPlaceData) {
          // Name has Search Text
          if (StringUtils.trimStringTillPosition(
                  gpMapPlaceData.getAddress(), i + gpSearchText.length)
              .trim()
              .toLowerCase()
              .contains(gpSearchText.trim().toLowerCase())) {
            bool isMapPlaceAlreadyPresent = false;
            gpSearchAndSortedMapPlaces.forEach((gpSearchAndSortedMapPlace) {
              if (gpSearchAndSortedMapPlace.id == gpMapPlaceData.id) {
                isMapPlaceAlreadyPresent = true;
              }
            });
            if (!isMapPlaceAlreadyPresent) {
              gpSearchAndSortedMapPlaces.add(gpMapPlaceData);
            }
          }
        });
      }
    }

    return gpSearchAndSortedMapPlaces;
  }
}

class MapPlacesSearchResult {
  List<MapPlaceData> localities;
  List<MapPlaceData> smallPlaces;
  List<MapPlaceData> cities;
  List<MapPlaceData> states;
  List<MapPlaceData> countries;

  MapPlacesSearchResult(
      {this.cities,
      this.countries,
      this.localities,
      this.smallPlaces,
      this.states});

  sortingOnBasisOfName() {
    if (cities != null) {
      cities.sort((a, b) =>
          a.name.trim().toLowerCase().compareTo(b.name.trim().toLowerCase()));
    }

    if (countries != null) {
      countries.sort((a, b) =>
          a.name.trim().toLowerCase().compareTo(b.name.trim().toLowerCase()));
    }

    if (localities != null) {
      localities.sort((a, b) =>
          a.name.trim().toLowerCase().compareTo(b.name.trim().toLowerCase()));
    }

    if (smallPlaces != null) {
      smallPlaces.sort((a, b) =>
          a.name.trim().toLowerCase().compareTo(b.name.trim().toLowerCase()));
    }

    if (states != null) {
      states.sort((a, b) =>
          a.name.trim().toLowerCase().compareTo(b.name.trim().toLowerCase()));
    }
  }
}
