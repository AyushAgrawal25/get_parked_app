// import 'package:getparked/BussinessLogic/VehiclesUtils.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttericon/font_awesome5_icons.dart';
// import './../../Widgets/UnderLineTextFormField.dart';
// import './../../Icons/g_p_icons_icons.dart';
// import './../../Theme/AppTheme.dart';
// import 'package:google_fonts/google_fonts.dart';
// import './../../Widgets/RadioTileButton.dart';
// import './../../Widgets/EdgeLessButton.dart';

// class RentOutSpaceSlotForm extends StatefulWidget {

//   Function onPrevPressed;
//   Function onNextPressed;

//   RentOutSpaceSlotForm({
//     @required this.onPrevPressed,
//     @required this.onNextPressed
//   });

//   @override
//   _RentOutSpaceSlotFormState createState() => _RentOutSpaceSlotFormState();
// }

// class _RentOutSpaceSlotFormState extends State<RentOutSpaceSlotForm> {

//   List<DropdownMenuItem<String>> startTimeList=[];
//   String startTimeVal;

//   List<DropdownMenuItem<String>> endTimeList=[];
//   String endTimeVal;

//   List<DropdownMenuItem<String>> securityDepositHoursList=[];
//   String securityDepositHourVal;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();

//     initTimeDropDown();
//     setSecurityDepositHoursList();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Container(

//       height: MediaQuery.of(context).size.height,
//       width: MediaQuery.of(context).size.width,

//       child: Scaffold(

//         appBar: AppBar(
//           title: Text(
//             "Parking Slot Details",
//             style: GoogleFonts.roboto(
//               fontWeight: FontWeight.w500,
//               color: qbDetailDarkColor
//             ),
//             textScaleFactor: 1,
//           ),
//           backgroundColor: Colors.transparent,
//           elevation: 0.0,
//         ),

//         backgroundColor: Colors.white,

//         body: SingleChildScrollView(
//           child: Container(
//             alignment: Alignment.center,
//             padding: EdgeInsets.symmetric(
//               horizontal: 15
//             ),

//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [

//                 Container(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: 5
//                   ),
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     "Parking Dimensions",
//                     style: GoogleFonts.roboto(
//                       fontSize: 17.5,
//                       fontWeight: FontWeight.w500,
//                       color: qbAppTextColor
//                     ),
//                     textScaleFactor: 1,
//                   ),
//                 ),

//                 Row(
//                   children: [

//                     Expanded(
//                       child: UnderLineTextFormField(
//                         labelText: "Length",
//                         contentPadding: EdgeInsets.symmetric(
//                           vertical: 4,
//                           horizontal: 7.5
//                         ),
//                       ),
//                     ),

//                     Container(
//                       padding: EdgeInsets.only(
//                         top: 20
//                       ),
//                       child: Icon(
//                         FontAwesome5.times,
//                         size: 20,
//                         color: qbAppTextColor,
//                       ),
//                     ),

//                     Expanded(
//                       child: UnderLineTextFormField(
//                         labelText: "Length",
//                         contentPadding: EdgeInsets.symmetric(
//                           vertical: 4,
//                           horizontal: 7.5
//                         ),
//                       ),
//                     ),

//                     Container(
//                       padding: EdgeInsets.only(
//                         top: 20
//                       ),
//                       child: Icon(
//                         FontAwesome5.times,
//                         size: 20,
//                         color: qbAppTextColor,
//                       ),
//                     ),

//                     Expanded(
//                       child: UnderLineTextFormField(
//                         labelText: "Length",
//                         contentPadding: EdgeInsets.symmetric(
//                           vertical: 4,
//                           horizontal: 7.5
//                         ),
//                       ),
//                     ),

//                   ],
//                 ),

//                 //Vehicles Container
//                 Container(
//                   margin: EdgeInsets.only(
//                     top: 20,
//                     bottom: 5
//                   ),

//                   width: 360,

//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(7.5),
//                     color: Colors.white,
//                     boxShadow: [
//                       BoxShadow(
//                         blurRadius: 10,
//                         spreadRadius: 0.25,
//                         offset: Offset(2,4),
//                         color: Color.fromRGBO(0, 0, 0, 0.04)
//                       ),
//                       BoxShadow(
//                         blurRadius: 10,
//                         spreadRadius: 0.25,
//                         offset: Offset(-4,-2),
//                         color: Color.fromRGBO(0, 0, 0, 0.04)
//                       ),
//                     ]
//                   ),

//                   padding: EdgeInsets.only(
//                     top: 20,
//                     bottom: 15,
//                     left: 15,
//                     right: 10
//                   ),

//                   child: Column(
//                     children: [

//                       //Two Wheeler
//                       Container(
//                         alignment: Alignment.centerLeft,

//                         padding: EdgeInsets.symmetric(
//                           horizontal: 10,
//                           vertical: 5
//                         ),

//                         child: Text(
//                           "Select Vehicles Type",
//                           style: GoogleFonts.roboto(
//                             fontSize: 17.5,
//                             fontWeight: FontWeight.w500,
//                             color: qbDetailDarkColor
//                           ),
//                           textScaleFactor: 1,
//                         ),
//                       ),

//                       Container(
//                         padding: EdgeInsets.symmetric(
//                           horizontal: 10
//                         ),
//                         child: Column(
//                           children: [

//                             //Bike
//                             Container(
//                               child: VehicleCheckBox(
//                                 vehicleType: VehicleType.bike,
//                               ),
//                             ),

//                             //Mini
//                             Container(
//                               child: VehicleCheckBox(
//                                 vehicleType: VehicleType.mini,
//                               ),
//                             ),

//                             //Sedan
//                             Container(
//                               child: VehicleCheckBox(
//                                 vehicleType: VehicleType.sedan,
//                                 status: true,
//                               ),
//                             ),

//                             //Van
//                             Container(
//                               child: VehicleCheckBox(
//                                 vehicleType: VehicleType.van,
//                                 status: true,
//                               ),
//                             ),

//                             //SUV
//                             Container(
//                               child: VehicleCheckBox(
//                                 vehicleType: VehicleType.suv,
//                                 status: true,
//                               ),
//                             ),

//                           ],
//                         ),
//                       )

//                     ],
//                   ),
//                 ),

//                 //Timing
//                 Container(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: 5,
//                     vertical: 5
//                   ),
//                   child: Row(
//                     children: [

//                       Container(
//                         alignment: Alignment.centerLeft,
//                         child: Text(
//                           "Parking Time",
//                           style: GoogleFonts.roboto(
//                             fontSize: 17.5,
//                             fontWeight: FontWeight.w500,
//                             color: qbAppTextColor
//                           ),
//                           textScaleFactor: 1,
//                         ),
//                       ),

//                       SizedBox(
//                         width: 5,
//                       ),

//                       Container(
//                         width: 80,
//                         height: 45,
//                         child: DropdownButton(
//                           value: startTimeVal,
//                           items: startTimeList,
//                           onChanged: (value){
//                             print(value);
//                             setState(() {
//                               startTimeVal=value;
//                             });

//                             setEndTimeList(value);
//                           },

//                         ),
//                       ),

//                       Container(
//                         padding: EdgeInsets.symmetric(
//                           horizontal: 5
//                         ),
//                         child: Text(
//                           "To",
//                           style: GoogleFonts.roboto(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w500,
//                             color: qbAppTextColor
//                           ),
//                           textScaleFactor: 1,
//                         ),
//                       ),

//                       Container(
//                         width: 80,
//                         child: DropdownButton(
//                           value: endTimeVal,
//                           items: endTimeList,
//                           onChanged: (value){
//                             print(value);
//                             setState(() {
//                               endTimeVal=value;
//                             });
//                           },

//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 //Parking Space Type
//                 Container(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: 5,
//                     vertical: 5
//                   ),
//                   alignment: Alignment.centerLeft,

//                   child: Text(
//                     "Parking Space Type",
//                     style: GoogleFonts.roboto(
//                       fontSize: 17.5,
//                       fontWeight: FontWeight.w500,
//                       color: qbAppTextColor
//                     ),
//                     textScaleFactor: 1,
//                   ),
//                 ),

//                 Container(
//                   padding: EdgeInsets.symmetric(
//                     vertical: 5,
//                   ),
//                   child: Row(
//                     children: [

//                       Expanded(
//                         child: RadioTileButton(
//                           value: "inside",
//                           groupValue: "Outside",
//                           title: Text(
//                             "Inside",
//                             style: GoogleFonts.roboto(
//                               fontSize: 12.5,
//                               fontWeight: FontWeight.w500,
//                               color: qbAppTextColor
//                             ),
//                             textScaleFactor: 1,
//                           ),

//                           onChanged: (value){},
//                         ),
//                       ),

//                       Expanded(
//                         child: RadioTileButton(
//                           value: "inside",
//                           groupValue: "Outside",
//                           title: Text(
//                             "Outside",
//                             style: GoogleFonts.roboto(
//                               fontSize: 12.5,
//                               fontWeight: FontWeight.w500,
//                               color: qbAppTextColor
//                             ),
//                             textScaleFactor: 1,
//                           ),

//                           onChanged: (value){},
//                         ),
//                       ),

//                       Expanded(
//                         child: RadioTileButton(
//                           value: "inside",
//                           groupValue: "Outside",
//                           title: Text(
//                             "Both",
//                             style: GoogleFonts.roboto(
//                               fontSize: 12.5,
//                               fontWeight: FontWeight.w500,
//                               color: qbAppTextColor
//                             ),
//                             textScaleFactor: 1,
//                           ),

//                           onChanged: (value){},
//                         ),
//                       ),

//                     ],
//                   ),
//                 ),

//                 //Parking Security Deposit
//                 Row(
//                   children: [
//                     Container(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 5,
//                         vertical: 5
//                       ),
//                       alignment: Alignment.centerLeft,

//                       child: Text(
//                         "Parking Security Deposit Fair :",
//                         style: GoogleFonts.roboto(
//                           fontSize: 17.5,
//                           fontWeight: FontWeight.w500,
//                           color: qbAppTextColor
//                         ),
//                         textScaleFactor: 1,
//                       ),
//                     ),

//                     Container(
//                       width: 80,
//                       height: 45,
//                       child: DropdownButton(

//                         value: securityDepositHourVal,
//                         items: securityDepositHoursList,

//                         onChanged: (value){
//                           print(value);
//                           setState(() {
//                             securityDepositHourVal=value;
//                           });
//                         },
//                       ),
//                     ),

//                   ],
//                 ),

//                 Container(
//                   padding: EdgeInsets.only(
//                     bottom: 10,
//                     right: 5,
//                     left: 5
//                   ),
//                   child: Text(
//                     "User have to deposit parking charges for your selected number hours as security deposit.",
//                     style: GoogleFonts.roboto(
//                       fontSize: 12.5,
//                       fontWeight: FontWeight.w500,
//                       color: qbDetailLightColor
//                     ),
//                   ),
//                 ),

//                 Container(

//                   alignment: Alignment.bottomCenter,
//                   padding: EdgeInsets.only(
//                     left: 5,
//                     right: 5,
//                     top: 10,
//                     bottom: 10
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [

//                       //Prev
//                       EdgeLessButton(
//                         color: Colors.blue.shade600,
//                         onPressed: (){
//                           widget.onPrevPressed();
//                         },

//                         padding: EdgeInsets.only(
//                           top: 7.5,
//                           bottom: 7.5,
//                           left: 15,
//                           right: 22.5
//                         ),
//                         child: Row(
//                           children: [

//                             Icon(
//                               Icons.arrow_back,
//                               color: Colors.white,
//                             ),

//                             SizedBox(
//                               width: 5,
//                             ),

//                             Text(
//                               "Prev",
//                               style: GoogleFonts.roboto(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.white
//                               ),
//                               textScaleFactor: 1,
//                             )
//                           ],
//                         ),
//                       ),
//                       //Prev
//                       EdgeLessButton(
//                         color: Colors.blue.shade600,
//                         onPressed: (){
//                           widget.onNextPressed();
//                         },

//                         padding: EdgeInsets.only(
//                           top: 7.5,
//                           bottom: 7.5,
//                           left: 22.5,
//                           right: 15
//                         ),
//                         child: Row(
//                           children: [

//                             Text(
//                               "Next",
//                               style: GoogleFonts.roboto(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w500,
//                                 color: Colors.white
//                               ),
//                               textScaleFactor: 1,
//                             ),

//                             SizedBox(
//                               width: 5,
//                             ),

//                             Icon(
//                               Icons.arrow_forward,
//                               color: Colors.white,
//                             ),
//                           ],
//                         ),
//                       ),

//                     ],
//                   ),
//                 ),

//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   //Start Time Drop Down
//   initTimeDropDown(){

//     startTimeList.add(
//       DropdownMenuItem(
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal:10),
//           child: Text(
//             "Time",
//             style: GoogleFonts.roboto(
//               fontSize: 12.5,
//               fontWeight: FontWeight.w500,
//               color: qbAppTextColor
//             ),
//             textScaleFactor: 1,
//           ),
//         ),
//       )
//     );

//     endTimeList.add(
//       DropdownMenuItem(
//         value: null,
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 10),
//           child: Text(
//             "Time",
//             style: GoogleFonts.roboto(
//               fontSize: 12.5,
//               fontWeight: FontWeight.w500,
//               color: qbAppTextColor
//             ),
//             textScaleFactor: 1,
//           ),
//         ),
//       )
//     );

//     var timeType="pm";
//     for(var i=0; i<24; i++)
//     {
//       var timeVal=(i%12).toString();
//       if(i%12==0)
//       {
//         if(timeType=="am")
//         {
//           timeType="pm";
//         }
//         else
//         {
//           timeType="am";
//         }

//         timeVal="12";
//       }

//       //print(timeVal+" "+timeType);

//       startTimeList.add(
//         DropdownMenuItem(
//           value: i.toString(),
//           child: Container(
//             padding: EdgeInsets.symmetric(horizontal: 10),
//             child: Text(
//               timeVal+" "+timeType,
//               style: GoogleFonts.roboto(
//                 fontSize: 12.5,
//                 fontWeight: FontWeight.w400,
//                 color: qbAppTextColor
//               ),
//               textScaleFactor: 1,
//             ),
//           ),
//         )
//       );

//     }
//   }

//   //End Time Drop Down
//   setEndTimeList(startTimeString){
//     setState(() {
//       endTimeVal=null;
//     });

//     endTimeList=[];
//     endTimeList.add(
//       DropdownMenuItem(
//         value: null,
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 10),
//           child: Text(
//             "Time",
//             style: GoogleFonts.roboto(
//               fontSize: 12.5,
//               fontWeight: FontWeight.w500,
//               color: qbAppTextColor
//             ),
//             textScaleFactor: 1,
//           ),
//         ),
//       )
//     );

//     var startTimeInt=int.parse(startTimeString)+1;

//     var timeType;
//     if(startTimeInt>12)
//     {
//       timeType="pm";
//     }
//     else
//     {
//       timeType="am";
//     }

//     for(var i=startTimeInt; i<24; i++)
//     {
//       var timeVal=(i%12).toString();
//       if(i%12==0)
//       {
//         if(timeType=="am")
//         {
//           timeType="pm";
//         }
//         else
//         {
//           timeType="am";
//         }

//         timeVal="12";
//       }

//       //print(timeVal+" "+timeType);

//       endTimeList.add(
//         DropdownMenuItem(
//           value: i.toString(),
//           child: Container(
//             padding: EdgeInsets.symmetric(horizontal: 10),
//             child: Text(
//               timeVal+" "+timeType,
//               style: GoogleFonts.roboto(
//                 fontSize: 12.5,
//                 fontWeight: FontWeight.w400,
//                 color: qbAppTextColor
//               ),
//               textScaleFactor: 1,
//             ),
//           ),
//         )
//       );

//     }

//   }

//   setSecurityDepositHoursList(){

//     securityDepositHoursList.add(
//       DropdownMenuItem(
//         child: Container(
//           padding: EdgeInsets.symmetric(
//             horizontal:10,
//             vertical: 2.5
//           ),
//           child: Text(
//             "Time",
//             style: GoogleFonts.roboto(
//               fontSize: 12.5,
//               fontWeight: FontWeight.w500,
//               color: qbAppTextColor
//             ),
//             textScaleFactor: 1,
//           ),
//         ),
//       )
//     );

//     for(var i=1; i<25; i++){
//       securityDepositHoursList.add(
//         DropdownMenuItem(
//           value: i.toString(),
//           child: Container(
//             padding: EdgeInsets.symmetric(horizontal: 10),
//             child: Text(
//               "$i hr",
//               style: GoogleFonts.roboto(
//                 fontSize: 12.5,
//                 fontWeight: FontWeight.w400,
//                 color: qbAppTextColor
//               ),
//               textScaleFactor: 1,
//             ),
//           ),
//         )
//       );
//     }
//   }
// }

// class VehicleCheckBox extends StatefulWidget {

//   VehicleType vehicleType;
//   bool status;

//   VehicleCheckBox({
//     this.vehicleType:VehicleType.bike,
//     this.status:true
//   });

//   @override
//   _VehicleCheckBoxState createState() => _VehicleCheckBoxState();
// }

// class _VehicleCheckBoxState extends State<VehicleCheckBox> {

//   IconData vehicleName;
//   String name;
//   double iconSize;
//   double iconBoxWidth;

//   EdgeInsets iconPadding=EdgeInsets.only(
//     right: 0
//   );

//   Color statusColor;

//   @override
//   Widget build(BuildContext context) {

//     iconBoxWidth=60;

//     if(widget.status){
//       statusColor=qbDetailDarkColor;
//     }
//     else{
//       statusColor=qbDetailLightColor;
//     }

//     if(widget.vehicleType==VehicleType.bike){
//       setState(() {
//         name="Bike";
//         vehicleName=GPIcons.bike;
//         iconSize=20;
//       });
//     }
//     else if(widget.vehicleType==VehicleType.mini){
//       setState(() {
//         name="Mini";
//         vehicleName=GPIcons.hatch_back_car;
//         iconSize=17.5;
//       });
//     }
//     else if(widget.vehicleType==VehicleType.sedan){
//       setState(() {
//         name="Sedan";
//         vehicleName=GPIcons.sedan_car;
//         iconSize=16;
//       });
//     }
//     else if(widget.vehicleType==VehicleType.suv){
//       setState(() {
//         name="SUV";
//         vehicleName=GPIcons.suv_car;
//         iconSize=18;
//       });
//     }
//     else if(widget.vehicleType==VehicleType.van){
//       setState(() {
//         name="Van";
//         vehicleName=GPIcons.van;
//         iconSize=18;
//       });
//     }

//     if(widget.status){
//       return Container(

//         margin: EdgeInsets.only(
//           top: 2.5,
//           bottom: 2.5,
//         ),

//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(3.5),
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               blurRadius: 1,
//               spreadRadius: 0.15,
//               color: Color.fromRGBO(0, 0, 0, 0.04),
//               offset: Offset(2,2)
//             ),
//             BoxShadow(
//               blurRadius: 1,
//               spreadRadius: 0.15,
//               color: Color.fromRGBO(0, 0, 0, 0.04),
//               offset: Offset(-2,-2)
//             ),
//           ]
//         ),

//         height: 50,
//         padding: EdgeInsets.only(
//           top: 5,
//           bottom: 5,
//           left: 20,
//           right: 5
//         ),

//         child: Row(
//           children: [

//             Container(
//               padding: iconPadding,
//               width: iconBoxWidth,
//               alignment: Alignment.centerLeft,
//               child: Icon(
//                 vehicleName,
//                 size: iconSize,
//                 color: statusColor,
//               ),
//             ),

//             Expanded(
//               child: Container(
//                 child: Text(
//                   name,
//                   style: GoogleFonts.roboto(
//                     fontSize: 15,
//                     fontWeight: FontWeight.w700,
//                     color: statusColor
//                   ),
//                   textScaleFactor: 1,
//                 ),
//               ),
//             ),

//             Container(
//               child: Text(
//                 "Fair : Rs ",
//                 style: GoogleFonts.roboto(
//                   fontSize: 13.5,
//                   fontWeight: FontWeight.w500,
//                   color: qbAppTextColor
//                 ),
//               ),
//             ),

//             Container(
//               height: 22.5,
//               width: 40,

//               child: TextField(

//                 style: GoogleFonts.roboto(
//                   fontSize: 12.5
//                 ),

//                 textAlign: TextAlign.center,
//                 decoration: InputDecoration(
//                   contentPadding: EdgeInsets.symmetric(
//                     horizontal: 2.5
//                   ),

//                   border: OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Colors.white
//                     )
//                   ),

//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Colors.white
//                     )
//                   ),

//                   enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Colors.white
//                     )
//                   ),

//                   fillColor: Color.fromRGBO(230, 230, 230, 1),
//                   filled: true,

//                   isDense: false,
//                 ),
//               ),
//             ),

//             Container(
//               child: Checkbox(
//                 value: true,
//                 onChanged: (value){},
//               )
//             )

//           ],
//         ),
//       );

//     }

//     else{

//       return Container(

//         margin: EdgeInsets.only(
//           top: 2.5,
//           bottom: 2.5,
//         ),

//         padding: EdgeInsets.only(
//           left: 20,
//           right: 20
//         ),

//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(2.5),
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               blurRadius: 1,
//               spreadRadius: 0.15,
//               color: Color.fromRGBO(0, 0, 0, 0.04),
//               offset: Offset(2,2)
//             ),
//             BoxShadow(
//               blurRadius: 1,
//               spreadRadius: 0.15,
//               color: Color.fromRGBO(0, 0, 0, 0.04),
//               offset: Offset(-2,-2)
//             ),
//           ]
//         ),

//         height: 50,
//         alignment: Alignment.centerLeft,
//         child: Text(
//           "Your Space is not eligible for $name",
//           style: GoogleFonts.roboto(
//             fontSize: 12.5,
//             fontWeight: FontWeight.w700,
//             color: statusColor
//           ),
//           textScaleFactor: 1,
//         ),

//       );
//     }
//   }

// }
