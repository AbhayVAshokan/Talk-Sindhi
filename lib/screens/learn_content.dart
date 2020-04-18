// Vocabulary/Conversation learning screen

import 'package:flutter/material.dart';

import '../my_appbar.dart';
import '../realtime_data.dart';
import '../my_bottom_navbar.dart';
import '../screens/learn_word.dart';

class LearnContent extends StatefulWidget {
  @override
  _LearnContentState createState() => _LearnContentState();
  final arguments;
  LearnContent(this.arguments);
}

class _LearnContentState extends State<LearnContent>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: (widget.arguments as Map)['topic']['data'].length,
    );
  }

  @override
  Widget build(BuildContext context) {
    print(_tabController.index);
    print(_tabController.previousIndex);
    final topic = (widget.arguments as Map<String, dynamic>)['topic'];
    final rebuildScreen =
        (widget.arguments as Map<String, dynamic>)['rebuildScreen'];

    return SafeArea(
      child: DefaultTabController(
        length: topic['data'].length,
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: myAppBar(
              context: context,
              rebuildScreen: () => rebuildScreen(),
              tabBar: tabBar(
                context: context,
                children: <Widget>[
                  ...topic['data'].map(
                    (item) => tabView(
                      title: globalLanguage == 'english'
                          ? item['english']
                          : item['hindi'],
                    ),
                  ),
                ],
              )),
          body: TabBarView(
            children: [
              for (var i = 0; i < topic['data'].length; i++)
                LearnWord(
                  wordData: topic['data'][i],
                  tabController: _tabController,
                  currentWordCount: i + 1,
                  totalWordCount: topic['totalWords'],
                  index: _tabController.index,
                )
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
