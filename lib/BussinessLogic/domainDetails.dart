import 'package:getparked/Utils/EncryptionUtils.dart';

String domainName = "http://3.21.53.195:3000";
String appName = "Get Parked";
String universalAPIToken = "926647c2821c814182b5b02b135733b66f0d2c048c5f5d2910";
String getUniversalAPIKey() {
  return EncryptionUtils.aesEncryption(universalAPIToken);
}

String formatImgUrl(String imgUrl) {
  if (imgUrl == null) {
    return null;
  }
  return domainName + imgUrl;
}
