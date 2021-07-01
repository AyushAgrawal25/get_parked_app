// import 'package:getparked/BussinessLogic/ContactUtils.dart';
import 'package:getparked/StateManagement/Models/SlotData.dart';
import 'package:getparked/StateManagement/Models/VehicleTypeData.dart';
import 'package:getparked/Utils/ContactUtils.dart';
import 'package:getparked/Utils/InternetConnection.dart';
// TODO: create map places utils
// import 'package:getparked/BussinessLogic/MapPlacesUtils.dart';
import 'package:getparked/StateManagement/Models/AppOverlayStyleData.dart';
import 'package:getparked/StateManagement/Models/ContactData.dart';
import 'package:getparked/StateManagement/Models/GooglePlaceData.dart';
import 'package:getparked/StateManagement/Models/NotificationData.dart';
import 'package:getparked/StateManagement/Models/OldNotificationData.dart';
import 'package:getparked/StateManagement/Models/ParkingLordData.dart';
import 'package:getparked/StateManagement/Models/ParkingRequestData.dart';
import 'package:getparked/StateManagement/Models/TransactionData.dart';
import 'package:getparked/StateManagement/Models/UserData.dart';
import 'package:getparked/StateManagement/Models/UserDetails.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:getparked/Utils/MapPlacesUtils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

@immutable
class AppState extends ChangeNotifier {
  // Socket
  IO.Socket socketIO;
  void initSocketIO(gpSocketIO) {
    this.socketIO = gpSocketIO;
    notifyListeners();
  }

  // Internet Connection Status
  bool isInternetConnected;
  void setInternetConnection(bool newInternetConnectionStatus) {
    isInternetConnected = newInternetConnectionStatus;
    InternetConnectionUtils()
        .toastConnectionStatus(newInternetConnectionStatus);
    notifyListeners();
  }

  // Camera Position
  CameraPosition currentCameraPosition;
  void setCurrentCameraPosition(CameraPosition gpCamPos) {
    currentCameraPosition = gpCamPos;
  }

  String authToken;
  void setAuthToken(String token) {
    authToken = token;
    notifyListeners();
  }

  //Map Suggestions Data
  List<GooglePlaceData> googlePlaces;
  void setGooglePlacesData(List<GooglePlaceData> gpGooglePlaces) {
    this.googlePlaces = gpGooglePlaces;
    notifyListeners();
  }

  //User Data
  UserData userData;
  void setUserData(UserData gpUserData) {
    this.userData = gpUserData;
    notifyListeners();
  }

  //User Details
  UserDetails userDetails;
  void setUserDetails(UserDetails gpUserDetails) {
    this.userDetails = gpUserDetails;
    notifyListeners();
  }

  //Slots
  Map<int, SlotData> slotsStore = {};
  void setSlots(List<SlotData> slotsData) {
    if (slotsData == null) {
      return;
    }
    bool toNotify = false;
    slotsData.forEach((SlotData slotData) {
      if (slotsStore[slotData.id] != null) {
        if (slotsStore[slotData.id].availableSpace != slotData.availableSpace) {
          toNotify = true;
          slotsStore[slotData.id] = slotData;
        }
      } else {
        slotsStore[slotData.id] = slotData;
        toNotify = true;
      }
    });

    if (toNotify) {
      notifyListeners();
    }
  }

  List<SlotData> get slotsOnMap {
    List<SlotData> slots = [];
    slotsStore.entries.forEach((slotEntry) {
      slots.add(slotEntry.value);
    });
    return slots;
  }

  SlotData findSlotFromMap(int slotId) {
    return slotsStore[slotId];
  }

  // is Parking Lord
  bool isParkingLord = false;
  //Parking Lord data
  ParkingLordData parkingLordData;
  void setParkingLordData(ParkingLordData gpParkingLordData) {
    this.parkingLordData = gpParkingLordData;
    if (gpParkingLordData != null) {
      this.isParkingLord = true;
    } else {
      this.isParkingLord = false;
    }
    notifyListeners();
  }

  // New Notification Data
  List<NotificationData> get notifications {
    List<NotificationData> notificationList = [];
    notificationsStore.forEach((key, value) {
      notificationList.add(value);
    });

    notificationList.sort((a, b) => DateTime.parse(b.time)
        .toLocal()
        .millisecondsSinceEpoch
        .compareTo(DateTime.parse(a.time).toLocal().millisecondsSinceEpoch));
    return notificationList;
  }

  Map<int, NotificationData> notificationsStore = {};
  void setNotifications(List<NotificationData> gpNotifications) {
    gpNotifications.forEach((element) {
      notificationsStore[element.id] = element;
    });
    notifyListeners();
  }

  //Wallet Money
  double walletMoney;
  void setWalletMoney(double wallAmt) {
    this.walletMoney = wallAmt.toDouble();
  }

  // Vault Money
  double vaultMoney;
  void setVaultMoney(double vaultAmt) {
    this.vaultMoney = vaultAmt.toDouble();
  }

  //Transactions Data
  // List<TransactionData> transactions;
  // void setTransactions(List<TransactionData> gpTransactions) {
  //   gpTransactions.sort((a, b) => DateTime.parse(b.time)
  //       .toLocal()
  //       .millisecondsSinceEpoch
  //       .compareTo(DateTime.parse(a.time).toLocal().millisecondsSinceEpoch));
  //   this.transactions = gpTransactions;
  //   // this.setWalleMoney();
  //   // this.setVaultMoney();
  //   notifyListeners();
  // }

  Map<int, TransactionData> transactionsStore = {};
  void setTransactions(List<TransactionData> gpTransactions) {
    gpTransactions.forEach((txn) {
      transactionsStore[txn.id] = txn;
    });
    notifyListeners();
  }

  List<TransactionData> get transactions {
    List<TransactionData> txns = [];
    transactionsStore.entries.forEach((txnEntry) {
      txns.add(txnEntry.value);
    });
    txns.sort((a, b) => DateTime.parse(b.time)
        .toLocal()
        .millisecondsSinceEpoch
        .compareTo(DateTime.parse(a.time).toLocal().millisecondsSinceEpoch));
    return txns;
  }

  //Contacts Data
  List<ContactData> contacts = [];
  void setContacts(List<ContactData> gpContacts) {
    contacts = gpContacts;
    contacts.sort((ContactData a, ContactData b) {
      return a.displayName.compareTo(b.displayName);
    });
    notifyListeners();
  }

  // Security Deposits
  double walletSecurityDeposit = 0;
  void setWalletSecurityDeposit() {
    walletSecurityDeposit = 0;
    userParkings.forEach((ParkingRequestData parkingRequest) {
      if ((parkingRequest.getParkingRequestDataType() ==
              ParkingRequestDataType.booked_BookingGoingON) ||
          (parkingRequest.getParkingRequestDataType() ==
              ParkingRequestDataType.booked_ParkingGoingON)) {
        double secDeposit = parkingRequest.vehicleData.fair *
            parkingRequest.slotData.securityDepositTime;
        walletSecurityDeposit += secDeposit;
      }
    });
  }

  // User Parking Requests.
  Map<int, ParkingRequestData> userParkingsStore = {};
  // Setter Method.
  void setUserParkings(List<ParkingRequestData> gpUserParkings) {
    gpUserParkings.forEach((userParking) {
      userParkingsStore[userParking.id] = userParking;
    });
    setWalletSecurityDeposit();
    notifyListeners();
  }

  // Getter Method.
  List<ParkingRequestData> get userParkings {
    List<ParkingRequestData> parkingReqs = [];
    userParkingsStore.entries.forEach((element) {
      parkingReqs.add(element.value);
    });
    parkingReqs.sort((a, b) => DateTime.parse(b.time)
        .toLocal()
        .millisecondsSinceEpoch
        .compareTo(DateTime.parse(a.time).toLocal().millisecondsSinceEpoch));
    return parkingReqs;
  }

  // Security Deposits
  double vaultFutureDeposit = 0;
  double getVaultFutureDeposit() {
    vaultFutureDeposit = 0;
    slotParkings.forEach((ParkingRequestData parkingRequest) {
      if ((parkingRequest.getParkingRequestDataType() ==
              ParkingRequestDataType.booked_BookingGoingON) ||
          (parkingRequest.getParkingRequestDataType() ==
              ParkingRequestDataType.booked_ParkingGoingON)) {
        int bookingTime = DateTime.now()
            .difference(DateTime.parse(parkingRequest.bookingData.time))
            .inMinutes;
        double futAmt =
            bookingTime * parkingRequest.vehicleData.fair * 0.7 / 60;
        vaultFutureDeposit += futAmt;
      }
    });

    return vaultFutureDeposit;
  }

  // Slot Parkings Data
  Map<int, ParkingRequestData> slotParkingsStore = {};
  void setSlotParkings(List<ParkingRequestData> gpSlotParkings) {
    gpSlotParkings.forEach((slotParking) {
      slotParkingsStore[slotParking.id] = slotParking;
    });
    notifyListeners();
  }

  List<ParkingRequestData> get slotParkings {
    List<ParkingRequestData> parkingReqs = [];
    slotParkingsStore.entries.forEach((element) {
      parkingReqs.add(element.value);
    });
    parkingReqs.sort((a, b) => DateTime.parse(b.time)
        .toLocal()
        .millisecondsSinceEpoch
        .compareTo(DateTime.parse(a.time).toLocal().millisecondsSinceEpoch));
    return parkingReqs;
  }

  // Map Places
  MapPlacesSearchResult mapPlacesForSearch;
  void setMapPlacesForSearch(MapPlacesSearchResult gpMapPlacesSearchResult) {
    this.mapPlacesForSearch = gpMapPlacesSearchResult;
    notifyListeners();
  }

  // App Overlay Style
  List<AppOverlayStyleData> overlayStyles = [];

  // // Pushing New Overlay Style
  // void pushOverlayStyle(AppOverlayStyleType appOverlayStyleType) {
  //   if (overlayStyles.length > 0) {
  //     // print("Last : " + overlayStyles.last.type.toString());
  //   }

  //   overlayStyles.add(AppOverlayStyleData(type: appOverlayStyleType));
  //   this.applyOverlayStyle();

  //   if (overlayStyles.length > 0) {
  //     // print("Current : " + overlayStyles.last.type.toString());
  //   }
  // }

  // void applyOverlayStyle() {
  //   if (overlayStyles.length > 0) {
  //     SystemChrome.setSystemUIOverlayStyle(
  //         overlayStyles[overlayStyles.length - 1].style);

  //     print("Applying : " + overlayStyles.last.type.toString());

  //     SystemChrome.setEnabledSystemUIOverlays(
  //         [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  //   }
  // }

  void applySpecificOverlayStyle(AppOverlayStyleType appOverlayStyleType) {
    AppOverlayStyleData appOverlayStyleData =
        AppOverlayStyleData(type: appOverlayStyleType);
    SystemChrome.setSystemUIOverlayStyle(appOverlayStyleData.style);

    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.bottom, SystemUiOverlay.top]);
  }

  // // Popping New Overlay Style
  // void popOverlayStyle() {
  //   if (overlayStyles.length > 0) {
  //     // print("Last : " + overlayStyles.last.type.toString());
  //   }

  //   if (overlayStyles.length > 0) {
  //     overlayStyles.removeLast();
  //     this.applyOverlayStyle();
  //   }

  //   if (overlayStyles.length > 0) {
  //     // print("Current : " + overlayStyles.last.type.toString());
  //   }
  // }

  List<VehicleTypeData> vehiclesTypeData = [];
  setVehiclesTypeData(List<VehicleTypeData> vehicleTypes) {
    vehiclesTypeData = vehicleTypes;
  }

  AppState(
      {this.googlePlaces,
      this.userData,
      this.userDetails,
      this.parkingLordData,
      this.contacts});
}

AppState globalAppState = AppState(
    googlePlaces: null,
    parkingLordData: null,
    userData: null,
    userDetails: null);
