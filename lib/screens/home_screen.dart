import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../my_appbar.dart';
import '../my_bottom_navbar.dart';
import '../widgets/homescreen/other_apps.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var language = 'english';

  @override
  Widget build(BuildContext context) {
    Directory directory;
    String fileName = 'userData.json';
    Map<String, dynamic> localStorage;

    // Function to return the location at which the data is stored locally.
    getApplicationDocumentsDirectory().then(
      (Directory dir) {
        directory = dir;
        var path = directory.path + '/' + fileName;
        var jsonFile = File(path);
        localStorage = json.decode(jsonFile.readAsStringSync());

        if (language != localStorage['language']) {
          setState(() {
            language = localStorage['language'];
          });
        }
      },
    );
    print('rebuilding screen');
    MediaQueryData mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height - mediaQuery.padding.top;
    final width = mediaQuery.size.width;
    final screenRatio = height / width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: myAppBar(
            context: context,
            rebuildScreen: () {
              setState(() {
                print('Rebuilding screen');
              });
            }),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 10,
              child: Container(
                width: width,
                padding: const EdgeInsets.only(left: 150, top: 10),
                child: Image.asset(
                  'assets/images/home_screen/ic_landing_image.png',
                  alignment: Alignment.centerRight,
                  fit: BoxFit.contain,
                  width: screenRatio >= 1 ? width / 2 : height / 2,
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 5.0,
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) => Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: language == 'english'
                              ? "Welcome to Sindhi Sangat\n"
                              : "सिंधी संगत में आपका स्वागत है\n",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                              fontSize: constraints.maxHeight * 0.18,
                              color: Colors.black),
                          children: [
                            TextSpan(
                              text: language == 'english'
                                  ? "Made Easy"
                                  : 'आसान बना दिया',
                              style: TextStyle(
                                fontSize: constraints.maxHeight * 0.15,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.0,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox.shrink(),
                      Text(
                        language == 'english'
                            ? "Dedicated to the promotion of Sindhi Language Culture & Heritage"
                            : 'सिंधी भाषा संस्कृति और विरासत को बढ़ावा देने के लिए समर्पित',
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                              color: Colors.grey,
                              fontSize: constraints.maxHeight * 0.12,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 10,
              child: OtherApps(language: language),
            ),
          ],
        ),
        bottomNavigationBar: myBottomNavbar(
          context: context,
          currentIndex: 0,
        ),
      ),
    );
  }
}
