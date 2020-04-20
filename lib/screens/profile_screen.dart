import 'dart:math';

import 'package:flutter/material.dart';

import '../my_appbar.dart';
import '../realtime_data.dart';
import '../my_bottom_navbar.dart';
import '../widgets/profile_screen/progress_data.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.indigo[50],
        appBar: myAppBar(
          backgroundColor: Colors.indigo[500],
          context: context,
          elevation: 0.0,
          iconColor: Colors.white,
          rebuildScreen: () {
            setState(() {
              print('rebuilding screen');
            });
          },
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
              ),
              child: Card(
                color: Colors.indigo[500],
                margin: EdgeInsets.all(0.0),
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: mediaQuery.size.width * 0.18,
                              backgroundColor: Colors.lightGreen,
                              child: FittedBox(
                                child: Text(
                                  userData['firstName'][0],
                                  style: const TextStyle(
                                    fontSize: 300.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: mediaQuery.size.width *
                                      0.2 *
                                      (sqrt2 - 1) /
                                      sqrt2 -
                                  mediaQuery.size.width * 0.04,
                              bottom: mediaQuery.size.width *
                                      0.2 *
                                      (sqrt2 - 1) /
                                      sqrt2 -
                                  mediaQuery.size.width * 0.04,
                              child: CircleAvatar(
                                backgroundColor: userData['league'] == 'bronze'
                                    ? Color(0xFFCD6B32)
                                    : (userData['league'] == 'silver'
                                        ? Color(0xFFAAA9AD)
                                        : Color(0xFFFFD700)),
                                radius: mediaQuery.size.width * 0.04,
                                child: FittedBox(
                                  child: Icon(
                                    Icons.star,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      FittedBox(
                        child: SizedBox(
                          width: mediaQuery.size.width * 0.8,
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: userData['firstName'],
                              children: [
                                TextSpan(
                                  text: userData['lastName'] == null
                                      ? ''
                                      : ' ${userData['lastName']}',
                                ),
                              ],
                              style: TextStyle(
                                  fontSize: 35.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.0,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        userData['email'],
                        style: const TextStyle(
                          color: Colors.white,
                          letterSpacing: 0.75,
                          fontWeight: FontWeight.w600,
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ProgressData(category: 'vocabulary'),
                      ProgressData(category: 'conversation'),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 7.0),
                        child: SizedBox(
                          height: 50.0,
                          child: Row(
                            children: [
                              Expanded(
                                child: RaisedButton.icon(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                    vertical: 5.0,
                                  ),
                                  color: Colors.pink,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  onPressed: () => Navigator.pushNamed(
                                      context, '/changePassword'),
                                  icon: Icon(
                                    Icons.security,
                                    color: Colors.white,
                                  ),
                                  label: const Text(
                                    'Change password',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5.0),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Container(
                                  color: globalLanguage == 'english'
                                      ? Colors.indigo
                                      : Colors.teal,
                                  child: ToggleButtons(
                                    children: [
                                      SizedBox(
                                        width: mediaQuery.size.width * 0.33,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const SizedBox(width: 10.0),
                                            Icon(
                                              Icons.language,
                                              size: 30.0,
                                            ),
                                            Expanded(
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                  globalLanguage == 'english'
                                                      ? 'English'
                                                      : 'हिन्दी  ',
                                                  style: TextStyle(
                                                      fontSize:
                                                          globalLanguage ==
                                                                  'english'
                                                              ? 16.0
                                                              : 20.0),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10.0),
                                          ],
                                        ),
                                      )
                                    ],
                                    isSelected: [
                                      globalLanguage == 'english' ? true : false
                                    ],
                                    fillColor: Colors.indigo,
                                    selectedColor: Colors.white,
                                    color: Colors.white,
                                    splashColor: Colors.lightBlue,
                                    renderBorder: false,
                                    onPressed: (value) {
                                      setState(() {
                                        globalLanguage == 'english'
                                            ? globalLanguage = 'hindi'
                                            : globalLanguage = 'english';
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: myBottomNavbar(
          context: context,
          currentIndex: 3,
        ),
      ),
    );
  }
}
