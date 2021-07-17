import 'package:flutter/material.dart';
import 'package:getparked/StateManagement/Models/VehicleData.dart';
import 'package:getparked/StateManagement/Models/VehicleTypeData.dart';
import 'package:getparked/UserInterface/Icons/g_p_icons_icons.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/CustomIcon.dart';
import 'package:getparked/UserInterface/Widgets/FormFieldHeader.dart';
import 'package:google_fonts/google_fonts.dart';

class VehicleSettingCard extends StatefulWidget {
  final VehicleData vehicleData;

  VehicleSettingCard({@required this.vehicleData});
  @override
  _VehicleSettingCardState createState() => _VehicleSettingCardState();
}

class _VehicleSettingCardState extends State<VehicleSettingCard> {
  @override
  Widget build(BuildContext context) {
    IconData vehicleIcon = GPIcons.bike;
    switch (widget.vehicleData.type) {
      case VehicleType.bike:
        vehicleIcon = GPIcons.bike_bag;
        break;
      case VehicleType.mini:
        vehicleIcon = GPIcons.hatch_back_car;
        break;
      case VehicleType.sedan:
        vehicleIcon = GPIcons.sedan_car;
        break;
      case VehicleType.van:
        vehicleIcon = GPIcons.van;
        break;
      case VehicleType.suv:
        vehicleIcon = GPIcons.suv_car;
        break;
    }

    //  Design One
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      color: Colors.transparent,
      child: Column(
        children: [
          Divider(
            color: qbDividerLightColor,
            thickness: 1.5,
            height: 2.5,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 18.5, horizontal: 10),
            child: Row(children: [
              // Icon
              Container(
                width: 75,
                alignment: Alignment.center,
                child: Column(
                  children: [
                    CustomIcon(
                      icon: vehicleIcon,
                      color: qbAppTextColor,
                      size: 17.5,
                      type: CustomIconType.onHeight,
                    ),
                    Container(
                      child: FormFieldHeader(
                        headerText: widget.vehicleData.typeData.name,
                        fontSize: 12.5,
                        color: qbAppTextColor,
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(width: 10),

              Expanded(
                child: Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          child: Text(
                        "Fair : ",
                        style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: qbDetailDarkColor),
                        textAlign: TextAlign.left,
                        textScaleFactor: 1.0,
                      )),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                          child: Text(
                        "₹ ${widget.vehicleData.fair.toStringAsFixed(2)}/-",
                        style: GoogleFonts.notoSans(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: qbDetailDarkColor),
                        textAlign: TextAlign.left,
                        textScaleFactor: 1.0,
                      )),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                          child: Text(
                        "Per Hour",
                        style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: qbDetailDarkColor),
                        textAlign: TextAlign.left,
                        textScaleFactor: 1.0,
                      )),
                    ],
                  ),
                ),
              )
            ]),
          ),
          Divider(
            color: qbDividerLightColor,
            thickness: 1.5,
            height: 2.5,
          ),
        ],
      ),
    );

    //  Design Two
    // return Container(
    //   margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
    //   decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(3.5),
    //       boxShadow: [
    //         BoxShadow(
    //             spreadRadius: 0.025,
    //             blurRadius: 5,
    //             offset: Offset(10, 5),
    //             color: Color.fromRGBO(0, 0, 0, 0.04)),
    //       ],
    //       color: qbWhiteBGColor),
    //   padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
    //   child: Row(children: [
    //     // Icon
    //     Container(
    //       width: 60,
    //       alignment: Alignment.center,
    //       child: Column(
    //         children: [
    //           CustomIcon(
    //             icon: vehicleIcon,
    //             color: qbAppTextColor,
    //             size: 17.5,
    //             type: CustomIconType.onHeight,
    //           ),
    //           Container(
    //             child: FormFieldHeader(
    //               headerText: widget.vehicleData.typeData.name,
    //               fontSize: 12.5,
    //               color: qbAppTextColor,
    //             ),
    //           )
    //         ],
    //       ),
    //     ),

    //     SizedBox(width: 17.5),

    //     Expanded(
    //       child: Container(
    //         child: Row(
    //           mainAxisSize: MainAxisSize.min,
    //           children: [
    //             Container(
    //                 child: Text(
    //               "Fair : ",
    //               style: GoogleFonts.poppins(
    //                   fontSize: 13.5,
    //                   fontWeight: FontWeight.w500,
    //                   color: qbDetailDarkColor),
    //               textAlign: TextAlign.left,
    //               textScaleFactor: 1.0,
    //             )),
    //             SizedBox(
    //               width: 5,
    //             ),
    //             Container(
    //                 child: Text(
    //               "₹ ${widget.vehicleData.fair.toStringAsFixed(2)}/-",
    //               style: GoogleFonts.notoSans(
    //                   fontSize: 13.5,
    //                   fontWeight: FontWeight.w600,
    //                   color: qbDetailDarkColor),
    //               textAlign: TextAlign.left,
    //               textScaleFactor: 1.0,
    //             )),
    //             SizedBox(
    //               width: 5,
    //             ),
    //             Container(
    //                 child: Text(
    //               "Per Hour",
    //               style: GoogleFonts.poppins(
    //                   fontSize: 13.5,
    //                   fontWeight: FontWeight.w500,
    //                   color: qbDetailDarkColor),
    //               textAlign: TextAlign.left,
    //               textScaleFactor: 1.0,
    //             )),
    //           ],
    //         ),
    //       ),
    //     )
    //   ]),
    // );
  }
}
