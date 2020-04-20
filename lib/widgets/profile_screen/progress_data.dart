// Progress bar for vocabulary and conversation data in the profile screen.

import 'package:flutter/material.dart';

import 'package:talksindhi/realtime_data.dart';

class ProgressData extends StatelessWidget {
  final String category;
  ProgressData({this.category});

  @override
  Widget build(BuildContext context) {
    print(wordsLearned);
    print('total words: ' + totalWords.toString());
    return LayoutBuilder(
      builder: (context, constraints) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: Colors.indigo[200],
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: constraints.maxHeight * 0.1,
            horizontal: 50.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    globalLanguage == 'english'
                        ? '${category[0].toUpperCase()}${category.substring(1)}'
                        : (category == 'vocabulary' ? 'शब्दावली' : 'बातचीत'),
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              totalWords[0] != 0
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: LinearProgressIndicator(
                        value: (category == 'vocabulary'
                                ? wordsLearned[0]
                                : wordsLearned[1]) /
                            (category == 'vocabulary'
                                ? totalWords[0]
                                : totalWords[1]),
                        backgroundColor: Colors.grey[100],
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.indigo),
                      ),
                    )
                  : Text('Progress not available'),
              totalWords[0] != 0
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          (category == 'vocabulary'
                                  ? '${(wordsLearned[0] / totalWords[0] * 100).toStringAsFixed(2)}'
                                  : '${(wordsLearned[1] / totalWords[1] * 100).toStringAsFixed(2)}') +
                              '% ' +
                              (globalLanguage == 'english'
                                  ? 'completed'
                                  : 'पूरा हुआ'),
                          style: const TextStyle(color: Colors.black54),
                        ),
                      ],
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
