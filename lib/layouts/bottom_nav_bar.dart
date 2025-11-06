import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sample_project/router/router.dart';
import 'package:sample_project/utils/constant.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    int currentIndex;
    switch (location) {
      case RoutePaths.profile:
      case RoutePaths.editProfile:
        currentIndex = 0;
        break;
      case RoutePaths.home:
        currentIndex = 1;
        break;
      case RoutePaths.setting:
        currentIndex = 2;
        break;
      default:
        currentIndex = 1;
    }

    void onTabTapped(int index) {
      switch (index) {
        case 0:
          context.goNamed(RouteNames.profile);
          break;
        case 1:
          context.goNamed(RouteNames.home);
          break;
        case 2:
          context.goNamed(RouteNames.setting);
          break;
      }
    }

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTabTapped,
      selectedItemColor: kPrimaryColor,
      unselectedItemColor: kTextLightColor,
      backgroundColor: kBgColor,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Contacts'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
    );
  }
}
