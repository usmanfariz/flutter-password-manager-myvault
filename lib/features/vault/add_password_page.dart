import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../core/storage/secure_storage.dart';
import '../../core/crypto/encryption_helper.dart';

class AddPasswordPage extends StatelessWidget {
  final titleCtrl = TextEditingController();
  final usernameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final storage = SecureStorage();

  void save(BuildContext context) async {
    final uuid = Uuid().v4();
    final title = titleCtrl.text;
    final username = usernameCtrl.text;
    final password = passwordCtrl.text;
    final raw = '$title|$username|$password';
    final encrypted = EncryptionHelper.encrypt(raw);

    await storage.write(uuid, encrypted);
    Navigator.pop(context);
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Password')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: titleCtrl, decoration: InputDecoration(labelText: 'Title')),
            TextField(controller: usernameCtrl, decoration: InputDecoration(labelText: 'Username')),
            TextField(controller: passwordCtrl, decoration: InputDecoration(labelText: 'Password')),
            SizedBox(height: 20),
            ElevatedButton(onPressed: () => save(context), child: Text('Save'))
          ],
        ),
      ),
    );
  }
}