import 'package:flutter/material.dart';
import 'package:sample_project/layouts/bottom_nav_bar.dart';

class MainLayout extends StatelessWidget {
  final Widget body;
  final int currentIndex;
  final Function(int) onTabSelected;

  const MainLayout({
    super.key,
    required this.body,
    this.currentIndex = 0,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Contact Manager"), centerTitle: true),
      body: body,
      bottomNavigationBar: BottomNavBar(
        currentIndex: currentIndex,
        onTap: onTabSelected,
      ),
    );
  }
}
