import 'package:flutter/material.dart';

import '../my_appbar.dart';
import '../my_bottom_navbar.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: myAppBar(
          context: context,
          rebuildScreen: () {
            setState(() {
              print('rebuilding screen');
            });
          },
        ),
        body: Center(
          child: Text('Profile Screen'),
        ),
        bottomNavigationBar: myBottomNavbar(
          context: context,
          currentIndex: 3,
        ),
      ),
    );
  }
}
