import 'package:flutter/material.dart';

class Contact {
  String name;
  String number;
  Contact({required this.name, required this.number});
}

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key});
  @override
  State<ContactListScreen> createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  final List<Contact> _contacts = [];
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();

  void _addContact() {
    if (_nameController.text.isNotEmpty && _numberController.text.isNotEmpty) {
      setState(() {
        _contacts.add(Contact(
          name: _nameController.text,
          number: _numberController.text,
        ));
      });
      _nameController.clear();
      _numberController.clear();
    }
  }

  void _editContact(int index) {
    final contact = _contacts[index];
    _nameController.text = contact.name;
    _numberController.text = contact.number;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Contact"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: _numberController,
              decoration: const InputDecoration(labelText: "Number"),
              keyboardType: TextInputType.phone,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _contacts[index] = Contact(
                  name: _nameController.text,
                  number: _numberController.text,
                );
              });
              _nameController.clear();
              _numberController.clear();
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  void _removeContact(int index) {
    setState(() {
      _contacts.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contact List")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Input fields
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: "Name",
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _numberController,
                    decoration: const InputDecoration(
                      labelText: "Number",
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle, color: Colors.blue),
                  onPressed: _addContact,
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Contact List
            Expanded(
              child: _contacts.isEmpty
                  ? const Center(child: Text("No contacts added"))
                  : ListView.builder(
                itemCount: _contacts.length,
                itemBuilder: (context, index) {
                  final contact = _contacts[index];
                  return Card(
                    child: ListTile(
                      title: Text(contact.name),
                      subtitle: Text(contact.number),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.orange),
                            onPressed: () => _editContact(index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _removeContact(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
