import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import '../../app/services/firebase_realtime_db.dart';
import '../../app/widgets/show_confirm_dialog.dart';
import 'contact_model.dart';
import 'copy_button.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});
  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  FirebaseDatabaseHelper dbHelper = FirebaseDatabaseHelper.instance;
  final nameController = TextEditingController();
  final numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contacts")),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(15),
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: [Color(0xFF061A5A), Color(0xFF6B80B6)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Lottie.asset('assets/lottie/telegram.json'),
                  ),
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Telegram",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "before activation you need to send message to this bot",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        CopyToClipboardButton(
                          textToCopy: '@DriveSenseAlertsBot',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Contact>>(
              future: dbHelper.getContacts(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error, size: 40),
                        Text(snapshot.error.toString()),
                      ],
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final contacts = snapshot.data!;

                if (contacts.isEmpty) {
                  return const Center(child: Text("No contacts yet"));
                }
                return ListView.separated(
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: contacts.length,
                  itemBuilder: (context, index) {
                    final c = contacts[index];
                    return Column(
                      children: [
                        ListTile(
                          leading: Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(2),
                                // border width
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: c.active ? Colors.green : Colors.red,
                                    width: 2,
                                  ),
                                ),
                                child: CircleAvatar(child: Text(c.name[0])),
                              ),
                              c.active
                                  ? Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                        size: 20,
                                      ),
                                    )
                                  : Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Container(),
                                    ),
                            ],
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 0,
                          ),
                          title: Text(
                            c.name,
                            style: const TextStyle(fontSize: 14),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                c.number,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Text(
                                c.userName == '' ? 'Not Activated' : c.userName,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            onPressed: () async {
                              bool isConfirmed = await showConfirmationDialog(
                                "Are you sure you want to delete this contact?",
                                "Confirmation",
                                context,
                              );
                              if (!isConfirmed) return;

                              await dbHelper.deleteContact(c);
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.remove_circle,
                              color: Colors.pink,
                              size: 30,
                            ),
                          ),
                        ),
                        c.active
                            ? Container()
                            : SizedBox(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    onPressed: () async {
                                      bool
                                      isConfirmed = await showConfirmationDialog(
                                        "Make sure that you send the message to the bot in the last minute",
                                        "Confirmation",
                                        context,
                                      );
                                      if (!isConfirmed) return;

                                      await dbHelper.activateContact(c);
                                      setState(() {});
                                    },
                                    child: const Text("Activate"),
                                  ),
                                ),
                              ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        elevation: 1,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
        splashColor: Colors.blueGrey,
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text("Add Contact"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: "Name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: numberController,
                    keyboardType: TextInputType.phone,
                    maxLength: 9,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    style: const TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      labelText: "Number",
                      border: OutlineInputBorder(),
                      prefix: const Text("+966 "),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    if (nameController.text.trim().isEmpty ||
                        numberController.text.trim().isEmpty) {
                      return;
                    }
                    await dbHelper.addContact(
                      nameController.text,
                      numberController.text,
                    );
                    context.pop(context);
                    setState(() {});
                  },
                  child: const Text("Save"),
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.add, size: 40),
      ),
    );
  }
}
