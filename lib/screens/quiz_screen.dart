import 'package:flutter/material.dart';

import '../my_appbar.dart';
import '../my_bottom_navbar.dart';

import '../realtime_data.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
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
        body: Center(
          child: Text('Quiz Screen'),
        ),
        bottomNavigationBar: myBottomNavbar(
          context: context,
          currentIndex: 2,
        ),
      ),
    );
  }
}
