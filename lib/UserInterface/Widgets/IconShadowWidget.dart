import 'dart:ui';

import 'package:getparked/UserInterface/Icons/g_p_icons_icons.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/CustomIcon.dart';
import 'package:flutter/material.dart';

class IconShadowWidget extends StatelessWidget {
  final Color color;
  final double size;
  final IconData icon;
  final IconShadow iconShadow;

  IconShadowWidget(
      {@required this.icon,
      this.size: 20,
      this.color: Colors.black,
      @required this.iconShadow});

  double convertRadiusToSigma(double radius) {
    return radius * 0.57735 + 0.5;
  }

  @override
  Widget build(BuildContext context) {
    double topPadding = this.iconShadow.offset.dy;
    double leftPadding = this.iconShadow.offset.dx;
    double shIconSize =
        this.size * ((100 + this.iconShadow.spreadRadius) / 100);

    double blurSigma = convertRadiusToSigma(this.iconShadow.blurRadius);
    return Container(
      height: shIconSize,
      width: shIconSize,
      child: Container(
        child: Stack(
          children: [
            ImageFiltered(
              imageFilter:
                  ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
              child: Container(
                padding: EdgeInsets.only(left: leftPadding, top: topPadding),
                child: CustomIcon(
                    icon: this.icon,
                    size: shIconSize,
                    color: this.iconShadow.color),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                child: CustomIcon(
                  icon: this.icon,
                  size: this.size,
                  color: this.color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IconShadow {
  Offset offset;
  final Color color;
  final double blurRadius;
  final double spreadRadius;

  IconShadow(
      {this.offset: const Offset(0, 0),
      this.blurRadius: 0,
      this.color: Colors.black,
      this.spreadRadius: 0});
}
