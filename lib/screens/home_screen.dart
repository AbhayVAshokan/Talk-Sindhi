import 'package:flutter/material.dart';

import '../my_appbar.dart';
import '../realtime_data.dart';
import '../my_bottom_navbar.dart';
import '../widgets/homescreen/other_apps.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
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
                          text: globalLanguage == 'english'
                              ? "Welcome to Sindhi Sangat\n"
                              : "सिंधी संगत में आपका स्वागत है\n",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                              fontSize: constraints.maxHeight * 0.18,
                              color: Colors.black),
                          children: [
                            TextSpan(
                              text: globalLanguage == 'english'
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
                        globalLanguage == 'english'
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
              child: OtherApps(language: globalLanguage),
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
