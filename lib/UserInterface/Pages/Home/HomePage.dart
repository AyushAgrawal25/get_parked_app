import 'dart:async';

import 'package:getparked/BussinessLogic/FAQsServices.dart';
import 'package:getparked/BussinessLogic/NotificationServices.dart';
import 'package:getparked/BussinessLogic/SlotsServices.dart';
import 'package:getparked/BussinessLogic/TransactionServices.dart';
import 'package:getparked/BussinessLogic/VehiclesServices.dart';
import 'package:getparked/StateManagement/Models/VehicleData.dart';
import 'package:getparked/StateManagement/Models/VehicleTypeData.dart';
import 'package:getparked/Utils/ContactUtils.dart';
import 'package:getparked/Utils/FlushBarUtils.dart';
import 'package:getparked/Utils/GPMapUtils.dart';
import 'package:getparked/Utils/LocalDataUtils.dart';
import 'package:getparked/Utils/MapPlacesUtils.dart';
import 'package:getparked/BussinessLogic/PlacesApiUtils.dart';
import 'package:getparked/BussinessLogic/PlacesDataCollection.dart';
import 'package:getparked/Utils/SocketUtils.dart';
import 'package:getparked/Utils/SecureStorageUtils.dart';
import 'package:getparked/Utils/TransactionUtils.dart';
import 'package:getparked/Utils/VehiclesUtils.dart';
import 'package:getparked/StateManagement/Models/AppOverlayStyleData.dart';
import 'package:getparked/StateManagement/Models/AppState.dart';
import 'package:getparked/StateManagement/Models/ContactData.dart';
import 'package:getparked/StateManagement/Models/NotificationData.dart';
import 'package:getparked/StateManagement/Models/ParkingRequestData.dart';
import 'package:getparked/StateManagement/Models/SlotData.dart';
import 'package:getparked/StateManagement/Models/TransactionData.dart';
import 'package:getparked/UserInterface/Pages/Home/BottomBar/ParkingInfoWidget.dart';
import 'package:getparked/UserInterface/Pages/Home/BottomBar/VehiclesBottomBar.dart';
import 'package:getparked/UserInterface/Pages/Home/InternetConnectionErrorPage.dart';
import 'package:getparked/UserInterface/Pages/Home/ParkingRequest/ParkingRequestPage.dart';
import 'package:getparked/UserInterface/Widgets/SideNav/SideNav.dart';
import 'package:getparked/UserInterface/Pages/Home/TestPages/IconTestPage.dart';
import 'package:getparked/UserInterface/Pages/Login/LoginDetailsForm.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:geolocator/geolocator.dart';
import 'package:getparked/encryptionConfig.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import './MapSearch/MapSearch.dart';
import './MenuAndSearchBar/MenuAndSeaarchButton.dart';
import 'package:getparked/UserInterface/Theme/AppTheme.dart';
import 'package:getparked/UserInterface/Widgets/qbFAB.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/mfg_labs_icons.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:getparked/UserInterface/Pages/Home/QRScanner/QRScannerPage.dart';
import 'package:getparked/UserInterface/Widgets/AppLock/AppLockPinChange.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GPMapController gpMapController;

  bool isMapSearchOpen = false;
  bool isSideNavOpen = false;
  bool isParkingInfoOpen = false;

  AppState gpAppState;

  List allSlots = [];
  SlotData gpSelectedMarkerSlotData;

  // Vehicle Type
  List<VehicleTypeData> vehiclesTypeData = [];
  VehicleTypeData gpSelectedVehicleTypeData;

  // For Initializing App State
  initializeAppOnlineData() async {
    initializeContacts();
    initializeVehiclesTypeData();
    initializeMapPlacesForCity();

    // Parkings
    initializeParkingsForUser();
    initializeParkingsForParkingLord();

    // Transactions
    initializeTransactions();

    // Notifications
    initializeNotifications();
  }

  // initialize parkings for user
  initializeParkingsForUser() async {
    List<ParkingRequestData> parkingReqs = await SlotsServices()
        .getParkingRequestsForUser(authToken: gpAppState.authToken);
    gpAppState.setUserParkings(parkingReqs);
  }

  // initialize parkings for parking lord.
  initializeParkingsForParkingLord() async {
    List<ParkingRequestData> parkingReqs = await SlotsServices()
        .getParkingRequestsForSlot(authToken: gpAppState.authToken);
    gpAppState.setSlotParkings(parkingReqs);
  }

  // initialize transactions
  initializeTransactions() async {
    await TransactionServices().getAllTransactions(context: context);
  }

  // initialize Notifications
  initializeNotifications() async {
    await NotificationServices().getAllNotifications(context: context);
  }

  initializeVehiclesTypeData() async {
    vehiclesTypeData =
        await VehiclesServices().getTypes(authToken: gpAppState.authToken);
    gpAppState.setVehiclesTypeData(vehiclesTypeData);
    print(vehiclesTypeData.length);
  }

  initializeContacts() async {
    List<ContactData> contacts =
        await ContactUtils().init(authToken: gpAppState.authToken);
    gpAppState.setContacts(contacts);
  }

  initializeMapPlacesForCity() async {
    // TODO: Uncommnet when ready.
    // MapPlacesSearchResult gpMapPlacesSearchResult = await MapPlacesUtils()
    //     .getPlacesOnCityBasis(gpAppState.userData.accessToken);
    // gpAppState.setMapPlacesForSearch(gpMapPlacesSearchResult);
  }

  initializeAppSockets() async {
    if (gpAppState.socketIO == null) {
      IO.Socket gpSocketIO = SocketUtils().init(
          authToken: gpAppState.authToken,
          onSocketConnected: onSocketConnection,
          onSocketDisconnected: onSocketDisconnect);
      gpAppState.initSocketIO(gpSocketIO);
    }
  }

  onSocketConnection(IO.Socket gpSocketIO) {
    // User stream will be automatically once token is configured.
    initializeNotificationsSocket(gpSocketIO);
    initializeTransactionsSocket(gpSocketIO);
    initializeSlotsSocket(gpSocketIO);
    initializeParkingsSocket(gpSocketIO);
  }

  onSocketDisconnect(IO.Socket gpSocketIO) {
    gpSocketIO.off('notification-update');
    gpSocketIO.off('transaction-update');
    gpSocketIO.off('slot-update');
    gpSocketIO.off('user-parking-update');
    gpSocketIO.off('slot-parking-update');
  }

  Map testNotificationData = {};

  // For Notifications
  initializeNotificationsSocket(IO.Socket gpSocketIO) async {
    gpSocketIO.on('notification-update', (data) async {
      // Saving Data Locally
      // LocalDataUtils().saveLocalData(LocalDataType.notifications, data["data"]);

      // // Tmp Code
      // data["data"].forEach((testNoti) {
      //   if (testNoti["notificationId"] == 157) {
      //     testNotificationData = testNoti;
      //   }
      // });

      List notifications = data;
      List<NotificationData> gpNotifications = [];
      notifications.forEach((element) {
        gpNotifications.add(NotificationData.fromMap(element));
      });

      gpAppState.setNotifications(gpNotifications);
    });
  }

  // For Transactions
  initializeTransactionsSocket(IO.Socket gpSocketIO) async {
    gpSocketIO.on('transaction-update', (data) {
      // Setting Up Money
      if (data["walletAmout"] != null) {
        gpAppState.setWalletMoney((data["walletAmout"]).toDouble());
      }
      if (data["vaultAmount"] != null) {
        gpAppState.setVaultMoney((data["vaultAmount"]).toDouble());
      }

      // LocalDataUtils()
      //     .savingAmountData(gpAppState.walletMoney, gpAppState.vaultMoney);

      // List<TransactionData> transactions = [];
      // data["data"].forEach((transactionMap) {
      //   transactions.add(TransactionData.fromMap(transactionMap));
      // });

      List<TransactionData> transactions = [];
      List txns = data["transactions"];
      txns.forEach((txn) {
        transactions.add(TransactionData.fromMap(txn));
      });
      gpAppState.setTransactions(transactions);

      // print(transactions.length.toString() + " Transactions");
      // gpAppState.setTransactions(transactions);

      // // Saving Data Locally
      // LocalDataUtils().saveLocalData(LocalDataType.transactions, data["data"]);
      // print("App Amount : " + data["appAmount"].toString());
    });
  }

  // For Slots
  initializeSlotsSocket(IO.Socket gpSocketIO) async {
    onCameraChangeFun(gpAppState.currentCameraPosition);

    // Use this room to get slot updates.
    gpSocketIO.on("slots-update", (data) {
      List slots = data;
      if (slots != null) {
        List<SlotData> slotsData = [];
        slots.forEach((slot) {
          slotsData.add(SlotData.fromMap(slot));
        });
        gpAppState.setSlots(slotsData);
      }
    });
  }

  // For Parkings
  initializeParkingsSocket(IO.Socket gpSocketIO) async {
    gpSocketIO.on("user-parking-update", (parkingReqData) {
      // if (data["data"] != null) {
      //   List<ParkingRequestData> gpUserParkingRequests = [];
      //   data["data"].forEach((parking) {
      //     gpUserParkingRequests.add(ParkingRequestData.fromMap(parking));
      //   });
      //   gpAppState.setUserParkings(gpUserParkingRequests);
      //   print(gpUserParkingRequests.length.toString() + " User Parkings");

      //   // Saving Data Locally
      //   LocalDataUtils()
      //       .saveLocalData(LocalDataType.userParkings, data["data"]);
      // }

      List parkings = parkingReqData;
      List<ParkingRequestData> parkingReqs = [];
      parkings.forEach((parking) {
        parkingReqs.add(ParkingRequestData.fromMap(parking));
      });

      gpAppState.setUserParkings(parkingReqs);
    });

    gpSocketIO.on("slot-parking-update", (parkingReqData) {
      // if (data["data"] != null) {
      //   List<ParkingRequestData> gpSlotParkingRequests = [];
      //   data["data"].forEach((parking) {
      //     gpSlotParkingRequests.add(ParkingRequestData.fromMap(parking));
      //   });
      //   gpAppState.setSlotParkings(gpSlotParkingRequests);
      //   print(gpSlotParkingRequests.length.toString() + " Slot Parkings");

      //   // Saving Data Locally
      //   LocalDataUtils()
      //       .saveLocalData(LocalDataType.slotParkings, data["data"]);
      // }

      List parkings = parkingReqData;
      List<ParkingRequestData> parkingReqs = [];
      parkings.forEach((parking) {
        parkingReqs.add(ParkingRequestData.fromMap(parking));
      });

      gpAppState.setSlotParkings(parkingReqs);
    });
  }

  initializeAppOnline() async {
    initializeAppOnlineData();
    initializeAppSockets();
  }

  initializeOfflineNotifications() async {
    // TODO: complete this function
    // Tmp Code
    // List notificationsData =
    //     await LocalDataUtils().readLocalData(LocalDataType.notifications);
    // List<NotificationData> gpNotifications = [];
    // notificationsData.forEach((gpNotificationMap) {
    //   gpNotifications.add(NotificationData.fromMap(gpNotificationMap));
    // });

    // gpAppState.setNotifications(gpNotifications);
  }

  initializeOfflineTransactions() async {
    // TODO: complete this function
    // List transactionsData =
    //     await LocalDataUtils().readLocalData(LocalDataType.transactions);
    // List<TransactionData> gpTransactions = [];
    // transactionsData.forEach((gpTransactionMap) {
    //   gpTransactions.add(TransactionData.fromMap(gpTransactionMap));
    // });

    // gpAppState.setTransactions(gpTransactions);

    // // Setting Up Money
    // Map amtData = await LocalDataUtils().readAmountData();
    // gpAppState.setWalletMoney(amtData["walletAmount"]);
    // gpAppState.setVaultMoney(amtData["vaultAmount"]);
  }

  initializeOfflineSlotParkings() async {
    // TODO: complete this function
    // List slotParkingsData =
    //     await LocalDataUtils().readLocalData(LocalDataType.slotParkings);
    // List<ParkingRequestData> gpSlotParkingRequests = [];
    // slotParkingsData.forEach((parking) {
    //   gpSlotParkingRequests.add(ParkingRequestData.fromMap(parking));
    // });

    // gpAppState.setSlotParkings(gpSlotParkingRequests);
  }

  initializeOfflineUserParkings() async {
    // TODO: complete this function
    // List userParkingsData =
    //     await LocalDataUtils().readLocalData(LocalDataType.userParkings);
    // List<ParkingRequestData> gpUserParkingRequests = [];
    // userParkingsData.forEach((parking) {
    //   gpUserParkingRequests.add(ParkingRequestData.fromMap(parking));
    // });

    // gpAppState.setUserParkings(gpUserParkingRequests);
  }

  initializeAppOffline() async {
    initializeOfflineNotifications();
    initializeOfflineTransactions();
    initializeOfflineSlotParkings();
    initializeOfflineUserParkings();
  }

  initializeApp() async {
    initializeAppOffline();
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult connectivityResult) {
      // New Internet Connection Status
      bool newInternetConnectionStatus;
      if ((connectivityResult == ConnectivityResult.mobile) ||
          (connectivityResult == ConnectivityResult.wifi)) {
        newInternetConnectionStatus = true;
      } else {
        newInternetConnectionStatus = false;
      }

      // Calling Function Based On Internet Connection Status Change
      if (newInternetConnectionStatus != gpAppState.isInternetConnected) {
        if (newInternetConnectionStatus) {
          print("Internet Connected...");
          initializeAppOnline();
        } else {
          print("Internet Disconnected...");
          initializeAppOffline();
        }

        gpAppState.setInternetConnection(newInternetConnectionStatus);
      }
    });
  }

  @override
  void initState() {
    super.initState();

    gpAppState = Provider.of<AppState>(context, listen: false);
    initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    AppState gpAppStateListen = Provider.of<AppState>(context, listen: true);
    gpAppStateListen.applySpecificOverlayStyle(AppOverlayStyleType.map);

    if (gpAppStateListen.slotsOnMap.length > 0) {
      settingUpMarkersAndBookings(gpAppStateListen);
    }

    // print(gpAppStateListen.userData);
    return WillPopScope(
        child: Scaffold(
            backgroundColor: qbWhiteBGColor,
            body: Container(
              child: Stack(
                children: [
                  //Map
                  GPMap(
                    getController: (controller) async {
                      gpMapController = controller;
                    },
                    onMapCreated: onMapCreated,
                    onCameraMove: onCameraMove,
                    onMarkerTap: onMarkerTap,
                    onTapOnMap: () {
                      setState(() {
                        isParkingInfoOpen = false;
                      });
                    },
                    initialZoom: 12,
                    onCameraIdle: onCameraIdle,
                  ),

                  (gpAppStateListen.isInternetConnected != true)
                      ? InternetConnectionErrorPage()
                      : Container(
                          height: 0,
                          width: 0,
                        ),

                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.06,
                    child: MenuAndSearchButton(
                      onMenuPressed: () {
                        setState(() {
                          isSideNavOpen = true;
                        });
                      },
                      onSearchPressed: () async {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return MapSearchPage(
                              onSearch: onMapSearch,
                              onLocationPressed: onLocationPressed,
                            );
                          },
                        ));
                      },
                    ),
                  ),

                  AnimatedPositioned(
                    right: 20,
                    bottom: (isParkingInfoOpen) ? 215 : 75,
                    duration: Duration(milliseconds: 350),
                    child: QbFAB(
                      child: Icon(
                        MfgLabs.location,
                        size: 25,
                        color: Colors.white,
                      ),
                      size: 50,
                      color: qbAppPrimaryThemeColor,
                      onPressed: () async {
                        // TempPlaces().start(gpMapController);
                        // Navigator.of(context).push(MaterialPageRoute(
                        //   builder: (context) {
                        //     return YourExperiencePage(
                        //       parkingId: 36,
                        //       vehicleTypeMasterId: 1,
                        //       slotData: gpSelectedMarkerSlotData,
                        //     );
                        //   },
                        // ));

                        // Navigator.of(context).push(MaterialPageRoute(
                        //   builder: (context) {
                        //     return TransactionPin();
                        //   },
                        // ));

                        // Navigator.of(context).push(MaterialPageRoute(
                        //   builder: (context) {
                        //     return CallTestPage();
                        //   },
                        // ));

                        // Navigator.of(context).push(MaterialPageRoute(
                        //   builder: (context) {
                        //     return LoginDetailsForm(
                        //       userData: gpAppState.userData,
                        //     );
                        //   },
                        // ));

                        // // App Lock Page
                        // Navigator.of(context).push(MaterialPageRoute(
                        //   builder: (context) {
                        //     return AppLockPinChangePage();
                        //   },
                        // ));

                        // Navigator.of(context).push(MaterialPageRoute(
                        //   builder: (context) {
                        //     return NewMapSearchPage(
                        //       onLocationPressed: () {},
                        //       onSearch: onMapSearch,
                        //     );
                        //   },
                        // ));

                        // Navigator.of(context).push(MaterialPageRoute(
                        //   builder: (context) {
                        //     return IconTestPage();
                        //   },
                        // ));

                        // Navigator.of(context).push(MaterialPageRoute(
                        //   builder: (context) {
                        //     return CurveTest();
                        //   },
                        // ));
                      },
                    ),
                  ),

                  AnimatedPositioned(
                    left: 20,
                    bottom: (isParkingInfoOpen) ? 215 : 75,
                    duration: Duration(milliseconds: 350),
                    child: QbFAB(
                      child: Icon(
                        MdiIcons.qrcodeScan,
                        size: 22.5,
                        color: Colors.white,
                      ),
                      size: 50,
                      color: qbAppPrimaryThemeColor,
                      onPressed: () async {
                        if (gpAppStateListen.isInternetConnected == true) {
                          qrCodeScanning();
                        }
                      },
                    ),
                  ),

                  AnimatedPositioned(
                    bottom: 0,
                    duration: Duration(milliseconds: 250),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        child: VehicleBottomBar(
                          onChanged: (type) {
                            vehiclesTypeData.forEach((vehicleTypeData) {
                              if (vehicleTypeData.type == type) {
                                setState(() {
                                  gpSelectedVehicleTypeData = vehicleTypeData;
                                });
                              }
                            });
                          },
                        )),
                  ),

                  AnimatedPositioned(
                    bottom: (isParkingInfoOpen) ? 0 : -195,
                    duration: Duration(milliseconds: 350),
                    curve: Curves.decelerate,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 195,
                      child: ParkingInfoWidget(
                        slotData: gpSelectedMarkerSlotData,
                        onParkHerePressed: (int slotId) {
                          if (isParkingInfoOpen == true) {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return ParkingRequestForm(
                                    //Should be set using vehicle select bottom bar
                                    slotData: gpSelectedMarkerSlotData,
                                    onParkingRequestSent:
                                        (bool parkingRequestSendStatus) {
                                      if (parkingRequestSendStatus == true) {
                                        Navigator.of(context).pop();
                                      }
                                    },
                                    vehicleType:
                                        gpSelectedVehicleTypeData.type);
                              },
                            ));
                          }
                        },
                      ),
                    ),
                  ),

                  AnimatedPositioned(
                    left: (isSideNavOpen) ? 0 : -360,
                    duration: Duration(milliseconds: 350),
                    curve: Curves.ease,
                    child: SideNav(
                      isUserAParkingLord: (gpAppStateListen.isParkingLord),
                      onMenuClose: () {
                        setState(() {
                          isSideNavOpen = false;
                        });
                      },
                    ),
                  ),
                ],
              ),
            )),
        onWillPop: onWillPopBackPressed);
  }

  Future<bool> onWillPopBackPressed() async {
    if (isSideNavOpen) {
      setState(() {
        isSideNavOpen = false;
      });
      return false;
    } else if (isParkingInfoOpen) {
      setState(() {
        isParkingInfoOpen = false;
      });
      return false;
    }
    return true;
  }

  onMarkerTap(int slotId, GPMapSlotMarkerType gpMapSlotMarkerType) {
    setState(() {
      gpSelectedMarkerSlotData = gpAppState.findSlotFromMap(slotId);
      if (gpSelectedVehicleTypeData != null) {
        if (gpMapSlotMarkerType == GPMapSlotMarkerType.spaceAvailable) {
          isParkingInfoOpen = true;
        } else {
          isParkingInfoOpen = false;
        }
      } else {
        FlushBarUtils.showTextResponsive(context, "Select Vehicle Type",
            "Vehicle Must be Selected Before Proccessing");
      }
    });
  }

  onMapCreated(CameraPosition gpCamPos) async {
    // Calling Cam Change from Sockets
    if (gpCamPos != null) {
      onCameraChangeFun(gpCamPos);
    }
  }

  onCameraMove(gpCamPos) async {
    // Calling Cam Change from Sockets
    if (gpCamPos != null) {
      onCameraChangeFun(gpCamPos);
    }
  }

  onCameraChangeFun(CameraPosition gpCamPos) async {
    if ((gpAppState.isInternetConnected == true) && (gpCamPos != null)) {
      gpAppState.socketIO.emit('CameraPosition-change', {
        "socketId": gpAppState.socketIO.id,
        "userId": gpAppState.userData.id,
        "latitude": gpCamPos.target.latitude,
        "longitude": gpCamPos.target.longitude,
        "zoom": gpCamPos.zoom
      });
    }

    gpAppState.setCurrentCameraPosition(gpCamPos);
    if (gpAppState.isInternetConnected == true) {
      // TODO: Uncomment when ready.
      // PlacesDataCollection().fetchAndPostPlacesForCamPos(gpCamPos);
    }
  }

  onCameraIdle() async {
    // TempPlaces.exploreAndPush(gpAppState.currentCameraPosition);
    if (gpAppState.isInternetConnected == true) {
      // TODO: Uncomment when ready.
      // PlacesDataCollection()
      //     .fetchAndPostPlacesForCamPos(gpAppState.currentCameraPosition);
    }
  }

  onMapSearch(CameraPosition gpCamPos) {
    if (gpMapController != null) {
      gpMapController.setCameraPosition(gpCamPos);
    }
  }

  onLocationPressed() {
    if (gpMapController != null) {
      gpMapController.setLocation(16);
    }
  }

  pushNewPlacemark(CameraPosition gpCamPos) async {
    try {
      List<Placemark> placemarks = await Geolocator().placemarkFromCoordinates(
          gpCamPos.target.latitude, gpCamPos.target.longitude);
      // Placemark placemark = (await Geolocator().placemarkFromCoordinates(
      //     gpCamPos.target.latitude, gpCamPos.target.longitude))[0];
      placemarks.forEach((placemark) {
        if (placemark.country == "India") {
          // TODO: uncomment When ready.
          // PlacesApiUtils().postingPlaceData(placemark);
        }
      });
      if (placemarks.length == 0) {
        print("No Locations Found On This Location");
      }
    } catch (error) {
      print("Geocoding Error .....");
    }
  }

  qrCodeScanning() async {
    String qrCode = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Cancel", true, ScanMode.QR);
    if (qrCode != "-1") {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return QRScannerPage(
            qrCode: qrCode,
            onScanAgain: qrCodeScanning,
          );
        },
      ));
    }
  }

  settingUpMarkersAndBookings(AppState appState) {
    List<GPMapSlotMarker> gpMapSlotMarkers = [];
    appState.slotsOnMap.forEach((slotData) {
      if (gpSelectedVehicleTypeData != null) {
        bool isVehicleAllowed = false;
        slotData.vehicles.forEach((vehicleData) {
          if (gpSelectedVehicleTypeData.type == vehicleData.type) {
            isVehicleAllowed = true;
          }
        });

        double vehicleArea = (gpSelectedVehicleTypeData.length *
                gpSelectedVehicleTypeData.breadth)
            .toDouble();
        // Setting Up slot Marker
        GPMapSlotMarkerType gpMapSlotMarkerType;
        if ((DateTime.now().toLocal().hour >= slotData.startTime) &&
            (DateTime.now().toLocal().hour < slotData.endTime)) {
          if ((vehicleArea < slotData.availableSpace) &&
              (gpSelectedVehicleTypeData.height <= slotData.height) &&
              (isVehicleAllowed)) {
            // Space is available for current type.
            gpMapSlotMarkerType = GPMapSlotMarkerType.spaceAvailable;
          } else {
            // Space is available for current type.
            gpMapSlotMarkerType = GPMapSlotMarkerType.spaceUnavailable;
          }
        } else {
          // When Space is Unavailable
          gpMapSlotMarkerType = GPMapSlotMarkerType.unavailable;
        }

        gpMapSlotMarkers.add(GPMapSlotMarker(
            slotId: slotData.id,
            latitude: slotData.latitude,
            longitude: slotData.longitude,
            type: gpMapSlotMarkerType));
      } else {
        GPMapSlotMarkerType gpMapSlotMarkerType;
        if ((DateTime.now().toLocal().hour >= slotData.startTime) &&
            (DateTime.now().toLocal().hour < slotData.endTime)) {
          gpMapSlotMarkerType = GPMapSlotMarkerType.spaceAvailable;
        } else {
          // When Space is Unavailable
          gpMapSlotMarkerType = GPMapSlotMarkerType.unavailable;
        }

        gpMapSlotMarkers.add(GPMapSlotMarker(
            slotId: slotData.id,
            latitude: slotData.latitude,
            longitude: slotData.longitude,
            type: gpMapSlotMarkerType));
      }
    });

    if (gpMapController != null) {
      gpMapController.setGPMapSlotMarkers(gpMapSlotMarkers);
    }
  }
}
