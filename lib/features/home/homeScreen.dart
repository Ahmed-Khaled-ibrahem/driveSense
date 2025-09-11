import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../auth/profile_model.dart';
import '../contacts/contacts_Screen.dart';
import '../drive/drive_screen.dart';
import '../instructions/instructions_screen.dart';
import '../reports_driver/reports.dart';
import '../settings/presentation/pages/settings_page.dart';

class Homescreen extends ConsumerStatefulWidget {
  final Profile profile;

  const Homescreen({super.key, required this.profile});

  @override
  ConsumerState createState() => _HomescreenState();
}

class _HomescreenState extends ConsumerState<Homescreen> {
  int _currentIndex = 0;
  final double notActiveIconSize = 25;
  final double activeIconSize = 32.0;

  List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages = [
      DriveScreen(widget.profile),
      ReportsScreen(profile: widget.profile,),
      SettingsPage(),
      InstructionsScreen(),
      ContactsScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },

        selectedItemColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/drive_not_active.png',
              width: notActiveIconSize,
              height: notActiveIconSize,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : null,
            ),
            activeIcon: Image.asset(
              'assets/icons/drive.png',
              width: activeIconSize,
              height: activeIconSize,
            ),
            label: "Drive",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/reports_not_active.png',
              width: notActiveIconSize,
              height: notActiveIconSize,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : null,
            ),
            activeIcon: Image.asset(
              'assets/icons/reports.png',
              width: activeIconSize,
              height: activeIconSize,
            ),
            label: "Reports",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/settings_not_active.png',
              width: notActiveIconSize,
              height: notActiveIconSize,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : null,
            ),
            activeIcon: Image.asset(
              'assets/icons/settings.png',
              width: activeIconSize,
              height: activeIconSize,
            ),
            label: "Settings",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/instructions_not_active.png',
              width: notActiveIconSize,
              height: notActiveIconSize,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : null,
            ),
            activeIcon: Image.asset(
              'assets/icons/instructions.png',
              width: activeIconSize,
              height: activeIconSize,
            ),
            label: "instructions",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/contacts_not_active.png',
              width: notActiveIconSize,
              height: notActiveIconSize,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : null,
            ),
            activeIcon: Image.asset(
              'assets/icons/contacts.png',
              width: activeIconSize,
              height: activeIconSize,
            ),
            label: "Contacts",
          ),
        ],
      ),
    );
  }
}
