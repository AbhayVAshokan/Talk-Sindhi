// Splash Screen: Duration = 3 seconds

import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height -
        mediaQuery.padding.top -
        mediaQuery.padding.bottom;
    final width = mediaQuery.size.width;
    final screenRatio = height / width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: SizedBox.shrink(),
            ),
            Expanded(
              flex: 5,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: const AssetImage(
                          'assets/images/splash_screen/splash_foreground.png',
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(
                      left: screenRatio < 1
                          ? (width / 2 - (height * 5 / 7) * 0.5)
                          : width * 0.13,
                      bottom: height * 0.075,
                    ),
                    child: Text(
                      'Speak \nSindhi',
                      style: Theme.of(context).textTheme.headline6.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      "Presented by,",
                      style: Theme.of(context).textTheme.headline5.copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Container(
                    child: Image.asset(
                      'assets/images/splash_screen/powerd_by_logo.png',
                      width: 80,
                      height: 80,
                      fit: BoxFit.contain,
                    ),
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
