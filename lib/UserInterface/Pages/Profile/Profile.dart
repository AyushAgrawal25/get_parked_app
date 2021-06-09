import 'dart:collection';

import 'package:getparked/BussinessLogic/UserServices.dart';
import 'package:getparked/Utils/FileUtils.dart';
// import 'package:getparked/BussinessLogic/UserAuth.dart';
import 'package:getparked/Utils/DomainUtils.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/StateManagement/Models/UserDetails.dart';
import 'package:getparked/UserInterface/Widgets/ImagePicker/ImagePickerAndInserter.dart';
import 'package:getparked/UserInterface/Pages/Profile/ProfileEdit/ProfileEditPage.dart';
import 'package:getparked/UserInterface/Widgets/Loaders/LoaderPage.dart';
// import 'package:getparked/UserInterface/Pages/Wallet/WalletPage.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/DisplayPicture.dart';
import 'package:flutter/material.dart';
import 'package:getparked/UserInterface/Icons/g_p_icons_icons.dart';
import 'package:getparked/UserInterface/Widgets/CustomIcon.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/linearicons_free_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:getparked/UserInterface/Widgets/ParkingCard/ParkingCard.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isLoading = false;
  loadHandler(bool status) {
    setState(() {
      isLoading = status;
    });
  }

  AppState gpAppState;
  @override
  void initState() {
    super.initState();
    gpAppState = Provider.of<AppState>(context, listen: false);
  }

  Widget parkingsTitle = Container();
  setParkingsTitle() {
    parkingsTitle = Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Row(
        children: [
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

  Widget profileTopWidget = Container();
  setProfileTopWidget() {
    double picSize = MediaQuery.of(context).size.width * 0.45;
    profileTopWidget = Container(
      child: Container(
        height: picSize + 40,
        child: Stack(
          children: [
            // BG
            Container(
              padding: EdgeInsets.only(top: 40),
              height: picSize,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: CustomPaint(
                  size: Size.fromHeight(picSize),
                  painter: CurvePainter(context: context),
                ),
              ),
            ),

            // Wallet
            Align(
              alignment: Alignment(0.75, -1),
              child: GestureDetector(
                onTap: onWalletPressed,
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      Container(
                        child: CustomIcon(
                          icon: GPIcons.wallet_outlined,
                          color: qbWhiteBGColor,
                          size: 22.5,
                        ),
                      ),
                      SizedBox(
                        height: 2.5,
                      ),
                      Text(
                        "Wallet",
                        style: GoogleFonts.nunito(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: qbWhiteBGColor),
                        textScaleFactor: 1.0,
                      )
                    ],
                  ),
                ),
              ),
            ),

            // Above
            Container(
              padding: EdgeInsets.only(top: 40),
              alignment: Alignment.center,
              child: DisplayPicture(
                imgUrl: formatImgUrl(gpAppState.userDetails.profilePicUrl),
                height: picSize,
                width: picSize,
                isElevated: true,
                onEditPressed: onEditProfilePic,
                type: (gpAppState.userDetails.getGenderType() ==
                        UserGender.female)
                    ? DisplayPictureType.profilePictureFemale
                    : DisplayPictureType.profilePictureMale,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget displayNameWidget = Container();
  setDisplayNameWidget() {
    displayNameWidget = Container(
      alignment: Alignment.center,
      child: Text(
        gpAppState.userDetails.firstName.trim() +
            " " +
            gpAppState.userDetails.lastName,
        style: GoogleFonts.mukta(
            fontSize: 22.5, fontWeight: FontWeight.w500, color: qbAppTextColor),
        textScaleFactor: 1.0,
      ),
    );
  }

  List<Widget> profileWidgets = [];
  setProfileWidgets() {
    AppState gpAppStateListen = Provider.of<AppState>(context);
    setParkingsTitle();
    setDisplayNameWidget();
    setProfileTopWidget();
    profileWidgets = [
      profileTopWidget,
      SizedBox(
        height: 15,
      ),
      displayNameWidget,
      SizedBox(
        height: 15,
      ),
      parkingsTitle,
    ];

    gpAppStateListen.userParkings.forEach((gpUserParkingData) {
      profileWidgets.add(ParkingCard(
        parkingRequestData: gpUserParkingData,
        type: ParkingDetailsAccType.user,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    AppState gpAppStateListen = Provider.of<AppState>(context);
    setProfileWidgets();
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
                      backgroundColor: qbAppPrimaryThemeColor,
                      title: Container(
                        child: Row(
                          children: [
                            // Icons
                            Container(
                              child: Icon(
                                Typicons.user_outline,
                                size: 20,
                              ),
                            ),

                            SizedBox(
                              width: 10,
                            ),

                            // Text Wallet
                            Container(
                              child: Text(
                                "Profile",
                                style: GoogleFonts.nunito(
                                    color: qbWhiteBGColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500),
                                textScaleFactor: 1.0,
                              ),
                            )
                          ],
                        ),
                      ),
                      actions: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(7.5),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    child: Text(
                                      "Edit",
                                      style: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 17.5,
                                        color: qbWhiteBGColor,
                                      ),
                                      textScaleFactor: 1.0,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    FontAwesome.edit,
                                    size: 17.5,
                                  )
                                ],
                              ),
                            ),
                            onTap: onProfileEditPressed,
                          ),
                        )
                      ],
                      brightness: Brightness.dark,
                      elevation: 0.0,
                    ),
                    body: Scrollbar(
                      radius: Radius.elliptical(2.5, 15),
                      child: Container(
                        child: ListView(
                          children: new UnmodifiableListView(profileWidgets),
                        ),
                      ),
                    )),
              ),
            ),
          ),
          (isLoading)
              ? Container(
                  child: LoaderPage(),
                )
              : Container(
                  height: 0,
                  width: 0,
                )
        ],
      ),
    );
  }

  onProfileEditPressed() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return ProfileEditPage();
      },
    ));
  }

  onEditProfilePic() {
    print(formatImgUrl(gpAppState.userDetails.profilePicUrl));
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return ImagePickerAndInserter(
            imgUrl: formatImgUrl(gpAppState.userDetails.profilePicUrl),
            onImageInsert: onImageInsert);
      },
    ));
  }

  onImageInsert(imgFile) async {
    if (imgFile != null) {
      // TODO: Add function for profile pic upload.
      UploadProfilePicStatus uploadStatus = await UserServices()
          .uploadProfilePic(
              profilePic: imgFile, authToken: gpAppState.authToken);

      if (uploadStatus == UploadProfilePicStatus.successful) {
        if (gpAppState.userDetails.profilePicUrl != null) {
          await FileUtils.updateCacheImage(
              formatImgUrl(gpAppState.userDetails.profilePicUrl));
        }
        UserServices()
            .getUser(authToken: gpAppState.authToken, context: context);
      }
      // Changing Profile Pic
      // if (updateStatus) {
      // if (gpAppState.userDetails.profilePicUrl != null) {
      //   // Updating ProfilePic
      //   await FileUtils.updateCacheImage(
      //       formatImgUrl(gpAppState.userDetails.profilePicUrl));

      //   // Updating ProfilePic
      //   await FileUtils.updateCacheImage(
      //       formatImgUrl(gpAppState.userDetails.profilePicThumbnailUrl));

      //   // gpAppState.setUserDetails(gpAppState.userDetails);
      // } else {
      //   UserDetails gpNewUserDetails = await UserAuth()
      //       .getUserDetailsFromUserId(
      //           gpAppState.userData.id, gpAppState.userData.accessToken);
      //   gpAppState.setUserDetails(gpNewUserDetails);
      // }
      // }
    }
  }

  onWalletPressed() {
    SystemSound.play(SystemSoundType.click);
    // TODO: add Wallet Page when done.
    // Navigator.of(context).push(MaterialPageRoute(
    //   builder: (context) {
    //     return WalletPage();
    //   },
    // ));
  }
}

class CurvePainter extends CustomPainter {
  BuildContext context;
  CurvePainter({this.context});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paintGreen = Paint();
    paintGreen.color = qbAppPrimaryThemeColor;
    double screenWidth = MediaQuery.of(context).size.width;
    canvas.drawCircle(Offset(screenWidth * 0.5, screenWidth * (-0.675)),
        screenWidth, paintGreen);
  }

  @override
  bool shouldRepaint(CurvePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(CurvePainter oldDelegate) => false;
}
