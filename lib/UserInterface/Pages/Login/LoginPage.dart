import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getparked/BussinessLogic/AuthProvider.dart';
import 'package:getparked/BussinessLogic/UserServices.dart';
import 'package:getparked/UserInterface/Icons/g_p_icons_icons.dart';
import 'package:getparked/UserInterface/Pages/SplashScreen/SplashScreenPage.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/CustomIcon.dart';
import 'package:getparked/UserInterface/Widgets/Loaders/LoaderPage.dart';
import 'package:getparked/Utils/DomainUtils.dart';
import 'package:getparked/Utils/SecureStorageUtils.dart';
import 'package:getparked/Utils/ToastUtils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Scaffold(
            body: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  Container(
                    child: CustomIcon(
                      icon: GPIcons.get_parked_logo,
                      size: 120,
                      color: qbAppPrimaryThemeColor,
                    ),
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  // AppName
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

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.125,
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: GestureDetector(
                      onTap: () {
                        SystemSound.play(SystemSoundType.click);
                        googleLogin();
                        // AuthProvider().firebaseLogout();
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 35, vertical: 12.5),
                        decoration: BoxDecoration(
                            color: qbWhiteBGColorShade248,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(10, 10),
                                  blurRadius: 5,
                                  spreadRadius: 0.25,
                                  color: Color.fromRGBO(0, 0, 0, 0.05))
                            ]),
                        child: Row(
                          children: [
                            //Icon
                            Container(
                              child: Image.asset(
                                'assets/images/googleLogo.png',
                                height: 22.5,
                                width: 25,
                                fit: BoxFit.cover,
                              ),
                            ),

                            //Login Text
                            Expanded(
                              child: Container(
                                child: Text(
                                  "Google",
                                  style: GoogleFonts.nunito(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textScaleFactor: 1,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),

                            //Some Padding
                            SizedBox(
                              width: 25,
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          (isLoading) ? LoaderPage() : Container()
        ],
      ),
    );
  }

  googleLogin() async {
    setState(() {
      isLoading = true;
    });
    fbAuth.User user = await AuthProvider().firebaseLogin();
    if (user != null) {
      // Check user registration
      bool userRegistrationStatus =
          await UserServices().isEmailRegistered(email: user.email);

      if (userRegistrationStatus) {
        // Call Login function.
        String authToken =
            await UserServices().login(email: user.email, userToken: user.uid);

        print(authToken);
        if (authToken != null) {
          await SecureStorageUtils().setAuthToken(authToken);
          navigateToSpashScreen();
        } else {
          ToastUtils.showMessage("Login Again");
        }
      } else {
        // Call SignUp function.
        UserCreateStatus createStatus = await UserServices()
            .createUser(email: user.email, userToken: user.uid);
        if (createStatus == UserCreateStatus.successful) {
          String authToken = await UserServices()
              .login(email: user.email, userToken: user.uid);
          if (authToken != null) {
            await SecureStorageUtils().setAuthToken(authToken);
            navigateToSpashScreen();
          }
        } else {
          ToastUtils.showMessage("Login Again");
        }
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  navigateToSpashScreen() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) {
        return SplashScreenPage();
      },
    ));
  }
}
