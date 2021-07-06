import 'package:getparked/StateManagement/Models/VehicleData.dart';
import 'package:getparked/StateManagement/Models/RatingReviewData.dart';
import 'package:getparked/StateManagement/Models/ReviewData.dart';
import 'package:getparked/StateManagement/Models/VehicleTypeData.dart';
import 'package:getparked/UserInterface/Icons/g_p_icons_icons.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/CustomIcon.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:getparked/UserInterface/Widgets/Rating/RatingWidget.dart';

class VehicleRatingWidget extends StatelessWidget {
  final VehicleType vehicleType;
  final double rating;
  VehicleRatingWidget({@required this.rating, @required this.vehicleType});
  @override
  Widget build(BuildContext context) {
    double ratingWidth = 100;
    IconData vehicleIcon = GPIcons.bike;
    String vehicleName = "Bike";
    double horiPadding = 35;

    switch (this.vehicleType) {
      case VehicleType.bike:
        vehicleName = "Bike";
        vehicleIcon = GPIcons.bike_bag;
        break;
      case VehicleType.mini:
        vehicleName = "Mini";
        vehicleIcon = GPIcons.hatch_back_car;
        break;
      case VehicleType.sedan:
        vehicleName = "Sedan";
        vehicleIcon = GPIcons.sedan_car;
        break;
      case VehicleType.van:
        vehicleName = "Van";
        vehicleIcon = GPIcons.van;
        break;
      case VehicleType.suv:
        vehicleName = "Suv";
        vehicleIcon = GPIcons.suv_car;
        break;
    }

    // return Container(
    //   child: Column(
    //     mainAxisSize: MainAxisSize.min,
    //     children: [
    //       SizedBox(
    //         height: 20,
    //       ),

    //       // Major Row
    //       Container(
    //         padding: EdgeInsets.symmetric(horizontal: horiPadding),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             // Icon
    //             Container(
    //               child: CustomIcon(
    //                 icon: vehicleIcon,
    //                 size: 25,
    //                 type: CustomIconType.onHeight,
    //                 color: qbAppTextColor,
    //               ),
    //             ),

    //             // Rating Val
    //             Container(
    //               width: ratingWidth,
    //               child: Text(
    //                 this.rating.toStringAsFixed(1),
    //                 style: GoogleFonts.notoSans(
    //                     fontSize: 20,
    //                     color: qbAppTextColor,
    //                     fontWeight: FontWeight.w600),
    //                 textScaleFactor: 1.0,
    //                 textAlign: TextAlign.center,
    //               ),
    //             )
    //           ],
    //         ),
    //       ),

    //       SizedBox(
    //         height: 5,
    //       ),

    //       // Name And Rating in stars
    //       Container(
    //         padding: EdgeInsets.symmetric(horizontal: horiPadding),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             // Vehicle Name
    //             Container(
    //               child: Text(
    //                 vehicleName,
    //                 style: GoogleFonts.nunito(
    //                     fontSize: 17.5,
    //                     color: qbAppTextColor,
    //                     fontWeight: FontWeight.w600),
    //                 textScaleFactor: 1.0,
    //                 textAlign: TextAlign.left,
    //               ),
    //             ),

    //             // Rating in stars
    //             Container(
    //               width: ratingWidth,
    //               child: RatingWidget(
    //                 ratingValue: this.rating,
    //                 fontSize: 17.5,
    //                 iconSize: 17.5,
    //                 toShowRatingText: false,
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),

    //       Divider(
    //         height: 20,
    //         thickness: 1.5,
    //         color: qbDividerDarkColor,
    //       )
    //     ],
    //   ),
    // );

    double vNWidgetHeight = 50;
    double widgetHeight = 250;
    return Align(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Container(
            alignment: Alignment.center,
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(
                      vertical: vNWidgetHeight / 2,
                      horizontal: vNWidgetHeight / 2),
                  padding: EdgeInsets.symmetric(
                      vertical: vNWidgetHeight / 2,
                      horizontal: vNWidgetHeight / 2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.5),
                      border:
                          Border.all(color: qbDividerDarkColor, width: 1.5)),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Vehilce And Rating
                        Container(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Vehicle
                              Container(
                                child: CustomIcon(
                                  icon: vehicleIcon,
                                  size: 35,
                                  color: qbDetailDarkColor,
                                  type: CustomIconType.onHeight,
                                ),
                              ),

                              SizedBox(
                                height: 12.5,
                              ),

                              // Rating
                              Container(
                                child: RatingWidget(
                                  ratingValue: this.rating.toDouble(),
                                  toShowRatingText: false,
                                  iconSize: 17.5,
                                ),
                              )
                            ],
                          ),
                        ),

                        // Rating Num
                        Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(360),
                              border: Border.all(
                                  color: qbAppPrimaryBlueColor, width: 3.5)),
                          child: Container(
                            child: Text(
                              this.rating.toStringAsFixed(1),
                              style: GoogleFonts.nunito(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                  color: qbAppPrimaryBlueColor),
                              textScaleFactor: 1.0,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: vNWidgetHeight,
                    alignment: Alignment(-0.65, 0),
                    child: Container(
                      width: 70,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      color: qbWhiteBGColor,
                      alignment: Alignment.center,
                      child: Text(
                        vehicleName,
                        style: GoogleFonts.nunito(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: qbAppTextColor),
                        textScaleFactor: 1.0,
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
