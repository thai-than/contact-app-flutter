import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sample_project/blocs/contact_detail/contact_detail_cubit.dart';
import 'package:sample_project/blocs/contact_list/contact_list_cubit.dart';
import 'package:sample_project/blocs/contact_list/contact_list_event.dart';
import 'package:sample_project/layouts/bottom_nav_bar.dart';
import 'package:sample_project/screens/home/add_contact.dart';
import 'package:sample_project/screens/home/detail.dart';
import 'package:sample_project/screens/profile/edit_profile.dart';
import 'package:sample_project/screens/home/home.dart';
import 'package:sample_project/screens/auth/login_screen.dart';
import 'package:sample_project/screens/home/modify_contact.dart';
import 'package:sample_project/screens/profile/profile.dart';
import 'package:sample_project/screens/auth/register_screen.dart';
import 'package:sample_project/screens/setting.dart';
import 'package:sample_project/screens/splash_screen.dart';

class RouteNames {
  static const String splash = 'splash';
  static const String home = 'home';
  static const String add = 'add';
  static const String profile = 'profile';
  static const String editProfile = 'profile/edit';
  static const String contact = 'contact';
  static const String editContact = 'contact/edit';
  static const String setting = 'setting';
  static const String login = 'login';
  static const String register = 'register';
}

class RoutePaths {
  static const String splash = '/splash';
  static const String home = '/';
  static const String add = '/add';
  static const String profile = '/profile';
  static const String editProfile = '/profile/edit';
  static const String contact = '/contact/:index';
  static const String editContact = '/contact/:index/edit';
  static const String setting = '/setting';
  static const String login = '/login';
  static const String register = '/register';
}

final GoRouter router = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: RoutePaths.splash,
      name: RouteNames.splash,
      builder: (context, state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: RoutePaths.login,
      name: RouteNames.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: RoutePaths.register,
      name: RouteNames.register,
      builder: (context, state) => const RegisterScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) =>
          Scaffold(body: child, bottomNavigationBar: const BottomNavBar()),
      routes: [
        GoRoute(
          path: RoutePaths.home,
          name: RouteNames.home,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: RoutePaths.add,
          name: RouteNames.add,
          builder: (context, state) => const AddContactScreen(),
        ),
        GoRoute(
          path: RoutePaths.profile,
          name: RouteNames.profile,
          builder: (context, state) => const ProfileScreen(),
        ),
        GoRoute(
          path: RoutePaths.contact,
          name: RouteNames.contact,
          builder: (context, state) {
            final index = int.parse(state.pathParameters['index']!);
            return BlocProvider(
              create: (context) => ContactDetailCubit(index: index),
              child: const DetailScreen(),
            );
          },
        ),
        GoRoute(
          path: RoutePaths.editContact,
          name: RouteNames.editContact,
          builder: (context, state) {
            final index = int.parse(state.pathParameters['index']!);
            return BlocProvider(
              create: (context) => ContactDetailCubit(index: index),
              child: const ModifyContactScreen(),
            );
          },
        ),
        GoRoute(
          path: RoutePaths.editProfile,
          name: RouteNames.editProfile,
          builder: (context, state) {
            return const EditProfileScreen();
          },
        ),
        GoRoute(
          path: RoutePaths.setting,
          name: RouteNames.setting,
          builder: (context, state) => const SettingScreen(),
        ),
      ],
    ),
  ],
);
