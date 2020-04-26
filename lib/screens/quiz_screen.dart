import 'package:flutter/material.dart';

import '../my_appbar.dart';
import '../realtime_data.dart';
import '../my_bottom_navbar.dart';
import '../widgets/quiz_screen/quiz_card.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0x7754123B),
        appBar: myAppBar(
          context: context,
          pointsBar: true,
          backgroundColor: Color(0xFF54123B),
          iconColor: Colors.white,
          rebuildScreen: () {
            setState(() {
              print('rebuilding screen');
            });
          },
        ),
        body: ListView(
          children: [
            GestureDetector(
              onTap: () {
                totalTime = 60;
                quizCategory = 'vocabulary';
                Navigator.pushNamed(
                  context,
                  '/chooseLanguage',
                );
              },
              child: QuizCard(
                name: globalLanguage == 'english' ? 'Vocabulary' : 'शब्दावली',
                imageUrl: 'assets/images/quiz_screen/vocabulary.jpg',
                winPoints: 15,
                backgroundColor: Color(0xFF84142D),
                questions: 10,
                cardImage: 'assets/images/quiz_screen/vocabulary_card.png',
              ),
            ),
            GestureDetector(
              onTap: () {
                totalTime = 60;
                quizCategory = 'conversation';
                Navigator.pushNamed(
                  context,
                  '/chooseLanguage',
                );
              },
              child: QuizCard(
                name: globalLanguage == 'english' ? 'Conversation' : 'बातचीत',
                imageUrl: 'assets/images/quiz_screen/conversation.jpg',
                winPoints: 15,
                backgroundColor: Colors.amber,
                questions: 10,
                cardImage: 'assets/images/quiz_screen/conversation_card.png',
              ),
            ),
            GestureDetector(
              onTap: () {
                totalTime = 120;
                quizCategory = 'absolute';
                Navigator.pushNamed(
                  context,
                  '/chooseLanguage',
                );
              },
              child: QuizCard(
                name: globalLanguage == 'english' ? 'Absolute' : 'मुकम्मल',
                imageUrl: 'assets/images/quiz_screen/absolute.jpg',
                winPoints: 25,
                backgroundColor: Color(0xFF182952),
                questions: 20,
                cardImage: 'assets/images/quiz_screen/absolute_card.png',
              ),
            ),
          ],
        ),
        bottomNavigationBar: myBottomNavbar(
          context: context,
          currentIndex: 2,
        ),
      ),
    );
  }
}
