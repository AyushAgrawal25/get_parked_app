import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/Utils/MapPlacesUtils.dart';
import 'package:provider/provider.dart';
import 'package:getparked/StateManagement/Models/MapPlaceData.dart';
import 'package:getparked/UserInterface/Pages/Home/MapSearch/SearchSuggestionCard.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchSuggestionsWidget extends StatefulWidget {
  Function(SearchSuggestionsController) getController;
  Function(CameraPosition) suggestionSelect;
  SearchSuggestionsWidget(
      {@required this.getController, @required this.suggestionSelect});
  @override
  _SearchSuggestionsWidgetState createState() =>
      _SearchSuggestionsWidgetState();
}

class SearchSuggestionsController {
  Function(String) textChanged;
}

class _SearchSuggestionsWidgetState extends State<SearchSuggestionsWidget> {
  AppState gpAppState;
  bool isLoading = false;
  int pendingAPICalls = 0;

  @override
  void initState() {
    super.initState();
    SearchSuggestionsController controller = SearchSuggestionsController();
    controller.textChanged = (String text) {
      setState(() {
        gpSearchText = text;
      });

      if (gpMapPlacesSearchResult != null) {
        int totalPlaces = gpMapPlacesSearchResult.cities.length +
            gpMapPlacesSearchResult.countries.length +
            gpMapPlacesSearchResult.localities.length +
            gpMapPlacesSearchResult.smallPlaces.length +
            gpMapPlacesSearchResult.states.length;
        if (totalPlaces < 400) {
          searchFromDB();
        }
      } else {
        searchFromDB();
      }
    };
    widget.getController(controller);
    gpAppState = Provider.of<AppState>(context, listen: false);
    initializeMapPlacesForCity();
    pendingAPICalls = 0;
  }

  initializeMapPlacesForCity() async {
    // TODO: uncomment this if required.
    // print(gpAppState.mapPlacesForSearch);
    // if (gpAppState.mapPlacesForSearch == null) {
    //   MapPlacesSearchResult gpMapPlacesSearchResult =
    //       await MapPlacesUtils().getPlacesOnCityBasis(gpAppState.authToken);
    //   gpAppState.setMapPlacesForSearch(gpMapPlacesSearchResult);
    // }
  }

  MapPlacesSearchResult gpMapPlacesSearchResult;
  String gpSearchText = "";
  List<SearchSuggestionCard> gpSearchSuggestionCards = [];

  searchFromDB() {
    // TODO: uncomment this if required.
    // print("API Called For $gpSearchText");
    // if ((gpSearchText != null) &&
    //     (gpSearchText != "") &&
    //     (gpAppState.isInternetConnected)) {
    //   pendingAPICalls++;
    //   MapPlacesUtils()
    //       .searchFasterFromDB(gpAppState.authToken, gpSearchText)
    //       .then((MapPlacesSearchResult gpNewMapPlacesSearchResult) {
    //     if (gpNewMapPlacesSearchResult != null) {
    //       gpMapPlacesSearchResult = gpNewMapPlacesSearchResult;
    //     }

    //     pendingAPICalls--;
    //   }).catchError((err) {
    //     print("From Search From DB Function API Call " + err.toString());
    //   });
    // }
  }

  onSearch(CameraPosition gpCamPos) {
    widget.suggestionSelect(gpCamPos);
  }

  @override
  Widget build(BuildContext context) {
    AppState gpAppStateListen = Provider.of<AppState>(context, listen: true);
    // gpAppStateListen.applyOverlayStyle();

    return Container(
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
            children: new UnmodifiableListView(gpSearchSuggestionCards),
          ),
        ),
      ],
    ));
  }
}
