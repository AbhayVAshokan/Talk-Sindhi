import 'package:flutter/material.dart';

import '../models/topic.dart';
import '../widgets/homescreen/topic_card.dart';

class ConversationTab extends StatelessWidget {
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
          itemCount: conversationProgress.length,
          itemBuilder: (context, index) {
            final topic = conversationProgress[index];

            return GestureDetector(
              onTap: () => Navigator.pushNamed(
                context,
                '/learnContent',
                arguments: topic,
              ),
              child: TopicCard(
                imageUrl: 'assets/images/card_back.jpg',
                title: topic['subCategory'],
                learnedWords: topic['learnedWords'],
                totalWords: topic['totalWords'],
              ),
            );
          }),
    );
  }
}
