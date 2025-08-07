import 'package:myvault/core/crypto/encryption_helper.dart';

class PasswordModel {
  final String id;
  final String title;
  final String username;
  final String password;

  PasswordModel({
    required this.id,
    required this.title,
    required this.username,
    required this.password,
  });

  // Factory untuk buat instance dari data terenkripsi
  factory PasswordModel.fromEncrypted(String id, String encryptedText) {
    try {
      final decrypted = EncryptionHelper.decrypt(encryptedText);
      // ignore: unnecessary_null_comparison
      if (decrypted == null) {
        throw Exception("Failed to decrypt");
      }

      final parts = decrypted.split('|');
      if (parts.length != 3) {
        throw Exception("Invalid format");
      }

      return PasswordModel(
        id: id,
        title: parts[0],
        username: parts[1],
        password: parts[2],
      );
    } catch (e) {
      print("Decryption error for $id: $e");
      return PasswordModel(
        id: id,
        title: 'Error',
        username: '',
        password: '',
      );
    }
  }
}
