// Vocabulary/Conversation learning screen

import 'package:flutter/material.dart';

import '../screens/learn_word.dart';
import '../my_appbar.dart';
import '../my_bottom_navbar.dart';

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
      length: (widget.arguments as Map)['data'].length,
    );
  }

  @override
  Widget build(BuildContext context) {
    final topic = widget.arguments as Map<String, dynamic>;
    print(topic['allWords']);
    print(topic['allWords'].length);

    return SafeArea(
      child: DefaultTabController(
        length: topic['allWords'].length,
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: myAppBar(
              context: context,
              rebuildScreen: () {},
              tabBar: tabBar(
                context: context,
                children: <Widget>[
                  ...topic['allWords'].map(
                    (item) => tabView(
                      title: item['english'],
                    ),
                  ),
                ],
              )

              //   tabBar: TabBar(
              //     isScrollable: true,
              //     tabs: <Widget>[
              //       ...topic['allWords'].map(
              //         (item) => Text(
              //           item['english'],
              //         ),
              //       ),
              //     ],
              //   ),
              ),

          // AppBar(
          //   title: Text('something'),
          //   bottom: TabBar(
          //     isScrollable: true,
          //     tabs: [...topic['allWords'].map((item) => Text(item['english']))],
          //   ),
          // ),
          body: TabBarView(
            children: [
              for (var i = 0; i < topic['allWords'].length; i++)
                LearnWord(
                    wordData: topic['allWords'][i],
                    tabController: _tabController,
                    currentWordCount: i + 1,
                    totalWordCount: topic['totalWords'])
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
