import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';

class InternetConnectionUtils {
  Future<bool> isInternetConnected() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }

  Future<bool> isInternetConnectedWithToast() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Fluttertoast.showToast(
            msg: "Internet Connected",
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            fontSize: 14);
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No Internet Connection");
      return false;
    }
  }

  toastConnectionStatus(bool internetConnectionStatus) {
    if (internetConnectionStatus) {
      Fluttertoast.showToast(
          msg: "Internet Connected",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          fontSize: 14);
    } else {
      Fluttertoast.showToast(
          msg: "Internet Disconnected",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          fontSize: 14);
    }
  }
}
