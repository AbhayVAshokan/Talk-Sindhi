// Progress bar for vocabulary and conversation data in the profile screen.

import 'package:flutter/material.dart';

import 'package:talksindhi/realtime_data.dart';

class ProgressData extends StatelessWidget {
  final String category;
  ProgressData({this.category});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
          child: Card(
        
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: Colors.indigo[100],
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 50.0,
          ),
          child: Column(
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
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: LinearProgressIndicator(
                  value: (category == 'vocabulary'
                          ? wordsLearned[0]
                          : wordsLearned[1]) /
                      (category == 'vocabulary' ? totalWords[0] : totalWords[1]),
                  backgroundColor: Colors.grey[100],
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.indigo),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    (category == 'vocabulary'
                            ? '${(wordsLearned[0] / totalWords[0] * 100).toStringAsFixed(2)}'
                            : '${(wordsLearned[1] / totalWords[1] * 100).toStringAsFixed(2)}') +
                        '% ' +
                        (globalLanguage == 'english' ? 'completed' : 'पूरा हुआ'),
                    style: const TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
