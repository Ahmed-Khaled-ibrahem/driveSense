import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../routes/app_router.dart';

class AppWrapper extends ConsumerWidget {
  final Widget child;

  const AppWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Builder(
      builder: (context) {
        final router = ref.read(appRouterProvider);
        return child;
      },
    );
  }
}
