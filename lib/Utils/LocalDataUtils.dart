import 'dart:convert';

import 'package:getparked/Utils/EncryptionUtils.dart';
import 'package:getparked/Utils/FileUtils.dart';
import 'package:getparked/StateManagement/Models/ParkingLordData.dart';
import 'package:getparked/StateManagement/Models/UserData.dart';
import 'package:getparked/StateManagement/Models/UserDetails.dart';

class LocalDataUtils {
  // For File Name On The Basis of Type
  String _getFileNameOnBasisOfType(LocalDataType type) {
    String fileName;
    switch (type) {
      case LocalDataType.transactions:
        fileName = "Transactions";
        break;
      case LocalDataType.notifications:
        fileName = "Notifications";
        break;
      case LocalDataType.userParkings:
        fileName = "UserParkings";
        break;
      case LocalDataType.slotParkings:
        fileName = "SlotParkings";
        break;
      case LocalDataType.money:
        fileName = "Money";
        break;
    }

    return fileName;
  }

  // Encrypted User Data
  Future saveUserData(UserData userData) async {
    Map userDataMap = UserDataUtils().toMap(userData);
    String userDataAsString = json.encode(userDataMap);
    String encryptedData = EncryptionUtils.aesEncryption(userDataAsString);
    FileUtils.saveDataInFile("User", encryptedData);
  }

  Future<UserData> readUserData() async {
    String encryptedUserData = await FileUtils.readDataFromFile("User");
    String userDataAsString = EncryptionUtils.aesDecryption(encryptedUserData);
    Map userDataMap = json.decode(userDataAsString);
    return UserDataUtils().fromMapToUserData(userDataMap);
  }

  // Encrypted User Details
  Future saveUserDetails(UserDetails userDetails) async {
    Map userDetailsMap = UserDetailsUtils.toMap(userDetails);
    String userDetailsAsString = json.encode(userDetailsMap);
    String encryptedData = EncryptionUtils.aesEncryption(userDetailsAsString);
    FileUtils.saveDataInFile("UserDetails", encryptedData);
  }

  Future<UserDetails> readUserDetails() async {
    String encryptedUserData = await FileUtils.readDataFromFile("UserDetails");
    String userDataAsString = EncryptionUtils.aesDecryption(encryptedUserData);
    Map userDetailsMap = json.decode(userDataAsString);
    return UserDetailsUtils.fromMapToUserDetails(userDetailsMap);
  }

  // Encrypted Parking Lord Data
  Future saveParkingLordData(ParkingLordData parkingLordData) async {
    Map parkingLordDataMap = parkingLordData.data;
    String parkingLordDataAsString = json.encode(parkingLordDataMap);
    String encryptedData =
        EncryptionUtils.aesEncryption(parkingLordDataAsString);
    FileUtils.saveDataInFile("ParkingLord", encryptedData);
  }

  Future<ParkingLordData> readParkingLordData() async {
    String encryptedParkingLordData =
        await FileUtils.readDataFromFile("ParkingLord");
    String parkingLordDataAsString =
        EncryptionUtils.aesDecryption(encryptedParkingLordData);
    Map parkingLordDataMap = json.decode(parkingLordDataAsString);
    return ParkingLordData.fromMap(parkingLordDataMap);
  }

  // For Parkings, Transactions And Notifications
  Future saveLocalData(LocalDataType type, List data) async {
    String fileName = _getFileNameOnBasisOfType(type);
    String dataAsString = json.encode(data);
    await FileUtils.saveDataInFile(fileName, dataAsString);
  }

  Future<List> readLocalData(LocalDataType type) async {
    String fileName = _getFileNameOnBasisOfType(type);
    String dataAsString = await FileUtils.readDataFromFile(fileName);
    List data = json.decode(dataAsString);
    return data;
  }

  Future savingAmountData(double walletAmt, double vaultAmt) async {
    String fileName = _getFileNameOnBasisOfType(LocalDataType.money);
    Map amtData = {"walletAmount": walletAmt, "vaultAmount": vaultAmt};
    String amtDataAsString = json.encode(amtData);
    await FileUtils.saveDataInFile(fileName, amtDataAsString);
  }

  Future<Map> readAmountData() async {
    String fileName = _getFileNameOnBasisOfType(LocalDataType.money);
    String amtDataAsString = await FileUtils.readDataFromFile(fileName);
    Map amtData = json.decode(amtDataAsString);
    return amtData;
  }
}

enum LocalDataType {
  transactions,
  notifications,
  userParkings,
  slotParkings,
  money
}
