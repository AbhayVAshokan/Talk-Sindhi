// Splash Screen: Duration = 3 seconds

import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/topic.dart';
import '../file_operations.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Check internet connectivity
  Future<ConnectivityResult> checkConnectivity() async {
    return await (Connectivity().checkConnectivity());
  }

  @override
  initState() {
    super.initState();

    // Fetching data during splashscreen.
    Timer(
      Duration(seconds: 3),
      () async {
        // Checking whether connected to internet or not
        checkConnectivity().then(
          (ConnectivityResult connectivityResult) async {
            if (connectivityResult == ConnectivityResult.wifi ||
                connectivityResult == ConnectivityResult.mobile) {
              // If internet connection is available update the local data from the server.
              var response = await http.post(
                Uri.encodeFull('http://204.48.26.50:8033/data/get'),
                headers: {
                  'Accept': 'application/json',
                },
              );

              var data = json.decode(response.body) as Map;
              for (var i = 0; i < data['data'].length; i++) {
                if (data['data'][i]['SubCategory']['Category']['name'] ==
                    'vocabulary') {
                  var index = vocabulary.indexWhere((element) =>
                      element['subCategory'] ==
                      data['data'][i]['SubCategory']['name']);

                  // print(index.toString() +
                  //     ' ' +
                  //     data['data'][i]['SubCategory']['name'] +
                  //     vocabulary.toString());
                  // print(data['data'][i]['SubCategory']['name']);

                  if (index == -1)
                    vocabulary.add(
                      {
                        'subCategory': data['data'][i]['SubCategory']['name'],
                        'data': [
                          {
                            'english': data['data'][i]['english'],
                            'hindi': data['data'][i]['hindi'],
                            'sindhi': data['data'][i]['sindhi'],
                          },
                        ],
                      },
                    );
                  else
                    vocabulary[index]['data'].add({
                      'english': data['data'][i]['english'],
                      'hindi': data['data'][i]['hindi'],
                      'sindhi': data['data'][i]['sindhi'],
                    });
                } else if (data['data'][i]['SubCategory']['Category']['name'] ==
                    'Conversation') {
                  var index = conversation.indexWhere((element) =>
                      element['subCategory'] ==
                      data['data'][i]['SubCategory']['name']);

                  if (index == -1)
                    conversation.add(
                      {
                        'subCategory': data['data'][i]['SubCategory']['name'],
                        'data': [
                          {
                            'english': data['data'][i]['english'],
                            'hindi': data['data'][i]['hindi'],
                            'sindhi': data['data'][i]['sindhi'],
                          },
                        ],
                      },
                    );
                  else
                    conversation[index]['data'].add({
                      'english': data['data'][i]['english'],
                      'hindi': data['data'][i]['hindi'],
                      'sindhi': data['data'][i]['sindhi'],
                    });
                }
              }

              print('number of vocabulary categories: ' +
                  vocabulary.length.toString());
              print('number of conversation categories: ' +
                  conversation.length.toString());

              // Update the locally stored data
              writeToFile(
                content: {
                  'vocabulary': vocabulary,
                  'conversation': conversation,
                },
                fileName: 'learnData.json',
              );
              conversation.forEach((element) {
                print(element['subCategory']);
              });
              createProgressFile();
            }
          },
        );

        // Checking whether the user had previously logged in. If yes, jump directly into the home screen.
        getApplicationDocumentsDirectory().then((Directory dir) {
          var path = dir.path + '/userData.json';
          var jsonFile = File(path);
          if (jsonFile.existsSync()) {
            var localStorage = json.decode(jsonFile.readAsStringSync());

            if (localStorage['isLoggedIn'] == true)
              Navigator.pushReplacementNamed(context, '/home');
          }
        });

        Navigator.pushReplacementNamed(context, '/login');
      },
    );
  }

  _permissionHandler() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
    print(statuses[Permission.storage]);
  }

  @override
  Widget build(BuildContext context) {
    _permissionHandler();

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
                  Positioned(
                    bottom: 0,
                    left: width / 2 - 15,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.red,
                      ),
                      backgroundColor: Colors.white24,
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
