class UserData {
  int id;
  String email;
  int signUpStatus;
  int status;

  UserData({
    this.id,
    this.email,
    this.signUpStatus,
    this.status,
  });

  UserData.fromMap(Map<String, dynamic> userMap) {
    if (userMap != null) {
      id = userMap["id"];
      email = userMap["email"];
      signUpStatus = userMap["signUpStatus"];
      status = userMap["status"];
    }
  }
}

class UserDataUtils {
  Map toMap(UserData userData) {
    return {
      "id": userData.id,
      "email": userData.email,
      "signUpStatus": userData.signUpStatus,
      "status": userData.status
    };
  }

  UserData fromMapToUserData(Map userDataMap) {
    return UserData(
        id: userDataMap["id"],
        email: userDataMap["email"],
        signUpStatus: userDataMap["signUpStatus"],
        status: userDataMap["status"]);
  }

  UserAccountType accountTypeFromString(String userAccType) {
    if (userAccType == "User") {
      return UserAccountType.user;
    } else if (userAccType == "Slot") {
      return UserAccountType.slot;
    } else {
      return UserAccountType.admin;
    }
  }

  String accountTypeAsString(UserAccountType userAccType) {
    String type = "";
    switch (userAccType) {
      case UserAccountType.user:
        type = "User";
        break;
      case UserAccountType.slot:
        type = "Slot";
        break;
      case UserAccountType.admin:
        type = "Admin";
        break;
    }

    return type;
  }
}

enum UserAccountType { slot, user, admin }
