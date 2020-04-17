// Registration Screen

import 'dart:io';
import 'dart:convert';


import '../file_operations.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:device_id/device_id.dart';
import 'package:device_info/device_info.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:connectivity/connectivity.dart';

import '../models/user.dart';
import '../widgets/login-register/submit_button.dart';
import '../widgets/login-register/input_textformfield.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  File jsonFile;

  bool fileExists = false;
  Map<String, dynamic> fileContent;
  String path;

  @override
  initState() {
    // get DeviceId, DeviceName, DeviceType
    getDeviceInfo();
    checkConnectivity();
    super.initState();
  }

  // Check internet connectivity
  ConnectivityResult connectivityResult;
  checkConnectivity() async {
    connectivityResult = await (Connectivity().checkConnectivity());
  }

  // Register new user using API.
  registerUser({
    @required BuildContext context,
  }) async {
    var response = await http.post(
      Uri.encodeFull('http://204.48.26.50:8033/user/register'),
      headers: {
        'Accept': 'application/json',
      },
      body: {
        'email': _emailAddress,
        'password': _password,
        'userName': _userName,
        'firstName': _firstName,
        'lastName': _lastName,
        'mobileNumber': _mobileNumber,
        'countryId': _countryId,
        'cityId': _cityId,
        'deviceId': _deviceId,
        'deviceToken': _deviceToken,
        'deviceName': _deviceName,
        'deviceType': _deviceType,
      },
    );

    var jsonResponse = json.decode(response.body);

    if (jsonResponse['status'] == true) {
      print('DEBUG: User successfully registered.');

      writeToFile(
        fileName: 'userData.json',
        content: {
          'email': _emailAddress,
          'userName': _userName,
          'firstName': _firstName,
          'lastname': _lastName,
          'mobileNumber': _mobileNumber,
          'language': 'english',
          'isLoggedIn': true,
        },
      );

      Navigator.pushReplacementNamed(context, '/home');
    } else if (jsonResponse['message'] == "Email already registered")
      Fluttertoast.showToast(
        msg: "Email already registered",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0,
      );
  }

  // Get device data for registration: DeviceId, DeviceType, DeviceName
  getDeviceInfo() async {
    _deviceId = await DeviceId.getID;
    if (Platform.isAndroid)
      _deviceType = 'Android';
    else if (Platform.isIOS)
      _deviceType = 'IOS';
    else if (Platform.isLinux)
      _deviceType = 'Linux';
    else if (Platform.isWindows)
      _deviceType = 'Windows';
    else if (Platform.isMacOS)
      _deviceType = 'MacOs';
    else if (Platform.isFuchsia)
      _deviceType = 'Fuchsia';
    else
      _deviceType = 'other';

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (_deviceType == 'Android') {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      _deviceName = androidInfo.model;
    } else if (_deviceType == 'IOS') {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      _deviceName = iosInfo.utsname.machine;
    }
  }

  @override
  Widget build(BuildContext context) {
    print('executing build');

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
                height: screenRatio < 1 ? height * 0.9 : height * 0.8,
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
                                        fontSize: constraints.maxHeight * 0.05,
                                      ),
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
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            height: constraints.maxHeight * 0.7,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  registrationForm(context: context),
                                ],
                              ),
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SubmitButton(
                                    text: 'FACEBOOK',
                                    width: constraints.maxWidth * 0.4,
                                    color: Colors.blue,
                                    onTap: () => Fluttertoast.showToast(
                                      msg: "Feature coming soon",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black87,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  Text(
                                    'Or',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .copyWith(
                                            fontWeight: FontWeight.normal),
                                  ),
                                  SubmitButton(
                                    text: 'REGISTER',
                                    width: constraints.maxWidth * 0.4,
                                    color: Colors.pink,
                                    onTap: () {
                                      if (!_registrationFormKey.currentState
                                          .validate()) {
                                        print(
                                            'DEBUG: Form cannot be submitted due to form validation requirements.');
                                        return;
                                      } else if (connectivityResult ==
                                              ConnectivityResult.wifi ||
                                          connectivityResult ==
                                              ConnectivityResult.mobile)
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
                                        print(
                                            'DEBUG: Form succesfully submitted for online validation.');
                                        _registrationFormKey.currentState
                                            .save();
                                        registerUser(context: context);
                                      }
                                    },
                                  ),
                                ],
                              ),
                              Divider(color: Theme.of(context).backgroundColor),
                              GestureDetector(
                                onTap: () => Navigator.pushReplacementNamed(
                                    context, '/login'),
                                child: Text(
                                  'Have an account? Login.',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      .copyWith(color: Colors.grey),
                                ),
                              ),
                            ],
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

  // Registration form for user registration.
  var _emailAddress = "";
  var _password = "";
  var _confirmPassword = "";
  var _userName = "";
  var _firstName = "";
  var _lastName = "";
  var _mobileNumber = '';
  var _countryId = "--- select country ---";
  var _cityId = "";
  var _deviceId = '';
  var _deviceToken = '';
  var _deviceName = '';
  var _deviceType = '';

  static GlobalKey<FormState> _registrationFormKey = GlobalKey<FormState>();
  Widget registrationForm({BuildContext context}) {
    return Form(
      key: _registrationFormKey,
      child: Column(
        children: [
          inputTextFormField(
            context: context,
            labelText: 'Email Address',
            data: _emailAddress,
            keyboardType: TextInputType.emailAddress,
            onChanged: (newValue) => _emailAddress = newValue,
            validation: (String email) {
              if (!RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
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
            textInputAction: TextInputAction.next,
            onChanged: (newValue) {
              _password = newValue;
            },
            validation: (String input) {
              if (input.length < 8)
                return "Must contain atleast 8 characters";
              else if (!RegExp(
                      r"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$")
                  .hasMatch(input))
                return "Must contain atleast one number and  special character";
              else
                return null;
            },
          ),
          inputTextFormField(
            context: context,
            labelText: 'Confirm Password',
            data: _confirmPassword,
            obscureText: true,
            textInputAction: TextInputAction.next,
            onChanged: (newValue) => _confirmPassword = newValue,
            validation: (String input) {
              if (input != _password)
                return 'Passwords do not match';
              else
                return null;
            },
          ),
          inputTextFormField(
            context: context,
            labelText: 'Username',
            data: _userName,
            textInputAction: TextInputAction.next,
            onChanged: (newValue) => _userName = newValue,
            validation: (String input) {
              if (_userName.isEmpty)
                return 'Username cannot be null';
              else
                return null;
            },
          ),
          inputTextFormField(
            context: context,
            labelText: 'First Name',
            data: _firstName,
            textInputAction: TextInputAction.next,
            onChanged: (newValue) => _firstName = newValue,
            validation: (String input) {
              if (_firstName.isEmpty)
                return 'First name cannot be null';
              else
                return null;
            },
          ),
          inputTextFormField(
            context: context,
            labelText: 'Last Name',
            data: _lastName,
            textInputAction: TextInputAction.next,
            onChanged: (newValue) => _lastName = newValue,
            validation: (String input) => null,
          ),
          inputTextFormField(
            context: context,
            labelText: 'Mobile Number',
            data: _mobileNumber,
            textInputAction: TextInputAction.next,
            onChanged: (String newValue) => _mobileNumber = newValue,
            validation: (input) {
              if (_mobileNumber.isNotEmpty &&
                  (!RegExp(r"^[0-9]*$").hasMatch(input) || input.length != 10))
                return 'Enter valid mobile number';
              else
                return null;
            },
            keyboardType: TextInputType.phone,
          ),
          DropdownButton(
            items: countries.map((String country) {
              return DropdownMenuItem<String>(
                value: country,
                child: Text(
                  country,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }).toList(),
            dropdownColor: Colors.amber[300],
            value: _countryId,
            onChanged: (selectedCountry) {
              setState(() {
                _countryId = selectedCountry;
              });
            },
          ),
          inputTextFormField(
            context: context,
            labelText: 'City',
            data: _cityId,
            textInputAction: TextInputAction.next,
            onChanged: (newValue) => _cityId = newValue,
            validation: (String input) => null,
          ),
        ],
      ),
    );
  }
}
