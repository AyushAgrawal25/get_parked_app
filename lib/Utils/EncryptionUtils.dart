import 'package:encrypt/encrypt.dart';

class EncryptionUtils {
  // Encryption Keys
  static final _key = Key.fromLength(32);
  static final _iv = IV.fromLength(16);

  // AES Encrypter
  static final aesEncrypter = Encrypter(AES(_key));

  // AES Encryption AND Decryption
  static String aesEncryption(String data) {
    try {
      String oneTimeEncryption = aesEncrypter.encrypt(data, iv: _iv).base64;
      return aesEncrypter.encrypt(oneTimeEncryption, iv: _iv).base64;
    } catch (exp) {
      return null;
    }
  }

  static String aesDecryption(String data) {
    try {
      String oneTimeDecryption = aesEncrypter.decrypt64(data, iv: _iv);
      return aesEncrypter.decrypt64(oneTimeDecryption, iv: _iv);
    } catch (exp) {
      return null;
    }
  }
}
