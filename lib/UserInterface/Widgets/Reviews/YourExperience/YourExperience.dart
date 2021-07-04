import 'package:getparked/Utils/FlushBarUtils.dart';
import 'package:getparked/Utils/ToastUtils.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/StateManagement/Models/SlotData.dart';
import 'package:getparked/UserInterface/Icons/g_p_icons_icons.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/EdgeLessButton.dart';
import 'package:getparked/UserInterface/Widgets/FormFieldHeader.dart';
import 'package:getparked/UserInterface/Widgets/Rating/RatingsButton.dart';
import 'package:getparked/UserInterface/Widgets/SlotInfoWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class YourExperience extends StatefulWidget {
  final Function(bool) changeLoadStatus;
  final Function exit;
  final SlotData slotData;
  final int parkingId;
  final int vehicleTypeMasterId;
  YourExperience(
      {@required this.changeLoadStatus,
      @required this.exit,
      @required this.parkingId,
      @required this.vehicleTypeMasterId,
      @required this.slotData});
  @override
  _YourExperienceState createState() => _YourExperienceState();
}

class _YourExperienceState extends State<YourExperience> {
  AppState gpAppState;

  int gpRatingValue;
  TextEditingController gpReviewTextController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gpAppState = Provider.of<AppState>(context, listen: false);
    gpRatingValue = 0;
    gpReviewTextController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    IconData vehicleIcon = GPIcons.hatch_back_car;
    return Container(
      color: qbWhiteBGColor,
      child: SafeArea(
          child: Scaffold(
              appBar: AppBar(
                title: Text(
                  "Your Experience",
                  style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w600, color: qbAppTextColor),
                  textScaleFactor: 1.0,
                ),
                backgroundColor: Colors.transparent,
                iconTheme: IconThemeData(color: qbAppTextColor),
                elevation: 0.0,
              ),
              body: Container(
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Slot Info
                        SlotInfoWidget(slotData: widget.slotData),

                        Divider(
                          height: 20,
                          thickness: 0.5,
                          color: qbDetailLightColor,
                        ),

                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 7.5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Rating
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Rating Header
                                    FormFieldHeader(
                                      headerText: "Rate Your Experience",
                                      fontSize: 20,
                                    ),

                                    SizedBox(
                                      height: 2.5,
                                    ),

                                    // Ratings Button
                                    RatingsButton(
                                      onRate: onRateChange,
                                    ),
                                  ],
                                ),
                              ),

                              // Review
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: TextField(
                                  style: GoogleFonts.roboto(
                                      fontSize: 17.5 /
                                          MediaQuery.of(context)
                                              .textScaleFactor,
                                      fontWeight: FontWeight.w400,
                                      color: qbAppTextColor),
                                  onChanged: (value) {
                                    setState(() {
                                      // note = value;
                                    });
                                  },
                                  controller: gpReviewTextController,
                                  maxLines: 5,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: qbAppTextColor),
                                        borderRadius:
                                            BorderRadius.circular(7.5)),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 12.5, horizontal: 20),
                                  ),
                                ),
                              ),

                              // Continue Button
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 12.5),
                                alignment: Alignment.center,
                                child: EdgeLessButton(
                                  width: 240,
                                  color: (gpRatingValue == 0)
                                      ? qbDividerDarkColor
                                      : qbAppPrimaryBlueColor,
                                  padding: EdgeInsets.symmetric(vertical: 7.5),
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Continue",
                                      style: GoogleFonts.nunito(
                                          fontSize: 17.5,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                      textScaleFactor: 1.0,
                                    ),
                                  ),
                                  onPressed: onContinuePressed,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ))),
    );
  }

  onRateChange(int ratingValue) {
    setState(() {
      gpRatingValue = ratingValue;
    });
  }

  onContinuePressed() async {
    // TODO: Uncomment when ready.
    // if (gpRatingValue == 0) {
    //   FlushBarUtils.showTextResponsive(
    //       context, "Rate please..", "Your rating is helpful.");
    // } else {
    //   widget.changeLoadStatus(true);

    //   if ((gpReviewTextController.text != null) &&
    //       (gpReviewTextController.text != "")) {
    //     await RatingsAndReviewsUtils().postRatingAndReview(
    //         userId: gpAppState.userData.id,
    //         userAccessToken: gpAppState.userData.accessToken,
    //         parkingId: widget.parkingId,
    //         ratingValue: gpRatingValue,
    //         reviewText: gpReviewTextController.text,
    //         vehicleTypeMasterId: widget.vehicleTypeMasterId,
    //         slotId: widget.slotData.id);
    //   } else {
    //     await RatingsAndReviewsUtils().postRating(
    //         userId: gpAppState.userData.id,
    //         userAccessToken: gpAppState.userData.accessToken,
    //         slotId: widget.slotData.id,
    //         parkingId: widget.parkingId,
    //         vehicleTypeMasterId: widget.vehicleTypeMasterId,
    //         ratingValue: gpRatingValue);
    //   }

    //   widget.exit();
    // }
  }
}
