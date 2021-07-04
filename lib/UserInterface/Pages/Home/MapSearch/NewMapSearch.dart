import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/qbFAB.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:getparked/UserInterface/Pages/Home/MapSearch/SearchSuggestionsWidget.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:getparked/Utils/MapPlacesUtils.dart';
import 'package:getparked/BussinessLogic/PlacesDataCollection.dart';
import 'package:getparked/Utils/StringUtils.dart';

class NewMapSearchPage extends StatefulWidget {
  Function onLocationPressed;
  Function(CameraPosition) onSearch;

  NewMapSearchPage({@required this.onLocationPressed, @required this.onSearch});
  @override
  _NewMapSearchPageState createState() => _NewMapSearchPageState();
}

class _NewMapSearchPageState extends State<NewMapSearchPage> {
  @override
  void initState() {
    super.initState();
  }

  SearchSuggestionsController gpSuggestionsController;

  Widget searchBarWidget = Container();
  setSearchBarWidget() {
    searchBarWidget = Container(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: Container(
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(360),
                    borderSide: BorderSide(
                        color: Color.fromRGBO(220, 220, 220, 1), width: 1.5)),
                filled: true,
                isDense: true,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(360),
                    borderSide: BorderSide(
                        color: Color.fromRGBO(220, 220, 220, 1), width: 1.5)),
                contentPadding:
                    EdgeInsets.only(top: 12, bottom: 12, left: 20, right: 20),
                fillColor: Color.fromRGBO(250, 250, 250, 1),
                hintText: "Search nearby your destination",
                hintStyle: GoogleFonts.montserrat(
                    fontSize: 13.5 / MediaQuery.of(context).textScaleFactor),
              ),
              style: GoogleFonts.roboto(fontSize: 16, color: qbDetailDarkColor),
              onChanged: (value) {
                gpSearchText = value;
                gpSuggestionsController.textChanged(value);
              },
            ),
          )),

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
    );
  }

  Widget locationButton = Container();
  setLocationButton() {
    locationButton = GestureDetector(
      onTap: () {
        SystemSound.play(SystemSoundType.click);
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
    );
  }

  Widget suggestionsText = Container();
  setSuggestionsText() {
    suggestionsText = Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10),
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
    );
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

    // TODO: uncomment this if required.
    // if (placemarks != null) {
    //   placemarks.forEach((placeMark) {
    //     print(placeMark.name);
    //     PlacesDataCollection().postingPlacemarkForDiifName(
    //       placeMark,
    //       StringUtils.toFirstLetterUpperCase(gpSearchText),
    //     );
    //   });
    // }
  }

  onSearch(CameraPosition gpCamPos) {
    if (widget.onSearch != null) {
      widget.onSearch(gpCamPos);
    } else {
      print(gpCamPos.target.latitude.toString() +
          " " +
          gpCamPos.target.longitude.toString());
    }
  }

  String gpSearchText = "";

  @override
  Widget build(BuildContext context) {
    print("Set State Calling..");
    setSearchBarWidget();
    setLocationButton();
    setSuggestionsText();
    return Container(
        child: Scaffold(
      backgroundColor: qbWhiteBGColor,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: qbAppTextColor,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: Container(
        child: Column(
          children: [
            // Search Bar
            searchBarWidget,

            SizedBox(
              height: 15,
            ),

            //Use Location
            locationButton,

            //Suggestions Text
            suggestionsText,

            SizedBox(
              height: 10,
            ),

            // Suggestion Parts
            Expanded(
              child: Container(
                child: SearchSuggestionsWidget(
                  getController: (controller) {
                    gpSuggestionsController = controller;
                  },
                  suggestionSelect: (gpCamPos) {
                    onSearch(gpCamPos);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
