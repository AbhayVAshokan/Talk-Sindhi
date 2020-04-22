import 'dart:async';

import 'package:flutter/material.dart';

import '../my_appbar.dart';
import '../realtime_data.dart';
import '../widgets/quiz_screen/quiz_question.dart';

class QuizQuestionsScreen extends StatefulWidget {
  @override
  _QuizQuestionsScreenState createState() => _QuizQuestionsScreenState();
}

class _QuizQuestionsScreenState extends State<QuizQuestionsScreen> {
  Timer _timer;
  int _time = totalTime;
  PageController _pageController = PageController();

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_time < 1) {
            timer.cancel();
            print('done done done done');
          } else {
            _time = _time - 1;
          }
        },
      ),
    );
  }

  @override
  void initState() {
    startTimer();
    correctAnswers = 0;
    wrongAnswers = 0;
    notAttempted = quizData.length;

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var pageNumber = 0;

    return SafeArea(
      child: Scaffold(
        appBar: myAppBar(
            context: context,
            rebuildScreen: () {},
            backButton: true,
            backgroundColor: Color(0xFF54123B),
            pointsBar: true,
            iconColor: Colors.white,
            elevation: 0.0),
        backgroundColor: Color(0x4454123B),
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              color: Color(0xFF54123B),
              height: 40.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    margin: const EdgeInsets.only(left: 20.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: Colors.purple,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 3.0,
                      ),
                      child: Text(
                        'Question ${pageNumber + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Quintessential',
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 80.0,
                    child: Row(
                      children: [
                        Icon(
                          Icons.timer,
                          color: _time <= 10 ? Colors.red : Colors.white,
                          size: 30.0,
                        ),
                        Text(
                          ' $_time',
                          style: TextStyle(
                            color: _time <= 10 ? Colors.red : Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                physics: _time == 0 ? NeverScrollableScrollPhysics() : null,
                itemCount: quizData.length,
                itemBuilder: (context, index) {
                  pageNumber = index;

                  return QuizQuestion(questionNumber: index);
                },
                controller: _pageController,
              ),
            ),
            Container(
              color: Color(0xFF54123B),
              height: 100.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: RaisedButton(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 13.0,
                      ),
                      color: Colors.amber,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      onPressed: () {
                        timeTaken = totalTime - _time;
                        Navigator.pushReplacementNamed(context, '/quizResults');
                      },
                      disabledColor: Colors.grey,
                      child: SizedBox(
                        width: 100.0,
                        height: 30.0,
                        child: Text(
                          quizLanguage == 'english' ? 'FINISH' : 'समाप्त',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: _time == 0
                            ? null
                            : () {
                                _pageController.animateToPage(
                                  pageNumber - 1,
                                  duration: Duration(milliseconds: 200),
                                  curve: Curves.decelerate,
                                );
                              },
                        child: CircleAvatar(
                          radius: 30.0,
                          backgroundColor:
                              _time == 0 ? Colors.grey : Colors.pink,
                          child: Icon(
                            Icons.chevron_left,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      GestureDetector(
                        onTap: _time == 0
                            ? null
                            : () {
                                if (pageNumber != quizData.length - 1)
                                  _pageController.animateToPage(
                                    pageNumber + 1,
                                    duration: Duration(milliseconds: 200),
                                    curve: Curves.decelerate,
                                  );
                              },
                        child: CircleAvatar(
                          radius: 30.0,
                          backgroundColor:
                              _time == 0 ? Colors.grey : Colors.pink,
                          child: Icon(
                            Icons.chevron_right,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20.0),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
