import 'package:flutter/material.dart';

import '../my_appbar.dart';
import '../my_bottom_navbar.dart';

class LearnVocabulary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final learnedWords = ModalRoute.of(context).arguments;

    return SafeArea(
      child: Scaffold(
        appBar: myAppBar(
          context: context,
        ),
        body: Center(
          child: Text('Learn Vocabulary Screen'),
        ),
        bottomNavigationBar: myBottomNavbar(
          context: context,
          currentIndex: 1,
        ),
      ),
    );
  }
}
