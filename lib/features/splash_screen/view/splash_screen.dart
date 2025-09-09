import 'package:drivesense/features/splash_screen/view/widgets/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/routes/app_router.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Future futureDelay = Future.delayed(const Duration(seconds: 1))
        .whenComplete(() {
          ref.read(appRouterProvider).go('/login');
        });
    return FutureBuilder(
      future: futureDelay,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LogoWidget();
        } else {
          return Container();
        }
      },
    );
  }
}
