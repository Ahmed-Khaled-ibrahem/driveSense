import 'package:drivesense/features/settings/presentation/pages/settings_page.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/home/homeScreen.dart';
import '../../features/splash_screen/view/splash_screen.dart';
import '../wrapper/app_wrapper.dart';

final _rootNavigatorKeyProvider = Provider<GlobalKey<NavigatorState>>(
  (ref) => GlobalKey<NavigatorState>(),
);

final appRouterProvider = Provider<GoRouter>((ref) {
  final GlobalKey<NavigatorState> rootKey = ref.watch(
    _rootNavigatorKeyProvider,
  );

  return GoRouter(
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return AppWrapper(child: child);
        },
        routes: [
          GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
          GoRoute(
            path: '/login',
            builder: (context, state) => const Homescreen(),
          ),
          GoRoute(
            path: '/admin',
            builder: (context, state) => const Homescreen(),
          ),
          GoRoute(
            path: '/home',
            builder: (context, state) => const Homescreen(),
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) => SettingsPage(),
          ),
        ],
      ),

      // other routes...
    ],
  );
});
