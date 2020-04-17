import 'package:flutter/material.dart';
import 'package:talksindhi/models/topic.dart';

import '../my_appbar.dart';
import '../my_bottom_navbar.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    print(vocabulary);
    return SafeArea(
      child: Scaffold(
        appBar: myAppBar(
          context: context,
          rebuildScreen: () {
            setState(
              () {
                print('rebuilding screen');
              },
            );
          },
        ),
        body: Container(),
        bottomNavigationBar: myBottomNavbar(
          context: context,
          currentIndex: 3,
        ),
      ),
    );
  }
}
