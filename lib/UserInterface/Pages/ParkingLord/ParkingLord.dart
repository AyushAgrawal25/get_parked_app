import 'dart:collection';

import 'package:getparked/StateManagement/Models/AppOverlayStyleData.dart';
import 'package:getparked/StateManagement/Models/ParkingLordData.dart';
import 'package:getparked/StateManagement/Models/UserDetails.dart';
import 'package:getparked/UserInterface/Icons/g_p_icons_icons.dart';
import 'package:getparked/UserInterface/Pages/ParkingLord/ParkingLordEdit/ParkingLordEditPage.dart';
import 'package:getparked/UserInterface/Pages/Vault/VaultPage.dart';
// import 'package:getparked/UserInterface/Pages/Vault/VaultPage.dart';
import 'package:getparked/UserInterface/Widgets/Reviews/ReviewButton.dart';
import 'package:getparked/UserInterface/Widgets/CustomIcon.dart';
import 'package:getparked/UserInterface/Widgets/MoreDetailsAcc.dart';
import 'package:getparked/UserInterface/Widgets/ParkingCard/ParkingCard.dart';
import 'package:getparked/UserInterface/Widgets/Rating/RatingWidget.dart';
import 'package:getparked/UserInterface/Widgets/SlotNameWidget.dart';
import 'package:getparked/UserInterface/Widgets/qbFAB.dart';
import 'package:flutter/material.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/modern_pictograms_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/services.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/StateManagement/Models/ParkingRequestData.dart';
import 'package:provider/provider.dart';
import 'package:getparked/Utils/DomainUtils.dart';
import 'package:getparked/UserInterface/Pages/ParkingLord/QRCodePage/QRCodePage.dart';
import 'package:getparked/UserInterface/Widgets/DisplayPicture.dart';
import 'package:getparked/UserInterface/Pages/ParkingLord/ParkingLordEdit/UIComponents/SlotImgGallery.dart';

class ParkingLord extends StatefulWidget {
  @override
  _ParkingLordState createState() => _ParkingLordState();
}

class _ParkingLordState extends State<ParkingLord> {
  AppState gpAppState;
  @override
  void initState() {
    super.initState();
    gpAppState = Provider.of(context, listen: false);
  }

  Widget slotImgWidget = Container(
    height: 0,
    width: 0,
  );
  setSlotImgWidget() {
    double slotImgSize = MediaQuery.of(context).size.width * 0.5;
    slotImgWidget = Stack(
      children: [
        Container(
          height: slotImgSize * 0.75,
          decoration: BoxDecoration(color: qbAppPrimaryThemeColor
              // borderRadius: BorderRadius.only(
              //     bottomLeft: Radius.circular(15),
              //     bottomRight: Radius.circular(15))
              ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 22.5, vertical: 5),
            alignment: Alignment.topCenter,
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: slotImgSize * 0.075),
          child: DisplayPicture(
            isElevated: true,
            borderRadius: BorderRadius.circular(5),
            height: slotImgSize,
            iconButtonSize: 50,
            width: slotImgSize * 1.5,
            imgUrl: formatImgUrl(gpAppState.parkingLordData.mainImage.imageUrl),
            actionButton: QbFAB(
              size: 50,
              color: qbAppPrimaryThemeColor,
              child: Icon(
                Entypo.picture,
                color: qbWhiteBGColor,
                size: 22.5,
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return SlotImgGallery();
                  },
                ));
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget slotUserDetailsWidget = Container();
  setSlotUserDetailsWidget() {
    slotUserDetailsWidget = Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          Container(
            child: DisplayPicture(
              imgUrl:
                  formatImgUrl(gpAppState.userDetails.profilePicThumbnailUrl),
              type:
                  (gpAppState.userDetails.getGenderType() == UserGender.female)
                      ? DisplayPictureType.profilePictureFemale
                      : DisplayPictureType.profilePictureMale,
              height: 50,
              width: 50,
              isEditable: false,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    child: Text(
                      gpAppState.userDetails.firstName.trim() +
                          " " +
                          gpAppState.userDetails.lastName,
                      style: GoogleFonts.yantramanav(
                          fontSize: 17.5,
                          fontWeight: FontWeight.w500,
                          color: qbAppTextColor),
                      overflow: TextOverflow.ellipsis,
                      textScaleFactor: 1.0,
                    ),
                  ),
                  SizedBox(
                    height: 1.5,
                  ),
                  Container(
                      child: RatingWidget(
                          fontSize: 12.5,
                          iconSize: 13,
                          ratingValue: gpAppState.parkingLordData.rating))
                ],
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          ReviewButton(
            slotId: gpAppState.parkingLordData.id,
          )
        ],
      ),
    );
  }

  Widget parkingsTitle = Container(
    height: 0,
    width: 0,
  );
  setParkingsTitle() {
    parkingsTitle = Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Row(
        children: <Widget>[
          Container(
            child: CustomIcon(
              icon: GPIcons.parking_history,
              size: 22.5,
              color: qbDetailLightColor,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            child: Text(
              "Parkings",
              style: GoogleFonts.nunito(
                  color: qbDetailLightColor,
                  fontSize: 17.5,
                  fontWeight: FontWeight.w700),
              textScaleFactor: 1.0,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> essentialWidgets = [];
  essentialWidgetsBuilder() {
    // setQRCodeButton();
    setSlotImgWidget();
    setSlotUserDetailsWidget();
    setParkingsTitle();

    List<String> slotImageUrls = [];
    gpAppState.parkingLordData.images.forEach((slotImage) {
      slotImageUrls.add(formatImgUrl(slotImage.imageUrl));
    });

    essentialWidgets = [
      // qrCodeButton,
      slotImgWidget,
      // Slot Name
      Container(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
        child: SlotNameWidget(
          slotName: gpAppState.parkingLordData.name,
        ),
      ),

      slotUserDetailsWidget,

      SizedBox(
        height: 10,
      ),

      Container(
        child: MoreDetailsAcc(
          contentPadding: EdgeInsets.symmetric(horizontal: 25),
          address: gpAppState.parkingLordData.address,
          landmark: gpAppState.parkingLordData.landmark,
          city: gpAppState.parkingLordData.city,
          state: gpAppState.parkingLordData.state,
          imgUrls: slotImageUrls,
        ),
      ),
      SizedBox(
        height: 10,
      ),

      //Booking History
      parkingsTitle
    ];
  }

  @override
  Widget build(BuildContext context) {
    AppState gpAppStateListen = Provider.of<AppState>(context, listen: true);

    // setParkingCards();
    essentialWidgetsBuilder();

    // print(formatImgUrl(gpAppStateListen.parkingLordData.mainImage.imageUrl));
    return Container(
      child: Stack(
        children: [
          Container(
            child: SafeArea(
              top: false,
              maintainBottomViewPadding: true,
              child: Container(
                child: Scaffold(
                  appBar: AppBar(
                    title: Row(
                      children: [
                        Icon(FontAwesome5.crown, size: 20),
                        SizedBox(
                          width: 12.5,
                        ),
                        Text(
                          "Parking Lord",
                          style:
                              GoogleFonts.nunito(fontWeight: FontWeight.w500),
                          textScaleFactor: 1.0,
                        ),
                      ],
                    ),
                    actions: [
                      PopupMenuButton<ParkingLordMenuItemType>(
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                              value: ParkingLordMenuItemType.edit,
                              child: Container(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      child: Icon(
                                        FontAwesome.edit,
                                        size: 22.5,
                                        color: qbDetailDarkColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      child: Text(
                                        "Edit",
                                        style: GoogleFonts.roboto(
                                            color: qbDetailDarkColor),
                                        textScaleFactor: 1.0,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            PopupMenuItem(
                              value: ParkingLordMenuItemType.qrCode,
                              child: Container(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      child: Icon(
                                        MdiIcons.qrcode,
                                        size: 22.5,
                                        color: qbDetailDarkColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      child: Text(
                                        "QR Code",
                                        style: GoogleFonts.roboto(
                                            color: qbDetailDarkColor),
                                        textScaleFactor: 1.0,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ];
                        },
                        onSelected: (value) {
                          switch (value) {
                            case ParkingLordMenuItemType.edit:
                              onEditPressed();
                              break;
                            case ParkingLordMenuItemType.qrCode:
                              onQRPressed();
                              break;
                          }
                        },
                      )
                    ],
                    brightness: Brightness.dark,
                    elevation: 0.0,
                    backgroundColor: qbAppPrimaryThemeColor,
                  ),
                  body: Container(
                    child: Scrollbar(
                      radius: Radius.elliptical(2.5, 15),
                      child: ListView.builder(
                        itemCount: essentialWidgets.length +
                            gpAppStateListen.slotParkings.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (index < essentialWidgets.length) {
                            return essentialWidgets[index];
                          } else {
                            int ind = index - essentialWidgets.length;
                            return ParkingCard(
                              parkingRequestData:
                                  gpAppStateListen.slotParkings[ind],
                              type: ParkingDetailsAccType.slot,
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  onQRPressed() {
    SystemSound.play(SystemSoundType.click);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return QRCodePage();
      },
    ));
  }

  onEditPressed() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ParkingLordEditPage();
    }));
  }

  onVaultPressed() {
    SystemSound.play(SystemSoundType.click);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return VaultPage();
    }));
  }

  @override
  void dispose() {
    super.dispose();
  }
}

enum ParkingLordMenuItemType { qrCode, edit }
