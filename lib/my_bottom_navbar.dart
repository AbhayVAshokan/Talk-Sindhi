// Custom bottom navigationbar.

import 'package:flutter/material.dart';

import './custom_icons.dart';

// Designing individual Bottom NavBar item
BottomNavigationBarItem _myBottomNavbarItem({
  BuildContext context,
  String screen,
  IconData inactiveIcon,
  IconData activeIcon,
  String title,
  int currentIndex,
  int itemIndex,
  double iconSize = 25.0,
}) {
  return BottomNavigationBarItem(
    icon: IconButton(
      icon: Icon(
        currentIndex == itemIndex ? activeIcon : inactiveIcon,
        size: iconSize,
      ),
      onPressed: () => Navigator.pushReplacementNamed(context, screen),
    ),
    title: Text(
      title,
      style: const TextStyle(
        letterSpacing: 1.0,
        fontSize: 17.0,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget myBottomNavbar({
  @required BuildContext context,
  @required int currentIndex,
}) {
  return SizedBox(
    child: BottomNavigationBar(
      currentIndex: currentIndex,
      elevation: 5,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: false,
      iconSize: 28.0,
      backgroundColor: Colors.white,
      items: [
        _myBottomNavbarItem(
          context: context,
          activeIcon: CustomIcons.home,
          inactiveIcon: CustomIcons.home_outline,
          screen: '/home',
          title: 'Home',
          currentIndex: currentIndex,
          itemIndex: 0,
        ),
        _myBottomNavbarItem(
          context: context,
          activeIcon: Icons.view_quilt,
          inactiveIcon: Icons.view_quilt,
          screen: '/topics',
          title: 'Topics',
          iconSize: 35.0,
          currentIndex: currentIndex,
          itemIndex: 1,
        ),
        _myBottomNavbarItem(
          context: context,
          activeIcon: Icons.lightbulb_outline,
          inactiveIcon: Icons.lightbulb_outline,
          screen: '/quiz',
          title: 'Quiz',
          iconSize: 35.0,
          currentIndex: currentIndex,
          itemIndex: 2,
        ),
        _myBottomNavbarItem(
          context: context,
          activeIcon: Icons.person,
          inactiveIcon: Icons.person_outline,
          screen: '/profile',
          title: 'Profile',
          currentIndex: currentIndex,
          itemIndex: 3,
          iconSize: 35.0,
        ),
      ],
    ),
  );
}
