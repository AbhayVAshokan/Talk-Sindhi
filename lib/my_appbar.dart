// Custom AppBar

import 'package:flutter/material.dart';
import 'package:share/share.dart';

// Language toggle dialog box.
_languageToggle({BuildContext context}) {
  Widget _languageButton({String language}) {
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
            const Text(
              "Select your prefered Language",
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w200,
              ),
            ),
            const SizedBox(height: 30.0),
            _languageButton(language: 'ENGLISH'),
            _languageButton(language: 'हिन्दी'),
          ],
        ),
      );
    },
  );
}

void _shareApp() {
  Share.share(
    'https://play.google.com/store/apps/details?id=com.sindhisangat.learnsindhi \n\nDedicated to the promotion of Sindhi Language Culture & Heritage. ',
  );
}

AppBar myAppBar({BuildContext context}) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 3,
    title: Text(
      "Talk Sindhi",
      style: Theme.of(context).textTheme.headline6.copyWith(
            letterSpacing: 1.0,
          ),
    ),
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.share),
        color: Theme.of(context).primaryColor,
        onPressed: () => _shareApp(),
      ),
      IconButton(
        icon: Icon(Icons.search),
        color: Theme.of(context).primaryColor,
        onPressed: () {},
      ),
      IconButton(
        icon: Icon(Icons.language),
        color: Theme.of(context).primaryColor,
        onPressed: () => _languageToggle(
          context: context,
        ),
      ),
    ],
  );
}
