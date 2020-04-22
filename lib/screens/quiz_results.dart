import 'package:flutter/material.dart';
import 'package:talksindhi/file_operations.dart';

import '../my_appbar.dart';
import '../realtime_data.dart';

class QuizResults extends StatelessWidget {
  calculatePoints() {
    double pts = 0;
    pts += correctAnswers;

    if (timeTaken <= totalTime / 2 && wrongAnswers == 0 && notAttempted == 0)
      pts += 5;

    quizPoints = pts.toInt();

    userData['points'] += quizPoints;
    writeToFile(content: userData, fileName: '/userData.json');
  }

  @override
  Widget build(BuildContext context) {
    bool allCorrect =
        correctAnswers == (correctAnswers + wrongAnswers + notAttempted);
    bool goodPerformance =
        correctAnswers >= (correctAnswers + wrongAnswers + notAttempted) / 2;

    Map<String, String> message;
    if (allCorrect) {
      message = {
        'english': 'Your practice is really paying off',
        'hindi': 'आपका अभ्यास वास्तव में भुगतान कर रहा है',
      };
    } else if (goodPerformance) {
      message = {
        'english': 'I\'ve noticed how hard you\'ve been trying',
        'hindi': 'मैंने देखा है कि आप कितनी मेहनत कर रहे हैं',
      };
    } else {
      message = {
        'english': 'Practice makes you perfect',
        'hindi': 'अभ्यास आपको परिपूर्ण बनाता है',
      };
    }

    calculatePoints();
    print(quizData);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0x4454123B),
        appBar: myAppBar(
          context: context,
          rebuildScreen: () {},
          backButton: true,
          backgroundColor: Color(0xFF54123B),
          pointsBar: true,
          iconColor: Colors.white,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              quizLanguage == 'english'
                  ? 'QUIZ RESULTS'
                  : 'प्रश्नोत्तरी परिणाम',
              style: const TextStyle(
                color: Colors.amber,
                fontFamily: 'Quintessential',
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
                fontSize: 40.0,
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Stack(
                children: [
                  Card(
                    margin: const EdgeInsets.all(0.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        allCorrect
                            ? 'assets/images/quiz_screen/all_correct.jpg'
                            : goodPerformance
                                ? 'assets/images/quiz_screen/good_performance.jpg'
                                : 'assets/images/quiz_screen/bad_performance.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0.0,
                    top: 20.0,
                    child: Card(
                      margin: const EdgeInsets.all(0.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          bottomLeft: Radius.circular(20.0),
                        ),
                      ),
                      color: Colors.amber,
                      child: FittedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: userData['league'] == 'bronze'
                                    ? Color(0xFFCD6B32)
                                    : (userData['league'] == 'silver'
                                        ? Color(0xFFAAA9AD)
                                        : Color(0xFFFFD700)),
                                radius:
                                    MediaQuery.of(context).size.width * 0.04,
                                child: FittedBox(
                                  child: Icon(
                                    Icons.star,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Text(
                                quizLanguage == 'english'
                                    ? ' +$quizPoints points'
                                    : '+$quizPoints अंक',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20.0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: 75,
                      alignment: Alignment.center,
                      color: Colors.black54,
                      child: FittedBox(
                        child: Text(
                          quizLanguage == 'english'
                              ? message['english']
                              : message['hindi'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Quintessential',
                            fontWeight: FontWeight.bold,
                            fontSize: 40.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    text: quizLanguage == 'english' ? 'SCORE: ' : 'स्कोर: ',
                    children: [
                      TextSpan(
                        text: '$correctAnswers',
                        style: const TextStyle(fontFamily: '.SF UI Display'),
                      ),
                      TextSpan(
                        text: '/',
                        style: const TextStyle(fontFamily: '.SF UI Display'),
                      ),
                      TextSpan(
                        text: '${correctAnswers + notAttempted + wrongAnswers}',
                        style: const TextStyle(fontFamily: '.SF UI Display'),
                      ),
                    ],
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Quintessential',
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                  ),
                ),
                Text(
                  timeTaken < totalTime / 2 &&
                          (wrongAnswers == 0 && notAttempted == 0)
                      ? (quizLanguage == 'english'
                          ? '+time bonus'
                          : '+समय बोनस')
                      : '',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontFamily: 'Quintessential',
                    fontSize: 15.0,
                    letterSpacing: 1.0,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 20.0,
                      bottom: 30.0,
                      left: 20.0,
                      right: 10.0,
                    ),
                    child: RaisedButton(
                      padding: const EdgeInsets.symmetric(vertical: 13.0),
                      color: Colors.pink,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      onPressed: () => Navigator.pushReplacementNamed(
                        context,
                        '/chooseLanguage',
                        arguments: quizCategory,
                      ),
                      child: FittedBox(
                        child: Text(
                          quizLanguage == 'english'
                              ? 'RETRY'
                              : 'पुन: प्रयास करें',
                          style: const TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 20.0,
                      bottom: 30.0,
                      left: 10.0,
                      right: 20.0,
                    ),
                    child: RaisedButton(
                      padding: const EdgeInsets.symmetric(vertical: 13.0),
                      color: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      onPressed: () =>
                          Navigator.pushReplacementNamed(context, '/quiz'),
                      child: Text(
                        quizLanguage == 'english' ? 'FINISH' : 'समाप्त',
                        style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
