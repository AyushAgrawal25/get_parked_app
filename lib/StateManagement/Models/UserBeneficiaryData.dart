class UserBeneficiaryData {
  int id;
  int userId;
  String name;
  String accountNumber;
  String ifscCode;
  String bankName;
  String upiId;
  int status;

  UserBeneficiaryData.fromMap(Map beneficiaryMap) {
    if (beneficiaryMap != null) {
      if (beneficiaryMap["id"] != null) {
        id = beneficiaryMap["id"];
      }

      if (beneficiaryMap["userId"] != null) {
        userId = beneficiaryMap["userId"];
      }

      if (beneficiaryMap["beneficiaryName"] != null) {
        name = beneficiaryMap["beneficiaryName"];
      }

      if (beneficiaryMap["accountNumber"] != null) {
        accountNumber = beneficiaryMap["accountNumber"];
      }

      if (beneficiaryMap["ifscCode"] != null) {
        ifscCode = beneficiaryMap["ifscCode"];
      }

      if (beneficiaryMap["bankName"] != null) {
        bankName = beneficiaryMap["bankName"];
      }

      if (beneficiaryMap["upiId"] != null) {
        upiId = beneficiaryMap["upiId"];
      }

      if (beneficiaryMap["status"] != null) {
        status = beneficiaryMap["status"];
      }
    }
  }
}

const String SBI_BANK = "SBI";
