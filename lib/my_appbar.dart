// Custom AppBar

import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:talksindhi/file_operations.dart';
import 'package:talksindhi/realtime_data.dart';

// Language toggle dialog box.
languageToggle({
  @required BuildContext context,
  @required Function rebuildScreen,
}) {
  Widget languageButton({
    @required String language,
    @required Function onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: RaisedButton(
        padding: const EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          alignment: Alignment.center,
          width: 120.0,
          child: Text(
            language,
            style: Theme.of(context).textTheme.headline6.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        color: Theme.of(context).primaryColor,
        onPressed: () {
          onPressed();
          Navigator.pop(context);
        },
      ),
    );
  }

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/language_logo.png',
              fit: BoxFit.contain,
              width: 150.0,
              height: 150.0,
            ),
            Text(
              'Choose Language',
              style: Theme.of(context).textTheme.headline4,
            ),
            FittedBox(
              child: const Text(
                "Select your prefered Language",
                textAlign: TextAlign.center,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey,
                  letterSpacing: 1.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            const SizedBox(height: 30.0),
            languageButton(
              language: 'ENGLISH',
              onPressed: () {
                globalLanguage = 'english';
                writeToFile(
                  fileName: 'userData.json',
                  content: {
                    'language': 'english',
                  },
                );
                rebuildScreen();
              },
            ),
            languageButton(
              language: 'हिन्दी',
              onPressed: () {
                globalLanguage = 'hindi';
                writeToFile(
                  fileName: 'userData.json',
                  content: {
                    'language': 'hindi',
                  },
                );
                rebuildScreen();
              },
            ),
          ],
        ),
      );
    },
  );
}

void shareApp() {
  Share.share(
    'https://play.google.com/store/apps/details?id=com.sindhisangat.learnsindhi \n\nDedicated to the promotion of Sindhi Language Culture & Heritage. ',
  );
}

// Individual tabs in TabBar
Widget tabView({String title}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Tab(
      child: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15.0,
        ),
      ),
    ),
  );
}

// TabBar below AppBar
TabBar tabBar({
  @required BuildContext context,
  @required children,
}) {
  return TabBar(
    labelStyle: const TextStyle(letterSpacing: 1.0),
    isScrollable: true,
    labelColor: Colors.white,
    unselectedLabelColor: Colors.black,
    indicatorSize: TabBarIndicatorSize.label,
    indicator: BoxDecoration(
      borderRadius: BorderRadius.circular(50),
      color: Theme.of(context).primaryColor,
    ),
    labelPadding: const EdgeInsets.symmetric(
      horizontal: 10.0,
      // vertical: 5.0,
    ),
    tabs: children,
  );
}

// Main AppBar
AppBar myAppBar({
  @required BuildContext context,
  @required Function rebuildScreen,
  TabBar tabBar,
}) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 5,
    iconTheme: IconThemeData(
      color: Colors.grey,
      size: 35.0,
    ),
    title: Text(
      "Talk Sindhi",
      style: Theme.of(context).textTheme.headline6.copyWith(letterSpacing: 1.0),
    ),
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.share),
        color: Theme.of(context).primaryColor,
        onPressed: () => shareApp(),
      ),
      IconButton(
        icon: Icon(Icons.search),
        color: Theme.of(context).primaryColor,
        onPressed: () {},
      ),
      IconButton(
        icon: Icon(Icons.language),
        color: Theme.of(context).primaryColor,
        onPressed: () => languageToggle(
          rebuildScreen: () => rebuildScreen(),
          context: context,
        ),
      ),
    ],
    bottom: tabBar != null ? tabBar : null,
  );
}
