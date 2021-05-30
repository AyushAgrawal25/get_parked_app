import 'package:getparked/UserInterface/Theme/AppOverlayStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class AppOverlayStyleData {
  AppOverlayStyleType type;
  SystemUiOverlayStyle style;

  AppOverlayStyleData({@required this.type}) {
    switch (this.type) {
      case AppOverlayStyleType.greyBG:
        style = AppOverlayStyle.greyBG;
        break;
      case AppOverlayStyleType.whiteBG:
        style = AppOverlayStyle.whiteBG;
        break;
      case AppOverlayStyleType.whiteBGGreenAppBar:
        style = AppOverlayStyle.whiteBGGreenAppBar;
        break;
      case AppOverlayStyleType.map:
        style = AppOverlayStyle.map;
        break;
      case AppOverlayStyleType.blackBG:
        style = AppOverlayStyle.blackBG;
        break;
      case AppOverlayStyleType.greenBG:
        style = AppOverlayStyle.greenBG;
        break;
    }
  }
}

enum AppOverlayStyleType {
  greyBG,
  whiteBGGreenAppBar,
  whiteBG,
  blackBG,
  map,
  greenBG
}
