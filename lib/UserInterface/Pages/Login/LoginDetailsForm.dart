import 'dart:async';
import 'dart:io';

import 'package:getparked/BussinessLogic/AuthProvider.dart';
import 'package:getparked/Utils/FCMUtils.dart';
import 'package:getparked/Utils/NotificationUtils.dart';
import 'package:getparked/BussinessLogic/UserServices.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/StateManagement/Models/UserData.dart';
import 'package:getparked/StateManagement/Models/UserDetails.dart';
import 'package:getparked/UserInterface/Icons/g_p_icons_icons.dart';
// import 'package:getparked/UserInterface/Pages/Home/HomePage.dart';
import 'package:getparked/UserInterface/Widgets/ImagePicker/ImagePickerAndInserter.dart';
import 'package:getparked/UserInterface/Pages/Login/PhoneNumberOTPPopUp.dart';
import 'package:getparked/UserInterface/Pages/Login/UIComponents/CircleSectionWidget.dart';
import 'package:getparked/UserInterface/Widgets/Loaders/LoaderPage.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/CustomButton.dart';
import 'package:getparked/UserInterface/Widgets/CustomIcon.dart';
import 'package:getparked/UserInterface/Widgets/EdgeLessButton.dart';
import 'package:getparked/UserInterface/Widgets/FormFieldHeader.dart';
import 'package:getparked/UserInterface/Widgets/PhoneNumberWidget/PhoneNumberWidget.dart';
import 'package:getparked/UserInterface/Widgets/RadioTileButton.dart';
import 'package:getparked/UserInterface/Widgets/UnderLineTextFormField.dart';
import 'package:getparked/UserInterface/Widgets/qbFAB.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginDetailsForm extends StatefulWidget {
  final UserData userData;
  final String authToken;
  LoginDetailsForm({@required this.userData, @required this.authToken});
  @override
  _LoginDetailsFormState createState() => _LoginDetailsFormState();
}

class _LoginDetailsFormState extends State<LoginDetailsForm> {
  bool isLoading = false;
  bool isFormValid = true;
  checkFormValidity() {
    isFormEntriesValid = true;

    if ((gpFirstName == null) || (gpFirstName == "")) {
      isFormEntriesValid = false;
    }

    if ((gpLastName == null) || (gpLastName == "")) {
      isFormEntriesValid = false;
    }

    if ((gpPhNum == null) || (gpPhNum == "")) {
      isFormEntriesValid = false;
    }

    if ((gpDialCode == null) || (gpDialCode == "")) {
      isFormEntriesValid = false;
    }

    if (!isPhNumVerified) {
      isFormEntriesValid = false;
    }

    if ((gpUserGenderValue == null) || (gpUserGenderValue == "")) {
      isFormEntriesValid = false;
    }
  }

  Widget profPicImgWidget = Container();
  setProfPicImgWidget() {
    String placeHolderPic = "";
    if (gpProfilePicFile == null) {
      if ((gpUserGenderValue == "") ||
          (gpUserGenderValue == "Others") ||
          (gpUserGenderValue == "Male") ||
          (gpUserGenderValue == null)) {
        placeHolderPic = "assets/images/male.png";
      } else {
        placeHolderPic = "assets/images/female.png";
      }

      profPicImgWidget = Container(
        child: Image.asset(
          placeHolderPic,
          height: profPicSize - 24,
          width: profPicSize - 24,
          fit: BoxFit.fitWidth,
        ),
      );
    } else {
      profPicImgWidget = Container(
        child: Image.file(
          gpProfilePicFile,
          height: profPicSize - 24,
          width: profPicSize - 24,
          fit: BoxFit.fitWidth,
        ),
      );
    }
  }

  Widget profilePicWidget = Container();
  setProfilePicWidget() {
    setProfPicImgWidget();
    profilePicWidget = Container(
      height: profPicSize,
      width: profPicSize,
      alignment: Alignment.center,
      decoration:
          BoxDecoration(color: qbAppPrimaryThemeColor, shape: BoxShape.circle),
      child: Container(
        height: profPicSize,
        width: profPicSize,
        child: Stack(
          children: [
            Align(
              child: Container(
                height: profPicSize - 12,
                width: profPicSize - 12,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: qbWhiteBGColor),
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(360),
                  child: profPicImgWidget,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: QbFAB(
                size: 40,
                border: Border.all(color: qbAppPrimaryGreenColor, width: 3),
                color: qbWhiteBGColor,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: (gpProfilePicFile != null)
                      ? Icon(
                          FontAwesome.pencil,
                          size: 15,
                          color: qbAppPrimaryGreenColor,
                        )
                      : Text(
                          "+",
                          style: GoogleFonts.roboto(
                              fontSize: 27.5,
                              fontWeight: FontWeight.w700,
                              color: qbAppPrimaryGreenColor),
                          textScaleFactor: 1.0,
                        ),
                ),
                onPressed: () {
                  if (gpProfilePicFile != null) {
                    onEditProfilePic();
                  } else {
                    onAddProfilePic();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  String gpFirstName = "";
  Widget firstNameWidget = Container();
  setFirstNameWidget() {
    firstNameWidget = Container(
      child: UnderLineTextFormField(
        labelText: "First Name",
        fontSize: 15,
        labelTextFontWeight: FontWeight.w400,
        prefixIcon: Container(
          margin: EdgeInsets.only(top: 12.5),
          child: Icon(
            FontAwesome5.user,
            color: qbAppTextColor,
            size: 15,
          ),
        ),
        onChange: (value) {
          setState(() {
            gpFirstName = value;
          });
        },
      ),
    );
  }

  String gpLastName = "";
  Widget lastNameWidget = Container();
  setLastNameWidget() {
    lastNameWidget = Container(
      child: UnderLineTextFormField(
        labelText: "Last Name",
        fontSize: 15,
        labelTextFontWeight: FontWeight.w400,
        prefixIcon: Container(
          margin: EdgeInsets.only(top: 12.5),
          child: Icon(
            FontAwesome5.user,
            color: qbAppTextColor,
            size: 15,
          ),
        ),
        onChange: (value) {
          setState(() {
            gpLastName = value;
          });
        },
      ),
    );
  }

  String gpPhNum = "";
  String gpDialCode = "";
  Widget phNumWidget = Container();
  setPhNumWidget() {
    setVerfiyBtn();
    setTimeForResendWidget();
    setResentBtn();
    phNumWidget = Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      decoration: BoxDecoration(
        color: qbWhiteBGColor,
      ),
      child: Column(
        children: [
          PhoneNumberWidget(
            readOnly: (isPhNumVerified || isOTPSentCurPhNum),
            onChange: (String dc, String phNum) {
              setState(() {
                gpDialCode = dc;
                gpPhNum = phNum;
              });
            },
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              resendBtn,
              SizedBox(
                width: 10,
              ),
              verifyBtn,
            ],
          ),
          timeForResendWidget
        ],
      ),
    );
  }

  bool isLoadinForOTPResend = false;
  Widget resendBtn = Container(
    height: 0,
    width: 0,
  );
  setResentBtn() {
    if ((toShowResendBtn) && (isOTPSentCurPhNum) && (!isPhNumVerified)) {
      resendBtn = Container(
        alignment: Alignment.centerRight,
        child: CustomButton(
          color: qbAppPrimaryThemeColor,
          padding: EdgeInsets.symmetric(vertical: 6.5, horizontal: 15),
          borderRadius: BorderRadius.circular(5),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Resend",
                style: GoogleFonts.nunito(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                    color: qbWhiteBGColor),
                textScaleFactor: 1.0,
              ),
              (isLoadinForOTPResend)
                  ? Container(
                      padding: EdgeInsets.only(left: 5),
                      child: SpinKitRing(
                        color: Colors.white,
                        lineWidth: 1.5,
                        size: 12.5,
                      ),
                    )
                  : Container(
                      height: 0,
                      width: 0,
                    )
            ],
          ),
          onPressed: onPhNumOTPResendPressed,
        ),
      );
    } else {
      resendBtn = Container(
        height: 0,
        width: 0,
      );
    }
  }

  Widget timeForResendWidget = Container(
    height: 0,
    width: 0,
  );
  setTimeForResendWidget() {
    if ((!toShowResendBtn) && (isOTPSentCurPhNum) && (!isPhNumVerified)) {
      timeForResendWidget = Container(
        padding: EdgeInsets.symmetric(vertical: 7.5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              child: Text(
                "Resend OTP in ",
                style: GoogleFonts.roboto(
                  color: qbAppPrimaryGreenColor,
                  fontSize: 11,
                ),
                textScaleFactor: 1.0,
              ),
            ),
            CustomIcon(
              icon: GPIcons.stopwatch_outlined,
              color: qbAppPrimaryGreenColor,
              size: 11,
            ),
            Container(
              child: Text(
                " ${60 - secsAfterOTPSent} secs.",
                style: GoogleFonts.roboto(
                  color: qbAppPrimaryGreenColor,
                  fontSize: 11,
                ),
                textScaleFactor: 1.0,
              ),
            ),
          ],
        ),
      );
    } else {
      timeForResendWidget = Container(
        height: 26,
        width: 0,
      );
    }
  }

  String gpCorrectOTP = "";
  bool isPhNumVerified = false;
  bool isOTPSentCurPhNum = false;
  bool toShowResendBtn = false;
  int secsAfterOTPSent = 0;
  Timer otpTimer;
  bool isLoadinForPhNumVerification = false;
  Widget verifyBtn = Container();
  setVerfiyBtn() {
    if (isPhNumVerified) {
      verifyBtn = Container(
          alignment: Alignment.centerRight,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 12.5),
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: qbAppPrimaryBlueColor),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              "Verfied",
              style: GoogleFonts.nunito(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: qbAppTextColor),
              textScaleFactor: 1.0,
            ),
          ));
    } else {
      verifyBtn = Container(
        alignment: Alignment.centerRight,
        child: CustomButton(
          color: qbAppPrimaryThemeColor,
          padding: EdgeInsets.symmetric(vertical: 6.5, horizontal: 15),
          borderRadius: BorderRadius.circular(5),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                (isOTPSentCurPhNum) ? "Enter OTP" : "Verfiy",
                style: GoogleFonts.nunito(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                    color: qbWhiteBGColor),
                textScaleFactor: 1.0,
              ),
              (isLoadinForPhNumVerification)
                  ? Container(
                      padding: EdgeInsets.only(left: 5),
                      child: SpinKitRing(
                        color: Colors.white,
                        lineWidth: 1.5,
                        size: 12.5,
                      ),
                    )
                  : Container(
                      height: 0,
                      width: 0,
                    )
            ],
          ),
          onPressed: onPhNumVerifyPressed,
        ),
      );
    }
  }

  onPhNumVerifyPressed() async {
    if ((!isPhNumVerified) &&
        (!isLoadinForPhNumVerification) &&
        (!isOTPSentCurPhNum)) {
      print(gpDialCode + gpPhNum);
      if (gpPhNum.length == 10) {
        setState(() {
          isLoadinForPhNumVerification = true;
        });

        //TODO: Add Firebase verification.
        String otpData = await UserServices().verifyPhoneNumber(
            phNum: gpDialCode + gpPhNum, authToken: widget.authToken);
        setState(() {
          gpCorrectOTP = otpData;
          isLoadinForPhNumVerification = false;
          if (gpCorrectOTP != null) {
            isOTPSentCurPhNum = true;
          }
        });

        // AuthProvider()
        //     .firebasePhoneVerification(phoneNumber: gpDialCode + gpPhNum);

        if (gpCorrectOTP != null) {
          PhoneNumberOTPPopUp().show(context,
              correctOtp: gpCorrectOTP,
              onCorrentOTPEntered: onCorrectOTPEntered,
              onChangePhNum: onChangePhNum,
              dialCode: gpDialCode,
              phoneNumber: gpPhNum);
        } else {
          Fluttertoast.showToast(
              msg: "Try Again",
              toastLength: Toast.LENGTH_SHORT,
              timeInSecForIosWeb: 1,
              fontSize: 14);
        }

        if (isOTPSentCurPhNum) {
          setState(() {
            secsAfterOTPSent = 0;
            toShowResendBtn = false;
          });
          otpTimer = Timer.periodic(Duration(seconds: 1), (timer) {
            setState(() {
              secsAfterOTPSent++;
              if (secsAfterOTPSent == 60) {
                toShowResendBtn = true;
                timer.cancel();
              }
            });
          });
        }
      }
    } else if (isOTPSentCurPhNum) {
      // Show Pop Up
      if (gpCorrectOTP != null) {
        PhoneNumberOTPPopUp().show(context,
            correctOtp: gpCorrectOTP,
            onChangePhNum: onChangePhNum,
            onCorrentOTPEntered: onCorrectOTPEntered,
            dialCode: gpDialCode,
            phoneNumber: gpPhNum);
      } else {
        setState(() {
          isOTPSentCurPhNum = false;
        });
      }
    }
  }

  onPhNumOTPResendPressed() async {
    if ((!isPhNumVerified) && (!isLoadinForOTPResend) && (isOTPSentCurPhNum)) {
      print(gpDialCode + gpPhNum);
      if (gpPhNum.length == 10) {
        setState(() {
          isLoadinForOTPResend = true;
        });

        //TODO: Add Firebase verification.
        String otpData = await UserServices().verifyPhoneNumber(
            phNum: gpDialCode + gpPhNum, authToken: widget.authToken);
        setState(() {
          gpCorrectOTP = otpData;
          isLoadinForOTPResend = false;
        });

        // AuthProvider()
        //     .firebasePhoneVerification(phoneNumber: gpDialCode + gpPhNum);

        if (gpCorrectOTP != null) {
          PhoneNumberOTPPopUp().show(context,
              correctOtp: gpCorrectOTP,
              onCorrentOTPEntered: onCorrectOTPEntered,
              onChangePhNum: onChangePhNum,
              dialCode: gpDialCode,
              phoneNumber: gpPhNum);

          setState(() {
            secsAfterOTPSent = 0;
            toShowResendBtn = false;
          });
          otpTimer = Timer.periodic(Duration(seconds: 1), (timer) {
            setState(() {
              secsAfterOTPSent++;
              if (secsAfterOTPSent == 60) {
                toShowResendBtn = true;
                timer.cancel();
              }
            });
          });
        } else {
          Fluttertoast.showToast(
              msg: "Try Again",
              toastLength: Toast.LENGTH_SHORT,
              timeInSecForIosWeb: 1,
              fontSize: 14);
        }
      }
    }
  }

  onCorrectOTPEntered() {
    otpTimer.cancel();
    setState(() {
      isPhNumVerified = true;
    });
  }

  onChangePhNum() {
    otpTimer.cancel();
    setState(() {
      isOTPSentCurPhNum = false;
    });
  }

  String gpUserGenderValue = "";
  Widget genderSelectionWidget = Container();
  setGenderSelectionWidget() {
    genderSelectionWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10),
          child: FormFieldHeader(
            headerText: "Gender",
            fontSize: 17.5,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              Expanded(
                child: RadioTileButton(
                  groupValue: gpUserGenderValue,
                  onChanged: (value) {
                    setState(() {
                      gpUserGenderValue = value;
                    });
                  },
                  title: Container(
                    padding: EdgeInsets.only(left: 2.5),
                    child: Text(
                      "Male",
                      style: GoogleFonts.roboto(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w500,
                          color: qbAppTextColor),
                      textScaleFactor: 1.0,
                    ),
                  ),
                  value: "Male",
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: RadioTileButton(
                  groupValue: gpUserGenderValue,
                  onChanged: (value) {
                    setState(() {
                      gpUserGenderValue = value;
                    });
                  },
                  title: Container(
                    padding: EdgeInsets.only(left: 2.5),
                    child: Text(
                      "Female",
                      style: GoogleFonts.roboto(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w500,
                          color: qbAppTextColor),
                      textScaleFactor: 1.0,
                    ),
                  ),
                  value: "Female",
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: RadioTileButton(
                  groupValue: gpUserGenderValue,
                  onChanged: (value) {
                    setState(() {
                      gpUserGenderValue = value;
                    });
                  },
                  title: Container(
                    padding: EdgeInsets.only(left: 2.5),
                    child: Text(
                      "Others",
                      style: GoogleFonts.roboto(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w500,
                          color: qbAppTextColor),
                      textScaleFactor: 1.0,
                    ),
                  ),
                  value: "Others",
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget continueBtn = Container();
  setContinueBtn() {
    continueBtn = Container(
        margin: EdgeInsets.symmetric(vertical: 1.5, horizontal: 2.5),
        child: EdgeLessButton(
          child: Text(
            "Continue",
            style: GoogleFonts.nunito(
                fontSize: 16.5,
                fontWeight: FontWeight.w500,
                color: Colors.white),
            textAlign: TextAlign.center,
            textScaleFactor: 1.0,
          ),
          color:
              (isFormEntriesValid) ? qbAppPrimaryBlueColor : qbDividerDarkColor,
          width: MediaQuery.of(context).size.width * 0.6,
          padding: EdgeInsets.symmetric(vertical: 8.5),
          onPressed: onContinuePressed,
        ));
  }

  bool isFormEntriesValid = true;

  double profPicSize = 125;
  double horPadding = 20;
  @override
  Widget build(BuildContext context) {
    double formPadding = 40;
    double formWidth = MediaQuery.of(context).size.width - formPadding;
    AppState gpAppStateListen = Provider.of<AppState>(context);
    checkFormValidity();
    // setGreenBgPart();
    // setFormBgPart();
    setProfilePicWidget();
    setFirstNameWidget();
    setLastNameWidget();
    setPhNumWidget();
    setGenderSelectionWidget();
    setContinueBtn();
    return Container(
      child: SafeArea(
          top: false,
          maintainBottomViewPadding: true,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Scaffold(
              body: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Stack(
                      children: [
                        // Green BgPart
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.45,
                            color: qbAppPrimaryThemeColor,
                          ),
                        ),

                        // Main Form
                        Align(
                          alignment: Alignment.center,
                          child: Stack(
                            children: [
                              // BG
                              Positioned.fill(
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: profPicSize / 2.6,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: CircleSectionWidget(
                                          width: formWidth,
                                          topMargin: 20,
                                          color: qbWhiteBGColor,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Color.fromRGBO(
                                                    0, 00, 0, 0.05),
                                                blurRadius: 10,
                                                spreadRadius: 15,
                                                offset: Offset(10, 0))
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          width: formWidth,
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Color.fromRGBO(
                                                        0, 00, 0, 0.05),
                                                    blurRadius: 10,
                                                    spreadRadius: 5,
                                                    offset: Offset(10, 20)),
                                                BoxShadow(
                                                    color: Color.fromRGBO(
                                                        0, 00, 0, 0.05),
                                                    blurRadius: 10,
                                                    spreadRadius: 5,
                                                    offset: Offset(-10, 20))
                                              ],
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
                                              ),
                                              color: qbWhiteBGColor,
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.white)),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),

                              // Form Front
                              Container(
                                width: MediaQuery.of(context).size.width,
                                child: Container(
                                  width: formWidth,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: horPadding + formPadding / 2),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // Profile Pic
                                      profilePicWidget,

                                      SizedBox(
                                        height: 15,
                                      ),

                                      // First Name
                                      firstNameWidget,

                                      SizedBox(
                                        height: 15,
                                      ),

                                      // Last Name
                                      lastNameWidget,

                                      SizedBox(
                                        height: 35,
                                      ),

                                      // Phone Number Widget
                                      phNumWidget,

                                      SizedBox(
                                        height: 0,
                                      ),

                                      // Gender
                                      genderSelectionWidget,

                                      SizedBox(
                                        height: 20,
                                      ),

                                      // Continue Button
                                      continueBtn,

                                      SizedBox(
                                        height: 25,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
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
                  ),
                ),
              ),
            ),
          )),
    );
  }

  File gpProfilePicFile;
  onAddProfilePic() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ImagePickerAndInserter(
          cropRatioX: 1,
          cropRatioY: 1,
          imgUrl: null,
          imgFile: gpProfilePicFile,
          onImageInsert: onProfilePicInsert);
    }));
  }

  onEditProfilePic() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ImagePickerAndInserter(
          cropRatioX: 1,
          cropRatioY: 1,
          imgUrl: null,
          imgFile: gpProfilePicFile,
          onImageInsert: onProfilePicInsert);
    }));
  }

  onProfilePicInsert(File imgFile) {
    setState(() {
      gpProfilePicFile = imgFile;
    });
  }

  onContinuePressed() async {
    if (isFormEntriesValid) {
      setState(() {
        isLoading = true;
      });
      String gpNotificationToken = await FCMUtils().getToken();
      UserDetailsUploadStatus uploadStatus = await UserServices()
          .uploadUserDetails(
              authToken: widget.authToken,
              firstName: gpFirstName,
              lastName: gpLastName,
              notificationToken: gpNotificationToken,
              dialCode: gpDialCode,
              gender: gpUserGenderValue,
              phoneNumber: gpPhNum);

      if (uploadStatus == UserDetailsUploadStatus.successful) {
        if (gpProfilePicFile != null) {
          await UserServices().uploadProfilePic(
              authToken: widget.authToken, profilePic: gpProfilePicFile);
        }
        navigateToHome();
      } else if (uploadStatus == UserDetailsUploadStatus.invalidToken) {
        await AuthProvider().firebaseLogout();
      } else {
        // TODO: toast try again.
      }
      setState(() {
        isLoading = false;
      });
    } else {
      // Show Error
    }
  }

  navigateToHome() async {
    // TODO: navigate to Home Page.
    print("Sending you to HomePage...");
    // await NotificationUtils().init();

    // UserDetails gpUserDetails = await UserAuth().getUserDetailsFromUserId(
    //     widget.userData.id, widget.userData.accessToken);

    // setState(() {
    //   if (widget.userData != null) {
    //     // globalAppState.userData=widget.userData;
    //     Provider.of<AppState>(context, listen: false)
    //         .setUserData(widget.userData);
    //   }

    //   if (gpUserDetails != null) {
    //     // globalAppState.userDetails=gpUserDetails;
    //     Provider.of<AppState>(context, listen: false)
    //         .setUserDetails(gpUserDetails);
    //   }

    //   // globalAppState.parkingLordData=null;
    //   Provider.of<AppState>(context, listen: false).setParkingLordData(null);
    // });

    // Navigator.pushReplacement(context, MaterialPageRoute(
    //   builder: (context) {
    //     return HomePage();
    //   },
    // ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (otpTimer != null) {
      otpTimer.cancel();
    }
  }
}
