import 'package:getparked/UserInterface/Icons/g_p_icons_icons.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color color;
  final CustomIconType type;
  final Alignment alignment;

  CustomIcon(
      {@required this.icon,
      this.color,
      this.size: 25,
      this.alignment: Alignment.centerLeft,
      this.type: CustomIconType.square});

  double heightFactor = 1;
  double widthFactor = 1;
  @override
  Widget build(BuildContext context) {
    if (type == CustomIconType.square) {
      // Creating Square
      if (this.icon == GPIcons.get_parked_logo) {
        heightFactor = 1;
        widthFactor = 1.32;
      }
      if (this.icon == GPIcons.rent_out_space) {
        heightFactor = 1;
        widthFactor = 98.5 / 60;
      }
      if ((this.icon == GPIcons.bike_bag) ||
          (this.icon == GPIcons.bike_bag_outlined)) {
        heightFactor = 1;
        widthFactor = 1.70;
      }
      if (this.icon == GPIcons.bike) {
        heightFactor = 1;
        widthFactor = 1.70;
      }
      if ((this.icon == GPIcons.hatch_back_car) ||
          (this.icon == GPIcons.hatch_back_car_outlined)) {
        heightFactor = 1;
        widthFactor = 2.45;
      }
      if ((this.icon == GPIcons.sedan_car) ||
          (this.icon == GPIcons.sedan_car_outlined)) {
        heightFactor = 1;
        widthFactor = 3.25;
      }
      if ((this.icon == GPIcons.suv_car) ||
          (this.icon == GPIcons.suv_car_outlined)) {
        heightFactor = 1;
        widthFactor = 2.7;
      }
      if ((this.icon == GPIcons.van) || (this.icon == GPIcons.van_outlined)) {
        heightFactor = 1;
        widthFactor = 2.1;
      }
      if (this.icon == GPIcons.wallet) {
        heightFactor = 1;
        widthFactor = 1.3;
      }
      if (this.icon == GPIcons.wallet_outlined) {
        heightFactor = 1;
        widthFactor = 1.21;
      }
      if (this.icon == GPIcons.transaction_slip) {
        heightFactor = 1;
        widthFactor = 1.56;
      }
      return Container(
        height: this.size,
        width: this.size,
        alignment: this.alignment,
        child:
            Icon(this.icon, size: this.size / widthFactor, color: this.color),
      );
    } else if (type == CustomIconType.onHeight) {
      // Original Dimensions
      if (this.icon == GPIcons.get_parked_logo) {
        heightFactor = 1;
        widthFactor = 1.32;
      }
      if (this.icon == GPIcons.rent_out_space) {
        heightFactor = 1;
        widthFactor = 98.5 / 60;
      }
      if ((this.icon == GPIcons.bike_bag) ||
          (this.icon == GPIcons.bike_bag_outlined)) {
        heightFactor = 1;
        widthFactor = 1.70;
      }
      if (this.icon == GPIcons.bike) {
        heightFactor = 1;
        widthFactor = 1.70;
      }
      if ((this.icon == GPIcons.hatch_back_car) ||
          (this.icon == GPIcons.hatch_back_car_outlined)) {
        heightFactor = 1;
        widthFactor = 2.45;
      }
      if ((this.icon == GPIcons.sedan_car) ||
          (this.icon == GPIcons.sedan_car_outlined)) {
        heightFactor = 1;
        widthFactor = 3.25;
      }
      if ((this.icon == GPIcons.suv_car) ||
          (this.icon == GPIcons.suv_car_outlined)) {
        heightFactor = 1;
        widthFactor = 2.7;
      }
      if ((this.icon == GPIcons.van) || (this.icon == GPIcons.van_outlined)) {
        heightFactor = 1;
        widthFactor = 2.1;
      }
      if (this.icon == GPIcons.transaction_slip) {
        heightFactor = 1;
        widthFactor = 1;
      }
      return Container(
        height: this.size,
        width: this.size * widthFactor,
        child: Icon(this.icon, size: this.size, color: this.color),
      );
    } else {
      return Container(
        height: 0,
        width: 0,
      );
    }
  }
}

enum CustomIconType { square, onHeight }
