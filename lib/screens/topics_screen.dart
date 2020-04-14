// Topics Screen: Learn new vocabulary and improve conversation skills.

import 'package:flutter/material.dart';

import '../my_appbar.dart';
import '../my_bottom_navbar.dart';
import './vocabulary_tab.dart';
import './conversation_tab.dart';

class TopicsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: myAppBar(
              context: context,
              tabBar: tabBar(context: context, children: [
                tabView(title: 'Vocabulary'),
                tabView(title: 'Conversation'),
              ]),
            ),
            body: TabBarView(children: [
              VocabularyTab(),
              ConversationTab(),
            ]),
            bottomNavigationBar: myBottomNavbar(
              context: context,
              currentIndex: 1,
            )),
      ),
    );
  }
}
