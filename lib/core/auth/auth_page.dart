import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final LocalAuthentication auth = LocalAuthentication();
  bool _isAuthenticating = false;
  String _authStatus = 'Mengautentikasi...';

  @override
  void initState() {
    super.initState();
    _authenticate();
  }

  Future<void> _authenticate() async {
    try {
      setState(() {
        _isAuthenticating = true;
        _authStatus = 'Mengecek fingerprint...';
      });

      final didAuthenticate = await auth.authenticate(
        localizedReason: 'Gunakan sidik jari atau PIN untuk mengakses MyVault',
        options: const AuthenticationOptions(
          biometricOnly: false,
          stickyAuth: true,
        ),
      );

      if (didAuthenticate) {
        Navigator.pushReplacementNamed(context, '/vault');
      } else {
        setState(() {
          _authStatus = 'Autentikasi dibatalkan.';
        });
      }
    } catch (e) {
      setState(() {
        _authStatus = 'Gagal autentikasi: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Autentikasi')),
      body: Center(
        child: _isAuthenticating
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text(_authStatus),
                ],
              )
            : ElevatedButton(
                onPressed: _authenticate,
                child: Text('Coba Lagi'),
              ),
      ),
    );
  }
}
