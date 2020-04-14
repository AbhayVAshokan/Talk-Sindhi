// Vocabulary tab in HomeScreen.

import 'package:flutter/material.dart';

import '../models/topic.dart';
import '../widgets/homescreen/topic_card.dart';

class VocabularyTab extends StatelessWidget {
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
          itemCount: dummyTopics.length,
          itemBuilder: (context, index) {
            final topic = dummyTopics[index];

            return GestureDetector(
              onTap: () => Navigator.pushNamed(
                context,
                '/learnVocabulary',
                arguments: topic.words,
              ),
              child: TopicCard(
                imageUrl: topic.imageUrl,
                title: topic.name,
                learnedWords: topic.learnedWords,
                totalWords: topic.totalWords,
              ),
            );
          }),
    );
  }
}