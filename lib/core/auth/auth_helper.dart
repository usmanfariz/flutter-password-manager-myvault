import 'package:local_auth/local_auth.dart';

class AuthHelper {
  static final _auth = LocalAuthentication();

  static Future<bool> authenticate() async {
    try {
      final isAvailable = await _auth.canCheckBiometrics;
      final isSupported = await _auth.isDeviceSupported();

      if (!isAvailable || !isSupported) return false;

      return await _auth.authenticate(
        localizedReason: 'Autentikasi dengan sidik jari atau wajah',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      print('Error saat autentikasi: $e');
      return false;
    }
  }
}
