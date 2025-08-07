import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/storage/secure_storage.dart';
import 'password_model.dart';

class VaultPage extends StatefulWidget {
  const VaultPage({Key? key}) : super(key: key);

  @override
  State<VaultPage> createState() => _VaultPageState();
}

class _VaultPageState extends State<VaultPage> {
  final SecureStorage storage = SecureStorage();
  List<PasswordModel> passwordList = [];

  @override
  void initState() {
    super.initState();
    loadPasswords();
  }

  Future<void> loadPasswords() async {
    final data = await storage.readAll();
    final items = data.entries.map((entry) {
      return PasswordModel.fromEncrypted(entry.key, entry.value);
    }).toList();

    setState(() => passwordList = items);
  }

  Future<void> deletePassword(String id) async {
    await storage.delete(id);
    loadPasswords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("MyVault")),
      body: passwordList.isEmpty
          ? const Center(child: Text('No saved passwords.'))
          : ListView.builder(
              itemCount: passwordList.length,
              itemBuilder: (context, index) {
                final item = passwordList[index];
                return ListTile(
                  title: Text(item.title),
                  subtitle: Text(item.username),
                  trailing: IconButton(
                    icon: const Icon(Icons.copy),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: item.password));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Password copied')),
                      );
                    },
                  ),
                  onLongPress: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Delete?'),
                        content:
                            Text('Are you sure to delete "${item.title}"?'),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('Cancel')),
                          TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text('Delete')),
                        ],
                      ),
                    );
                    if (confirm == true) {
                      deletePassword(item.id);
                    }
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.pushNamed(context, '/add');
          loadPasswords(); // refresh list after return
        },
      ),
    );
  }
}
