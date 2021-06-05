// import 'package:getparked/UserInterface/Pages/RentOutSpace/SetLocation.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import './../../Widgets/qbFAB.dart';
// import './../../Theme/AppTheme.dart';
// import 'package:google_fonts/google_fonts.dart';
// import './../../Widgets/UnderLineTextFormField.dart';
// import './../../Widgets/WrapButton.dart';
// import 'package:fluttericon/font_awesome5_icons.dart';
// import './../../Widgets/EdgeLessButton.dart';

// class RentOutSpaceDetailsForm extends StatefulWidget {

//   Function onNextPressed;

//   RentOutSpaceDetailsForm({
//     @required this.onNextPressed
//   });

//   @override
//   _RentOutSpaceDetailsFormState createState() => _RentOutSpaceDetailsFormState();
// }

// class _RentOutSpaceDetailsFormState extends State<RentOutSpaceDetailsForm> {

//   @override
//   Widget build(BuildContext context) {

//     return Container(

//       height: MediaQuery.of(context).size.height,
//       width: MediaQuery.of(context).size.width,

//       child: Scaffold(

//         appBar: AppBar(
//           title: Text(
//             "Rent out your space",
//             style: GoogleFonts.roboto(
//               color: qbAppTextColor,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           backgroundColor: Colors.transparent,
//           elevation: 0.0,

//         ),

//         backgroundColor: Colors.white,

//         body: SingleChildScrollView(
//           child: Container(
//             padding: EdgeInsets.symmetric(
//               vertical: 15,
//               horizontal: 25
//             ),

//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [

//                 //Slot Pic
//                 Container(
//                   alignment: Alignment.topCenter,
//                   child: Container(
//                     margin: EdgeInsets.only(
//                       bottom: 15,
//                     ),
//                     width: 190,
//                     height: 170,
//                     child: Stack(
//                       children: [

//                         Align(
//                           alignment: Alignment.topCenter,
//                           child: Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               color: Color.fromRGBO(220, 220, 220, 1)
//                             ),
//                             height: 140,
//                             width: 140,
//                           ),
//                         ),

//                         Positioned(
//                           right: 5,
//                           bottom: 15,
//                           child: Container(
//                             child: QbFAB(
//                               size: 50,
//                               child: Icon(
//                                 MdiIcons.cameraPlus,
//                                 size: 24,
//                                 color: Colors.white,
//                               ),
//                               onPressed: (){},
//                             ),
//                           ),
//                         )

//                       ],
//                     ),
//                   ),
//                 ),

//                 //Input Field
//                 Container(
//                   child: TextFormField(
//                     minLines: 1,
//                     maxLines: 1,
//                     onChanged: (value){},

//                     decoration: InputDecoration(
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: BorderSide(
//                           width: 1,
//                           color: qbAppTextColor
//                         )
//                       ),

//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: BorderSide(
//                           width: 1.5,
//                           color: Colors.blue
//                         )
//                       ),

//                       labelText: "Enter your Slot Name",
//                       labelStyle: GoogleFonts.roboto(
//                         fontSize: 15,
//                         color: qbAppTextColor,
//                         fontWeight: FontWeight.w500,
//                       ),
//                       contentPadding: EdgeInsets.only(
//                         left: 25,
//                         right: 25,
//                         top: 12.5,
//                         bottom: 12.5
//                       ),
//                       alignLabelWithHint: false,
//                       isDense: true
//                     ),

//                   ),
//                 ),

//                 //Location Container
//                 Container(
//                   margin: EdgeInsets.only(
//                     top: 20,
//                     left: 10,
//                     right: 10
//                   ),
//                   child: Text(
//                     "Location",
//                     style: GoogleFonts.roboto(
//                       fontSize: 20,
//                       fontWeight: FontWeight.w500,
//                       color: Color.fromRGBO(30, 30, 30, 30)
//                     ),
//                   ),
//                 ),

//                 Container(
//                   child: Divider(
//                     color: qbDividerLightColor,
//                     thickness: 1.5,
//                   ),
//                 ),

//                 UnderLineTextFormField(
//                   labelText: "Address",
//                 ),

//                 UnderLineTextFormField(
//                   labelText: "State",
//                 ),

//                 Row(
//                   children: [

//                     Expanded(
//                       child: UnderLineTextFormField(
//                         labelText: "City",
//                         padding: EdgeInsets.only(
//                           right: 10
//                         ),
//                       ),
//                     ),

//                     Expanded(
//                       child: UnderLineTextFormField(
//                         labelText: "Postal Code",
//                         padding: EdgeInsets.only(
//                           left: 10
//                         ),
//                       ),
//                     ),

//                   ],
//                 ),

//                 //Landmark
//                 UnderLineTextFormField(
//                   labelText: "Landmark",
//                 ),

//                 Container(
//                   padding: EdgeInsets.only(
//                     top: 5
//                   ),
//                   alignment: Alignment.center,
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [

//                       //Set Location
//                       Container(
//                         child: Text(
//                           "SET Location",
//                           style: GoogleFonts.roboto(
//                             fontSize: 17.5,
//                             fontWeight: FontWeight.w500,
//                             color: qbDetailDarkColor
//                           ),
//                         ),
//                       ),

//                       SizedBox(
//                         width: 10,
//                       ),

//                       Container(
//                         child: WrapButton(
//                           onPressed: (){
//                             Navigator.of(context).push(
//                               MaterialPageRoute(
//                                 builder: (context) {
//                                   return SetLocationPage(
//                                     onSetLocation: (LatLng gpSlotLatLng){
//                                       print(gpSlotLatLng);
//                                     },
//                                   );
//                                 },
//                               )
//                             );
//                           },

//                           padding: EdgeInsets.only(
//                             top: 7.5,
//                             bottom: 7.5,
//                             left: 20,
//                             right: 20
//                           ),

//                           color: qbAppPrimaryThemeColor,
//                           borderRadius: BorderRadius.circular(5),
//                           child: Text(
//                             "Map",
//                             style: GoogleFonts.roboto(
//                               fontSize: 15,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.white
//                             ),
//                           )
//                         ),
//                       )
//                     ],
//                   ),
//                 ),

//                 //Buttons
//                 Container(
//                   padding: EdgeInsets.symmetric(
//                     vertical: 7.5
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [

//                       //Add Images
//                       EdgeLessButton(
//                         onPressed: (){},
//                         padding: EdgeInsets.only(
//                           left: 25,
//                           right: 22.5,
//                           top: 10,
//                           bottom: 10
//                         ),
//                         color: Colors.blue.shade600,
//                         child: Row(
//                           children: [
//                             Text(
//                               "Add",
//                               style: GoogleFonts.roboto(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.white
//                               ),
//                             ),

//                             SizedBox(
//                               width: 5,
//                             ),

//                             Icon(
//                               MdiIcons.imageMultiple,
//                               size: 20,
//                               color: Colors.white,
//                             )
//                           ],
//                         ),
//                       ),

//                       //Next
//                       EdgeLessButton(

//                         onPressed: (){
//                           widget.onNextPressed();
//                         },

//                         padding: EdgeInsets.only(
//                           left: 25,
//                           right: 17.5,
//                           top: 10,
//                           bottom: 10
//                         ),
//                         color: Colors.blue.shade600,
//                         child: Row(
//                           children: [
//                             Text(
//                               "Next",
//                               style: GoogleFonts.roboto(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.white
//                               ),
//                             ),

//                             SizedBox(
//                               width: 7.5,
//                             ),

//                             Icon(
//                               Icons.arrow_forward,
//                               size: 20,
//                               color: Colors.white,
//                             )
//                           ],
//                         ),
//                       )

//                     ],
//                   ),
//                 )

//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
