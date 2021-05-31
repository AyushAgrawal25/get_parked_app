import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:getparked/UserInterface/Icons/g_p_icons_icons.dart';

class NavigationModel {
  String title;
  IconData icon;
  String route;

  NavigationModel({this.title, this.icon, this.route});
}

List<NavigationModel> navigationPrimaryItems = [
  NavigationModel(title: "Profile", icon: Typicons.user, route: "/Profile"),
  NavigationModel(title: "Wallet", icon: GPIcons.wallet, route: "/Wallet"),
  NavigationModel(
      title: "Notifications",
      icon: FontAwesome.bell_alt,
      route: "/Notifications"),
];

List<NavigationModel> navigationParkingLordItems = [
  NavigationModel(
      title: "Parking Lord",
      icon: FontAwesomeIcons.crown,
      route: "/ParkingLord"),
  NavigationModel(
      title: "Vault", icon: GPIcons.vault_circular_gear, route: "/Vault"),
  NavigationModel(title: "Live Slot", icon: Elusive.video, route: "/LiveSlot"),
  NavigationModel(
      title: "Slot Settings",
      icon: FontAwesome.cog_alt,
      route: "/SlotSettings"),
];

List<NavigationModel> navigationSecondaryItems = [
  NavigationModel(
      title: "Settings", icon: FontAwesomeIcons.slidersH, route: "/Settings"),
  NavigationModel(
      title: "Help And Feedback",
      icon: FontAwesomeIcons.comment,
      route: "/HelpAndFeedback"),
  NavigationModel(
      title: "About", icon: FontAwesomeIcons.infoCircle, route: "/About"),
];
