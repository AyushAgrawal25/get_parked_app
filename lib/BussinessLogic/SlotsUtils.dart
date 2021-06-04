import 'dart:convert';

import 'package:getparked/Utils/EncryptionUtils.dart';
import 'package:getparked/StateManagement/Models/SlotData.dart';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:getparked/Utils/DomainUtils.dart';

class SlotsUtils {
  Dio gpDio = Dio();

  // Get Slots From Location And Zoom
  Future<List> getSlotsFromCameraPosition(CameraPosition gpCamPos) async {
    var uri = domainName +
        "/appRoute/slots/map/${gpCamPos.target.latitude}/${gpCamPos.target.longitude}/${gpCamPos.zoom}";
    Response slotsData = await gpDio.get(uri);
    return slotsData.data["data"];
  }

  Map essentialSlotData(List slots, int slotId) {
    Map parkingInfoData = {};
    Map targetSlot;
    slots.forEach((slot) {
      if (slotId == slot["slotId"]) {
        targetSlot = slot;
      }
    });

    if (targetSlot != null) {
      String imageUrl;
      targetSlot["slotImages"].forEach((slotImage) {
        if (slotImage["slotImageType"] == 0) {
          imageUrl = formatImgUrl(slotImage["slotImageUrl"]);
        }
      });

      List slotImages = [];
      slotImages.add(imageUrl);
      targetSlot["slotImages"].forEach((slotImage) {
        if (slotImage["slotImageType"] == 1) {
          slotImages.add(formatImgUrl(slotImage["slotImageUrl"]));
        }
      });

      parkingInfoData = {
        "slotId": targetSlot["slotId"],
        "slotName": targetSlot["slotName"],
        "slotMainImageUrl": imageUrl,
        "slotParkingType": targetSlot["slotSpecSpaceParkingType"],
        "slotParkingRating": 3.75,
        "slotParkingStartTime": targetSlot["slotSpecParkingStartTime"],
        "slotParkingEndTime": targetSlot["slotSpecParkingEndTime"],
        "slotUserName": targetSlot["userDetailFirstName"] +
            " " +
            targetSlot["userDetailLastName"],
        "slotUserId": targetSlot["slotUserId"],
        "slotUserProfilePicUrl": targetSlot["userProfilePicUrl"],
        "slotImages": slotImages,
        "slotVehicles": targetSlot["vehicles"],
        "slotSpecSecurityDepositTime": targetSlot["slotSpecSecurityDepositTime"]
      };
    }

    return parkingInfoData;
  }

  //Check is Slots Data updated or not
  bool isSlotsUpdated(List newSlotsData, List oldSlotsData) {
    if (oldSlotsData == null) {
      print("Old Slots Data is null");
      if (newSlotsData == null) {
        return false;
      } else {
        return true;
      }
    } else {
      if (newSlotsData == null) {
        return false;
      } else {
        bool isUpdated = false;

        // bool isExactCopyPresent = true;
        // newSlotsData.forEach((newSlotData) {
        //   bool isSlotAlreadyPresent = false;
        //   oldSlotsData.forEach((oldSlotData) {
        //     if (newSlotData["slotId"] == oldSlotData["slotId"]) {
        //       isSlotAlreadyPresent = true;

        //       if (newSlotData.toString() != oldSlotData.toString()) {
        //         isExactCopyPresent = false;
        //       }
        //     }
        //   });
        //   if (!isSlotAlreadyPresent) {
        //     isUpdated = true;
        //   } else {
        //     if (!isExactCopyPresent) {
        //       isUpdated = true;
        //     }
        //   }
        // });

        if (newSlotsData.toString() != oldSlotsData.toString()) {
          isUpdated = true;
        } else {
          isUpdated = false;
        }

        return isUpdated;
      }
    }
  }

  List updateSlots(List newSlotsData, List oldSlotsData) {
    if (oldSlotsData == null) {
      if (newSlotsData == null) {
        return null;
      } else {
        return newSlotsData;
      }
    } else {
      if (newSlotsData == null) {
        return oldSlotsData;
      } else {
        List updatedSlotsData = [];

        // Code For Updating Slots
        updatedSlotsData = newSlotsData;
        print("Old Length ${updatedSlotsData.length}");

        oldSlotsData.forEach((oldSlotData) {
          bool isSlotAlreadyPresent = false;
          newSlotsData.forEach((newSlotData) {
            if (newSlotData["slotId"] == oldSlotData["slotId"]) {
              isSlotAlreadyPresent = true;
            }
          });
          if (!isSlotAlreadyPresent) {
            updatedSlotsData.add(oldSlotData);
          }
        });

        return updatedSlotsData;
      }
    }
  }

  //Parking Request
  Future<bool> sendParkingRequest(Map requestData) async {
    try {
      Response requestResponse = await gpDio.post(
          domainName + "/appRoute/slots/parkingRequest",
          data: requestData);
      if (requestResponse.data["status"] == 1) {
        return true;
      } else {
        return false;
      }
    } catch (excp) {
      return false;
    }
  }

  //Parking Request Response
  Future<Map> responseParkingRequest(Map responseData) async {
    Response requestResponse = await gpDio.post(
        domainName + "/appRoute/slots/parkingRequestResponse",
        data: responseData);

    return requestResponse.data;
  }

  // Booking
  Future<Map> booking(Map bookingData, String userAccessToken) async {
    Map<String, dynamic> headers = {"userAccessToken": userAccessToken};

    Response bookingResp = await gpDio.post(
        domainName + "/appRoute/slots/booking",
        data: bookingData,
        options: Options(headers: headers));

    return bookingResp.data;
  }

  // Booking Cancellation
  Future<Map> bookingCancellation(
      Map bookingCancellationData, String userAccessToken) async {
    Map<String, dynamic> headers = {"userAccessToken": userAccessToken};

    Response bookingCancellationResp = await gpDio.post(
        domainName + "/appRoute/slots/bookingCancellation",
        data: bookingCancellationData,
        options: Options(headers: headers));

    return bookingCancellationResp.data;
  }

  // Initiate Parking
  Future<Map> initiateParking(Map parkingData, String slotToken) async {
    Map<String, dynamic> headers = {"slotToken": slotToken};

    Response parkingResp = await gpDio.post(
        domainName + "/appRoute/slots/parking",
        data: parkingData,
        options: Options(headers: headers));

    return parkingResp.data;
  }

  // Complete Parking
  Future<Map> parkingWithdraw(Map parkingWithdrawData, String slotToken) async {
    Map<String, dynamic> headers = {"slotToken": slotToken};

    Response parkingWithdrawResp = await gpDio.post(
        domainName + "/appRoute/slots/parkingWithdraw",
        data: parkingWithdrawData,
        options: Options(headers: headers));

    return parkingWithdrawResp.data;
  }

  Future<SlotData> getSlotDetailsFromQRCode(
      String qrCode, String userAccessToken) async {
    String slotQRCode = EncryptionUtils.aesDecryption(qrCode);
    Map slotQRData = json.decode(slotQRCode);
    // String slotToken =
    //     "IAaLd2dRGFQjzyL2tGPtNPxDPdM9n7F9TiP+C726AwE1vDxlF2bGnQ==";
    if (slotQRData == null) {
      return null;
    } else {
      Response slotResp = await gpDio.post(
          domainName + "/appRoute/slots/slotDetails",
          data: slotQRData,
          options: Options(headers: {"userAccessToken": userAccessToken}));
      if (slotResp.data["status"] == 1) {
        SlotData slotData = SlotDataUtils.mapToSlotData(slotResp.data["data"]);
        return slotData;
      } else {
        return null;
      }
    }
  }
}
