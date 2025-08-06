import 'package:local_auth/local_auth.dart';

class AuthHelper {
  static final _auth = LocalAuthentication();

  static Future<bool> authenticate() async {
    try {
      bool canCheckBiometrics = await _auth.canCheckBiometrics;
      bool isDeviceSupported = await _auth.isDeviceSupported();

      if (!canCheckBiometrics || !isDeviceSupported) return false;

      return await _auth.authenticate(
        localizedReason: 'Akses vault dengan sidik jari atau PIN',
        options: const AuthenticationOptions(
          biometricOnly: false,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      print("Auth error: $e");
      return false;
    }
  }
}
