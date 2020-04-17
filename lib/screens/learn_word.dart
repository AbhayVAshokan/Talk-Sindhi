// Screen for learning individual words in the vocabulary screen.

import 'package:flutter/material.dart';

import '../widgets/vocabulary-tab/word_card.dart';

class LearnWord extends StatelessWidget {
  final Map<String, dynamic> wordData;
  final TabController tabController;
  final int currentWordCount;
  final int totalWordCount;

  LearnWord({
    @required this.wordData,
    @required this.tabController,
    @required this.currentWordCount,
    @required this.totalWordCount,
  });

  // Individual arrow keys to navigate to next word/milestone
  Widget arrowButton({
    @required BuildContext context,
    @required IconData icon,
    @required Function onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: GestureDetector(
        onTap: () => onTap(),
        child: CircleAvatar(
          child: Icon(
            icon,
            size: 30.0,
            color: Colors.white,
          ),
          backgroundColor: Theme.of(context).primaryColor,
          radius: 25.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox.shrink(),
        WordCard(word: wordData['english'], language: 'english'),
        WordCard(word: wordData['sindhi'], language: 'sindhi'),
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          child: Card(
            elevation: 1.0,
            margin: EdgeInsets.all(0),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 10.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your milestone: $currentWordCount/$totalWordCount',
                    style: const TextStyle(
                      fontSize: 18.0,
                      letterSpacing: 0.75,
                    ),
                  ),
                  Row(
                    children: [
                      arrowButton(
                        context: context,
                        icon: Icons.arrow_back_ios,
                        onTap: () {
                          tabController.index > 0
                              ? tabController.animateTo(
                                  tabController.index - 1,
                                  curve: Curves.decelerate,
                                  duration: Duration(microseconds: 200),
                                )
                              : print('Not possible to go back!');
                        },
                      ),
                      arrowButton(
                        context: context,
                        icon: Icons.arrow_forward_ios,
                        onTap: () {},
                        // onTap: () {
                        //   tabController.index < category.words.length - 1
                        //       ? tabController.animateTo(
                        //           tabController.index + 1,
                        //           curve: Curves.decelerate,
                        //           duration: Duration(milliseconds: 200),
                        //         )
                        //       : print('Not possible to go forward!');
                        // },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
