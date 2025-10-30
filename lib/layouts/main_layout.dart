import 'package:flutter/material.dart';
import 'package:sample_project/layouts/bottom_nav_bar.dart';

class MainLayout extends StatelessWidget {
  final Widget body;

  const MainLayout({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contact Manager"), centerTitle: true),
      body: body,
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
