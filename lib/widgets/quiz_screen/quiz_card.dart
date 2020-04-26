import 'package:flutter/material.dart';

import '../../realtime_data.dart';

class QuizCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final int winPoints;
  final Color backgroundColor;
  final int questions;
  final String cardImage;

  QuizCard({
    @required this.imageUrl,
    @required this.name,
    @required this.winPoints,
    @required this.backgroundColor,
    @required this.questions,
    @required this.cardImage,
  });

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(40.0),
      child: Card(
        color: backgroundColor,
        child: SizedBox(
          width: mediaQuery.size.width * 0.9,
          height: mediaQuery.size.width * 1.2,
          child: LayoutBuilder(
            builder: (context, constraints) => Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  children: [
                    Image.asset(
                      imageUrl,
                      width: constraints.maxWidth,
                      height: constraints.maxHeight * 0.85,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 20.0,
                      right: 0.0,
                      child: Card(
                        margin: const EdgeInsets.all(0.0),
                        color: Colors.amber,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            globalLanguage == 'english'
                                ? 'Win $winPoints points'
                                : '$winPoints अंक जीते',
                            style: const TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10.0,
                      child: Container(
                        width: constraints.maxWidth,
                        color: Colors.black38,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FittedBox(
                              child: SizedBox(
                                width: constraints.maxWidth * 0.8,
                                child: SizedBox(
                                  width: constraints.maxWidth * 0.5,
                                  child: FittedBox(
                                    child: Text(
                                      name.toUpperCase(),
                                      maxLines: 1,
                                      style: const TextStyle(
                                          fontFamily: 'Quintessential',
                                          color: Colors.amber,
                                          fontSize: 50.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: constraints.maxWidth * 0.35,
                              child: FittedBox(
                                child: Text(
                                  globalLanguage == 'english'
                                      ? 'TRIVIA'
                                      : 'प्रश्नोत्तरी',
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontFamily: 'Quintessential',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 40.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            cardImage,
                            height: constraints.maxHeight * 0.75,
                          ),
                          Row(
                            children: [
                              Text(
                                '$questions',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Quintessential',
                                  fontSize: 20.0,
                                ),
                              ),
                              Text(
                                globalLanguage == 'english'
                                    ? ' questions'
                                    : ' प्रशन',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Quintessential',
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                          FlatButton.icon(
                            color: Color(0xff202040),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            onPressed: () {},
                            icon: Icon(
                              Icons.timer,
                              size: 30.0,
                              color: Colors.white,
                            ),
                            label: Text(
                              globalLanguage == 'english'
                                  ? '${questions * 6} seconds'
                                  : '${questions * 6} सेकंड',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Quintessential',
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
