import 'package:flutter/material.dart';

import '../realtime_data.dart';
import '../widgets/homescreen/topic_card.dart';

class VocabularyTab extends StatelessWidget {
  final Function rebuildScreen;
  final String cardImageUrl;

  VocabularyTab({
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
          itemCount: vocabulary.length,
          itemBuilder: (context, index) {
            final subCategory = vocabulary[index];

            return InkWell(
              splashColor: Colors.orange,
              onTap: () => Navigator.pushNamed(
                context,
                '/learnContent',
                arguments: {
                  'category': 'vocabulary',
                  'subCategory': subCategory,
                  'subCategoryIndex': index,
                  'rebuildScreen': rebuildScreen,
                  'initialIndex': 0,
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
