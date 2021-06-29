// import 'package:getparked/UserInterface/Pages/Vault/VaultPage.dart';
// import 'package:getparked/UserInterface/Pages/Profile/ProfilePage.dart';
// import 'package:getparked/UserInterface/Pages/Notifications/NotificationsPage.dart';
// import 'package:getparked/UserInterface/Pages/RentOutSpace/RentOutSpaceFormsPage.dart';
// import 'package:getparked/UserInterface/Pages/Wallet/WalletPage.dart';
// import 'package:getparked/UserInterface/Pages/ParkingLord/ParkingLordPage.dart';
// import 'package:getparked/UserInterface/Pages/ParkingLordSettings/ParkingLordSettingsPage.dart';
// import 'package:getparked/UserInterface/Pages/LiveSlot/LiveSlotPage.dart';
// import 'package:getparked/UserInterface/Pages/About/AboutPage.dart';
// import 'package:getparked/UserInterface/Pages/Settings/SettingsPage.dart';
// import 'package:getparked/UserInterface/Pages/HelpAndFeedback/HelpAndFeedbackPage.dart';
import 'package:getparked/UserInterface/Pages/Notifications/NotificationsPage.dart';
import 'package:getparked/UserInterface/Pages/ParkingLord/ParkingLordPage.dart';
import 'package:getparked/UserInterface/Pages/Profile/ProfilePage.dart';
import 'package:getparked/UserInterface/Pages/RentOutSpace/RentOutSpaceFormsPage.dart';
import 'package:getparked/UserInterface/Pages/Vault/VaultPage.dart';
import 'package:getparked/UserInterface/Pages/Wallet/WalletPage.dart';
import 'package:sailor/sailor.dart';

class SideNavRoutes {
  static final sailor = Sailor();

  static void createRoutes() {
    sailor.addRoutes([
      // SailorRoute(
      //     name: '/',
      //     builder: (context, args, paramMap) {
      //       return NotificationsPage();
      //     },
      //     defaultTransitions: [
      //       SailorTransition.slide_from_left,
      //       SailorTransition.fade_in
      //     ],
      //     defaultTransitionDuration: Duration(milliseconds: 250)),
      SailorRoute(
          name: '/Profile',
          builder: (context, args, paramMap) {
            return ProfilePage();
          },
          defaultTransitions: [
            SailorTransition.slide_from_left,
            SailorTransition.fade_in
          ],
          defaultTransitionDuration: Duration(milliseconds: 250)),
      SailorRoute(
          name: '/Wallet',
          builder: (context, args, paramMap) {
            return WalletPage();
          },
          defaultTransitions: [
            SailorTransition.slide_from_left,
            SailorTransition.fade_in
          ],
          defaultTransitionDuration: Duration(milliseconds: 250)),
      SailorRoute(
          name: '/Notifications',
          builder: (context, args, paramMap) {
            return NotificationsPage();
          },
          defaultTransitions: [
            SailorTransition.slide_from_left,
            SailorTransition.fade_in
          ],
          defaultTransitionDuration: Duration(milliseconds: 250)),
      SailorRoute(
          name: '/RentOutSpace',
          builder: (context, args, paramMap) {
            return RentOutSpaceForms();
          },
          defaultTransitions: [
            SailorTransition.slide_from_left,
            SailorTransition.fade_in
          ],
          defaultTransitionDuration: Duration(milliseconds: 250)),
      SailorRoute(
          name: '/ParkingLord',
          builder: (context, args, paramMap) {
            return ParkingLordPage();
          },
          defaultTransitions: [
            SailorTransition.slide_from_left,
            SailorTransition.fade_in
          ],
          defaultTransitionDuration: Duration(milliseconds: 250)),
      SailorRoute(
          name: '/Vault',
          builder: (context, args, paramMap) {
            return VaultPage();
          },
          defaultTransitions: [
            SailorTransition.slide_from_left,
            SailorTransition.fade_in
          ],
          defaultTransitionDuration: Duration(milliseconds: 250)),
      // SailorRoute(
      //     name: '/LiveSlot',
      //     builder: (context, args, paramMap) {
      //       return LiveSlotPage();
      //     },
      //     defaultTransitions: [
      //       SailorTransition.slide_from_left,
      //       SailorTransition.fade_in
      //     ],
      //     defaultTransitionDuration: Duration(milliseconds: 250)),
      // SailorRoute(
      //     name: '/SlotSettings',
      //     builder: (context, args, paramMap) {
      //       return ParkingLordSettingsPage();
      //     },
      //     defaultTransitions: [
      //       SailorTransition.slide_from_left,
      //       SailorTransition.fade_in
      //     ],
      //     defaultTransitionDuration: Duration(milliseconds: 250)),
      // SailorRoute(
      //     name: '/Settings',
      //     builder: (context, args, paramMap) {
      //       return SettingsPage();
      //     },
      //     defaultTransitions: [
      //       SailorTransition.slide_from_left,
      //       SailorTransition.fade_in
      //     ],
      //     defaultTransitionDuration: Duration(milliseconds: 250)),
      // SailorRoute(
      //     name: '/HelpAndFeedback',
      //     builder: (context, args, paramMap) {
      //       return HelpAndFeedbackPage();
      //     },
      //     defaultTransitions: [
      //       SailorTransition.slide_from_left,
      //       SailorTransition.fade_in
      //     ],
      //     defaultTransitionDuration: Duration(milliseconds: 250)),
      // SailorRoute(
      //     name: '/About',
      //     builder: (context, args, paramMap) {
      //       return AboutPage();
      //     },
      //     defaultTransitions: [
      //       SailorTransition.slide_from_left,
      //       SailorTransition.fade_in
      //     ],
      //     defaultTransitionDuration: Duration(milliseconds: 250)),
    ]);
  }
}
