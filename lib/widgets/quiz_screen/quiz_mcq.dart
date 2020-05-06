import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

import '../../realtime_data.dart';

class QuizMCQ extends StatefulWidget {
  final time;
  final int questionNumber;
  final String quizLanguage;
  final PageController pageController;

  QuizMCQ({
    this.questionNumber,
    @required this.time,
    @required this.quizLanguage,
    @required this.pageController,
  });

  @override
  _QuizMCQState createState() => _QuizMCQState();
}

class _QuizMCQState extends State<QuizMCQ> {
  AudioPlayer advancedPlayer;
  AudioCache audioCache;

  playLocalAudio({String url}) {
    audioCache.play(url);
  }

  @override
  void initState() {
    advancedPlayer = new AudioPlayer();
    audioCache = new AudioCache(fixedPlayer: advancedPlayer);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String question = quizData[widget.questionNumber]['question'];
    if (question.contains(':')) {
      question = question.replaceAll(':', '');
      List<String> questionWords = question.split(' ');
      if (questionWords.length > 1) questionWords.removeAt(0);
      question = questionWords.join(' ');
    }

    List choices = [
      quizData[widget.questionNumber]['answer'],
      quizData[widget.questionNumber]['option1'],
      quizData[widget.questionNumber]['option2'],
      quizData[widget.questionNumber]['option3']
    ];

    List<String> options = [
      choices[quizData[widget.questionNumber]['optionsOrder'][0]],
      choices[quizData[widget.questionNumber]['optionsOrder'][1]],
      choices[quizData[widget.questionNumber]['optionsOrder'][2]],
      choices[quizData[widget.questionNumber]['optionsOrder'][3]],
    ];

    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40.0),
              child: Card(
                margin: const EdgeInsets.all(0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.pink[400],
                    border: Border.all(color: Color(0xFF54123B), width: 7),
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  padding: const EdgeInsets.all(25.0),
                  alignment: Alignment.center,
                  child: Text(
                    question,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: question.length > 10
                          ? (quizLanguage == 'english' ? 25.0 : 27.0)
                          : (quizLanguage == 'english' ? 55.0 : 57.0),
                      fontFamily: 'Quintessential',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 7,
          child: GridView(
            padding: const EdgeInsets.all(10.0),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300,
              childAspectRatio: 1,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            children: options.map((option) {
              int index = options.indexWhere((element) => element == option);

              return GestureDetector(
                onTap: () {
                  if (widget.questionNumber < quizData.length &&
                      widget.time != 0)
                    widget.pageController.animateToPage(
                        widget.questionNumber + 1,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeIn);

                  if (quizData[widget.questionNumber]['marked'] == -1 &&
                      widget.time != 0) {
                    if (option == choices[0]) {
                      correctAnswers += 1;
                      notAttempted -= 1;

                      if (userData['quizAudio'])
                        playLocalAudio(url: 'audios/correct_answer.mp3');
                    } else {
                      wrongAnswers += 1;
                      notAttempted -= 1;
                      if (userData['quizAudio'])
                        playLocalAudio(url: 'audios/wrong_answer.mp3');
                    }
                    setState(
                      () {
                        quizData[widget.questionNumber]['marked'] = index;

                        quizData[widget.questionNumber]['colors'][
                                options.indexWhere(
                                    (element) => element == choices[0])] =
                            Colors.green;
                        if (option != choices[0])
                          quizData[widget.questionNumber]['colors'][index] =
                              Colors.red;
                      },
                    );
                  }
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: quizData[widget.questionNumber]['colors'][index],
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(25.0),
                    child: Text(
                      option,
                      maxLines: 4,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: option.length > 20 ? 17.0 : 30.0,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}
