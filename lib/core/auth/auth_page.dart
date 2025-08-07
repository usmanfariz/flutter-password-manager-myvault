import 'package:flutter/material.dart';
import 'auth_helper.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MyVault')),
      body: Center(
        child: ElevatedButton.icon(
          icon: Icon(Icons.fingerprint),
          label: Text('Autentikasi'),
          onPressed: () async {
            final isAuthenticated = await AuthHelper.authenticate();
            if (isAuthenticated) {
              Navigator.pushReplacementNamed(context, '/vault');
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Autentikasi gagal')),
              );
            }
          },
        ),
      ),
    );
  }
}
