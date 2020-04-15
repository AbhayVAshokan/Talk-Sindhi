// Vocabulary learning screen

import 'package:flutter/material.dart';

import '../screens/learn_word.dart';
import '../my_appbar.dart';
import '../my_bottom_navbar.dart';
import '../models/topic.dart';

class LearnVocabulary extends StatefulWidget {
  @override
  _LearnVocabularyState createState() => _LearnVocabularyState();
  final arguments;
  LearnVocabulary(this.arguments);
}

class _LearnVocabularyState extends State<LearnVocabulary>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: dummyTopics
          .firstWhere((cat) => cat.categoryId == widget.arguments as String)
          .words
          .length,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Topic category = dummyTopics
        .firstWhere((cat) => cat.categoryId == widget.arguments as String);

    return SafeArea(
      child: DefaultTabController(
        length: category.words.length,
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: myAppBar(
            context: context,
            tabBar: tabBar(
              context: context,
              controller: _tabController,
              children: [
                ...category.words.map((word) => tabView(title: word)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ...category.words.map(
                (word) => LearnWord(
                  tabController: _tabController,
                  word: word,
                  category: category,
                ),
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
