import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

// ignore: must_be_immutable
class GPMap extends StatefulWidget {
  Function getController;
  Function onCameraMove;
  double initialZoom;
  Function(int, GPMapSlotMarkerType) onMarkerTap;
  Function onTapOnMap;
  Function onMapCreated;
  Function onCameraIdle;
  Function onCameraMoveStarted;

  GPMap(
      {@required this.getController,
      this.onCameraMove,
      this.initialZoom: 12,
      this.onMarkerTap,
      this.onTapOnMap,
      this.onMapCreated,
      this.onCameraIdle,
      this.onCameraMoveStarted});

  @override
  _GPMapState createState() => _GPMapState();
}

class GPMapController {
  Function changeText;
  Function(double) setLocation;
  Function(CameraPosition) setCameraPosition;
  Function getCameraPostion;
  Function setMarkers;
  Function setGPMapSlotMarkers;

  GPMapController(
      {this.changeText,
      this.setLocation,
      this.setCameraPosition,
      this.getCameraPostion,
      this.setMarkers,
      this.setGPMapSlotMarkers});
}

class _GPMapState extends State<GPMap> {
  String centerText = "Hello World !";

  GPMapController qbGPMapController;

  Completer<GoogleMapController> mapComplete = Completer();
  GoogleMapController qbMapController;

  //Bilaspur Location
  static LatLng centerLocation = const LatLng(22.0797, 82.1409);
  static double gpMapTextScaleFactor = 1;

  //Markers
  List<Marker> mapMarkers = [];

  //Securing last map position
  LatLng lastMapPosition = centerLocation;
  CameraPosition lastCameraPosition;

  //Map type
  MapType currentMapType = MapType.normal;

  //Location
  Location qbLocation = Location();

  onMapCreatedFun(GoogleMapController qbGoogleMapController) async {
    print("GPMaps Created And Initialized...");
    mapComplete.complete(qbGoogleMapController);
    qbMapController = qbGoogleMapController;

    //Setting Map Style.

    if (widget.onMapCreated != null) {
      widget.onMapCreated(
          CameraPosition(target: centerLocation, zoom: widget.initialZoom));
    }

    // Setting Up Text Scale Factor
    gpMapTextScaleFactor = MediaQuery.of(context).textScaleFactor;

    // Creating Slot Markers
    createGPSlotSpaceAvailableMarkerIcon();
    createGPSlotSpaceUnavailableMarkerIcon();
    createGPSlotUnavailableMarkerIcon();

    setLocation(widget.initialZoom);
  }

  onCameraMoveFun(CameraPosition qbCamPos) {
    lastMapPosition = qbCamPos.target;
    lastCameraPosition = qbCamPos;

    if (widget.onCameraMove != null) {
      widget.onCameraMove(qbCamPos);
    }
  }

  //For location
  setLocation(zoom) async {
    LocationData qbUserPosition = await qbLocation.getLocation();
    // GeoLoc.Position gpUserPosition = await GeoLoc.Geolocator().getCurrentPosition(desiredAccuracy: GeoLoc.LocationAccuracy.bestForNavigation);
    //Calling on get location function

    qbMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(qbUserPosition.latitude, qbUserPosition.longitude),
        zoom: zoom)));
  }

  changeTextFun(val) {
    setState(() {
      centerText = val;
    });
  }

  // Slot Unavailable Marker Icons
  BitmapDescriptor gpSlotUnavailableMarker;
  createGPSlotUnavailableMarkerIcon() async {
    final Uint8List markerIcon = await getBytesFromAsset(
        'assets/images/gpSlotUnavailableMarker.png',
        (100 ~/ gpMapTextScaleFactor).toInt());
    gpSlotUnavailableMarker = BitmapDescriptor.fromBytes(markerIcon);
  }

  // Slot Space Unavailable Marker Icons
  BitmapDescriptor gpSlotSpaceUnavailableMarker;
  createGPSlotSpaceUnavailableMarkerIcon() async {
    final Uint8List markerIcon = await getBytesFromAsset(
        'assets/images/gpSlotSpaceUnavailableMarker.png',
        (100 ~/ gpMapTextScaleFactor).toInt());
    gpSlotSpaceUnavailableMarker = BitmapDescriptor.fromBytes(markerIcon);
  }

  // Slot Space Available Marker Icons
  BitmapDescriptor gpSlotSpaceAvailableMarker;
  createGPSlotSpaceAvailableMarkerIcon() async {
    final Uint8List markerIcon = await getBytesFromAsset(
        'assets/images/gpSlotSpaceAvailableMarker.png',
        (100 ~/ gpMapTextScaleFactor).toInt());
    gpSlotSpaceAvailableMarker = BitmapDescriptor.fromBytes(markerIcon);
  }

  BitmapDescriptor locationPin;
  createLocationPin() async {
    final Uint8List markerIcon =
        await getBytesFromAsset('assets/images/gpMarker.png', 80);
    locationPin = BitmapDescriptor.fromBytes(markerIcon);
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  @override
  void initState() {
    createLocationPin();

    super.initState();

    lastCameraPosition =
        CameraPosition(target: lastMapPosition, zoom: widget.initialZoom);

    qbGPMapController = GPMapController(changeText: (val) {
      changeTextFun(val);
    }, setLocation: (double zoom) {
      setLocation(zoom);
    }, setCameraPosition: (CameraPosition qbCameraPosition) {
      qbMapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(qbCameraPosition.target.latitude,
                  qbCameraPosition.target.longitude),
              zoom: qbCameraPosition.zoom)));
    }, getCameraPostion: () {
      CameraPosition gpCamPos = lastCameraPosition;

      return gpCamPos;
    }, setMarkers: (List gpMapMarkers) {
      List<Marker> psuedoMapMarkers = [];
      gpMapMarkers.forEach((gpMapMarker) {
        Marker mapMarker = Marker(
            markerId: MarkerId(gpMapMarker["slotId"].toString()),
            draggable: false,
            icon: locationPin,
            onTap: () {
              widget.onMarkerTap(
                  gpMapMarker["slotId"], GPMapSlotMarkerType.spaceAvailable);
            },
            position:
                LatLng(gpMapMarker["latitude"], gpMapMarker["longitude"]));

        psuedoMapMarkers.add(mapMarker);
      });

      setState(() {
        mapMarkers = psuedoMapMarkers;
      });
    }, setGPMapSlotMarkers: (List<GPMapSlotMarker> gpMapSlotMarkers) {
      List<Marker> gpMapMarkers = [];
      gpMapSlotMarkers.forEach((gpMapSlotMarker) {
        // Setting Up Marker
        BitmapDescriptor gpMarkerIcon;
        switch (gpMapSlotMarker.type) {
          case GPMapSlotMarkerType.unavailable:
            gpMarkerIcon = gpSlotUnavailableMarker;
            break;
          case GPMapSlotMarkerType.spaceAvailable:
            gpMarkerIcon = gpSlotSpaceAvailableMarker;
            break;
          case GPMapSlotMarkerType.spaceUnavailable:
            gpMarkerIcon = gpSlotSpaceUnavailableMarker;
            break;
        }

        gpMapMarkers.add(Marker(
            markerId: MarkerId(gpMapSlotMarker.slotId.toString()),
            draggable: false,
            icon: gpMarkerIcon,
            onTap: () {
              qbGPMapController.setCameraPosition(CameraPosition(
                  zoom: 18.5,
                  target: LatLng(
                      gpMapSlotMarker.latitude, gpMapSlotMarker.longitude)));
              widget.onMarkerTap(gpMapSlotMarker.slotId, gpMapSlotMarker.type);
            },
            position:
                LatLng(gpMapSlotMarker.latitude, gpMapSlotMarker.longitude)));
      });

      setState(() {
        mapMarkers = gpMapMarkers;
      });
    });
  }

  bool isFirstTime = true;

  @override
  Widget build(BuildContext context) {
    if (isFirstTime) {
      widget.getController(qbGPMapController);
      isFirstTime = false;
    }
    gpMapTextScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Container(
        child: GoogleMap(
            initialCameraPosition: CameraPosition(
                target: centerLocation, zoom: widget.initialZoom),
            onCameraMove: onCameraMoveFun,
            myLocationButtonEnabled: true,
            onMapCreated: onMapCreatedFun,
            onTap: (latlng) {
              if (widget.onTapOnMap != null) {
                widget.onTapOnMap();
              }
            },
            onCameraIdle: () {
              if (widget.onCameraIdle != null) {
                widget.onCameraIdle();
              }
            },
            onCameraMoveStarted: () {
              if (widget.onCameraMoveStarted != null) {
                widget.onCameraMoveStarted();
              }
            },
            tiltGesturesEnabled: false,
            mapType: MapType.normal,
            zoomControlsEnabled: false,
            compassEnabled: false,
            liteModeEnabled: false,
            // There occurs an error due to marker data null solve it.
            markers:
                (mapMarkers != null) ? Set.from(mapMarkers) : Set<Marker>()));
  }
}

class GPMapSlotMarker {
  int slotId;
  double latitude;
  double longitude;
  GPMapSlotMarkerType type;

  GPMapSlotMarker({this.slotId, this.longitude, this.latitude, this.type});
}

enum GPMapSlotMarkerType {
  unavailable,
  spaceAvailable,
  spaceUnavailable,
}
