import 'package:drivesense/features/auth/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../app/services/firebase_realtime_db.dart';

class ProfileViewScreen extends ConsumerStatefulWidget {
  final Profile profile;
  final Profile myProfile;

  const ProfileViewScreen({
    super.key,
    required this.profile,
    required this.myProfile,
  });

  @override
  ConsumerState createState() => _ProfileViewScreenState();
}

class _ProfileViewScreenState extends ConsumerState<ProfileViewScreen> {
  FirebaseDatabaseHelper dbHelper = FirebaseDatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            onPressed: () {
              if (widget.profile.id == widget.myProfile.id) {
                // you can not remove your own profile
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('You can not remove your own profile'),
                  ),
                );
                return;
              }
              dbHelper.deleteProfile(widget.profile);
              context.pop(context);
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: CircleAvatar(
                  radius: 80,
                  child: Text(
                    widget.profile.name[0].toUpperCase(),
                    style: const TextStyle(fontSize: 40),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                widget.profile.name.toUpperCase(),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Center(
              child: Text(
                widget.profile.id.toUpperCase(),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
