// Vocabulary/Conversation learning screen

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

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
      length: (widget.arguments as Map)['topic']['data'].length,
    );
  }

  var language = 'english';
  @override
  Widget build(BuildContext context) {
    // Function to return the location at which the data is stored locally.
    getApplicationDocumentsDirectory().then(
      (Directory dir) {
        var jsonFile = File(dir.path + '/userData.json');
        var localStorage = json.decode(jsonFile.readAsStringSync());

        if (language != localStorage['language']) {
          setState(() {
            language = localStorage['language'];
          });
          print('inshid learn content: ' + localStorage['language']);
        }
      },
    );

    final topic = (widget.arguments as Map<String, dynamic>)['topic'];
    final rebuildScreen =
        (widget.arguments as Map<String, dynamic>)['rebuildScreen'];

    return SafeArea(
      child: DefaultTabController(
        length: topic['allWords'].length,
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: myAppBar(
              context: context,
              rebuildScreen: () => rebuildScreen(),
              tabBar: tabBar(
                context: context,
                children: <Widget>[
                  ...topic['allWords'].map(
                    (item) => tabView(
                      title: language == 'english'
                          ? item['english']
                          : item['hindi'],
                    ),
                  ),
                ],
              )),
          body: TabBarView(
            children: [
              for (var i = 0; i < topic['allWords'].length; i++)
                LearnWord(
                  wordData: topic['allWords'][i],
                  tabController: _tabController,
                  currentWordCount: i + 1,
                  totalWordCount: topic['totalWords'],
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
