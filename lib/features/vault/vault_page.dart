import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/storage/secure_storage.dart';
import 'password_model.dart';
import '../../core/crypto/encryption_helper.dart';

class VaultPage extends StatefulWidget {
  const VaultPage({Key? key}) : super(key: key);

  @override
  State<VaultPage> createState() => _VaultPageState();
}

class _VaultPageState extends State<VaultPage> {
  final SecureStorage storage = SecureStorage();
  List<PasswordItem> passwordList = [];

  @override
  void initState() {
    super.initState();
    loadPasswords();
  }

  void loadPasswords() async {
  final data = await storage.readAll();
  setState(() {
    passwordList = data.entries.map((e) {
      final decrypted = EncryptionHelper.decrypt(e.value);
      final parts = decrypted.split('|');
      return PasswordItem(
        id: e.key,
        title: parts[0],
        username: parts[1],
        password: parts[2],
      );
    }).toList();
  });
}

  void deletePassword(String id) async {
    await storage.delete(id);
    loadPasswords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("MyVault")),
      body: ListView.builder(
        itemCount: passwordList.length,
        itemBuilder: (context, index) {
          final item = passwordList[index];
          return ListTile(
            title: Text(item.title),
            subtitle: Text(item.username),
            trailing: IconButton(
              icon: Icon(Icons.copy),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: item.password));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Password copied')),
                );
              },
            ),
            onLongPress: () => deletePassword(item.id),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, '/add'),
      ),
    );
  }
}