// Major configurations: Routes and ThemeData

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './screens/splash_screen.dart';
import './screens/home_screen.dart';
import './screens/login_screen.dart';
import './screens/profile_screen.dart';
import './screens/settings_screen.dart';
import './screens/topics_screen.dart';
import './screens/learn_vocabulary.dart';

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
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),
        '/topics': (context) => TopicsScreen(),
        '/profile': (context) => ProfileScreen(),
        '/settings': (context) => SettingsScreen(),
        '/learnVocabulary': (context) => LearnVocabulary( ModalRoute.of(context).settings.arguments),
      },
    );
  }
}
