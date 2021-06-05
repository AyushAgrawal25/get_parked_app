// import 'package:getparked/UserInterface/Pages/RentOutSpace/RentOutSpaceDetailsForm.dart';
// import 'package:getparked/UserInterface/Pages/RentOutSpace/RentOutSpaceSlotForm.dart';
// import 'package:getparked/UserInterface/Pages/RentOutSpace/RentOutSpaceTermsAndCondition.dart';
// import 'package:flutter/material.dart';

// class RentOutSpacePage extends StatefulWidget {
//   @override
//   _RentOutSpacePageState createState() => _RentOutSpacePageState();
// }

// class _RentOutSpacePageState extends State<RentOutSpacePage>
//     with SingleTickerProviderStateMixin {
//   double gpFormPosition = 0;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Stack(
//         children: [
//           AnimatedPositioned(
//             left: MediaQuery.of(context).size.width * gpFormPosition,
//             width: MediaQuery.of(context).size.width * 3,
//             duration: Duration(
//               milliseconds: 500,
//             ),
//             curve: Curves.decelerate,
//             child: Row(
//               children: [
//                 Container(
//                   child: RentOutSpaceDetailsForm(onNextPressed: () {
//                     setState(() {
//                       gpFormPosition = -1;
//                     });
//                   }),
//                 ),
//                 Container(
//                   child: RentOutSpaceSlotForm(
//                     onPrevPressed: () {
//                       setState(() {
//                         gpFormPosition = 0;
//                       });
//                     },
//                     onNextPressed: () {
//                       setState(() {
//                         gpFormPosition = -2;
//                       });
//                     },
//                   ),
//                 ),
//                 Container(
//                   child: RentOutSpaceTermsAndCondition(
//                     onSubmitPressed: () {
//                       print("Submit Pressed..");
//                     },
//                   ),
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
