import 'dart:convert';

import 'package:encrypt/encrypt.dart';
import 'package:getparked/Utils/EncryptionUtils.dart';
import 'package:getparked/encryptionConfig.dart';

class TransactionUtils {
  // static final _key = Key.fromLength(32);
  static final _key = Key.fromUtf8(ENCRYPTION_KEY.substring(0, 32));
  static final _iv = IV.fromLength(16);

  static final aesEncrypter = Encrypter(AES(_key, mode: AESMode.cbc));

  Map<String, dynamic> getEncryptedData(String encrypted) {
    try {
      String oneTimeDecryption = aesEncrypter.decrypt64(encrypted, iv: _iv);
      String dataAsString = aesEncrypter.decrypt64(oneTimeDecryption, iv: _iv);
      return json.decode(dataAsString);
    } catch (excp) {
      print(excp);
      return null;
    }
  }

  String encryptData(Map<String, dynamic> dataMap) {
    String data = json.encode(dataMap);
    try {
      String oneTimeEncryption = aesEncrypter.encrypt(data, iv: _iv).base64;
      return aesEncrypter.encrypt(oneTimeEncryption, iv: _iv).base64;
    } catch (exp) {
      print(exp);
      return null;
    }
  }
}
