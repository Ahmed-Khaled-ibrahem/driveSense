import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../routes/app_router.dart';
import '../services/firebase_realtime_db.dart';

final isAlertOpenProvider = StateProvider<bool>((ref) => false);

class AppWrapper extends ConsumerStatefulWidget {
  const AppWrapper({super.key, required this.child});

  final Widget child;

  @override
  AppWrapperState createState() => AppWrapperState();
}

class AppWrapperState extends ConsumerState<AppWrapper> {
  FirebaseDatabaseHelper dbHelper = FirebaseDatabaseHelper.instance;

  onChange(isDetected) {
    if (isDetected) {
      openAlert(context, ref);
    } else {
      if (ref.read(isAlertOpenProvider)) {
        ref.read(isAlertOpenProvider.notifier).state = false;
        context.pop();
      }
    }
  }

  void openAlert(BuildContext context, WidgetRef ref) {
    final isOpen = ref.read(isAlertOpenProvider);

    if (!isOpen) {
      ref.read(isAlertOpenProvider.notifier).state = true;

      context.push('/alert').then((_) {
        ref.read(isAlertOpenProvider.notifier).state = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    dbHelper.setAlertOff();
    dbHelper.listen('live/detected', onChange);
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final router = ref.read(appRouterProvider);
        return widget.child;
      },
    );
  }
}
