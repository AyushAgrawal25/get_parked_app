import 'package:getparked/Utils/ContactUtils.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/StateManagement/Models/ContactData.dart';
import 'package:getparked/UserInterface/Pages/Wallet/RequestMoney/ContactCard/ContactCard.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/EdgeLessButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:getparked/UserInterface/Icons/g_p_icons_icons.dart';
import 'package:getparked/UserInterface/Widgets/CustomIcon.dart';

class SelectContact extends StatefulWidget {
  final double amount;

  SelectContact({this.amount});

  @override
  _SelectContactState createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  AppState gpAppState;

  List<Widget> contactCards = [];
  String gpContactSearch = "";

  @override
  void initState() {
    super.initState();

    gpAppState = Provider.of<AppState>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    List<ContactData> searchedContacts = [];
    if ((gpContactSearch != "") && (gpContactSearch != null)) {
      searchedContacts =
          ContactUtils().search(gpAppState.contacts, gpContactSearch);
    }

    return Container(
      color: qbWhiteBGColor,
      child: SafeArea(
          top: false,
          maintainBottomViewPadding: true,
          child: Container(
            child: Scaffold(
              appBar: AppBar(
                  title: Row(
                    children: [
                      CustomIcon(
                        icon: GPIcons.request_money,
                        size: 20,
                        color: qbAppTextColor,
                      ),
                      SizedBox(
                        width: 12.5,
                      ),
                      Text(
                        "Send Payment Request",
                        style: GoogleFonts.nunito(
                            fontWeight: FontWeight.w600, color: qbAppTextColor),
                        textScaleFactor: 1.0,
                      ),
                    ],
                  ),
                  iconTheme: IconThemeData(color: qbAppTextColor),
                  elevation: 0.5,
                  brightness: Brightness.light,
                  backgroundColor: Color.fromRGBO(250, 250, 250, 1)),
              body: Container(
                padding: EdgeInsets.only(top: 25, bottom: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Enter Phone Number
                    Container(
                      padding: EdgeInsets.only(
                          top: 3.5, bottom: 3.5, left: 43.75, right: 25),
                      child: Text(
                        "Enter name or number",
                        style: GoogleFonts.nunito(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: qbDetailLightColor),
                        textScaleFactor: 1.0,
                      ),
                    ),

                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 3.5, horizontal: 25),
                      child: Container(
                        child: TextField(
                          style: GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: qbAppTextColor),
                          onChanged: (value) {
                            setState(() {
                              gpContactSearch = value;
                            });
                          },
                          decoration: InputDecoration(
                            isDense: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: qbAppTextColor),
                                borderRadius: BorderRadius.circular(360)),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 11.5, horizontal: 25),
                          ),
                        ),
                      ),
                    ),

                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                      alignment: Alignment.centerRight,
                      child: EdgeLessButton(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 22.5),
                        color: qbAppPrimaryBlueColor,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              child: Icon(
                                FontAwesome5.search,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                            SizedBox(
                              width: 3.5,
                            ),
                            Container(
                              child: Text(
                                "Search",
                                style: GoogleFonts.nunito(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                                textScaleFactor: 1.0,
                              ),
                            ),
                            SizedBox(
                              width: 1.5,
                            )
                          ],
                        ),
                        onPressed: () {},
                      ),
                    ),

                    SizedBox(
                      height: 5,
                    ),

                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                      child: Text(
                        "Suggestions",
                        style: GoogleFonts.nunito(
                            fontSize: 17.5,
                            fontWeight: FontWeight.w600,
                            color: qbDetailDarkColor),
                        textScaleFactor: 1.0,
                      ),
                    ),

                    Container(
                      child: Divider(
                        color: qbDetailLightColor,
                        height: 5,
                      ),
                    ),

                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(top: 10),
                        child: ListView(
                          children: searchedContacts.map((searchedContact) {
                            return ContactCard(
                                contactData: searchedContact,
                                amount: widget.amount);
                          }).toList(),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
