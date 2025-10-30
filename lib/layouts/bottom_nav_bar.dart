import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    int currentIndex;
    switch (location) {
      case '/add':
        currentIndex = 0;
        break;
      case '/':
        currentIndex = 1;
        break;
      case '/profile':
        currentIndex = 2;
        break;
      default:
        currentIndex = 1;
    }

    void onTabTapped(int index) {
      switch (index) {
        case 0:
          context.go('/add');
          break;
        case 1:
          context.go('/');
          break;
        case 2:
          context.go('/profile');
          break;
      }
    }

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTabTapped,
      selectedItemColor: Colors.green,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.person_add_alt_1),
          label: 'Add',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list_alt),
          label: 'Contacts',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
