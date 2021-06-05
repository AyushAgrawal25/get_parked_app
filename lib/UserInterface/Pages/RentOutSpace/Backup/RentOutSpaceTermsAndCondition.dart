// import 'package:getparked/UserInterface/Theme/AppTheme.dart';
// import 'package:getparked/UserInterface/Widgets/EdgeLessButton.dart';
// import 'package:flutter/material.dart';

// import 'package:google_fonts/google_fonts.dart';class RentOutSpaceTermsAndCondition extends StatefulWidget {

//   Function onSubmitPressed;

//   RentOutSpaceTermsAndCondition({
//     @required this.onSubmitPressed
//   });

//   @override
//   _RentOutSpaceTermsAndConditionState createState() => _RentOutSpaceTermsAndConditionState();
// }

// class _RentOutSpaceTermsAndConditionState extends State<RentOutSpaceTermsAndCondition> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(

//       height: MediaQuery.of(context).size.height,
//       width: MediaQuery.of(context).size.width,
//       color: Colors.white,

//       child: Scaffold(

//         appBar: AppBar(
//           title: Text(
//             "Terms And Condition",
//             style: GoogleFonts.roboto(
//               fontWeight: FontWeight.w500,
//               color: qbAppTextColor
//             ),
//           ),

//           backgroundColor: Colors.transparent,
//           elevation: 0.0,
//         ),

//         body: SingleChildScrollView(
//           child: Container(
//             alignment: Alignment.bottomCenter,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [

//                 Container(
//                   child: EdgeLessButton(
//                     margin: EdgeInsets.symmetric(
//                       vertical: 10,
//                       horizontal: 20
//                     ),
//                     padding: EdgeInsets.symmetric(
//                       vertical: 10,
//                       horizontal: 40
//                     ),
//                     child: Text(
//                       "Submit",
//                       style: GoogleFonts.roboto(
//                         fontSize: 17.5,
//                         fontWeight: FontWeight.w500,
//                         color: Colors.white
//                       ),
//                     ),

//                     onPressed: (){
//                       widget.onSubmitPressed();
//                     },
//                   ),
//                 ),

//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
