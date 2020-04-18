import 'package:flutter/material.dart';

import '../realtime_data.dart';
import '../widgets/homescreen/topic_card.dart';

class ConversationTab extends StatelessWidget {
  final Function rebuildScreen;
  final String cardImageUrl;

  ConversationTab({
    @required this.rebuildScreen,
    @required this.cardImageUrl,
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
          itemCount: conversation.length,
          itemBuilder: (context, index) {
            final subCategory = conversation[index];

            return GestureDetector(
              onTap: () => Navigator.pushNamed(
                context,
                '/learnContent',
                arguments: {
                  'category': 'conversation',
                  'subCategory': subCategory,
                  'subCategoryIndex': index,
                  'rebuildScreen': rebuildScreen,
                },
              ),
              child: TopicCard(
                imageUrl: cardImageUrl,
                title: subCategory['subCategory'],
                learnedWords: subCategory['learnedWords'].length,
                totalWords: subCategory['totalWords'],
              ),
            );
          }),
    );
  }
}
