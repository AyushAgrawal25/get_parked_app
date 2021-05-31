import 'package:getparked/UserInterface/Icons/g_p_icons_icons.dart';
import 'package:getparked/UserInterface/Widgets/SideNav/NavigationModel.dart';
import 'package:getparked/UserInterface/Widgets/SideNav/SideNavItem.dart';
import 'package:getparked/UserInterface/Widgets/SideNav/SideNavTheme.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/CustomButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:getparked/Utils/DomainUtils.dart';

class SideNav extends StatefulWidget {
  Function onMenuClose;
  bool isUserAParkingLord;

  SideNav({this.onMenuClose, this.isUserAParkingLord});

  @override
  _SideNavState createState() => _SideNavState();
}

class _SideNavState extends State<SideNav> {
  List<Widget> qbSideNavItemsList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    qbSideNavItemsList = [];
    navigationPrimaryItems.forEach((qbSideNavModel) {
      qbSideNavItemsList.add(SideNavItem(
        title: qbSideNavModel.title,
        icon: qbSideNavModel.icon,
        route: qbSideNavModel.route,
        iconSize: qbNavPrimaryItemIconSize,
        fontSize: qbNavPrimaryItemFontSize,
      ));
    });

    if (widget.isUserAParkingLord) {
      qbSideNavItemsList.add(Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Divider(
          height: 10,
          thickness: 1,
          color: Color.fromRGBO(200, 200, 200, 1),
        ),
      ));

      navigationParkingLordItems.forEach((qbSideNavModel) {
        qbSideNavItemsList.add(SideNavItem(
          title: qbSideNavModel.title,
          icon: qbSideNavModel.icon,
          route: qbSideNavModel.route,
          iconSize: qbNavPrimaryItemIconSize,
          fontSize: qbNavPrimaryItemFontSize,
        ));
      });

      qbSideNavItemsList.add(Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Divider(
          height: 10,
          thickness: 1,
          color: Color.fromRGBO(200, 200, 200, 1),
        ),
      ));
    } else {
      qbSideNavItemsList.add(SideNavItem(
        title: "Rent Out your Sapce",
        icon: GPIcons.rent_out_space,
        route: '/RentOutSpace',
        iconSize: 25,
        fontSize: 17.5,
      ));
    }

    navigationSecondaryItems.forEach((qbSideNavModel) {
      qbSideNavItemsList.add(SideNavItem(
        title: qbSideNavModel.title,
        icon: qbSideNavModel.icon,
        route: qbSideNavModel.route,
        iconSize: qbNavPrimaryItemIconSize,
        fontSize: qbNavPrimaryItemFontSize,
      ));
    });

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Row(
        children: [
          //NavBar
          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.05 +
                    MediaQuery.of(context).padding.top,
                bottom: 30),
            decoration: BoxDecoration(
                color: Color.fromRGBO(250, 250, 250, 1),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(2, 0),
                      blurRadius: 10,
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                      spreadRadius: 0.25)
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Logo
                Container(
                  height: 70,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 15, right: 15),
                        child: Icon(
                          GPIcons.get_parked_logo,
                          size: 35,
                          color: qbAppPrimaryThemeColor,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 10),
                        child: Text(
                          appName,
                          style: GoogleFonts.josefinSans(
                              fontSize: 40,
                              fontWeight: FontWeight.w700,
                              color: qbAppPrimaryThemeColor),
                          textScaleFactor: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Divider(
                    height: 1,
                    thickness: 1,
                    color: Color.fromRGBO(200, 200, 200, 1),
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        //Menu Items
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.5, vertical: 15),
                          child: Column(
                            children: qbSideNavItemsList,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                SystemSound.play(SystemSoundType.click);
                widget.onMenuClose();
              },
              child: Container(
                color: Colors.transparent,
              ),
            ),
          )
        ],
      ),
    );
  }
}
