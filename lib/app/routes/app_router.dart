import 'package:drivesense/features/settings/presentation/pages/settings_page.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/admin/add_new_account_screen.dart';
import '../../features/admin/admin_home.dart';
import '../../features/admin/profile_view_screen.dart';
import '../../features/alert/alert_screen.dart';
import '../../features/auth/login_page.dart';
import '../../features/auth/profile_model.dart';
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
            builder: (context, state) => const LoginPage(),
          ),
          GoRoute(
            path: '/add-new-account',
            builder: (context, state) => const AddNewAccountScreen(),
          ),
          GoRoute(
            path: '/alert',
            builder: (context, state) => const AlertScreen(),
          ),
          GoRoute(
            path: '/admin',
            builder: (context, state) {
              final profile = state.extra as Profile;
              return AdminHome(profile);
            },
          ),
          GoRoute(
            path: '/home',
            builder: (context, state) {
              final profile = state.extra as Profile;
              return Homescreen(profile: profile);
            },
          ),
          GoRoute(
            path: '/view-profile',
            builder: (context, state) {
              final extras = state.extra as Map<String, dynamic>;
              final profile = extras['profile'];
              final myProfile = extras['myProfile'];
              return ProfileViewScreen(profile: profile, myProfile: myProfile);
            },
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
