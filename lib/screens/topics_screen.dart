import 'package:flutter/material.dart';

import '../my_appbar.dart';
import '../my_bottom_navbar.dart';

class TopicsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context: context),
      body: SafeArea(
          child: Center(
        child: Text('Profile Screen'),
      )),
      bottomNavigationBar: myBottomNavbar(
        context: context,
        currentIndex: 1,
      ),
    );
  }
}
