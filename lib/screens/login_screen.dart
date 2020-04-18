// Login Screen

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

import '../file_operations.dart';
import '../widgets/login-register/submit_button.dart';
import '../widgets/login-register/input_textformfield.dart';

class LoginScreen extends StatefulWidget {
  static GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  writeToFileAsynchronous({content}) async {
    writeToFile(
      fileName: 'userData.json',
      content: content,
    );
  }

  bool isLoggedIn = false;

  void onLoginStatusChanged(bool isLoggedIn) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
    });
  }

  void initiateFacebookLogin() async {
    var facebookLogin = FacebookLogin();
    var facebookLoginResult =
        await facebookLogin.logInWithReadPermissions(['email']);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        print("Error");
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("CancelledByUser");
        onLoginStatusChanged(false);

        break;
      case FacebookLoginStatus.loggedIn:
        print("LoggedIn");

        var graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${facebookLoginResult.accessToken.token}');

        var profile = json.decode(graphResponse.body);
        print(profile.toString());

        onLoginStatusChanged(true);
        userLogin(
            email: profile['email'], password: profile['id'], context: context);
        break;
    }
  }

  // Check whether connected to internet or not.
  @override
  initState() {
    checkConnectivity();
    super.initState();
  }

  ConnectivityResult connectivityResult;
  checkConnectivity() async {
    connectivityResult = await (Connectivity().checkConnectivity());
  }

  userLogin({
    @required String email,
    @required String password,
    @required BuildContext context,
  }) async {
    var response = await http.post(
      Uri.encodeFull('http://204.48.26.50:8033/user/login'),
      headers: {
        'Accept': 'application/json',
      },
      body: {
        'email': email,
        'password': password,
      },
    );

    var jsonFile = json.decode(response.body);

    if (jsonFile['status'] == true) {
      writeToFileAsynchronous(
        content: {
          'email': _emailAddress,
          'userName': jsonFile['userName'],
          'firstName': jsonFile['firstName'],
          'lastName': jsonFile['lastName'],
          'mobileNumber': jsonFile['mobileNumber'],
          'language': 'english',
          'isLoggedIn': true,
        },
      );

      Navigator.pushReplacementNamed(context, '/home');
    } else if (jsonFile['message'] == 'email not found')
      Fluttertoast.showToast(
        msg: "User does not exist.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    else if (jsonFile['message'] == 'wrong password')
      Fluttertoast.showToast(
        msg: "Incorrect password",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0,
      );
  }

  String _emailAddress = "";

  String _password = "";

  @override
  Widget build(BuildContext context) {
    print('executing build: ' + _emailAddress + _password);

    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double height = mediaQuery.size.height -
        mediaQuery.padding.top -
        mediaQuery.padding.bottom;
    final double width = mediaQuery.size.width;
    final screenRatio = height / width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Center(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.symmetric(vertical: 37.5),
                width: screenRatio < 1 ? width * 0.75 : width * 0.9,
                height: screenRatio < 1 ? height * 0.9 : height * 0.6,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: LayoutBuilder(
                      builder: (context, constraints) => Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 60.0),
                            child: FittedBox(
                              child: RichText(
                                text: TextSpan(
                                  text: 'S',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                          color: Colors.red,
                                          fontSize:
                                              constraints.maxHeight * 0.07),
                                  children: [
                                    const TextSpan(
                                      text: 'PEAK ',
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    const TextSpan(text: 'S'),
                                    const TextSpan(
                                      text: 'INDHI',
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Form(
                            key: LoginScreen._formKey,
                            child: Column(
                              children: [
                                inputTextFormField(
                                  context: context,
                                  labelText: 'Email',
                                  data: _emailAddress,
                                  keyboardType: TextInputType.emailAddress,
                                  onChanged: (newValue) =>
                                      _emailAddress = newValue,
                                  validation: (String email) {
                                    if (!RegExp(
                                            r"^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$")
                                        .hasMatch(email)) {
                                      return 'Enter valid email address';
                                    }
                                    return null;
                                  },
                                ),
                                inputTextFormField(
                                  context: context,
                                  labelText: 'Password',
                                  data: _password,
                                  obscureText: true,
                                  textInputAction: TextInputAction.done,
                                  onChanged: (newValue) => _password = newValue,
                                  validation: (String input) {
                                    if (input.isEmpty)
                                      return 'Password cannot be null';
                                    else
                                      return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            child: const Align(
                              alignment: Alignment.centerRight,
                              child: const Text(
                                'Forgot Password?',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  letterSpacing: 0.75,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SubmitButton(
                                text: 'FACEBOOK',
                                width: constraints.maxWidth * 0.4,
                                color: Colors.blue,
                                onTap: () => initiateFacebookLogin(),
                              ),
                              Text(
                                'Or',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    .copyWith(fontWeight: FontWeight.normal),
                              ),
                              SubmitButton(
                                text: 'LOGIN',
                                width: constraints.maxWidth * 0.4,
                                color: Colors.pink,
                                onTap: () {
                                  if (!LoginScreen._formKey.currentState
                                      .validate())
                                    return;
                                  else if (!(connectivityResult ==
                                          ConnectivityResult.wifi ||
                                      connectivityResult ==
                                          ConnectivityResult.mobile))
                                    Fluttertoast.showToast(
                                      msg: "No network connectivity",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black87,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                                  else {
                                    LoginScreen._formKey.currentState.save();
                                    userLogin(
                                      context: context,
                                      email: _emailAddress,
                                      password: _password,
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                          Divider(color: Theme.of(context).backgroundColor),
                          GestureDetector(
                            onTap: () => Navigator.pushReplacementNamed(
                                context, '/register'),
                            child: Text(
                              'Don\'t have an account? Enroll now.',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 10.0,
                child: Card(
                  child: Container(
                    margin: const EdgeInsets.all(5.0),
                    color: Theme.of(context).backgroundColor,
                    child: Image.asset(
                      'assets/images/splash_screen/powerd_by_logo.png',
                      width: 75.0,
                      height: 75.0,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
