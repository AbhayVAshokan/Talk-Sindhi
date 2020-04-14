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

Widget myBottomNavbar({BuildContext context, int currentIndex}) {
  return SizedBox(
      child: BottomNavigationBar(
      currentIndex: currentIndex,
      elevation: 3,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: false,
      iconSize: 28.0,
      selectedIconTheme: IconThemeData(size: 35.0),
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
          activeIcon: CustomIcons.address_book,
          inactiveIcon: CustomIcons.address_book_alt,
          screen: '/topics',
          title: 'Topics',
          currentIndex: currentIndex,
          itemIndex: 1,
        ),
        _myBottomNavbarItem(
          context: context,
          activeIcon: Icons.person,
          inactiveIcon: Icons.person_outline,
          screen: '/profile',
          title: 'Profile',
          currentIndex: currentIndex,
          itemIndex: 2,
          iconSize: 35.0,
        ),
        _myBottomNavbarItem(
          context: context,
          activeIcon: CustomIcons.wrench,
          inactiveIcon: CustomIcons.wrench_outline,
          screen: '/settings',
          title: 'Settings',
          currentIndex: currentIndex,
          itemIndex: 3,
        ),
      ],
    ),
  );
}
