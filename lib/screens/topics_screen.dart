// Topics Screen: Learn new vocabulary and improve conversation skills.

import 'package:flutter/material.dart';

import '../my_appbar.dart';
import '../realtime_data.dart';
import './vocabulary_tab.dart';
import '../file_operations.dart';
import './conversation_tab.dart';
import '../my_bottom_navbar.dart';

class TopicsScreen extends StatefulWidget {
  final TabController tabController;
  TopicsScreen({this.tabController});

  @override
  _TopicsScreenState createState() => _TopicsScreenState();
}

class _TopicsScreenState extends State<TopicsScreen> {
  @override
  Widget build(BuildContext context) {
    // Updating local storage
    writeToFile(
      content: {
        'vocabulary': vocabulary,
        'conversation': conversation,
      },
      fileName: '/progressData.json',
    );

    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: myAppBar(
            context: context,
            tabBar: tabBar(
              context: context,
              children: [
                tabView(
                    title: globalLanguage == 'english'
                        ? 'Vocabulary'
                        : 'शब्दावली'),
                tabView(
                    title: globalLanguage == 'english'
                        ? 'Conversation'
                        : 'बातचीत'),
              ],
            ),
            rebuildScreen: () {
              setState(() {
                print('rebuilding screen');
              });
            },
          ),
          body: TabBarView(
            children: [
              VocabularyTab(
                rebuildScreen: () {
                  setState(() {});
                },
                cardImageUrl: 'assets/images/vocabulary_card.jpg',
              ),
              ConversationTab(
                rebuildScreen: () {
                  setState(() {});
                },
                cardImageUrl: 'assets/images/conversation_card.jpg',
              ),
            ],
          ),
          bottomNavigationBar: myBottomNavbar(
            context: context,
            currentIndex: 1,
          ),
        ),
      ),
    );
  }
}
