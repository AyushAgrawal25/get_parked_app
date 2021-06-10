import 'package:getparked/Utils/DomainUtils.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/UserInterface/Icons/g_p_icons_icons.dart';
import 'package:getparked/UserInterface/Widgets/Loaders/LoaderPage.dart';
import 'package:getparked/UserInterface/Widgets/SuccessAndFailure/SuccessAndFailurePage.dart';
import 'package:getparked/UserInterface/Widgets/EdgeLessButton.dart';
import 'package:getparked/UserInterface/Widgets/ErrorPopUp.dart';
import 'package:getparked/UserInterface/Widgets/FormFieldHeader.dart';
import 'package:provider/provider.dart';
import '../../../Theme/AppOverlayStyle.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/CustomIcon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:getparked/StateManagement/Models/SlotData.dart';

class RentOutSpaceTermsAndConditions extends StatefulWidget {
  SlotData slotData;
  Function(SlotData) onAgree;
  RentOutSpaceTermsAndConditions(
      {@required this.onAgree, @required this.slotData});
  @override
  _RentOutSpaceTermsAndConditionsState createState() =>
      _RentOutSpaceTermsAndConditionsState();
}

class _RentOutSpaceTermsAndConditionsState
    extends State<RentOutSpaceTermsAndConditions> {
  AppState gpAppState;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gpAppState = Provider.of(context, listen: false);

    initHrsDropDown();
  }

  bool isLoading = false;
  loadHandler(bool status) {
    setState(() {
      isLoading = status;
    });
  }

  bool isFormEntriesValid = true;

  Widget securityHrsInfoWidget = Container(
    height: 0,
    width: 0,
  );
  setSecurityHrsInfoWidget() {
    securityHrsInfoWidget = Container(
      child: Column(
        children: [
          TermDisplayWidget(
              term:
                  "Security deposit is the minimum amount that a user must have in it's wallet before booking."),
          TermDisplayWidget(
              term:
                  "Secuity Deposit is the product of number of hours (selected from the list by you) and parking fair of the vehicle type selcted by the user.")
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> hrsList = [];
  String hrsValue;
  int gpSecurityHrsValue;

  Widget securityHrsWidget = Container(
    height: 0,
    width: 0,
  );
  setSecurityHrsWidget() {
    securityHrsWidget = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          child: Row(
            children: [
              FormFieldHeader(
                headerText: "Select number of hours : ",
                fontSize: 15,
              ),
              Container(
                width: 100,
                height: 45,
                child: DropdownButton(
                  value: hrsValue,
                  items: hrsList,
                  onChanged: (value) {
                    if (value != null) {
                      gpSecurityHrsValue = int.parse(value);
                      setState(() {
                        hrsValue = value;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget bookingTermsWidget = Container(
    height: 0,
    width: 0,
  );
  setBookingTermsWidget() {
    List<String> bookingTerms = [
      "$appName works as a mediator between the user and the parking lord.",
      "Security deposit is the maximum amount that $appName can provide to the parking lord after the parking completed and its the minimum amount that the user must have in its wallet.",
      "$appName will not be responsible for any damages caused during the proccess."
    ];

    List<Widget> bookingTermsList = [];
    for (int i = 0; i < bookingTerms.length; i++) {
      bookingTermsList.add(TermDisplayWidget(
        term: bookingTerms[i],
      ));
    }

    bookingTermsWidget = Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: bookingTermsList,
      ),
    );
  }

  Widget iAgreeBtn = Container(
    height: 0,
    width: 0,
  );
  setIAgreeBtn() {
    iAgreeBtn = Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 2.5),
        child: EdgeLessButton(
            child: Text(
              "I Agree",
              style: GoogleFonts.nunito(
                  fontSize: 16.5,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
              textAlign: TextAlign.center,
              textScaleFactor: 1.0,
            ),
            color: (isFormEntriesValid)
                ? qbAppPrimaryBlueColor
                : qbDividerDarkColor,
            width: MediaQuery.of(context).size.width * 0.6,
            padding: EdgeInsets.symmetric(vertical: 8.5),
            onPressed: onAgreePressed));
  }

  checkFormValidity() {
    isFormEntriesValid = true;

    if ((gpSecurityHrsValue == null) || (gpSecurityHrsValue == 0)) {
      isFormEntriesValid = false;
    }
  }

  onAgreePressed() async {
    if (isFormEntriesValid) {
      SlotData gpSlotData = widget.slotData;
      gpSlotData.securityDepositHours = gpSecurityHrsValue;

      loadHandler(true);
      bool postStatus = await widget.onAgree(gpSlotData);
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return SuccessAndFailurePage(
            buttonText: "Continue",
            status: (postStatus)
                ? SuccessAndFailureStatus.success
                : SuccessAndFailureStatus.failure,
            statusText: "Parking Lord Registration",
            onButtonPressed: () {
              onContinuePressed(postStatus);
            },
          );
        },
      ));
      loadHandler(false);
    } else {
      ErrorPopUp().show("Please Enter Security Deposit Hours", context,
          errorMoreDetails: "Security Deposit Hours is essential for parking.");
    }
  }

  onContinuePressed(bool postStatus) {
    Navigator.of(context).pop();
    if (postStatus) {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    checkFormValidity();
    setSecurityHrsInfoWidget();
    setSecurityHrsWidget();
    setBookingTermsWidget();
    setIAgreeBtn();
    return Container(
      color: Color.fromRGBO(250, 250, 250, 1),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SafeArea(
        top: false,
        maintainBottomViewPadding: true,
        child: Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    CustomIcon(
                      icon: GPIcons.rent_out_space,
                      size: 25,
                      color: qbAppTextColor,
                    ),
                    SizedBox(
                      width: 7.5,
                    ),
                    Container(
                      child: Text(
                        "Terms And Conditions",
                        style: GoogleFonts.nunito(
                            fontWeight: FontWeight.w600, color: qbAppTextColor),
                        textScaleFactor: 1.0,
                      ),
                    )
                  ],
                ),

                // Decoration
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                brightness: Brightness.light,
                iconTheme: IconThemeData(
                  color: qbAppTextColor,
                ),
              ),
              body: Container(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Security Deposit Header
                        FormFieldHeader(headerText: "Security Deposit Hours"),

                        // Security Deposit Info
                        securityHrsInfoWidget,

                        // Security Deposit Widget
                        securityHrsWidget,

                        // Booking Terms Header
                        FormFieldHeader(headerText: "Booking Terms"),

                        // Booking Terms Widget
                        bookingTermsWidget,
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // I Agree Btn Button
            Align(
              alignment: Alignment.bottomCenter,
              child: iAgreeBtn,
            ),

            (isLoading)
                ? Container(child: LoaderPage())
                : Container(height: 0, width: 0)
          ],
        ),
      ),
    );
  }

  initHrsDropDown() {
    hrsList = [];
    hrsList.add(DropdownMenuItem(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          "Hours",
          style: GoogleFonts.roboto(
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
              color: qbAppTextColor),
          textScaleFactor: 1,
        ),
      ),
    ));

    for (int i = 1; i <= 15; i++) {
      String suffix = "hr";
      if (i > 1) {
        suffix += "s";
      }
      hrsList.add(DropdownMenuItem(
        value: i.toString(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "$i $suffix",
            style: GoogleFonts.roboto(
                fontSize: 12.5,
                fontWeight: FontWeight.w500,
                color: qbAppTextColor),
            textScaleFactor: 1,
          ),
        ),
      ));
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class TermDisplayWidget extends StatelessWidget {
  String term;
  bool addHashtag;
  bool addMargin;
  double fontSize;
  TermDisplayWidget(
      {@required this.term,
      this.addHashtag: true,
      this.addMargin: true,
      this.fontSize: 12.5});
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = GoogleFonts.roboto(
        letterSpacing: 0.15,
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        color: qbDetailLightColor);

    return Container(
        margin:
            (addMargin) ? EdgeInsets.symmetric(vertical: 5) : EdgeInsets.all(0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (addHashtag)
                ? Container(
                    padding: EdgeInsets.only(right: 5),
                    alignment: Alignment.topCenter,
                    child: Text(
                      "#",
                      style: textStyle,
                      textScaleFactor: 1.0,
                    ),
                  )
                : Container(
                    height: 0,
                    width: 0,
                  ),
            Expanded(
              child: Container(
                child: Text(
                  this.term,
                  style: textStyle,
                  textScaleFactor: 1.0,
                ),
              ),
            ),
          ],
        ));
  }
}

// Damage

// User
// Extra Time
