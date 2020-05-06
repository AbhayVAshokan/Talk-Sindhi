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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final category = (widget.arguments as Map<String, dynamic>)['category'];
    final subCategory =
        (widget.arguments as Map<String, dynamic>)['subCategory'];
    final subCategoryIndex =
        (widget.arguments as Map<String, dynamic>)['subCategoryIndex'];
    final rebuildScreen =
        (widget.arguments as Map<String, dynamic>)['rebuildScreen'];
    int initialIndex =
        (widget.arguments as Map<String, dynamic>)['initialIndex'];

    return SafeArea(
      child: DefaultTabController(
        initialIndex: initialIndex,
        length: subCategory['data'].length,
        child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: myAppBar(
              context: context,
              rebuildScreen: () {
                setState(() {
                  rebuildScreen();
                });
              },
              backButton: true,
              tabBar: tabBar(
                context: context,
                children: <Widget>[
                  ...subCategory['data'].map(
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
              for (var i = 0; i < subCategory['data'].length; i++)
                LearnWord(
                  pageNumber: i,
                  category: category,
                  subCategoryIndex: subCategoryIndex,
                  wordData: subCategory['data'][i],
                  totalWordCount: subCategory['totalWords'],
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
