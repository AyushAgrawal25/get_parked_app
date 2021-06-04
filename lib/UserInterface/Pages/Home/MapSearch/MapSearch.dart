import 'dart:convert';

import 'package:getparked/Utils/MapPlacesUtils.dart';
import 'package:getparked/BussinessLogic/PlacesApiUtils.dart';
import 'package:getparked/Utils/StringUtils.dart';
import 'package:getparked/StateManagement/Models/AppOverlayStyleData.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/StateManagement/Models/MapPlaceData.dart';
import 'package:getparked/UserInterface/Pages/Home/MapSearch/SearchSuggestionCard.dart';
import 'package:getparked/UserInterface/Widgets/Loaders/LoaderPage.dart';
import '../../../Theme/AppOverlayStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import './../../../Widgets/qbFAB.dart';
import './../../../Theme/AppTheme.dart';
import 'package:google_fonts/google_fonts.dart';

class MapSearchPage extends StatefulWidget {
  Function onLocationPressed;
  Function(CameraPosition) onSearch;

  MapSearchPage({@required this.onSearch, @required this.onLocationPressed});

  @override
  _MapSearchPageState createState() => _MapSearchPageState();
}

class _MapSearchPageState extends State<MapSearchPage> {
  AppState gpAppState;
  bool isLoading = false;
  int pendingAPICalls = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    gpAppState = Provider.of<AppState>(context, listen: false);
    initializeMapPlacesForCity();
    pendingAPICalls = 0;
  }

  initializeMapPlacesForCity() async {
    // TODO: Uncomment when it is ready.
    // print(gpAppState.mapPlacesForSearch);
    // if (gpAppState.mapPlacesForSearch == null) {
    //   MapPlacesSearchResult gpMapPlacesSearchResult = await MapPlacesUtils()
    //       .getPlacesOnCityBasis(gpAppState.userData.accessToken);
    //   gpAppState.setMapPlacesForSearch(gpMapPlacesSearchResult);
    // }
  }

  MapPlacesSearchResult gpMapPlacesSearchResult;
  MapPlacesSearchResult gpFinalMapPlacesSearchResult;
  String gpSearchText;
  List<MapPlaceData> gpMapPlacesList = [];
  List<SearchSuggestionCard> gpSearchSuggestionCards = [];

  onTextChanged(String text) async {
    setState(() {
      gpSearchText = text;
      if (gpFinalMapPlacesSearchResult == null) {
        gpFinalMapPlacesSearchResult = gpAppState.mapPlacesForSearch;
      }
    });

    if (gpMapPlacesList != null) {
      if (gpMapPlacesList.length < 400) {
        searchFromDB();
      }
    } else {
      searchFromDB();
    }
  }

  searchFromDB() {
    pendingAPICalls++;
    print("API Called For $gpSearchText");
    if ((gpSearchText != null) &&
        (gpSearchText != "") &&
        (gpAppState.isInternetConnected)) {
      MapPlacesUtils()
          .searchFasterFromDB(gpAppState.authToken, gpSearchText)
          .then((MapPlacesSearchResult gpNewMapPlacesSearchResult) {
        if (gpFinalMapPlacesSearchResult != null) {
          if (gpNewMapPlacesSearchResult != null) {
            gpFinalMapPlacesSearchResult = MapPlacesUtils()
                .mergeTwoMapPlacesSearchResult(
                    gpFinalMapPlacesSearchResult, gpNewMapPlacesSearchResult);
          }
        } else {
          if (gpNewMapPlacesSearchResult != null) {
            gpFinalMapPlacesSearchResult = MapPlacesUtils()
                .mergeTwoMapPlacesSearchResult(
                    gpAppState.mapPlacesForSearch, gpNewMapPlacesSearchResult);
          } else {
            gpFinalMapPlacesSearchResult = gpAppState.mapPlacesForSearch;
          }
        }

        pendingAPICalls--;
        gpAppState.setMapPlacesForSearch(gpFinalMapPlacesSearchResult);
      });
    }
  }

  setSearchSuggestionCards(mapPlacesSearchResult) {
    gpSearchSuggestionCards = [];
    if ((gpSearchText != null) &&
        (gpSearchText != "") &&
        (mapPlacesSearchResult != null)) {
      // Search On Search Text
      MapPlacesSearchResult gpMapPlacesSearchResultAfterWordSearched =
          MapPlacesUtils().search(mapPlacesSearchResult, gpSearchText);

      // Sorting On The Basis Of Name
      gpMapPlacesSearchResultAfterWordSearched.sortingOnBasisOfName();

      // Searching And Sorting Both at a time
      gpMapPlacesList = MapPlacesUtils().getSearchAndSortedList(
          gpMapPlacesSearchResultAfterWordSearched, gpSearchText);

      int iterationNumber =
          (gpMapPlacesList.length > 50) ? 50 : gpMapPlacesList.length;
      // Creating Cards
      for (int i = 0; i < iterationNumber; i++) {
        gpSearchSuggestionCards.add(SearchSuggestionCard(
          searchSuggestionData: gpMapPlacesList[i].createSearchSuggestionData(),
          searchText: gpSearchText,
          onPressed: (CameraPosition gpCamPos) {
            Navigator.of(context).pop();
            onSearch(gpCamPos);
          },
        ));
      }
    }
  }

  onSearch(CameraPosition gpCamPos) {
    widget.onSearch(gpCamPos);
  }

  onSearchPressed() async {
    Navigator.of(context).pop();
    List<Placemark> placemarks =
        await Geolocator().placemarkFromAddress(gpSearchText).catchError((err) {
      print("GeoCoding Error Found For Searched Text!");
    });
    Placemark placemark = placemarks[0];
    onSearch(CameraPosition(
        target:
            LatLng(placemark.position.latitude, placemark.position.longitude),
        zoom: 15));

    if (placemarks != null) {
      placemarks.forEach((placeMark) {
        print(placeMark.name);
        PlacesApiUtils().postingPlaceDataWithDifferentName(
            placeMark, StringUtils.toFirstLetterUpperCase(gpSearchText));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AppState gpAppStateListen = Provider.of<AppState>(context, listen: true);
    // gpAppStateListen.applyOverlayStyle();

    setSearchSuggestionCards(gpAppStateListen.mapPlacesForSearch);
    if ((gpSearchSuggestionCards != null) && (gpSearchText != null)) {
      print(gpSearchSuggestionCards.length.toString() + " " + gpSearchText);
    }

    return Container(
      color: qbWhiteBGColor,
      child: SafeArea(
        top: false,
        maintainBottomViewPadding: true,
        child: Container(
          child: Stack(
            children: [
              Container(
                child: Scaffold(
                  appBar: AppBar(
                    elevation: 0.0,
                    brightness: Brightness.light,
                    backgroundColor: Color.fromRGBO(250, 250, 250, 1),
                    iconTheme: IconThemeData(color: qbAppTextColor),
                  ),
                  body: Container(
                    child: Column(
                      children: <Widget>[
                        //Search Bar
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              //Search Box
                              Expanded(
                                child: Container(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(360),
                                          borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  220, 220, 220, 1),
                                              width: 1.5)),
                                      filled: true,
                                      isDense: true,
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(360),
                                          borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  220, 220, 220, 1),
                                              width: 1.5)),
                                      contentPadding: EdgeInsets.only(
                                          top: 12,
                                          bottom: 12,
                                          left: 20,
                                          right: 20),
                                      fillColor:
                                          Color.fromRGBO(250, 250, 250, 1),
                                      hintText:
                                          "Search nearby your destination",
                                      hintStyle: GoogleFonts.montserrat(
                                          fontSize: 13.5 /
                                              MediaQuery.of(context)
                                                  .textScaleFactor),
                                    ),
                                    style: GoogleFonts.roboto(
                                        fontSize: 16, color: qbDetailDarkColor),
                                    onChanged: onTextChanged,
                                  ),
                                ),
                              ),

                              SizedBox(
                                width: 5,
                              ),

                              //Search Button
                              QbFAB(
                                color: qbAppPrimaryThemeColor,
                                size: 45,
                                child: Icon(
                                  FontAwesomeIcons.search,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                onPressed: onSearchPressed,
                              )
                            ],
                          ),
                        ),

                        //Use Location
                        SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (widget.onLocationPressed != null) {
                              Navigator.of(context).pop();
                              widget.onLocationPressed();
                            }
                          },
                          child: Container(
                              color: Colors.transparent,
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: Row(
                                children: <Widget>[
                                  //Location Icon
                                  QbFAB(
                                    color: qbAppPrimaryThemeColor,
                                    size: 40,
                                    child: Icon(
                                      Icons.location_on,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                    onPressed: () {},
                                  ),

                                  SizedBox(
                                    width: 15,
                                  ),

                                  Text(
                                    "Use Your Location",
                                    style: GoogleFonts.roboto(
                                        fontSize: 17.5,
                                        fontWeight: FontWeight.w500,
                                        color: qbDetailLightColor),
                                    textScaleFactor: 1,
                                  )
                                ],
                              )),
                        ),
                        //Suggestions Text
                        Container(
                          padding:
                              EdgeInsets.only(left: 20, right: 20, top: 10),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: Divider(
                                    height: 10,
                                    thickness: 1.5,
                                    color: Color.fromRGBO(220, 220, 220, 1),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  "Suggestions",
                                  style: GoogleFonts.roboto(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w400,
                                      color: qbDetailLightColor),
                                  textScaleFactor: 1,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Divider(
                                    height: 10,
                                    thickness: 1.5,
                                    color: Color.fromRGBO(220, 220, 220, 1),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),

                        Expanded(
                            child: Stack(
                          children: [
                            // Loader For Suggestions
                            ((gpSearchText != null) && (gpSearchText != ""))
                                ? Container(
                                    alignment: Alignment.center,
                                    child: Container(
                                      child: (pendingAPICalls > 0)
                                          ? CircularProgressIndicator()
                                          : Container(
                                              child: Text(
                                                "No Suggestions Found !",
                                                style: GoogleFonts.roboto(
                                                    fontSize: 13.5,
                                                    fontWeight: FontWeight.w400,
                                                    color: qbDetailLightColor),
                                                textScaleFactor: 1.0,
                                              ),
                                            ),
                                    ),
                                  )
                                : Container(
                                    height: 0,
                                    width: 0,
                                  ),

                            // Suggesstion Cards
                            Container(
                              color: (gpSearchSuggestionCards.length > 0)
                                  ? Color.fromRGBO(250, 250, 250, 1)
                                  : Colors.transparent,
                              child: ListView(
                                children:
                                    List.unmodifiable(gpSearchSuggestionCards),
                              ),
                            ),
                          ],
                        ))
                      ],
                    ),
                  ),
                ),
              ),

              // Loader Page
              (isLoading)
                  ? LoaderPage()
                  : Container(
                      height: 0,
                      width: 0,
                    )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
