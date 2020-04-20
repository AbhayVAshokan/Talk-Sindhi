import 'dart:math';

import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../my_appbar.dart';
import '../realtime_data.dart';
import '../file_operations.dart';
import '../my_bottom_navbar.dart';
import '../widgets/profile_screen/progress_data.dart';
import '../widgets/profile_screen/change_password.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ConnectivityResult connectivityResult;
  checkConnectivity() async {
    connectivityResult = await (Connectivity().checkConnectivity());
  }

  @override
  Widget build(BuildContext context) {
    print(userData);
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.indigo[50],
        appBar: myAppBar(
          pointsBar: true,
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
            Expanded(
              child: Stack(
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
                                      backgroundColor:
                                          userData['league'] == 'bronze'
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
                  FlatButton.icon(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                    color: Colors.pink,
                    onPressed: () {
                      var content = userData;
                      content['isLoggedIn'] = false;
                      writeToFile(content: content, fileName: '/userData.json');

                      Fluttertoast.showToast(
                        msg: "Logged Out",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black87,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );

                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    icon: const Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                      size: 30.0,
                    ),
                    label: const Text(
                      'Logout',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: LayoutBuilder(
                  builder: (context, constraints) => Column(
                    children: [
                      SizedBox(
                          height: constraints.maxHeight * 0.33,
                          child: ProgressData(category: 'vocabulary')),
                      SizedBox(
                          height: constraints.maxHeight * 0.33,
                          child: ProgressData(category: 'conversation')),
                      Container(
                        height: constraints.maxHeight * 0.33,
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
                                    vertical: 10.0,
                                  ),
                                  color: Colors.pink,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  onPressed: () => changePassword(
                                    context: context,
                                    formkey: _formKey,
                                  ),
                                  icon: Icon(
                                    Icons.security,
                                    color: Colors.white,
                                    size: 30.0,
                                  ),
                                  label: Text(
                                    globalLanguage == 'english'
                                        ? 'Change password'
                                        : 'पासवर्ड बदलें',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: globalLanguage == 'english'
                                          ? 16.0
                                          : 20.0,
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
