import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sample_project/layouts/bottom_nav_bar.dart';
import 'package:sample_project/models/contact.dart';
import 'package:sample_project/screens/add_contact.dart';
import 'package:sample_project/screens/detail.dart';
import 'package:sample_project/screens/home.dart';
import 'package:sample_project/screens/modify_contact.dart';
import 'package:sample_project/screens/profile.dart';

class RouteNames {
  static const String home = '/';
  static const String add = '/add';
  static const String profile = '/profile';
  static const String contact = '/contact/:index';
  static const String modify = '/modify/:index';
}

class RoutePaths {
  static const String home = '/';
  static const String add = '/add';
  static const String profile = '/profile';
  static const String contact = '/contact/:index';
  static const String modify = '/modify/:index';
}

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
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
          builder: (context, state) => DetailScreen(
            contact: state.extra as Contact,
            index: int.parse(state.pathParameters['index']!),
          ),
        ),
        GoRoute(
          path: RoutePaths.modify,
          name: RouteNames.modify,
          builder: (context, state) => ModifyContactScreen(
            contact: state.extra as Contact,
            index: int.parse(state.pathParameters['index']!),
          ),
        ),
      ],
    ),
  ],
);
