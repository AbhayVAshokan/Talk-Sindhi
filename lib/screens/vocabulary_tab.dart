import 'package:flutter/material.dart';

import '../realtime_data.dart';
import '../widgets/homescreen/topic_card.dart';

class VocabularyTab extends StatelessWidget {
  final String language;
  final Function rebuildScreen;

  VocabularyTab({
    this.language,
    @required this.rebuildScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Theme.of(context).backgroundColor,
      child: GridView.builder(
          padding: const EdgeInsets.all(10.0),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 150.0,
            childAspectRatio: 0.65,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
          ),
          itemCount: vocabulary.length,
          itemBuilder: (context, index) {
            final topic = vocabulary[index];

            return GestureDetector(
              onTap: () => Navigator.pushNamed(
                context,
                '/learnContent',
                arguments: {
                  'topic': topic,
                  'rebuildScreen': rebuildScreen,
                },
              ),
              child: TopicCard(
                imageUrl: 'assets/images/card_back.jpg',
                title: topic['subCategory'],
                learnedWords: topic['learnedWords'].length,
                totalWords: topic['totalWords'],
              ),
            );
          }),
    );
  }
}
