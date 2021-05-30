import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppOverlayStyle {
  static SystemUiOverlayStyle greyBG = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: qbAppBGBluishGreyColor,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light);

  static SystemUiOverlayStyle whiteBGGreenAppBar = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: qbWhiteBGColor,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light);

  static SystemUiOverlayStyle whiteBG = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: qbWhiteBGColor,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light);

  static SystemUiOverlayStyle blackBG = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color.fromRGBO(25, 25, 25, 1),
      systemNavigationBarIconBrightness: Brightness.dark);

  static SystemUiOverlayStyle map = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: qbWhiteBGColor,
      systemNavigationBarIconBrightness: Brightness.dark);

  static SystemUiOverlayStyle greenBG = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: qbAppPrimaryThemeColor,
      systemNavigationBarIconBrightness: Brightness.light);
}
