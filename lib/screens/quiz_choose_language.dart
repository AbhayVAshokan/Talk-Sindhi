import 'dart:math';

import 'package:flutter/material.dart';

import '../my_appbar.dart';
import '../realtime_data.dart';

class QuizChooseLanguage extends StatefulWidget {
  @override
  _QuizChooseLanguageState createState() => _QuizChooseLanguageState();
}

class _QuizChooseLanguageState extends State<QuizChooseLanguage> {
  generateVocabularyQuiz({int questions}) {
    var randomQuestions = [];
    List<Map<String, dynamic>> questionPool = [];

    for (var i = 0; i < vocabulary.length; i++) {
      for (var j = 0; j < vocabulary[i]['learnedWords'].length; j++) {
        questionPool.add(vocabulary[i]['learnedWords'][j]);
      }
    }

    final random = Random();
    while (randomQuestions.length < questions) {
      var randNumQ = random.nextInt(questionPool.length);

      // Generate a random question
      if (!randomQuestions.contains(randNumQ)) {
        randomQuestions.add(randNumQ);
      } else
        continue;

      // generate random options
      var randomOptions = [];
      while (randomOptions.length < 3) {
        var randNumA = random.nextInt(questionPool.length);

        if (randNumA != randNumQ && !randomOptions.contains(randNumA)) {
          randomOptions.add(randNumA);
        }
      }

      optionsOrder = [];
      while (optionsOrder.length != 4) {
        var randNum = random.nextInt(4);
        if (!optionsOrder.contains(randNum)) optionsOrder.add(randNum);
      }

      quizData.add(
        {
          'question': quizLanguage == 'english'
              ? questionPool[randNumQ]['english']
              : questionPool[randNumQ]['hindi'],
          'answer': questionPool[randNumQ]['sindhi'],
          'option1': questionPool[randomOptions[0]]['sindhi'],
          'option2': questionPool[randomOptions[1]]['sindhi'],
          'option3': questionPool[randomOptions[2]]['sindhi'],
          'optionsOrder': optionsOrder,
          'colors': [
            Colors.purple[100],
            Colors.purple[100],
            Colors.purple[100],
            Colors.purple[100],
          ],
          'marked': -1,
        },
      );
    }
  }

  List<String> shuffle(List<String> items) {
    var random = new Random();

    // Go through all elements.
    for (var i = items.length - 1; i > 1; i--) {
      // Pick a pseudorandom number according to the list length
      var n = random.nextInt(i + 1);

      var temp = items[i];
      items[i] = items[n];
      items[n] = temp;
    }

    return items;
  }

  generateConversationQuiz({int questions}) {
    var randomQuestions = [];
    List<Map<String, dynamic>> questionPool = [];

    for (var i = 0; i < conversation.length; i++) {
      for (var j = 0; j < conversation[i]['learnedWords'].length; j++) {
        questionPool.add(conversation[i]['learnedWords'][j]);
      }
    }

    final random = Random();
    while (randomQuestions.length < questions) {
      var randNumQ = random.nextInt(questionPool.length);

      // Generate a random question
      if (!randomQuestions.contains(randNumQ)) {
        randomQuestions.add(randNumQ);
      } else
        continue;

      // generate random options
      List<String> randomOptions = [];
      List<String> sindhiWords;

      // formatting answer
      String correctAnswer = questionPool[randNumQ]['sindhi'];
      if (correctAnswer.contains(':')) {
        correctAnswer = correctAnswer.replaceAll(':', '');
        sindhiWords = correctAnswer.split(' ');
        if (sindhiWords.length > 1) sindhiWords.removeAt(0);
      } else
        sindhiWords = correctAnswer.split(' ');

      correctAnswer = sindhiWords.join(' ');

      int counter =
          0; // this is used for the worst case scenario where it goes into infinite loop (try 50 different random sequences of the translation. If it fails, assign it with another option)
      while (randomOptions.length < 3) {
        if (counter >= 50)
          randomOptions
              .add(questionPool[random.nextInt(questionPool.length)]['sindhi']);
        counter += 1;

        String newOption = shuffle(sindhiWords).join(' ');

        if (!randomOptions.contains(newOption) && newOption != correctAnswer)
          randomOptions.add(newOption);
      }

      optionsOrder = [];
      while (optionsOrder.length != 4) {
        var randNum = random.nextInt(4);
        if (!optionsOrder.contains(randNum)) optionsOrder.add(randNum);
      }

      quizData.add(
        {
          'question': quizLanguage == 'english'
              ? questionPool[randNumQ]['english']
              : questionPool[randNumQ]['hindi'],
          'answer': correctAnswer,
          'option1': randomOptions[0],
          'option2': randomOptions[1],
          'option3': randomOptions[2],
          'optionsOrder': optionsOrder,
          'colors': [
            Colors.purple[100],
            Colors.purple[100],
            Colors.purple[100],
            Colors.purple[100],
          ],
          'marked': -1,
        },
      );
    }
  }

  generateAbsoluteQuiz({int vocabularyQuestions, int conversationQuestions}) {
    generateVocabularyQuiz(questions: vocabularyQuestions);
    generateConversationQuiz(questions: conversationQuestions);
  }

  // Function to generate all the random questions and the options to be displayed.
  generateQuiz({String category, int questions}) {
    // Updating global data
    quizData = [];
    quizCategory = category;

    if (category == 'vocabulary')
      generateVocabularyQuiz(questions: questions);
    else if (category == 'conversation')
      generateConversationQuiz(questions: questions);
    else {
      if (wordsLearned[0] < questions / 2)
        generateAbsoluteQuiz(
            vocabularyQuestions: wordsLearned[0],
            conversationQuestions: questions - wordsLearned[0]);
      else if (wordsLearned[1] < questions / 1)
        generateAbsoluteQuiz(
            vocabularyQuestions: questions - wordsLearned[1],
            conversationQuestions: wordsLearned[1]);
      else
        generateAbsoluteQuiz(
            vocabularyQuestions: questions ~/ 2,
            conversationQuestions: questions - questions ~/ 2);
    }
  }

  @override
  initState() {
    super.initState();
    quizLanguage = 'english';
  }

  String language = 'english';
  @override
  Widget build(BuildContext context) {
    if (quizCategory == 'vocabulary' || quizCategory == 'conversation')
      totalTime = 60;
    else
      totalTime = 120;

    bool attemptQuiz = true;
    if (quizCategory == 'vocabulary' && wordsLearned[0] < 20 ||
        quizCategory == 'conversation' && wordsLearned[1] < 20 ||
        quizCategory == 'absolute' && wordsLearned[0] + wordsLearned[1] < 20)
      attemptQuiz = false;

    if (attemptQuiz)
      generateQuiz(
        category: quizCategory,
        questions: quizCategory == 'absolute' ? 20 : 10,
      );

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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          quizLanguage = 'english';
                          language = 'english';
                        });
                      },
                      child: Card(
                        color: quizLanguage == 'english'
                            ? Colors.amber
                            : Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width * 0.5,
                          child: Center(
                            child: Text(
                              'English',
                              style: TextStyle(
                                fontFamily: 'Quintessential',
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold,
                                color: quizLanguage == 'english'
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          quizLanguage = 'hindi';
                          language = 'hindi';
                        });
                      },
                      child: Card(
                        color: quizLanguage == 'hindi'
                            ? Colors.amber
                            : Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.width * 0.5,
                          child: Center(
                            child: Text(
                              'हिन्दी',
                              style: TextStyle(
                                fontFamily: 'Quintessential',
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold,
                                color: quizLanguage == 'hindi'
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            attemptQuiz
                ? Text(
                    quizLanguage == 'english'
                        ? 'CHOOSE LANGUAGE'
                        : 'भाषा चुनें',
                    style: const TextStyle(
                      color: Colors.white24,
                      fontFamily: 'Quintessential',
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  )
                : Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Text(
                      'You must atleast learn 20 words to attempt the quiz',
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontFamily: 'Quintessential',
                      ),
                    ),
                  ),
            RaisedButton(
              padding: const EdgeInsets.symmetric(
                horizontal: 60.0,
                vertical: 13.0,
              ),
              color: Colors.teal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              onPressed: attemptQuiz
                  ? () => Navigator.pushReplacementNamed(
                        context,
                        '/quizQuestions',
                      )
                  : null,
              disabledColor: Colors.grey,
              child: SizedBox(
                width: 100.0,
                height: 30.0,
                child: Text(
                  quizLanguage == 'english' ? 'START' : 'शुरू',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
