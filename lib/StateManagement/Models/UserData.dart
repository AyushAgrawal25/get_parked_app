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
}
