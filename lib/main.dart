// Major configurations: Routes and ThemeData

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './screens/home_screen.dart';
import './screens/quiz_screen.dart';
import './screens/quiz_results.dart';
import './screens/login_screen.dart';
import './screens/search_screen.dart';
import './screens/topics_screen.dart';
import './screens/learn_content.dart';
import './screens/splash_screen.dart';
import './screens/profile_screen.dart';
import './screens/forgot_password.dart';
import './screens/registration_screen.dart';
import './screens/quiz_choose_language.dart';
import './screens/quiz_questions_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    TalkSindhi(),
  );
}

class TalkSindhi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Talk Sindhi",
      theme: ThemeData(
        primarySwatch: Colors.orange,
        primaryColor: const Color.fromRGBO(156, 9, 9, 1),
        backgroundColor: const Color(0xFFFFE3D7),
        textTheme: const TextTheme(
          headline4: const TextStyle(
            fontSize: 25.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
          headline6: const TextStyle(
            fontSize: 22.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          subtitle2: TextStyle(
            letterSpacing: 0.75,
            fontSize: 20.0,
          ),
        ),
        iconTheme: const IconThemeData(
          size: 40.0,
        ),
        cursorColor: Colors.orange,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => HomeScreen(),
        '/quiz': (context) => QuizScreen(),
        '/login': (context) => LoginScreen(),
        '/topics': (context) => TopicsScreen(),
        '/search': (context) => SearchScreen(),
        '/profile': (context) => ProfileScreen(),
        '/quizResults': (context) => QuizResults(),
        '/register': (context) => RegistrationScreen(),
        '/forgotPassword': (context) => ForgotPassword(),
        '/chooseLanguage': (context) => QuizChooseLanguage(),
        '/quizQuestions': (context) => QuizQuestionsScreen(),
        '/learnContent': (context) =>
            LearnContent(ModalRoute.of(context).settings.arguments),
      },
    );
  }
}
