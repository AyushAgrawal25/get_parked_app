import 'package:flutter/cupertino.dart';
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
    // Call Get User function
    // TODO: complete this function.
    await UserServices().getUser(authToken: authToken);

    // Set the user data and details together.
    // Refresh the token also.

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
}

enum InitAppStatus { loggedIn, notLoggedIn }
