import 'package:encrypt/encrypt.dart';

class EncryptionHelper {
  // Ganti dengan kunci 32-byte kamu sendiri
  static final _key = Key.fromUtf8('my32lengthsupersecretnooneknows1'); 
  static final _iv = IV.fromLength(16); // IV 16-byte (acak bisa juga disimpan per-entry)

  static String encrypt(String plainText) {
    final encrypter = Encrypter(AES(_key));
    final encrypted = encrypter.encrypt(plainText, iv: _iv);
    return encrypted.base64;
  }

  static String decrypt(String encryptedText) {
    final encrypter = Encrypter(AES(_key));
    final decrypted = encrypter.decrypt64(encryptedText, iv: _iv);
    return decrypted;
  }
}
