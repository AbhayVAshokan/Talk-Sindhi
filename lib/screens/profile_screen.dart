import 'package:flutter/material.dart';

import '../my_appbar.dart';
import '../my_bottom_navbar.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context: context),
      body: SafeArea(child: Container()),
      bottomNavigationBar: myBottomNavbar(
        context: context,
        currentIndex: 2,
      ),
    );
  }
}
