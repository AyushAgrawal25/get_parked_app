import 'package:getparked/Utils/EncryptionUtils.dart';

const String HOST_NAME = "192.168.42.175";
const String HOST_PORT = "5000";
String domainName = "http://192.168.42.175:5000";
// String domainName = "http://3.21.53.195:3000";
String appName = "Get Parked";
// String universalAPIToken = "926647c2821c814182b5b02b135733b66f0d2c048c5f5d2910";
// TODO: change with correct API TOken.
String universalAPIToken =
    "fd252f2f0fc5b4243957e934886d8b481b0ee2262cee2320bc979d3968263699a7096e73135caa02a48eec02b0adc225ae03de182e34059a46215f712672687dbecc57bfed4c1c3093ec0e05a9ae83401338e2eec3cf9876c59c231c1964b6ec9221ea46bc553a17f1a90feb125d4d01707cbf1da2fcf02389a01d0ad08a803f0fd93e8157e7d661d87d5f3ad4ff99d9";
String getUniversalAPIKey() {
  return EncryptionUtils.aesEncryption(universalAPIToken);
}

String formatImgUrl(String imgUrl) {
  if (imgUrl == null) {
    return null;
  }
  return domainName + imgUrl;
}
