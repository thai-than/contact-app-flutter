import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sample_project/layouts/bottom_nav_bar.dart';
import 'package:sample_project/models/contact.dart';
import 'package:sample_project/screens/add_contact.dart';
import 'package:sample_project/screens/detail.dart';
import 'package:sample_project/screens/home.dart';
import 'package:sample_project/screens/modify_contact.dart';
import 'package:sample_project/screens/profile.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) =>
          Scaffold(body: child, bottomNavigationBar: const BottomNavBar()),
      routes: [
        GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
        GoRoute(
          path: '/add',
          builder: (context, state) => const AddContactScreen(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
        GoRoute(
          path: '/contact/:id',
          builder: (context, state) =>
              DetailScreen(contact: state.extra as Contact),
        ),
        GoRoute(
          path: '/modify/:id',
          builder: (context, state) =>
              ModifyContactScreen(contact: state.extra as Contact),
        ),
      ],
    ),
  ],
);
