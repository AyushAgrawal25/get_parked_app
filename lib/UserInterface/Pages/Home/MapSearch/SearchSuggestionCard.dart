import 'package:getparked/Utils/MapPlacesUtils.dart';
import 'package:getparked/Utils/StringUtils.dart';
import 'package:getparked/StateManagement/Models/MapPlaceData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import './../../../Theme/AppTheme.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchSuggestionCard extends StatefulWidget {
  SearchSuggestionData searchSuggestionData;
  String searchText;
  Function(CameraPosition) onPressed;
  SearchSuggestionCard(
      {this.searchSuggestionData, this.searchText, this.onPressed});

  @override
  _SearchSuggestionCardState createState() => _SearchSuggestionCardState();
}

class _SearchSuggestionCardState extends State<SearchSuggestionCard> {
  @override
  Widget build(BuildContext context) {
    // Code For Title Widget
    String titleText1 = widget.searchSuggestionData.title;
    String titleText2 = "";
    String titleText3 = "";
    if (widget.searchSuggestionData.title
        .trim()
        .toLowerCase()
        .contains(widget.searchText.trim().toLowerCase())) {
      int similarSearhTextStartPositionForTitle;
      for (int i = 0;
          i <
              (widget.searchSuggestionData.title.trim().length -
                  widget.searchText.trim().length +
                  1);
          i++) {
        similarSearhTextStartPositionForTitle = i;
        if (StringUtils.trimStringTillPosition(
                widget.searchSuggestionData.title.trim(),
                i + widget.searchText.trim().length)
            .trim()
            .toLowerCase()
            .contains(widget.searchText.trim().toLowerCase())) {
          break;
        }
      }

      if (similarSearhTextStartPositionForTitle != null) {
        titleText1 = StringUtils.trimBetween(
            widget.searchSuggestionData.title.trim(),
            0,
            similarSearhTextStartPositionForTitle - 1);
        titleText2 = StringUtils.trimBetween(
            widget.searchSuggestionData.title.trim(),
            similarSearhTextStartPositionForTitle,
            similarSearhTextStartPositionForTitle +
                widget.searchText.trim().length -
                1);
        titleText3 = StringUtils.trimBetween(
            widget.searchSuggestionData.title.trim(),
            similarSearhTextStartPositionForTitle +
                widget.searchText.trim().length,
            widget.searchSuggestionData.title.trim().length - 1);
      }
    }

    String addressText1 = widget.searchSuggestionData.address.trim();
    String addressText2 = "";
    String addressText3 = "";
    if (widget.searchSuggestionData.address
        .trim()
        .toLowerCase()
        .contains(widget.searchText.trim().toLowerCase())) {
      int similarSearhTextStartPositionForAddress;
      for (int i = 0;
          i <
              (widget.searchSuggestionData.address.trim().length -
                  widget.searchText.trim().length +
                  1);
          i++) {
        similarSearhTextStartPositionForAddress = i;
        if (StringUtils.trimStringTillPosition(
                widget.searchSuggestionData.address.trim(),
                i + widget.searchText.trim().length)
            .trim()
            .toLowerCase()
            .contains(widget.searchText.trim().toLowerCase())) {
          break;
        }
      }

      if (similarSearhTextStartPositionForAddress != null) {
        addressText1 = StringUtils.trimBetween(
            widget.searchSuggestionData.address.trim(),
            0,
            similarSearhTextStartPositionForAddress - 1);
        addressText2 = StringUtils.trimBetween(
            widget.searchSuggestionData.address.trim(),
            similarSearhTextStartPositionForAddress,
            similarSearhTextStartPositionForAddress +
                widget.searchText.trim().length -
                1);
        addressText3 = StringUtils.trimBetween(
            widget.searchSuggestionData.address.trim(),
            similarSearhTextStartPositionForAddress +
                widget.searchText.trim().length,
            widget.searchSuggestionData.address.trim().length - 1);
      }
    }

    return GestureDetector(
      onTap: () {
        SystemSound.play(SystemSoundType.click);
        if (widget.onPressed != null) {
          widget.onPressed(widget.searchSuggestionData.cameraPosition);
        }
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(30, 5, 0, 0),
        color: Colors.transparent,
        child: Column(
          children: <Widget>[
            //Main Card Element
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Color.fromRGBO(210, 210, 210, 1)),
                    child: Icon(
                      Icons.location_on,
                      color: Color.fromRGBO(100, 100, 100, 1),
                    ),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Flexible(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: titleText1, style: titleLightStyle),
                                TextSpan(
                                    text: titleText2, style: titleDarkStyle),
                                TextSpan(
                                    text: titleText3, style: titleLightStyle),
                              ]),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textScaleFactor: 1.0,
                            ),
                          ),
                          SizedBox(
                            height: 2.5,
                          ),
                          Container(
                            child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: addressText1,
                                    style: addressLightStyle),
                                TextSpan(
                                    text: addressText2,
                                    style: addressDarkStyle),
                                TextSpan(
                                    text: addressText3,
                                    style: addressLightStyle),
                              ]),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textScaleFactor: 1.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.fromLTRB(60, 2.5, 0, 5),
              child: Divider(
                height: 10,
                thickness: 1.5,
                color: Color.fromRGBO(220, 220, 220, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Colors
  static Color qbTitleLightColor = Color.fromRGBO(130, 130, 130, 1);
  static Color qbTitleDarkColor = Color.fromRGBO(50, 50, 50, 1);

  static Color qbAddressLightColor = Color.fromRGBO(130, 130, 130, 1);
  static Color qbAddressDarkColor = Color.fromRGBO(75, 75, 75, 1);

  TextStyle titleDarkStyle = GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: qbTitleDarkColor,
    letterSpacing: 0.3,
  );
  TextStyle titleLightStyle = GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: qbTitleLightColor,
    letterSpacing: 0.3,
  );
  TextStyle addressDarkStyle = GoogleFonts.roboto(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: qbAddressDarkColor,
    letterSpacing: 0.3,
  );
  TextStyle addressLightStyle = GoogleFonts.roboto(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: qbAddressLightColor,
    letterSpacing: 0.3,
  );
}

class SearchSuggestionData {
  int id;
  String title;
  String address;
  CameraPosition cameraPosition;

  SearchSuggestionData(
      {this.address, this.id, this.title, this.cameraPosition});
}
