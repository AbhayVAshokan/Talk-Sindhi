// Individual cards in the vocabulary grid view.

import 'package:flutter/material.dart';

class TopicCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final int learnedWords;
  final int totalWords;

  TopicCard({
    @required this.imageUrl,
    @required this.title,
    @required this.learnedWords,
    @required this.totalWords,
  });

  @override
  Widget build(BuildContext context) {
    final double progress = learnedWords / totalWords;

    return LayoutBuilder(
      builder: (context, constraints) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          color: progress == 1
              ? Colors.green[200]
              : (progress > 0 ? Colors.amber[100] : Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: constraints.maxHeight * 0.55,
                width: constraints.maxWidth * 0.7,
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(5.0),
                  image: DecorationImage(
                    image: AssetImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: constraints.maxWidth * 0.05),
                    child: Text(
                      '${title[0].toUpperCase()}${title.substring(1).replaceAll('_', ' ')}',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: constraints.maxHeight * 0.09,
                      ),
                    ),
                  ),
                  Text(
                    '$learnedWords/$totalWords',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: constraints.maxHeight * 0.08,
                    ),
                  ),
                ],
              ),
              Container(
                height: constraints.maxHeight * 0.1,
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 15),
                child: LinearProgressIndicator(
                  value: learnedWords / totalWords,
                  backgroundColor: Colors.grey[100],
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.orange),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
