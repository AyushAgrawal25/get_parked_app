import 'package:fluttertoast/fluttertoast.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';

class ToastUtils {
  static showMessage(String message) {
    Fluttertoast.showToast(
        msg: "   " + message + "   ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: qbDividerLightColor,
        textColor: qbAppTextColor,
        fontSize: 15.0);
  }
}
