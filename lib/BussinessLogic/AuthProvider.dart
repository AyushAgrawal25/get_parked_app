import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:getparked/BussinessLogic/NotificationServices.dart';
import 'package:getparked/BussinessLogic/ParkingLordServices.dart';
import 'package:getparked/BussinessLogic/SlotsServices.dart';
import 'package:getparked/BussinessLogic/UserServices.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/Utils/SecureStorageUtils.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;

class AuthProvider {
  Future<InitAppStatus> initApp({@required BuildContext context}) async {
    // Check the firebase user.
    fbAuth.User firebaseUser = getFirebaseUser();
    if (firebaseUser == null) {
      return InitAppStatus.notLoggedIn;
    }
    String email = firebaseUser.email;

    // Check the token.
    String authToken = await SecureStorageUtils().getAuthToken();

    if (authToken == null) {
      return InitAppStatus.notLoggedIn;
    }

    // Set the token.
    AppState appState = Provider.of<AppState>(context, listen: false);
    appState.setAuthToken(authToken);

    // Get User
    // Set the user data and details together.
    UserGetStatus userGetStatus =
        await UserServices().getUser(authToken: authToken, context: context);
    if (userGetStatus == UserGetStatus.notSignedUp) {
      return InitAppStatus.notSignedUp;
    } else if (userGetStatus != UserGetStatus.successful) {
      await firebaseLogout();
      return InitAppStatus.notLoggedIn;
    }

    // For Parking Lord
    await ParkingLordServices().getParkingLord(context: context);

    // User Details
    if (appState.userData.signUpStatus == 0) {
      return InitAppStatus.notSignedUp;
    }

    // FCM Token Update
    NotificationServices().updateFCMToken(authToken: authToken);

    return InitAppStatus.loggedIn;
  }

  fbAuth.User getFirebaseUser() {
    try {
      fbAuth.User fbCurrUser = fbAuth.FirebaseAuth.instance.currentUser;
      if (fbCurrUser == null) {
        return null;
      }
      return fbCurrUser;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<fbAuth.User> firebaseLogin() async {
    try {
      GoogleSignInAuthentication googleAuth = await googleLogin();
      if (googleAuth == null) {
        return null;
      }
      fbAuth.FirebaseAuth fbAuthInstance = fbAuth.FirebaseAuth.instance;

      fbAuth.AuthCredential authCred = fbAuth.GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      fbAuth.UserCredential userCred =
          await fbAuthInstance.signInWithCredential(authCred);
      return userCred.user;
    } on fbAuth.FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        print(
            "Firebase Auth Status: Account already exists with different credentails.");
        return null;
      } else if (e.code == 'invalid-credential') {
        print("Firebase Auth Status: Invalid Credential");
        return null;
      }
      print(e);
      return null;
    } catch (e) {
      print(e);
      // handle the error here
      return null;
    }
  }

  Future<GoogleSignInAuthentication> googleLogin() async {
    try {
      GoogleSignInAccount googleAcc = await GoogleSignIn().signIn();
      if (googleAcc == null) {
        return null;
      }

      GoogleSignInAuthentication googleSignInAuth =
          await googleAcc.authentication;
      return googleSignInAuth;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> firebaseLogout() async {
    try {
      googleSignOut();
      fbAuth.FirebaseAuth.instance.signOut();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> googleSignOut() async {
    try {
      if (!await GoogleSignIn().isSignedIn()) {
        return true;
      }
      GoogleSignInAccount googleAcc = await GoogleSignIn().signOut();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future firebasePhoneVerification({@required String phoneNumber}) async {
    print(phoneNumber + " this is phone number....");
    fbAuth.FirebaseAuth firebaseAuth = fbAuth.FirebaseAuth.instance;
    firebaseAuth.verifyPhoneNumber(
        // phoneNumber: phoneNumber,
        phoneNumber: "+91 8085 873 059",
        verificationCompleted: (phoneAuthCredential) {
          print("Verification Complete !");
          print(phoneAuthCredential.smsCode);
        },
        verificationFailed: (error) {
          print("Error !");
          print(error.phoneNumber);
          print(error.tenantId);
          print(error.code);
          print(error.message);
        },
        codeSent: (verificationId, forceResendingToken) {
          print("Code Sent !");
          print(verificationId);
          print(forceResendingToken);
        },
        codeAutoRetrievalTimeout: (verificationId) {
          print(verificationId);
        },
        autoRetrievedSmsCodeForTesting: "4565");
  }
}

enum InitAppStatus { loggedIn, notSignedUp, notLoggedIn }
