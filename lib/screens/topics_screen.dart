// Topics Screen: Learn new vocabulary and improve conversation skills.

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../my_appbar.dart';
import '../my_bottom_navbar.dart';
import './vocabulary_tab.dart';
import './conversation_tab.dart';

class TopicsScreen extends StatefulWidget {
  final TabController tabController;
  TopicsScreen({this.tabController});

  @override
  _TopicsScreenState createState() => _TopicsScreenState();
}

class _TopicsScreenState extends State<TopicsScreen> {
  var language = 'english';

  @override
  Widget build(BuildContext context) {
    Directory directory;
    String fileName = 'userData.json';
    Map<String, dynamic> localStorage;

    // Function to return the location at which the data is stored locally.
    getApplicationDocumentsDirectory().then(
      (Directory dir) {
        directory = dir;
        var path = directory.path + '/' + fileName;
        var jsonFile = File(path);
        localStorage = json.decode(jsonFile.readAsStringSync());

        if (language != localStorage['language']) {
          setState(() {
            language = localStorage['language'];
          });
          print(localStorage['language']);
        }
      },
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
                      title: language == 'english' ? 'Vocabulary' : 'शब्दावली'),
                  tabView(
                      title: language == 'english' ? 'Conversation' : 'बातचीत'),
                ],
              ),
              rebuildScreen: () {
                setState(() {
                  print('rebuilding screen');
                });
              },
            ),
            body: TabBarView(children: [
              VocabularyTab(
                  language: language,
                  rebuildScreen: () {
                    setState(() {
                      print('rebuilding screen');
                    });
                  }),
              ConversationTab(
                  language: language,
                  rebuildScreen: () {
                    setState(() {
                      print('rebuilding screen');
                    });
                  }),
            ]),
            bottomNavigationBar: myBottomNavbar(
              context: context,
              currentIndex: 1,
            )),
      ),
    );
  }
}
