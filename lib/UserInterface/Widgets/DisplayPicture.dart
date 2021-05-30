import 'dart:io';

import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/qbFAB.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';

class DisplayPicture extends StatefulWidget {
  String imgUrl;
  File proxyImgFile;
  bool toShowProxyImgFile;
  bool isEditable;
  Function onEditPressed;
  bool isDeletable;
  double height;
  double width;
  bool isElevated;
  DisplayPictureType type;
  BorderRadius borderRadius;
  Widget actionButton;
  double iconButtonSize;

  DisplayPicture(
      {@required this.imgUrl,
      this.proxyImgFile,
      this.toShowProxyImgFile: false,
      this.onEditPressed,
      this.isEditable: true,
      this.isDeletable: false,
      this.height,
      this.width,
      this.isElevated: false,
      this.borderRadius,
      this.actionButton,
      this.iconButtonSize: 50,
      this.type: DisplayPictureType.defaultImg});
  @override
  _DisplayPictureState createState() => _DisplayPictureState();
}

class _DisplayPictureState extends State<DisplayPicture> {
  // Container Dimensions
  double containerWidth;
  double containerHeight;

  // Img Dimensions
  double imgHeight;
  double imgWidth;

  // BorderRadius
  BorderRadius borderRadius;

  // Placeholder Pic
  String placeholderPic;

  bool toShowPic = false;

  settingUpDimensions() {
    // Setting Up Height
    if (widget.height != null) {
      containerHeight = widget.height;
      imgHeight = widget.height;
    } else {
      containerHeight = (MediaQuery.of(context).size.width * 0.5);
      imgHeight = (MediaQuery.of(context).size.width * 0.5);
    }

    // Setting Up Width
    if (widget.width != null) {
      containerWidth = widget.width;
      imgWidth = widget.width;
    } else {
      containerWidth = (MediaQuery.of(context).size.width * 0.5);
      imgWidth = (MediaQuery.of(context).size.width * 0.5);
    }

    // if its Editable
    if (widget.isEditable) {
      containerHeight += 30;
      containerWidth += 30;
    }
  }

  settingUpBorderRadiusAndDefPic() {
    switch (widget.type) {
      case DisplayPictureType.profilePictureMale:
        placeholderPic = "assets/images/male.png";
        borderRadius = BorderRadius.circular(360);
        break;
      case DisplayPictureType.profilePictureFemale:
        placeholderPic = "assets/images/female.png";
        borderRadius = BorderRadius.circular(360);
        break;
      case DisplayPictureType.slotMainImage:
        placeholderPic = "assets/images/house.png";
        borderRadius = BorderRadius.circular(imgWidth / 18);
        break;
      case DisplayPictureType.defaultImg:
        placeholderPic = "assets/images/house.png";
        borderRadius = BorderRadius.circular(0);
        break;
    }

    if (widget.borderRadius != null) {
      borderRadius = widget.borderRadius;
    }
  }

  @override
  Widget build(BuildContext context) {
    if ((widget.imgUrl == "") || (widget.imgUrl == null)) {
      toShowPic = false;
    } else {
      toShowPic = true;
    }
    settingUpDimensions();
    settingUpBorderRadiusAndDefPic();

    return Container(
      height: containerHeight,
      width: containerWidth,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
      ),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: (widget.isElevated)
                      ? [
                          BoxShadow(
                              offset: Offset(2, 4),
                              blurRadius: 10,
                              spreadRadius: 5,
                              color: Color.fromRGBO(0, 0, 0, 0.15))
                        ]
                      : null,
                  borderRadius: borderRadius),
              child: ClipRRect(
                borderRadius: borderRadius,
                child: Image.asset(
                  placeholderPic,
                  width: imgWidth,
                  height: imgHeight,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              child: ClipRRect(
                  borderRadius: borderRadius,
                  child: (toShowPic)
                      ? CachedNetworkImage(
                          imageUrl: widget.imgUrl,
                          fit: BoxFit.cover,
                          width: imgWidth,
                          height: imgHeight,
                        )
                      : Container(
                          height: 0,
                          width: 0,
                        )),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: (widget.isElevated)
                      ? [
                          BoxShadow(
                              offset: Offset(2, 4),
                              blurRadius: 10,
                              spreadRadius: 5,
                              color: Color.fromRGBO(0, 0, 0, 0.15))
                        ]
                      : null,
                  borderRadius: borderRadius),
              child:
                  ((widget.toShowProxyImgFile) && (widget.proxyImgFile != null))
                      ? ClipRRect(
                          borderRadius: borderRadius,
                          child: Image.file(
                            widget.proxyImgFile,
                            width: imgWidth,
                            height: imgHeight,
                          ),
                        )
                      : Container(
                          height: 0,
                          width: 0,
                        ),
            ),
          ),
          (widget.isEditable)
              ? Align(
                  alignment: Alignment(1, 1),
                  child: Container(
                    child: QbFAB(
                      color: qbAppPrimaryThemeColor,
                      size: widget.iconButtonSize,
                      child: Icon(
                        FontAwesome.pencil,
                        size: 22.5 * widget.iconButtonSize / 50,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        if (widget.onEditPressed != null) {
                          widget.onEditPressed();
                        }
                      },
                    ),
                  ),
                )
              : Container(
                  height: 0,
                  width: 0,
                ),
          (widget.isDeletable)
              ? Align(
                  alignment: Alignment(1, -1),
                  child: Container(
                    child: QbFAB(
                      size: 42.5,
                      color: qbAppPrimaryRedColor,
                      child: Icon(
                        FontAwesome5.trash,
                        size: 17.5,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ),
                )
              : Container(
                  height: 0,
                  width: 0,
                ),
          (widget.actionButton != null)
              ? Align(
                  alignment: Alignment(1, 1),
                  child: widget.actionButton,
                )
              : Container(
                  height: 0,
                  width: 0,
                )
        ],
      ),
    );
  }
}

enum DisplayPictureType {
  profilePictureMale,
  profilePictureFemale,
  slotMainImage,
  defaultImg
}
