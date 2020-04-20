// Screen for learning individual words in the vocabulary screen.

import 'package:flutter/material.dart';

import '../realtime_data.dart';
import '../widgets/vocabulary-tab/word_card.dart';

class LearnWord extends StatelessWidget {
  final Map<String, dynamic> wordData;
  final int totalWordCount;
  final String category;
  final int subCategoryIndex;

  LearnWord({
    @required this.wordData,
    @required this.totalWordCount,
    @required this.category,
    @required this.subCategoryIndex,
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
    // Check whether the user has already learned this word/conversation. If not add it to the list of learned words/conversations.
    bool completed = true;

    if (category == 'vocabulary') {
      if (!vocabulary[subCategoryIndex]['learnedWords']
          .contains(wordData['english'])) {
        vocabulary[subCategoryIndex]['learnedWords'].add(wordData['english']);
        completed = false;
      }
    } else if (category == 'conversation') {
      if (!conversation[subCategoryIndex]['learnedWords']
          .contains(wordData['english'])) {
        conversation[subCategoryIndex]['learnedWords'].add(wordData['english']);
        completed = false;
      }
    }

    return Container(
      color: completed ? Colors.green[100] : Theme.of(context).backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox.shrink(),
          WordCard(
            word: globalLanguage == 'english'
                ? wordData['english']
                : wordData['hindi'],
            language: globalLanguage,
          ),
          WordCard(
            word: wordData['sindhi'],
            language: 'sindhi',
            media: wordData['media'],
          ),
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
                      'Your milestone: ${DefaultTabController.of(context).index + 1}/$totalWordCount',
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
                            if (DefaultTabController.of(context).index > 0)
                              DefaultTabController.of(context).animateTo(
                                DefaultTabController.of(context).index - 1,
                                curve: Curves.easeIn,
                                duration: Duration(
                                  milliseconds: 500,
                                ),
                              );
                          },
                        ),
                        arrowButton(
                          context: context,
                          icon: Icons.arrow_forward_ios,
                          onTap: () {
                            if (DefaultTabController.of(context).index <
                                totalWordCount - 1)
                              DefaultTabController.of(context).animateTo(
                                DefaultTabController.of(context).index + 1,
                                curve: Curves.easeIn,
                                duration: Duration(
                                  milliseconds: 500,
                                ),
                              );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
