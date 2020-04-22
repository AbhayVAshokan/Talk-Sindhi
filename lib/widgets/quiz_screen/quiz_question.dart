import 'package:flutter/material.dart';
import 'package:talksindhi/realtime_data.dart';

class QuizQuestion extends StatefulWidget {
  final int questionNumber;
  QuizQuestion({this.questionNumber});

  @override
  _QuizQuestionState createState() => _QuizQuestionState();
}

class _QuizQuestionState extends State<QuizQuestion> {
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
          child: Card(
            child: Container(
              padding: const EdgeInsets.all(25.0),
              alignment: Alignment.center,
              child: Text(
                question,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 30.0,
                  fontFamily: 'Quintessential',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 7,
          child: GridView(
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
                  if (quizData[widget.questionNumber]['marked'] == -1) {
                    if (option == choices[0]) {
                      correctAnswers += 1;
                      notAttempted -= 1;
                    } else {
                      wrongAnswers += 1;
                      notAttempted -= 1;
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
                  color: quizData[widget.questionNumber]['colors'][index],
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(25.0),
                    child: Text(
                      option,
                      maxLines: 4,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 17.0),
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
