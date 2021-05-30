class UserData {
  int id;
  String email;
  String accessToken;
  int loginStatus;
  int status;

  UserData({
    this.id,
    this.email,
    this.accessToken,
    this.loginStatus,
    this.status,
  });

  UserData copyWith({
    int id,
    String email,
    String accessToken,
    int loginStatus,
    int status,
  }) {
    return UserData(
      id: id ?? this.id,
      email: email ?? this.email,
      accessToken: accessToken ?? this.accessToken,
      loginStatus: loginStatus ?? this.loginStatus,
      status: status ?? this.status,
    );
  }
}

class UserDataUtils {
  Map toMap(UserData userData) {
    return {
      "id": userData.id,
      "email": userData.email,
      "accessToken": userData.accessToken,
      "logInStatus": userData.loginStatus,
      "status": userData.status
    };
  }

  UserData fromMapToUserData(Map userDataMap) {
    return UserData(
        id: userDataMap["id"],
        accessToken: userDataMap["accessToken"],
        email: userDataMap["email"],
        loginStatus: userDataMap["logInStatus"],
        status: userDataMap["status"]);
  }
}
