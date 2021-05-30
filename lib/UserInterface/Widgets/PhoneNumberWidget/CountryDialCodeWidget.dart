import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CountryDialCodeWidget extends StatelessWidget {
  String flagUrl;
  String dialCode;
  String name;
  String isoCode;
  String searchText;
  Function(String, String) onSelect;

  CountryDialCodeWidget(
      {@required this.dialCode,
      @required this.flagUrl,
      @required this.isoCode,
      @required this.name,
      @required this.searchText,
      @required this.onSelect});

  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    String displayDialCode = "+" + this.dialCode;
    isVisible = false;
    if (this.searchText.length < this.name.length) {
      if (this
          .name
          .toLowerCase()
          .trim()
          .contains(this.searchText.toLowerCase())) {
        isVisible = true;
      }
    } else {
      if (this
          .searchText
          .toLowerCase()
          .trim()
          .contains(this.name.toLowerCase())) {
        isVisible = true;
      }
    }

    if (this.searchText.length < displayDialCode.length) {
      if (displayDialCode
          .toLowerCase()
          .trim()
          .contains(this.searchText.toLowerCase())) {
        isVisible = true;
      }
    } else {
      if (this
          .searchText
          .toLowerCase()
          .trim()
          .contains(displayDialCode.toLowerCase())) {
        isVisible = true;
      }
    }

    if (isVisible) {
      return GestureDetector(
        onTap: () {
          SystemSound.play(SystemSoundType.click);
          this.onSelect(this.dialCode, this.flagUrl);
        },
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 7.5),
          child: Row(
            children: [
              // Flag
              Container(
                height: 40,
                width: 40,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: SvgPicture.network(
                          this.flagUrl,
                          height: 15,
                          width: 20,
                          fit: BoxFit.fitHeight,
                          allowDrawingOutsideViewBox: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          this.name,
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: qbDetailDarkColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textScaleFactor: 1.0,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Container(
                        child: Text(
                          "+ " + this.dialCode,
                          style: GoogleFonts.roboto(
                            fontSize: 12.5,
                            color: qbDetailLightColor,
                          ),
                          textScaleFactor: 1.0,
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(
        height: 0,
        width: 0,
      );
    }
  }
}
