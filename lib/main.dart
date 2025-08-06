import 'package:flutter/material.dart';
import 'features/vault/vault_page.dart';
import 'features/vault/add_password_page.dart';

void main() {
  runApp(MyVaultApp());
}

class MyVaultApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyVault',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (_) => VaultPage(),
        '/add': (_) => AddPasswordPage(),
      },
    );
  }
}