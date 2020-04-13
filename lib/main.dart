// Major configurations: Routes and ThemeData

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './screens/splash_screen.dart';
import './screens/home_screen.dart';

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
        primaryColor: Colors.white,
        backgroundColor: const Color.fromRGBO(255, 227, 215, 10),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
