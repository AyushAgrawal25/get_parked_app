import 'package:flutter/cupertino.dart';

class ContactData {
  int id;
  int userId;
  String displayName;
  String dialCode;
  String phoneNumber;
  String gender;
  String profilePicUrl;
  String thumbnailUrl;
  bool isAppUser;

  ContactData(
      {this.id,
      this.userId,
      this.displayName,
      this.dialCode,
      this.phoneNumber,
      this.gender,
      this.profilePicUrl,
      this.thumbnailUrl,
      this.isAppUser});

  ContactData.fromMap(Map gpContactMap) {
    if (gpContactMap != null) {
      id = gpContactMap["userDetailId"];
      userId = gpContactMap["userDetailUserId"];
      if ((gpContactMap["userDetailFirstName"] != null) &&
          (gpContactMap["userDetailLastName"] != null)) {
        displayName = gpContactMap["userDetailFirstName"].trim() +
            " " +
            gpContactMap["userDetailLastName"].trim();
      } else if (gpContactMap["displayName"] != null) {
        displayName = gpContactMap["displayName"];
      } else if (gpContactMap["name"] != null) {
        displayName = gpContactMap["name"];
      }
      dialCode = gpContactMap["userDetailDialCode"];
      phoneNumber = gpContactMap["userDetailPhoneNumber"];
      gender = gpContactMap["userDetailGender"];
      profilePicUrl = gpContactMap["userProfilePicUrl"];
      thumbnailUrl = gpContactMap["userProfilePicThumbnailUrl"];

      if (gpContactMap["isAppUser"] != null) {
        isAppUser = gpContactMap["isAppUser"];
      } else {
        isAppUser = false;
      }
    }
  }

  String getSearchDetails() {
    return this.displayName + " " + this.phoneNumber;
  }
}
