// import 'package:getparked/BussinessLogic/GPMapUtils.dart';
// import 'package:getparked/UserInterface/Theme/AppTheme.dart';
// import 'package:getparked/UserInterface/Widgets/EdgeLessButton.dart';
// import 'package:getparked/UserInterface/Widgets/qbFAB.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:fluttericon/elusive_icons.dart';
// import 'package:fluttericon/entypo_icons.dart';
// import 'package:fluttericon/font_awesome5_icons.dart';
// import 'package:fluttericon/font_awesome_icons.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class SetLocationPage extends StatefulWidget {
//   Function onSetLocation;

//   SetLocationPage({this.onSetLocation});

//   @override
//   _SetLocationPageState createState() => _SetLocationPageState();
// }

// class _SetLocationPageState extends State<SetLocationPage> {
//   GPMapController gpMapController;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//       statusBarColor: Color.fromRGBO(0, 0, 0, 0.3),
//       statusBarIconBrightness: Brightness.dark,
//       systemNavigationBarColor: Colors.transparent,
//     ));
//     SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);

//     return Container(
//         child: Stack(
//       children: [
//         GPMap(
//           initialZoom: 18,
//           getController: (controller) {
//             gpMapController = controller;
//             gpMapController.setLocation(16);
//           },
//           onCameraMove: (qbCamPos) {
//             print(qbCamPos.zoom);
//           },
//         ),
//         Container(
//           height: 56 + MediaQuery.of(context).padding.top,
//           child: Scaffold(
//             appBar: AppBar(
//               backgroundColor: Colors.white,
//               title: Text(
//                 "Set Location",
//                 style: GoogleFonts.roboto(
//                     fontWeight: FontWeight.w500, color: qbAppTextColor),
//               ),
//               iconTheme: IconThemeData(color: qbAppTextColor),
//             ),
//           ),
//         ),
//         Align(
//           alignment: Alignment(1, 0.9),
//           child: Container(
//             margin: EdgeInsets.only(right: 20),
//             child: QbFAB(
//               size: 50,
//               color: qbAppPrimaryThemeColor,
//               child: Icon(
//                 Elusive.location,
//                 size: 23.5,
//                 color: Colors.white,
//               ),
//               onPressed: () {
//                 gpMapController.setLocation(16);
//               },
//             ),
//           ),
//         ),
//         Align(
//           alignment: Alignment(0, 0.9),
//           child: EdgeLessButton(
//             padding: EdgeInsets.symmetric(vertical: 12.5, horizontal: 40),
//             color: qbAppPrimaryThemeColor,
//             child: Text(
//               "Set Location",
//               style: GoogleFonts.roboto(
//                   color: Colors.white,
//                   fontSize: 17.5,
//                   fontWeight: FontWeight.w500),
//             ),
//             onPressed: () async {
//               Navigator.of(context).pop();
//               LatLng gpCurrentLatLng = await gpMapController.getCameraPostion();
//               widget.onSetLocation(gpCurrentLatLng);
//             },
//           ),
//         ),
//         Align(
//           alignment: Alignment.center,
//           child: Icon(
//             FontAwesome5.map_pin,
//             size: 35,
//           ),
//         )
//       ],
//     ));
//   }
// }
