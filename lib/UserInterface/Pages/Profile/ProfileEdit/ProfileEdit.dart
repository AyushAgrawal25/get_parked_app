import 'dart:io';

import 'package:getparked/Utils/ContactUtils.dart';
import 'package:getparked/Utils/DomainUtils.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/StateManagement/Models/UserDetails.dart';
import 'package:getparked/UserInterface/Widgets/ImagePicker/ImagePickerAndInserter.dart';
import 'package:getparked/UserInterface/Widgets/Loaders/LoaderPage.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/DisplayPicture.dart';
import 'package:getparked/UserInterface/Widgets/OutlineTextFormField.dart';
import 'package:getparked/UserInterface/Widgets/UnderLineTextFormField.dart';
import 'package:getparked/UserInterface/Widgets/qbFAB.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfileEdit extends StatefulWidget {
  Function(bool) changeLoadStatus;
  ProfileEdit({@required this.changeLoadStatus});
  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  AppState gpAppState;
  @override
  void initState() {
    super.initState();
    gpAppState = Provider.of(context, listen: false);
    gpFirstName = gpAppState.userDetails.firstName.trim();
    gpLastName = gpAppState.userDetails.lastName.trim();
    gpDialCode = gpAppState.userDetails.dialCode;
    gpPhoneNumber = gpAppState.userDetails.phoneNumber;
  }

  double iconDis = 12.5;

  Widget profilePicWidget = Container(
    height: 0,
    width: 0,
  );
  setProfilePicWidget() {
    String profPicUrl = formatImgUrl(gpAppState.userDetails.profilePicUrl);
    DisplayPictureType profPicType = DisplayPictureType.profilePictureMale;
    if (gpAppState.userDetails.getGenderType() == UserGender.female) {
      profPicType = DisplayPictureType.profilePictureFemale;
    }

    profilePicWidget = Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: MediaQuery.of(context).size.width * 0.35 + 10,
      width: MediaQuery.of(context).size.width * 0.35 + 10,
      child: DisplayPicture(
        imgUrl: profPicUrl,
        iconButtonSize: 40,
        proxyImgFile: gpProfilePicImg,
        toShowProxyImgFile: (gpProfilePicImg != null),
        height: MediaQuery.of(context).size.width * 0.35,
        width: MediaQuery.of(context).size.width * 0.35,
        type: profPicType,
        onEditPressed: onEditProfilePic,
      ),
    );
  }

  String gpFirstName = "";
  Widget firstNameWidget = Container(
    height: 0,
    width: 0,
  );
  setFirstNameWidget() {
    firstNameWidget = Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Icon
          Container(
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(360),
                    border: Border.all(width: 1.5, color: qbAppTextColor)),
                child: Icon(FontAwesome5.user,
                    color: qbAppPrimaryBlueColor, size: 17.5)),
          ),

          SizedBox(
            width: iconDis,
          ),

          // TextField
          Expanded(
            child: Container(
              child: UnderLineTextFormField(
                labelText: "First Name",
                value: gpFirstName,
                onChange: (value) {
                  setState(() {
                    gpFirstName = value;
                  });
                },
                showClearButton: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String gpLastName = "";
  Widget lastNameWidget = Container(
    height: 0,
    width: 0,
  );
  setLastNameWidget() {
    lastNameWidget = Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Icon
          Container(
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(360),
                    border: Border.all(width: 1.5, color: qbAppTextColor)),
                child: Icon(
                  FontAwesome5.user,
                  size: 17.5,
                  color: qbAppTextColor,
                )),
          ),
          SizedBox(
            width: iconDis,
          ),

          // TextField
          Expanded(
            child: Container(
              child: UnderLineTextFormField(
                labelText: "Last Name",
                value: gpLastName,
                onChange: (value) {
                  setState(() {
                    gpLastName = value;
                  });
                },
                showClearButton: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String gpDialCode = "";
  String gpPhoneNumber = "";
  Widget phoneNumberWidget = Container(height: 0, width: 0);
  setPhoneNumberWidget() {
    double editIconSize = 40;
    phoneNumberWidget = Container(
      child: Row(
        children: [
          // Icon
          Container(
            margin: EdgeInsets.only(bottom: editIconSize * 0.25),
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(360),
                    border: Border.all(width: 1.5, color: qbAppTextColor)),
                child: Icon(
                  FontAwesome5.phone,
                  size: 17.5,
                  color: qbAppTextColor,
                )),
          ),
          SizedBox(
            width: iconDis,
          ),

          Expanded(
            child: Container(
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        right: editIconSize * 0.25,
                        bottom: editIconSize * 0.25),
                    child: OutlineTextFormField(
                      labelText: "Phone Number",
                      value: gpDialCode +
                          " " +
                          ContactUtils.encodePhNum(gpPhoneNumber),
                      isReadOnly: true,
                      fontSize: 15,
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      alignment: Alignment.bottomRight,
                      child: QbFAB(
                        size: editIconSize,
                        child: Icon(
                          FontAwesome.pencil,
                          size: 17.5,
                          color: qbWhiteBGColor,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget emailWidget = Container(
    height: 0,
    width: 0,
  );
  setEmailWidget() {
    emailWidget = Container(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Icon
        Container(
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 7.5, horizontal: 7.5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(360),
                  border: Border.all(width: 1.5, color: qbAppTextColor)),
              child: Container(
                height: 22.5,
                width: 22.5,
                alignment: Alignment.center,
                child: Text(
                  "@",
                  style: GoogleFonts.roboto(
                      fontSize: 19,
                      fontWeight: FontWeight.w900,
                      color: qbAppTextColor),
                  textScaleFactor: 1.0,
                ),
              )),
        ),
        SizedBox(
          width: iconDis + 10,
        ),

        // Email
        Expanded(
          child: Container(
            child: Text(
              gpAppState.userDetails.email,
              style: GoogleFonts.mukta(
                  fontSize: 17.5,
                  color: qbAppTextColor,
                  fontWeight: FontWeight.w500),
              textScaleFactor: 1.0,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    ));
  }

  bool isFormValid = true;
  checkFormValidity() {
    isFormValid = true;
    if ((gpFirstName == null) && (gpFirstName == "")) {
      isFormValid = false;
    }

    if ((gpLastName == null) && (gpLastName == "")) {
      isFormValid = false;
    }

    if ((gpPhoneNumber == null) && (gpPhoneNumber == "")) {
      isFormValid = false;
    }

    if ((gpDialCode == null) && (gpDialCode == "")) {
      isFormValid = false;
    }

    bool isChangesDone = false;
    if (gpFirstName != gpAppState.userDetails.firstName) {
      isChangesDone = true;
    }

    if (gpLastName != gpAppState.userDetails.lastName) {
      isChangesDone = true;
    }

    if (gpPhoneNumber != gpAppState.userDetails.phoneNumber) {
      isChangesDone = true;
    }

    if (gpDialCode != gpAppState.userDetails.dialCode) {
      isChangesDone = true;
    }

    if (!isChangesDone) {
      isFormValid = false;
    }
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    checkFormValidity();
    setProfilePicWidget();
    setFirstNameWidget();
    setLastNameWidget();
    setPhoneNumberWidget();
    setEmailWidget();

    return Container(
      child: SafeArea(
        top: false,
        maintainBottomViewPadding: true,
        child: Stack(
          children: [
            Container(
              child: Scaffold(
                appBar: AppBar(
                  title: Row(
                    children: [
                      Icon(
                        FontAwesome.edit,
                        size: 20,
                        color: qbAppTextColor,
                      ),
                      SizedBox(
                        width: 12.5,
                      ),
                      Text(
                        "Edit Profile",
                        style: GoogleFonts.nunito(
                            color: qbAppTextColor, fontWeight: FontWeight.w600),
                        textScaleFactor: 1.0,
                      ),
                    ],
                  ),
                  actions: [
                    GestureDetector(
                      onTap: onSavePressed,
                      child: Container(
                        color: Colors.transparent,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Save",
                          style: GoogleFonts.nunito(
                              fontSize: 17.5,
                              fontWeight: FontWeight.w500,
                              color: (isFormValid)
                                  ? qbAppPrimaryBlueColor
                                  : qbDividerDarkColor),
                          textScaleFactor: 1.0,
                        ),
                      ),
                    ),
                  ],
                  backgroundColor: qbWhiteBGColor,
                  elevation: 0.0,
                  iconTheme: IconThemeData(color: qbAppTextColor),
                  brightness: Brightness.light,
                ),
                body: Container(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          profilePicWidget,
                          SizedBox(
                            height: 10,
                          ),
                          firstNameWidget,
                          SizedBox(
                            height: 12.5,
                          ),
                          lastNameWidget,
                          SizedBox(
                            height: 25,
                          ),
                          phoneNumberWidget,
                          SizedBox(
                            height: 12.5,
                          ),
                          emailWidget
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            (isLoading)
                ? LoaderPage()
                : Container(
                    height: 0,
                    width: 0,
                  )
          ],
        ),
      ),
    );
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

  File gpProfilePicImg;
  onImageInsert(imgFile) async {
    // TODO: Add this function on done.
    // if (imgFile != null) {
    //   setState(() {
    //     gpProfilePicImg = imgFile;
    //   });
    //   bool updateStatus = await UserAuth().uploadProfilePic(
    //       imgFile, gpAppState.userData.id, gpAppState.userData.accessToken);

    //   // Changing Profile Pic
    //   if (updateStatus) {
    //     if (gpAppState.userDetails.profilePicUrl != null) {
    //       // Updating ProfilePic
    //       await FileUtils.updateCacheImage(
    //           formatImgUrl(gpAppState.userDetails.profilePicUrl));

    //       // Updating ProfilePic
    //       await FileUtils.updateCacheImage(
    //           formatImgUrl(gpAppState.userDetails.profilePicThumbnailUrl));

    //       // gpAppState.setUserDetails(gpAppState.userDetails);
    //     }
    //   }
    // }
  }

  onSavePressed() async {
    SystemSound.play(SystemSoundType.click);
    if (isFormValid) {
      setState(() {
        isLoading = true;
      });
      // TODO: Call The API
      // bool userDetailsUpdateStatus = await UserAuth().updateUserDetails(
      //     gpAppState.userData.id, gpAppState.userData.accessToken,
      //     dialCode: gpDialCode,
      //     firstName: gpFirstName,
      //     lastName: gpLastName,
      //     phoneNumber: gpPhoneNumber);
      // if (userDetailsUpdateStatus) {
      //   UserDetails gpNewUserDetails = await UserAuth()
      //       .getUserDetailsFromUserId(
      //           gpAppState.userData.id, gpAppState.userData.accessToken);
      //   gpAppState.setUserDetails(gpNewUserDetails);
      // }
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();
    } else {
      // TODO: Show Error

    }
  }
}
