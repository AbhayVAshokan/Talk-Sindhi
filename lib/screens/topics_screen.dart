// Topics Screen: Learn new vocabulary and improve conversation skills.

import 'package:flutter/material.dart';

import '../my_appbar.dart';
import '../my_bottom_navbar.dart';
import './vocabulary_tab.dart';
import './conversation_tab.dart';

class TopicsScreen extends StatelessWidget {
  final TabController tabController;
  final Map<String, dynamic> localStorage;
  TopicsScreen( this.localStorage, {this.tabController});

  @override
  Widget build(BuildContext context) {
    print('inside topicsscreen: ' + localStorage['language']);
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: myAppBar(
              context: context,
              tabBar: tabBar(
                controller: tabController,
                context: context,
                children: [
                  tabView(title: 'Vocabulary'),
                  tabView(title: 'Conversation'),
                ],
              ),
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
