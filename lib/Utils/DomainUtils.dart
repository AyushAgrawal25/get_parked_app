import 'package:getparked/Utils/EncryptionUtils.dart';
import 'package:getparked/encryptionConfig.dart';

const String HOST_NAME = "192.168.42.175";
// const String HOST_NAME = "urownsite.xyz";
const String HOST_PORT = "5000";
String domainName = "http://" + HOST_NAME + ":" + HOST_PORT;

String appName = "Get Parked";

String universalAPIToken = UNIVERSAL_API_TOKEN;

String formatImgUrl(String imgUrl) {
  if (imgUrl == null) {
    return null;
  }
  return domainName + imgUrl;
}
