import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:getparked/StateManagement/Models/FAQData.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/qbFAB.dart';
import 'package:google_fonts/google_fonts.dart';

class FAQWidget extends StatefulWidget {
  final FAQData faqData;
  FAQWidget({this.faqData});
  @override
  _FAQWidgetState createState() => _FAQWidgetState();
}

class _FAQWidgetState extends State<FAQWidget> {
  bool isOpen = false;
  bool isDiscriptionOpen = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          width: MediaQuery.of(context).size.width,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: qbDividerLightColor, width: 1.5),
                borderRadius: BorderRadius.circular(7.5)),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  // Left Color
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(7.5),
                          bottomLeft: Radius.circular(7.5),
                        ),
                        color: qbAppPrimaryThemeColor),
                    width: 27.5,
                  ),

                  Expanded(
                    child: Container(
                      constraints: BoxConstraints(minHeight: 65),
                      padding:
                          EdgeInsets.symmetric(vertical: 12.5, horizontal: 20),
                      child: Column(
                        children: [
                          // Query
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              widget.faqData.query,
                              style: GoogleFonts.nunito(
                                  color: qbAppTextColor,
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.start,
                              textScaleFactor: 1.0,
                            ),
                          ),

                          ((isOpen) && (widget.faqData.description != null))
                              ? Container(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isDiscriptionOpen = !isDiscriptionOpen;
                                      });
                                    },
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5),
                                      child: Text(
                                        "Description",
                                        style: GoogleFonts.roboto(
                                          color: qbDetailLightColor,
                                          fontSize: 13.5,
                                        ),
                                        textAlign: TextAlign.right,
                                        textScaleFactor: 1.0,
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  height: 0,
                                  width: 0,
                                ),

                          // Description
                          (isDiscriptionOpen)
                              ? Container(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(
                                    (widget.faqData.description != null)
                                        ? widget.faqData.description.trim()
                                        : "",
                                    style: GoogleFonts.roboto(
                                        color: qbDetailLightColor,
                                        fontSize: 14.5,
                                        fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.left,
                                    textScaleFactor: 1.0,
                                  ),
                                )
                              : Container(
                                  height: 0,
                                  width: 0,
                                ),

                          // Answer
                          (isOpen)
                              ? Container(
                                  child: Divider(
                                      thickness: 1.5,
                                      color: qbDividerLightColor,
                                      height: 15),
                                )
                              : Container(
                                  height: 0,
                                  width: 0,
                                ),

                          // Answer
                          (isOpen)
                              ? Container(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(
                                    widget.faqData.answer,
                                    style: GoogleFonts.roboto(
                                        color: qbDetailLightColor,
                                        fontSize: 14.5,
                                        fontWeight: FontWeight.w400),
                                    textScaleFactor: 1.0,
                                    textAlign: TextAlign.left,
                                  ),
                                )
                              : Container(
                                  height: 0,
                                  width: 0,
                                ),

                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),

        // Fab
        Positioned(
            bottom: 0,
            right: MediaQuery.of(context).size.width * 0.125,
            child: QbFAB(
              size: 42.5,
              color: qbAppPrimaryThemeColor,
              child: Container(
                child: Icon(
                  FontAwesome5.chevron_down,
                  color: qbWhiteBGColor,
                  size: 17.5,
                ),
              ),
              onPressed: () {
                setState(() {
                  isOpen = !isOpen;
                  if (!isOpen) {
                    isDiscriptionOpen = false;
                  }
                });
              },
            ))
      ],
    );
  }
}
