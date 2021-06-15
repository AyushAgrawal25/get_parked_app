import 'package:getparked/StateManagement/Models/AppOverlayStyleData.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/StateManagement/Models/BookingData.dart';
import 'package:getparked/StateManagement/Models/NotificationData.dart';
import 'package:getparked/StateManagement/Models/ParkingData.dart';
import 'package:getparked/StateManagement/Models/ParkingRequestData.dart';
import 'package:getparked/StateManagement/Models/VehicleData.dart';
import 'package:getparked/UserInterface/Widgets/ParkingDetailsPage/ParkingActionButtons/CancelBookingButton.dart';
import 'package:getparked/UserInterface/Widgets/ParkingDetailsPage/ParkingActionButtons/BookNowButton.dart';
import 'package:getparked/UserInterface/Widgets/ParkingDetailsPage/ParkingActionButtons/EnterOTPButton.dart';
import 'package:getparked/UserInterface/Widgets/ParkingDetailsPage/ParkingActionButtons/ParkingRequestAcceptButton.dart';
import 'package:getparked/UserInterface/Widgets/ParkingDetailsPage/ParkingActionButtons/ParkingRequestRejectButton.dart';
import 'package:getparked/UserInterface/Widgets/ParkingDetailsPage/ParkingActionButtons/WithdrawParkingButton.dart';
import 'package:getparked/UserInterface/Widgets/Loaders/LoaderPage.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/ParkingCard/ParkingCard.dart';
import 'package:getparked/UserInterface/Widgets/ParkingDetailsPage/ParkingDetailsWidgets/ParkingDetailStatus.dart';
import 'package:getparked/UserInterface/Widgets/ParkingDetailsPage/ParkingDetailsWidgets/ParkingDetailsWidget.dart';
import 'package:getparked/UserInterface/Widgets/ParkingDetailsPage/ParkingDetailsWidgets/ParkingDurationWidget.dart';
import 'package:getparked/UserInterface/Widgets/ParkingDetailsPage/ParkingDetailsWidgets/ParkingExtraDetailsWidget.dart';
import 'package:getparked/UserInterface/Widgets/ParkingDetailsPage/ParkingDetailsWidgets/VehicleDetailWidget.dart';
import 'package:getparked/UserInterface/Widgets/SlotInfoWidget.dart';
import 'package:getparked/UserInterface/Widgets/UserInfoWidget.dart';
import 'package:flutter/material.dart';
import 'package:getparked/StateManagement/Models/UserDetails.dart';
import 'package:getparked/StateManagement/Models/SlotData.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:getparked/UserInterface/Widgets/ParkingDetailsPage/ParkingDetailsWidgets/ParkingTotalProfitWidget.dart';
import 'package:getparked/UserInterface/Widgets/ParkingDetailsPage/ParkingDetailsWidgets/ParkingOTPWidget.dart';

class ParkingDetailsPage extends StatefulWidget {
  ParkingRequestData parkingRequest;
  BookingData booking;
  ParkingData parking;
  ParkingDetailsAccType accType;
  NotificationDataType notificationType;
  ParkingDetailsPage(
      {this.parkingRequest,
      this.booking,
      this.parking,
      @required this.accType,
      this.notificationType});
  @override
  _ParkingDetailsPageState createState() => _ParkingDetailsPageState();
}

class _ParkingDetailsPageState extends State<ParkingDetailsPage> {
  AppState gpAppState;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    gpAppState = Provider.of<AppState>(context, listen: false);
  }

  loadHandler(loadingStatus) {
    setState(() {
      isLoading = loadingStatus;
    });
  }

  UserDetails gpUserDetails;
  SlotData gpSlotData;
  setSlotAndUserDetails() {
    if (widget.notificationType == null) {
      gpSlotData = gpParkingRequestData.slotData;
      gpUserDetails = gpParkingRequestData.userDetails;
    }
  }

  bool isCallOptionAvailable = false;
  Widget slotORUserInfoWidget = Container(
    height: 0,
    width: 0,
  );
  setSlotORUserInfoWidget() {
    if (widget.accType == ParkingDetailsAccType.slot) {
      slotORUserInfoWidget = Container(
        child: UserInfoWidget(
          userDetails: gpUserDetails,
          callingOption: isCallOptionAvailable,
        ),
      );
    } else {
      slotORUserInfoWidget = Container(
        padding: EdgeInsets.only(bottom: 10),
        child: SlotInfoWidget(
          slotData: gpSlotData,
          callingOption: isCallOptionAvailable,
        ),
      );
    }
  }

  String appBarTitle = "";
  setAppBarTitle() {
    if (widget.notificationType == null) {
      switch (gpParkingRequestData.getParkingRequestDataType()) {
        case ParkingRequestDataType.rejected:
        case ParkingRequestDataType.accepted:
        case ParkingRequestDataType.pending:
        case ParkingRequestDataType.pendingButExpired:
        case ParkingRequestDataType.accepted_BookingExpired:
          appBarTitle = "Parking Request";
          break;
        case ParkingRequestDataType.booked_BookingFailed:
        case ParkingRequestDataType.accepted_BookingPending:
        case ParkingRequestDataType.booked_BookingGoingON:
        case ParkingRequestDataType.booked:
        case ParkingRequestDataType.booked_BookingCancelled:
          appBarTitle = "Booking";
          break;
        case ParkingRequestDataType.booked_ParkingGoingON:
        case ParkingRequestDataType.booked_ParkedAndWithdrawn:
          appBarTitle = "Parked";
          break;
      }
    } else {
      switch (widget.notificationType) {
        case NotificationDataType.booking:
          appBarTitle = "Booking";
          gpUserDetails = widget.booking.userDetails;
          gpSlotData = widget.booking.slotData;
          break;
        case NotificationDataType.parking:
          appBarTitle = "Parking";
          gpUserDetails = widget.parking.userDetails;
          gpSlotData = widget.parking.slotData;
          break;
        case NotificationDataType.parkingRequest:
          appBarTitle = "Parking Request";
          gpUserDetails = widget.parkingRequest.userDetails;
          gpSlotData = widget.parkingRequest.slotData;
          break;
        default:
          appBarTitle = "Some Problem";
          break;
      }
    }
  }

  int pHrs;
  SlotSpaceType spType;
  double pChrs;
  Widget parkingDetailsWidget = Container();
  setParkingDetailsWidget() {
    parkingDetailsWidget = Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: ParkingDetailsWidget(
        charges: pChrs,
        parkingHours: pHrs,
        spaceType: spType,
      ),
    );
  }

  bool toShowParkingCharges = false;
  double parkingCharges = 0;
  Widget parkingChargesWidget = Container();
  setParkingChargesWidget() {
    if (toShowParkingCharges) {
      parkingChargesWidget = Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        child: ParkingTotalProfitWidget(
          amount: parkingCharges,
          accType: widget.accType,
        ),
      );
    } else {
      parkingChargesWidget = Container(
        height: 0,
        width: 0,
      );
    }
  }

  VehicleData parkingVehicleData;
  Widget vehicleDataWidget = Container(
    height: 0,
    width: 0,
  );
  setVehicleDataWidget() {
    vehicleDataWidget = Container(
      child: VehicleDetailWidget(
        widgetType: VehicleDetailWidgetType.borderLess,
        vehicleData: parkingVehicleData,
      ),
    );
  }

  bool toShowOTP = false;
  String otp;
  ParkingOTPType otpType;
  Widget parkingOTPWidget;
  setParkingOTPWidget() {
    if (toShowOTP) {
      parkingOTPWidget = Container(
        child: ParkingOTPWidget(
          accType: widget.accType,
          type: otpType,
          otp: otp,
        ),
      );
    } else {
      parkingOTPWidget = Container(
        height: 0,
        width: 0,
      );
    }
  }

  String eDIdText;
  String eDId;
  String eDTime;
  Widget parkingExtraDetailsWidget = Container(
    height: 0,
    width: 0,
  );
  setParkingExtraDetailsWidget() {
    parkingExtraDetailsWidget = Container(
      child: ParkingExtraDetailsWidget(
        id: eDId,
        idText: eDIdText,
        time: eDTime,
      ),
    );
  }

  String bookingStartTime = "";
  int bookingDuration = -1;
  Widget bookingDurationWidget = Container(
    height: 0,
    width: 0,
  );
  setBookingDurationWidget() {
    if (((bookingStartTime != "") && (bookingStartTime != null)) ||
        bookingDuration != -1) {
      bookingDurationWidget = Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          child: ParkingDurationWidget(
            bookingTime: bookingStartTime,
            bookingDuration: bookingDuration,
          ));
    } else {
      bookingDurationWidget = Container(
        height: 0,
        width: 0,
      );
    }
  }

  Widget statusOrActionButton = Container(
    child: Text("WHat the Fuck.."),
  );
  setAllParkingDetails() {
    toShowOTP = false;
    bookingStartTime = "";
    bookingDuration = -1;
    isCallOptionAvailable = false;
    parkingCharges = 0;
    toShowParkingCharges = false;
    if (widget.notificationType == null) {
      switch (this.gpParkingRequestData.getParkingRequestDataType()) {
        case ParkingRequestDataType.pending:
          if (widget.accType == ParkingDetailsAccType.slot) {
            statusOrActionButton = Container(
              child: Column(
                children: [
                  ParkingRequestAcceptButton(
                      parkingRequestData: gpParkingRequestData,
                      changeLoadStatus: loadHandler),
                  Container(
                    child: Text("OR",
                        style: GoogleFonts.roboto(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: qbAppTextColor),
                        textScaleFactor: 1.0),
                  ),
                  ParkingRequestRejectButton(
                      parkingRequestData: gpParkingRequestData,
                      changeLoadStatus: loadHandler)
                ],
              ),
            );
          } else {
            statusOrActionButton = Container(
              child: ParkingDetailStatus(
                color: qbAppSecondaryBlueColor,
                status: "Pending",
                icon: FontAwesome5.hourglass_half,
                title: "Parking Request",
              ),
            );
          }
          break;
        case ParkingRequestDataType.pendingButExpired:
          statusOrActionButton = Container(
            child: ParkingDetailStatus(
              color: qbAppPrimaryRedColor,
              status: "Expired",
              icon: FontAwesome5.exclamation_triangle,
              title: "Parking Request",
            ),
          );
          break;
        case ParkingRequestDataType.accepted_BookingPending:
          if (widget.accType == ParkingDetailsAccType.slot) {
            statusOrActionButton = Container(
              child: ParkingDetailStatus(
                color: qbAppSecondaryBlueColor,
                status: "Pending",
                icon: FontAwesome5.hourglass_half,
                title: "Booking Status",
              ),
            );
          } else {
            statusOrActionButton = Container(
              child: BookNowButton(
                changeLoadStatus: loadHandler,
                parkingRequestData: gpParkingRequestData,
                slotData: gpParkingRequestData.slotData,
                vehicleData: gpParkingRequestData.vehicleData,
              ),
            );
          }
          break;
        case ParkingRequestDataType.accepted_BookingExpired:
          statusOrActionButton = Container(
            child: ParkingDetailStatus(
              color: qbAppPrimaryRedColor,
              status: " Expired",
              icon: FontAwesome5.exclamation_triangle,
              title: "Parking Request",
            ),
          );
          break;
        case ParkingRequestDataType.booked_BookingFailed:
          statusOrActionButton = Container(
            child: ParkingDetailStatus(
              color: qbAppPrimaryRedColor,
              status: "Failed",
              icon: FontAwesome5.exclamation_triangle,
              title: "Booking Status",
            ),
          );
          break;
        case ParkingRequestDataType.booked_BookingGoingON:
          if (widget.accType == ParkingDetailsAccType.slot) {
            statusOrActionButton = Container(
                child: EnterOTPButton(
                    bookingData: gpParkingRequestData.bookingData,
                    changeLoadStatus: loadHandler));
          } else {
            statusOrActionButton = Container(
              child: CancelBookingButton(
                bookingData: gpParkingRequestData.bookingData,
                slotData: gpParkingRequestData.slotData,
                changeLoadStatus: loadHandler,
              ),
            );
          }

          // OTP
          toShowOTP = true;
          otpType = ParkingOTPType.parking;
          otp = gpParkingRequestData.bookingData.parkingOTP.toString();

          bookingStartTime = gpParkingRequestData.bookingData.time;
          isCallOptionAvailable = true;
          break;
        case ParkingRequestDataType.booked_BookingCancelled:
          statusOrActionButton = Container(
            child: ParkingDetailStatus(
              color: qbAppPrimaryRedColor,
              status: "Cancelled",
              icon: FontAwesome5.times_circle,
              title: "Booking Status",
            ),
          );

          toShowParkingCharges = true;
          bookingDuration = gpParkingRequestData.bookingData.duration;
          parkingCharges = (gpParkingRequestData.bookingData.duration *
                  gpParkingRequestData.vehicleData.fair /
                  60) +
              (gpParkingRequestData.bookingData.exceedDuration *
                  gpParkingRequestData.vehicleData.fair *
                  2 /
                  60);
          break;
        case ParkingRequestDataType.booked_ParkingGoingON:
          if (widget.accType == ParkingDetailsAccType.slot) {
            statusOrActionButton = Container(
              child: WithdrawParkingButton(
                  bookingData: widget.booking, changeLoadStatus: loadHandler),
            );
          } else {
            statusOrActionButton = Container(
              child: ParkingDetailStatus(
                color: qbAppSecondaryGreenColor,
                status: "Parked",
                icon: FontAwesome5.car,
                title: "Parking Status",
              ),
            );
          }

          // OTP
          toShowOTP = true;
          otpType = ParkingOTPType.withdraw;
          otp = gpParkingRequestData.bookingData.parkingData.withdrawOTP
              .toString();

          bookingStartTime = gpParkingRequestData.bookingData.time;
          isCallOptionAvailable = true;
          break;
        case ParkingRequestDataType.booked_ParkedAndWithdrawn:
          statusOrActionButton = Container(
            child: ParkingDetailStatus(
              color: qbAppSecondaryGreenColor,
              status: "Withdrawn",
              icon: FontAwesome5.check_circle,
              title: "Parking Status",
            ),
          );

          toShowParkingCharges = true;
          bookingDuration = gpParkingRequestData.bookingData.duration;
          parkingCharges = (gpParkingRequestData.bookingData.duration *
                  gpParkingRequestData.vehicleData.fair /
                  60) +
              (gpParkingRequestData.bookingData.exceedDuration *
                  gpParkingRequestData.vehicleData.fair *
                  2 /
                  60);
          break;
        case ParkingRequestDataType.rejected:
          statusOrActionButton = Container(
            child: ParkingDetailStatus(
              color: qbAppPrimaryRedColor,
              status: "Rejected",
              icon: FontAwesome5.times_circle,
              title: "Parking Request",
            ),
          );
          break;
        case ParkingRequestDataType.accepted:
          statusOrActionButton = Container(
            child: ParkingDetailStatus(
              color: qbAppSecondaryGreenColor,
              status: "Accepted",
              icon: FontAwesome5.check_circle,
              title: "Parking Request",
            ),
          );
          break;
        case ParkingRequestDataType.booked:
          statusOrActionButton = Container(
            child: ParkingDetailStatus(
              color: qbAppSecondaryGreenColor,
              status: "Booked",
              icon: FontAwesome5.check_circle,
              title: "Booking Status",
            ),
          );
          bookingDuration = gpParkingRequestData.bookingData.duration;
          bookingStartTime = gpParkingRequestData.bookingData.time;
          break;
      }

      // Main Details
      pChrs = this.gpParkingRequestData.vehicleData.fair;
      pHrs = this.gpParkingRequestData.parkingHours;
      spType = this.gpParkingRequestData.spaceType;

      // Extra Details
      eDId = this.gpParkingRequestData.id.toString();
      eDIdText = "Request Id";
      eDTime = this.gpParkingRequestData.time;

      // Vehicle Details
      parkingVehicleData = this.gpParkingRequestData.vehicleData;
    } else {
      switch (widget.notificationType) {
        case NotificationDataType.parkingRequest:
          {
            switch (widget.parkingRequest.getParkingRequestDataType()) {
              case ParkingRequestDataType.pending:
                {
                  if (widget.accType == ParkingDetailsAccType.slot) {
                    statusOrActionButton = Container(
                      child: Column(
                        children: [
                          ParkingRequestAcceptButton(
                              parkingRequestData: widget.parkingRequest,
                              changeLoadStatus: loadHandler),
                          Container(
                            child: Text(
                              "OR",
                              style: GoogleFonts.roboto(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: qbAppTextColor),
                              textScaleFactor: 1.0,
                            ),
                          ),
                          ParkingRequestRejectButton(
                              parkingRequestData: widget.parkingRequest,
                              changeLoadStatus: loadHandler)
                        ],
                      ),
                    );
                  } else {
                    statusOrActionButton = Container(
                      child: ParkingDetailStatus(
                        color: qbAppSecondaryBlueColor,
                        status: "Pending",
                        icon: FontAwesome5.hourglass_half,
                        title: "Parking Request",
                      ),
                    );
                  }
                  break;
                }
              case ParkingRequestDataType.pendingButExpired:
                {
                  statusOrActionButton = Container(
                    child: ParkingDetailStatus(
                      color: qbAppPrimaryRedColor,
                      status: "Expired",
                      icon: FontAwesome5.exclamation_triangle,
                      title: "Parking Request",
                    ),
                  );
                  break;
                }
              case ParkingRequestDataType.accepted_BookingPending:
                {
                  if (widget.accType == ParkingDetailsAccType.slot) {
                    statusOrActionButton = Container(
                      child: ParkingDetailStatus(
                        color: qbAppSecondaryBlueColor,
                        status: "Pending",
                        icon: FontAwesome5.hourglass_half,
                        title: "Booking Status",
                      ),
                    );
                  } else {
                    statusOrActionButton = Container(
                      child: BookNowButton(
                        changeLoadStatus: loadHandler,
                        parkingRequestData: widget.parkingRequest,
                        slotData: widget.parkingRequest.slotData,
                        vehicleData: widget.parkingRequest.vehicleData,
                      ),
                    );
                  }
                  break;
                }
              case ParkingRequestDataType.accepted_BookingExpired:
                {
                  statusOrActionButton = Container(
                    child: ParkingDetailStatus(
                      color: qbAppPrimaryRedColor,
                      status: "Expired",
                      icon: FontAwesome5.exclamation_triangle,
                      title: "Booking Status",
                    ),
                  );
                  break;
                }
              case ParkingRequestDataType.rejected:
                {
                  statusOrActionButton = Container(
                    child: ParkingDetailStatus(
                      color: qbAppPrimaryRedColor,
                      status: "Rejected",
                      icon: FontAwesome5.times_circle,
                      title: "Parking Request",
                    ),
                  );
                  break;
                }
              case ParkingRequestDataType.booked:
                {
                  statusOrActionButton = Container(
                    child: ParkingDetailStatus(
                      color: qbAppSecondaryGreenColor,
                      status: "Booked",
                      icon: Octicons.checklist,
                      title: "Booking Status",
                    ),
                  );
                  break;
                }
              case ParkingRequestDataType.booked_ParkedAndWithdrawn:
              case ParkingRequestDataType.booked_ParkingGoingON:
              case ParkingRequestDataType.booked_BookingGoingON:
              case ParkingRequestDataType.booked_BookingCancelled:
              case ParkingRequestDataType.booked_BookingFailed:
              case ParkingRequestDataType.accepted:
                {
                  statusOrActionButton = Container(
                    child: ParkingDetailStatus(
                      color: qbAppSecondaryGreenColor,
                      status: "Accepted",
                      icon: FontAwesome5.check_circle,
                      title: "Parking Request",
                    ),
                  );
                  break;
                }
            }

            // Main Details
            pHrs = widget.parkingRequest.parkingHours;
            spType = widget.parkingRequest.spaceType;
            pChrs = widget.parkingRequest.vehicleData.fair;

            // Extra Details
            eDId = widget.parkingRequest.id.toString();
            eDIdText = "Request Id";
            eDTime = widget.parkingRequest.time;

            // Vehicle Details
            parkingVehicleData = widget.parkingRequest.vehicleData;
            break;
          }
        case NotificationDataType.booking:
          {
            switch (widget.booking.getBookingDataType()) {
              case BookingDataType.failed:
                {
                  statusOrActionButton = Container(
                    child: ParkingDetailStatus(
                      color: qbAppPrimaryRedColor,
                      status: "Failed",
                      icon: FontAwesome5.exclamation_triangle,
                      title: "Booking Status",
                    ),
                  );
                  break;
                }
              case BookingDataType.bookingGoingON:
                {
                  if (widget.accType == ParkingDetailsAccType.slot) {
                    statusOrActionButton = Container(
                        child: EnterOTPButton(
                            bookingData: widget.booking,
                            changeLoadStatus: loadHandler));
                  } else {
                    statusOrActionButton = Container(
                      child: CancelBookingButton(
                        bookingData: widget.booking,
                        slotData: widget.booking.slotData,
                        changeLoadStatus: loadHandler,
                      ),
                    );
                  }
                  // OTP
                  toShowOTP = true;
                  otpType = ParkingOTPType.parking;
                  otp = widget.booking.parkingOTP.toString();

                  bookingStartTime = widget.booking.time;
                  bookingDuration = widget.booking.duration;
                  isCallOptionAvailable = true;
                  break;
                }
              case BookingDataType.cancelled:
                {
                  statusOrActionButton = Container(
                    child: ParkingDetailStatus(
                      color: qbAppPrimaryRedColor,
                      status: "Cancelled",
                      icon: FontAwesome5.times_circle,
                      title: "Booking Status",
                    ),
                  );

                  toShowParkingCharges = true;
                  bookingStartTime = widget.booking.time;
                  bookingDuration = widget.booking.duration;
                  parkingCharges = (widget.booking.duration *
                          widget.booking.vehicleData.fair /
                          60) +
                      (widget.booking.exceedDuration *
                          widget.booking.vehicleData.fair *
                          2 /
                          60);
                  break;
                }
              case BookingDataType.parkingGoingON:
                {
                  statusOrActionButton = Container(
                    child: ParkingDetailStatus(
                      color: qbAppSecondaryGreenColor,
                      status: "Parked",
                      icon: FontAwesome5.car,
                      title: "Booking Status",
                    ),
                  );

                  bookingStartTime = widget.booking.time;
                  bookingDuration = widget.booking.duration;
                  break;
                }
              case BookingDataType.parkedAndWithdrawn:
                {
                  statusOrActionButton = Container(
                    child: ParkingDetailStatus(
                      color: qbAppSecondaryGreenColor,
                      status: "Withdrawn",
                      icon: FontAwesome5.check_circle,
                      title: "Booking Status",
                    ),
                  );

                  toShowParkingCharges = true;
                  bookingStartTime = widget.booking.time;
                  bookingDuration = widget.booking.duration;
                  parkingCharges = (widget.booking.duration *
                          widget.booking.vehicleData.fair /
                          60) +
                      (widget.booking.exceedDuration *
                          widget.booking.vehicleData.fair *
                          2 /
                          60);
                  break;
                }
            }

            // Main Details
            pHrs = widget.booking.parkingHours;
            spType = widget.booking.spaceType;
            pChrs = widget.booking.vehicleData.fair;

            // Extra Details
            eDId = widget.booking.id.toString();
            eDIdText = "Booking Id";
            eDTime = widget.booking.time;

            // Vehicle Details
            parkingVehicleData = widget.booking.vehicleData;
            break;
          }
        case NotificationDataType.parking:
          {
            switch (widget.parking.getParkingDataType()) {
              case ParkingDataType.completed:
                {
                  statusOrActionButton = Container(
                    child: ParkingDetailStatus(
                      color: qbAppSecondaryGreenColor,
                      status: "Withdrawn",
                      icon: FontAwesome5.check_circle,
                      title: "Parking Status",
                    ),
                  );

                  toShowParkingCharges = true;
                  bookingStartTime = widget.booking.time;
                  bookingDuration = widget.booking.duration;
                  parkingCharges = (widget.booking.duration *
                          widget.parking.vehicleData.fair /
                          60) +
                      (widget.booking.exceedDuration *
                          widget.parking.vehicleData.fair *
                          2 /
                          60);
                  break;
                }
              case ParkingDataType.goingON:
                {
                  if (widget.accType == ParkingDetailsAccType.slot) {
                    statusOrActionButton = Container(
                      child: WithdrawParkingButton(
                          bookingData: widget.booking,
                          changeLoadStatus: loadHandler),
                    );
                  } else {
                    statusOrActionButton = Container(
                      child: ParkingDetailStatus(
                        color: qbAppSecondaryGreenColor,
                        status: "Parked",
                        icon: FontAwesome5.car,
                        title: "Parking Status",
                      ),
                    );
                  }
                  // OTP
                  toShowOTP = true;
                  otpType = ParkingOTPType.withdraw;
                  otp = widget.booking.parkingData.withdrawOTP.toString();

                  bookingStartTime = widget.booking.time;
                  bookingDuration = widget.booking.duration;
                  isCallOptionAvailable = true;
                  break;
                }
            }

            pHrs = widget.parking.parkingHours;
            spType = widget.parking.spaceType;
            pChrs = widget.parking.vehicleData.fair;

            // Extra Details
            eDId = widget.parking.id.toString();
            eDIdText = "Parking Id";
            eDTime = widget.parking.time;

            // Vehicle Details
            parkingVehicleData = widget.parking.vehicleData;
            break;
          }
        default:
          {
            statusOrActionButton = Container(
              child: ParkingDetailStatus(
                color: qbAppSecondaryGreenColor,
                status: "Completed",
                icon: FontAwesome5.car,
                title: "Parking Status",
              ),
            );
            break;
          }
      }
    }
  }

  ParkingRequestData gpParkingRequestData;
  setUpNewUIOnUpdate() {
    if (gpParkingRequestData == null) {
      gpParkingRequestData = widget.parkingRequest;
    } else {
      if (widget.notificationType == null) {
        if (widget.accType == ParkingDetailsAccType.user) {
          gpAppState.userParkings.forEach((gpUserParking) {
            if (gpParkingRequestData.id == gpUserParking.id) {
              gpParkingRequestData = gpUserParking;
            }
          });
        } else {
          gpAppState.slotParkings.forEach((gpSlotParking) {
            if (gpParkingRequestData.id == gpSlotParking.id) {
              gpParkingRequestData = gpSlotParking;
            }
          });
        }
      } else {
        gpParkingRequestData = widget.parkingRequest;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    setUpNewUIOnUpdate();
    setAppBarTitle();
    setAllParkingDetails();
    setSlotAndUserDetails();
    setSlotORUserInfoWidget();
    setVehicleDataWidget();
    setParkingOTPWidget();
    setParkingExtraDetailsWidget();
    setParkingDetailsWidget();
    setParkingChargesWidget();
    setBookingDurationWidget();
    AppState gpAppStateListen = Provider.of<AppState>(context);
    return Container(
      color: qbWhiteBGColor,
      child: SafeArea(
        top: false,
        maintainBottomViewPadding: true,
        child: Stack(
          children: [
            Container(
              child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    appBarTitle,
                    style: GoogleFonts.nunito(
                        color: qbAppTextColor, fontWeight: FontWeight.w600),
                    textScaleFactor: 1.0,
                  ),
                  backgroundColor: qbWhiteBGColor,
                  elevation: 0.0,
                  iconTheme: IconThemeData(color: qbAppTextColor),
                  brightness: Brightness.light,
                ),
                body: Container(
                  child: SingleChildScrollView(
                    child: Container(
                      child: Column(
                        children: [
                          // Details
                          slotORUserInfoWidget,

                          SizedBox(
                            height: 10,
                          ),
                          // Vehicle Data
                          vehicleDataWidget,

                          // Parking OTP
                          parkingOTPWidget,
                          SizedBox(
                            height: 10,
                          ),

                          // Parking Details
                          parkingDetailsWidget,

                          // Booking Duration
                          bookingDurationWidget,

                          // Profit
                          parkingChargesWidget,

                          // Parking Status
                          Container(
                              padding: EdgeInsets.symmetric(vertical: 25),
                              child: statusOrActionButton),

                          // Parking Extra Details
                          Divider(
                            color: qbDividerLightColor,
                            height: 10,
                            thickness: 1.5,
                          ),
                          parkingExtraDetailsWidget,
                          Divider(
                            color: qbDividerLightColor,
                            height: 10,
                            thickness: 1.5,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            (isLoading)
                ? Container(
                    child: LoaderPage(),
                  )
                : Container(
                    height: 0,
                    width: 0,
                  ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
