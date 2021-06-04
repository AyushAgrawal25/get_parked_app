class UserDetails {
  int id;
  String email;
  String firstName;
  String lastName;
  String dialCode;
  String phoneNumber;
  String gender;
  String profilePicUrl;
  String profilePicThumbnailUrl;
  int loginStatus;
  int status;

  UserGender getGenderType() {
    return UserDetailsUtils.setGenderTypeFromString(gender);
  }

  UserDetails.fromMap(Map userDetailsMap) {
    id = userDetailsMap["userId"];
    email = userDetailsMap["userEmail"];
    firstName = userDetailsMap["userDetailFirstName"];
    lastName = userDetailsMap["userDetailLastName"];
    gender = userDetailsMap["userDetailGender"];
    loginStatus = userDetailsMap["userLogInStatus"];
    dialCode = userDetailsMap["userDetailDialCode"];
    phoneNumber = userDetailsMap["userDetailPhoneNumber"];
    profilePicUrl = userDetailsMap["userProfilePicUrl"];
    profilePicThumbnailUrl = userDetailsMap["userProfilePicThumbnailUrl"];
    status = userDetailsMap["userStatus"];
  }

  UserDetails({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.dialCode,
    this.phoneNumber,
    this.gender,
    this.profilePicUrl,
    this.profilePicThumbnailUrl,
    this.loginStatus,
    this.status,
  });
}

class UserDetailsUtils {
  static UserGender setGenderTypeFromString(String gender) {
    UserGender userGender;
    switch (gender) {
      case "Male":
        userGender = UserGender.male;
        break;
      case "Female":
        userGender = UserGender.female;
        break;
      case "Others":
        userGender = UserGender.others;
        break;
    }

    return userGender;
  }

  static String getStringFromGenderType(UserGender userGender) {
    String gender;
    switch (userGender) {
      case UserGender.male:
        gender = "Male";
        break;
      case UserGender.female:
        gender = "Female";
        break;
      case UserGender.others:
        gender = "Others";
        break;
    }

    return gender;
  }

  static Map toMap(UserDetails userDetails) {
    return {
      "userId": userDetails.id,
      "userEmail": userDetails.email,
      "userDetailFirstName": userDetails.firstName,
      "userDetailLastName": userDetails.lastName,
      "userDetailPhoneNumber": userDetails.phoneNumber,
      "userDetailDialCode": userDetails.dialCode,
      "userDetailGender": userDetails.gender,
      "userProfilePicUrl": userDetails.profilePicUrl,
      "userProfilePicThumbnailUrl": userDetails.profilePicThumbnailUrl,
      "userLogInStatus": userDetails.loginStatus,
      "userStatus": userDetails.status
    };
  }

  static UserDetails fromMapToUserDetails(Map userDetailsMap) {
    return UserDetails(
      id: userDetailsMap["userId"],
      email: userDetailsMap["userEmail"],
      firstName: userDetailsMap["userDetailFirstName"],
      lastName: userDetailsMap["userDetailLastName"],
      gender: userDetailsMap["userDetailGender"],
      loginStatus: userDetailsMap["userLogInStatus"],
      dialCode: userDetailsMap["userDetailDialCode"],
      phoneNumber: userDetailsMap["userDetailPhoneNumber"],
      profilePicUrl: userDetailsMap["userProfilePicUrl"],
      profilePicThumbnailUrl: userDetailsMap["userProfilePicThumbnailUrl"],
      status: userDetailsMap["userStatus"],
    );
  }
}

enum UserGender { male, female, others }
